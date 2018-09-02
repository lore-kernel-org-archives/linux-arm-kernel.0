From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  2 Sep 2018 18:29:12 +0200
Subject: [PATCH 2/2] ARM: dts: vf610-zii-dev-rev-c: add support for one SFF
 module
In-Reply-To: <1535905752-17730-1-git-send-email-andrew@lunn.ch>
References: <1535905752-17730-1-git-send-email-andrew@lunn.ch>
Message-ID: <1535905752-17730-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@armlinux.org.uk>

The board typically has 2 populated SFF interfaces. The mv88e6xxx
driver currently supports SFF modules connected to ports 9 and 10 of
the mv88e6390. Add support for sff2, which is connected to port 9.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 44 +++++++++++++----------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index 0b1e94c6f25b..6f4a5602cefd 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -200,6 +200,13 @@
 						phy-handle = <&switch1phy4>;
 					};
 
+					port at 9 {
+						reg = <9>;
+						label = "sff2";
+						phy-mode = "sgmii";
+						managed = "in-band-status";
+						sfp = <&sff2>;
+					};
 
 					switch1port10: port at 10 {
 						reg = <10>;
@@ -245,6 +252,22 @@
 			#size-cells = <0>;
 		};
 	};
+
+	sff2: sff2 {
+		/* lower */
+		compatible = "sff,sff";
+		i2c-bus = <&sff2_i2c>;
+		los-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
+	};
+
+	sff3: sff3 {
+		/* upper */
+		compatible = "sff,sff";
+		i2c-bus = <&sff3_i2c>;
+		los-gpios = <&gpio6 13 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &dspi0 {
@@ -329,13 +352,6 @@
 		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
 		gpio-controller;
 		interrupt-controller;
-
-		enet_swr_en {
-			gpio-hog;
-			gpios = <0 GPIO_ACTIVE_HIGH>;
-			output-high;
-			line-name = "enet-swr-en";
-		};
 	};
 
 	/*
@@ -378,26 +394,16 @@
 			reg = <0>;
 		};
 
-		i2c at 1 {
+		sff2_i2c: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
-
-			sfp2: at24c04 at 50 {
-				compatible = "atmel,24c02";
-				reg = <0x50>;
-			};
 		};
 
-		i2c at 2 {
+		sff3_i2c: i2c at 2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-
-			sfp3: at24c04 at 50 {
-				compatible = "atmel,24c02";
-				reg = <0x50>;
-			};
 		};
 
 		i2c at 3 {
-- 
2.19.0.rc1
