From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 22 Jun 2016 12:43:46 +0900
Subject: [PATCH v3 08/13] ARM: dts: porter: use demuxer for I2C2
In-Reply-To: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
References: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1466567031-20381-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a separate bus for HDMI related I2C2 and provide fallback to GPIO.

Based on work for the r8a7790/lager by Wolfram Sang.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3
* New patch
* Compile tested only
---
 arch/arm/boot/dts/r8a7791-porter.dts | 129 +++++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 6761d11d3f9e..dea3c1a103a5 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -29,6 +29,8 @@
 
 	aliases {
 		serial0 = &scif0;
+		i2c9 = "gpioi2c2";
+		i2c10 = "i2chdmi";
 	};
 
 	chosen {
@@ -135,6 +137,79 @@
 			clocks = <&x14_clk>;
 		};
 	};
+
+	gpioi2c2: i2c-9 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio2 7 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio2 6 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
+	/*
+	 * A fallback to GPIO is provided for I2C2.
+	 */
+	i2chdmi: i2c-10 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c2>, <&gpioi2c2>;
+		i2c-bus-name = "i2c-hdmi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ak4642: codec at 12 {
+			compatible = "asahi-kasei,ak4642";
+			#sound-dai-cells = <0>;
+			reg = <0x12>;
+		};
+
+		composite-in at 20 {
+			compatible = "adi,adv7180";
+			reg = <0x20>;
+			remote = <&vin0>;
+
+			port {
+				adv7180: endpoint {
+					bus-width = <8>;
+					remote-endpoint = <&vin0ep>;
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
+						remote-endpoint = <&hdmi_con>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &extal_clk {
@@ -296,61 +371,9 @@
 
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-hdmi";
 
-	status = "okay";
 	clock-frequency = <400000>;
-
-	ak4642: codec at 12 {
-		compatible = "asahi-kasei,ak4642";
-		#sound-dai-cells = <0>;
-		reg = <0x12>;
-	};
-
-	composite-in at 20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-		remote = <&vin0>;
-
-		port {
-			adv7180: endpoint {
-				bus-width = <8>;
-				remote-endpoint = <&vin0ep>;
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
-					remote-endpoint = <&hdmi_con>;
-				};
-			};
-		};
-	};
 };
 
 &sata0 {
-- 
2.1.4
