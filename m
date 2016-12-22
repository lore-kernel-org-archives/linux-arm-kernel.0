From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 22 Dec 2016 10:43:27 +0100
Subject: [PATCH v2] ARM: dts: turris-omnia: add support for ethernet switch
Message-ID: <20161222094327.24051-1-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Turris Omnia features a Marvell MV88E7176 ethernet switch. Add it to
the dts.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
Changes since (implicit) v1:
 - drop mdio bus and per port phy-handle as they match the default
   setup.

One thing I was surprised is that the mv88e6xxx module isn't autoloaded
by udev. Is this expected?

Best regards
Uwe

 arch/arm/boot/dts/armada-385-turris-omnia.dts | 66 ++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index ab49acb2d452..f8e55fa7f0fa 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -122,7 +122,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ge0_rgmii_pins>;
 	status = "okay";
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii";
 
 	fixed-link {
 		speed = <1000>;
@@ -135,7 +135,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ge1_rgmii_pins>;
 	status = "okay";
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii";
 
 	fixed-link {
 		speed = <1000>;
@@ -274,6 +274,68 @@
 	};
 
 	/* Switch MV88E7176 at address 0x10 */
+	switch at 10 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dsa,member = <0 0>;
+
+		reg = <0x10>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ports at 0 {
+				reg = <0>;
+				label = "lan0";
+			};
+
+			ports at 1 {
+				reg = <1>;
+				label = "lan1";
+			};
+
+			ports at 2 {
+				reg = <2>;
+				label = "lan2";
+			};
+
+			ports at 3 {
+				reg = <3>;
+				label = "lan3";
+			};
+
+			ports at 4 {
+				reg = <4>;
+				label = "lan4";
+			};
+
+			ports at 5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&eth1>;
+				phy-mode = "rgmii-id";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			ports at 6 {
+				reg = <6>;
+				label = "cpu";
+				ethernet = <&eth0>;
+				phy-mode = "rgmii-id";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
 };
 
 &pinctrl {
-- 
2.11.0
