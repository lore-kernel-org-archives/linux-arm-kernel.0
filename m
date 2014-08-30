From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 30 Aug 2014 18:54:28 +0200
Subject: [PATCH] ARM: Kirkwood: Fix DT based DSA.
Message-ID: <1409417668-7169-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the conversion of boards to use DT to instantiate Distributed
Switch Architecture, nobody volunteered to test. As to be expected,
the conversion was flawed. Testers and access to hardware has now
become available, and this patch hopefully fixes the problems.

dsa,mii-bus must be a phandle to the top level mdio node, not the port
specific subnode of the mdio device.

dsa,ethernet must be a phandle to the port subnode within the ethernet
DT node, not the ethernet node.

Fixes: e2eaa339af441b3d51cdaa16870065c4154ce13c
Fixes: e7c8f3808be854379c9784745663a55371cbf232

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

NOTE: This is a request for testing. Please do not commit unless it
gains a Tested-by: There is a user out there of one of these boards,
so hopefully it will get tested.

 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 16 ++++++----------
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi      | 13 ++++---------
 arch/arm/boot/dts/kirkwood.dtsi                |  4 ++--
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index 8f76d28759a3..f82827d6fcff 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -123,11 +123,11 @@
 
 	dsa at 0 {
 		compatible = "marvell,dsa";
-		#address-cells = <2>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		dsa,ethernet = <&eth0>;
-		dsa,mii-bus = <&ethphy0>;
+		dsa,ethernet = <&eth0port>;
+		dsa,mii-bus = <&mdio>;
 
 		switch at 0 {
 			#address-cells = <1>;
@@ -169,17 +169,13 @@
 
 &mdio {
 	status = "okay";
-
-	ethphy0: ethernet-phy at ff {
-		reg = <0xff>; 	/* No phy attached */
-		speed = <1000>;
-		duplex = <1>;
-	};
 };
 
 &eth0 {
 	status = "okay";
+
 	ethernet0-port at 0 {
-		phy-handle = <&ethphy0>;
+		speed = <1000>;
+		duplex = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
index 26cf0e0ccefd..57e5213c11cf 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
@@ -69,8 +69,8 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		dsa,ethernet = <&eth0>;
-		dsa,mii-bus = <&ethphy1>;
+		dsa,ethernet = <&eth0port>;
+		dsa,mii-bus = <&mdio>;
 
 		switch at 0 {
 			#address-cells = <1>;
@@ -130,12 +130,6 @@
 	ethphy0: ethernet-phy at 0 {
 		reg = <0>;
 	};
-
-	ethphy1: ethernet-phy at ff {
-		reg = <0xff>; /* No PHY attached */
-		speed = <1000>;
-		duple = <1>;
-	};
 };
 
 &eth0 {
@@ -148,6 +142,7 @@
 &eth1 {
 	status = "okay";
 	ethernet1-port at 0 {
-		phy-handle = <&ethphy1>;
+		speed = <1000>;
+		duple = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index afc640cd80c5..464f09a1a4a5 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -309,7 +309,7 @@
 			marvell,tx-checksum-limit = <1600>;
 			status = "disabled";
 
-			ethernet0-port at 0 {
+			eth0port: ethernet0-port at 0 {
 				compatible = "marvell,kirkwood-eth-port";
 				reg = <0>;
 				interrupts = <11>;
@@ -342,7 +342,7 @@
 			pinctrl-names = "default";
 			status = "disabled";
 
-			ethernet1-port at 0 {
+			eth1port: ethernet1-port at 0 {
 				compatible = "marvell,kirkwood-eth-port";
 				reg = <0>;
 				interrupts = <15>;
-- 
2.1.0
