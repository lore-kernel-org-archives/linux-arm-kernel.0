From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:34 +0100
Subject: [PATCH 37/47] ARM: dts: porter: use demuxer for I2C2
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <12937bffd64f5b9970589d0b946305d14cc45e6a.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Create a separate bus for HDMI related I2C2 and provide fallback to GPIO.

Based on work for the r8a7790/lager by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased, fixed aliases, switched to named GPIOs]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 128 ++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 9a02d03b23c2..c14e6fe9e4f6 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -29,6 +29,8 @@
 
 	aliases {
 		serial0 = &scif0;
+		i2c9 = &gpioi2c2;
+		i2c10 = &i2chdmi;
 	};
 
 	chosen {
@@ -135,6 +137,78 @@
 			clocks = <&x14_clk>;
 		};
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
@@ -296,61 +370,9 @@
 
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
2.11.0
