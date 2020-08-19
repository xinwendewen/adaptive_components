import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ControlCenterPage());
  }
}

const title = '多设备控制中心';
const subtitle = '全新交互，全景体验';
const description = '从屏幕左下角或右下角向上滑动，激活多设备控制中心，可以实现智能设备间16的互动。'
    '同时，当你在手机上看视频、听音乐和畅连通话时，系统智能推荐附近设备，一键切换，享受更佳体验。';

class ControlCenterPage extends StatelessWidget {
  Widget _landscapeCard() {
    return Card(
      color: Colors.black,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 18.0, color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        subtitle,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
//              Expanded(child: Container(),),
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 250,
                  child: Image.asset(
                    "assets/control-center.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _squareCard() {
    return Card(
      color: Colors.black,
      child: Center(child: Text('square')),
    );
  }

  Widget _portraitCard() {
    return Card(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 250,
                  child: Image.asset(
                    "assets/control-center.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: Row(
              children: <Widget>[
                ExpandedInformativeBox(),
                ExpandedInformativeBox()
              ],
            )),
            ExpandedInformativeBox(),
            ExpandedInformativeBox(),
            ExpandedInformativeBox(),
          ],
        ),
//        body: LayoutBuilder(
//          builder: (BuildContext context, BoxConstraints constraints) {
//            var ratio = constraints.maxWidth / constraints.maxHeight;
//            if (ratio > 4 / 3) {
//              return _landscapeCard();
//            } else if (ratio < 4 / 3) {
//              return _portraitCard();
//            } else {
//              return _squareCard();
//            }
//          },
//        ),
      ),
    );
  }
}

class UnScrollableGallery extends StatefulWidget {
  @override
  _UnScrollableGalleryState createState() => _UnScrollableGalleryState();
}

class _UnScrollableGalleryState extends State<UnScrollableGallery> {
  static const int maxRowCount = 4;
  static const int maxColumnCount = 2;

  final int maxSize = maxRowCount * maxColumnCount;
  final List<List<int>> items = [];
  int size;

  void addItem() {
    if (size >= maxSize) {
      return;
    }
    setState(() {
      size++;
      var column = size % maxRowCount;
      var row = size % maxColumnCount;
      items[row][column] = 1;
    });
  }

  void removeItem() {}

  @override
  Widget build(BuildContext context) {
    List<Row> _itemToRows() {
      var rows = <Row>[];
      for (var row in items) {
        rows.add(Row(
          children: row.map((e) => ExpandedInformativeBox()).toList(),
        ));
      }
    }

    return Column(
      children: _itemToRows(),
    );
  }
}

class ExpandedInformativeBox extends StatelessWidget {
  Widget _constraintsWidthText(BoxConstraints constraints) {
    return Text('constraints width [${constraints.minWidth * 10 ~/ 10},'
        ' ${constraints.maxWidth * 10 ~/ 10}]');
  }

  Widget _constraintsHeightText(BoxConstraints constraints) {
    return Text('constraints height [${constraints.minHeight * 10 ~/ 10},'
        ' ${constraints.maxHeight * 10 ~/ 10}]');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            color: _randomPrimaryColor(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _constraintsWidthText(constraints),
                  _constraintsHeightText(constraints)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Color _randomPrimaryColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
