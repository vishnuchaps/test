import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse;
  List listResponse;
  Map mapResponse;
  List listofFacts;
  Future fetchData() async {
    http.Response response;
    response = await http
        .get('https://ecommercepanda.herokuapp.com/api/v1/product/all');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listofFacts = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hi'),
      ),
      body: mapResponse == null
          ? Container()
          : Column(
              children: [
                Text(mapResponse['meta'].toString()),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              listofFacts[index]['name'].toString(),
                            ),
                            Text(
                              listofFacts[index]['category'].toString(),
                            ),
                            Text(
                              listofFacts[index]['subcategory'].toString(),
                            ),
                            Text(
                              listofFacts[index]['price'].toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: listofFacts == null ? 0 : listofFacts.length,
                )
              ],
            ),
    );
  }
}
