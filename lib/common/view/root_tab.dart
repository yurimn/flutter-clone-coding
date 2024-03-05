import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/order/view/order_screen.dart';
import 'package:actual/product/view/product_screen.dart';
import 'package:actual/restaurant/view/restaurant_screen.dart';
import 'package:actual/user/view/profile_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller; // late : 나중에 입력될것임

  int index = 0;

  @override
  void initState() {
    super.initState();

    // vsync: this gkfuaus singleTickerProviderStateMixin 사용해야 함
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener); // 탭이 바뀔 때마다 실행됨
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(), //tab 스크롤 시 넘어가지 않게
        controller: controller,
        children: [
          RestaurantScreen(),
          ProductScreen(),
          OrderScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed, // shifting이 기본. 선택된 곳이 커짐
        onTap: (int index) {
          controller.animateTo(index); // tab 스크롤 시 바텀 탭도 함꼐 이동
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
