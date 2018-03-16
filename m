From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:59 +0100
Subject: [PATCH 40/52] ARM: dts: gose: use demuxer for I2C2
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <786ef2eeb04cca41d6382556f1409f37f64c4a0c.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Create a separate bus for HDMI related I2C2 and provide fallback to GPIO.

Based on work for the r8a7790/lager by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased, corrected board name in subject, fixed aliases, switched
to named GPIOs]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 218 ++++++++++++++++++++-----------------
 1 file changed, 121 insertions(+), 97 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 51b3ffac8efa..2b330ef71f4c 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -48,6 +48,8 @@
 	aliases {
 		serial0 = &scif0;
 		serial1 = &scif1;
+		i2c9 = &gpioi2c2;
+		i2c11 = &i2chdmi;
 	};
 
 	chosen {
@@ -296,6 +298,124 @@
 		#clock-cells = <0>;
 		clock-frequency = <148500000>;
 	};
+
+	gpioi2c2: i2c-9 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		scl-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		sda-gpios = <&gpio2 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <5>;
+	};
+
+	/*
+	 * A fallback to GPIO is provided for I2C2.
+	 */
+	i2chdmi: i2c-11 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c2>, <&gpioi2c2>;
+		i2c-bus-name = "i2c-hdmi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ak4643: codec at 12 {
+			compatible = "asahi-kasei,ak4643";
+			#sound-dai-cells = <0>;
+			reg = <0x12>;
+		};
+
+		composite-in at 20 {
+			compatible = "adi,adv7180cp";
+			reg = <0x20>;
+			remote = <&vin1>;
+
+			port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					adv7180_in: endpoint {
+						remote-endpoint = <&composite_con_in>;
+					};
+				};
+
+				port at 3 {
+					reg = <3>;
+					adv7180_out: endpoint {
+						bus-width = <8>;
+						remote-endpoint = <&vin1ep>;
+					};
+				};
+			};
+		};
+
+		hdmi at 39 {
+			compatible = "adi,adv7511w";
+			reg = <0x39>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+
+			adi,input-depth = <8>;
+			adi,input-colorspace = "rgb";
+			adi,input-clock = "1x";
+			adi,input-style = <1>;
+			adi,input-justification = "evenly";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					adv7511_in: endpoint {
+						remote-endpoint = <&du_out_rgb>;
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+					adv7511_out: endpoint {
+						remote-endpoint = <&hdmi_con_out>;
+					};
+				};
+			};
+		};
+
+		hdmi-in at 4c {
+			compatible = "adi,adv7612";
+			reg = <0x4c>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			default-input = <0>;
+
+			port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					adv7612_in: endpoint {
+						remote-endpoint = <&hdmi_con_in>;
+					};
+				};
+
+				port at 2 {
+					reg = <2>;
+					adv7612_out: endpoint {
+						remote-endpoint = <&vin0ep2>;
+					};
+				};
+			};
+		};
+
+		eeprom at 50 {
+			compatible = "renesas,r1ex24002", "atmel,24c02";
+			reg = <0x50>;
+			pagesize = <16>;
+		};
+	};
 };
 
 &du {
@@ -544,107 +664,11 @@
 
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-hdmi";
 
 	status = "okay";
 	clock-frequency = <100000>;
 
-	ak4643: codec at 12 {
-		compatible = "asahi-kasei,ak4643";
-		#sound-dai-cells = <0>;
-		reg = <0x12>;
-	};
-
-	composite-in at 20 {
-		compatible = "adi,adv7180cp";
-		reg = <0x20>;
-		remote = <&vin1>;
-
-		port {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port at 0 {
-				reg = <0>;
-				adv7180_in: endpoint {
-					remote-endpoint = <&composite_con_in>;
-				};
-			};
-
-			port at 3 {
-				reg = <3>;
-				adv7180_out: endpoint {
-					bus-width = <8>;
-					remote-endpoint = <&vin1ep>;
-				};
-			};
-		};
-	};
-
-	hdmi at 39 {
-		compatible = "adi,adv7511w";
-		reg = <0x39>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
-
-		adi,input-depth = <8>;
-		adi,input-colorspace = "rgb";
-		adi,input-clock = "1x";
-		adi,input-style = <1>;
-		adi,input-justification = "evenly";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port at 0 {
-				reg = <0>;
-				adv7511_in: endpoint {
-					remote-endpoint = <&du_out_rgb>;
-				};
-			};
-
-			port at 1 {
-				reg = <1>;
-				adv7511_out: endpoint {
-					remote-endpoint = <&hdmi_con_out>;
-				};
-			};
-		};
-	};
-
-	hdmi-in at 4c {
-		compatible = "adi,adv7612";
-		reg = <0x4c>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
-		default-input = <0>;
-
-		port {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port at 0 {
-				reg = <0>;
-				adv7612_in: endpoint {
-					remote-endpoint = <&hdmi_con_in>;
-				};
-			};
-
-			port at 2 {
-				reg = <2>;
-				adv7612_out: endpoint {
-					remote-endpoint = <&vin0ep2>;
-				};
-			};
-		};
-	};
-
-	eeprom at 50 {
-		compatible = "renesas,r1ex24002", "atmel,24c02";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
 };
 
 &i2c6 {
-- 
2.11.0
