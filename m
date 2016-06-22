From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 22 Jun 2016 12:43:41 +0900
Subject: [PATCH v3 03/13] ARM: dts: lager: use demuxer for IIC2/I2C2
In-Reply-To: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
References: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1466567031-20381-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a separate bus for HDMI related I2C slaves.

Based on work by Wolfram Sang.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3
* Name GPIO i2c node gpioi2c2 instead of gpioi2c2 as there
  is now another gpioi2c node
* Add a small comment documenting that IIC2/I2C2 may be switched
  and that a GPIO fallback is provided.
* Group additional GPIO buses

v2
* No change
---
 arch/arm/boot/dts/r8a7790-lager.dts | 142 ++++++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 05302d0d7e33..862d766b932b 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -51,8 +51,10 @@
 		serial0 = &scif0;
 		serial1 = &scifa1;
 		i2c8 = "gpioi2c1";
+		i2c9 = "gpioi2c2";
 		i2c10 = "i2cexio0";
 		i2c11 = "i2cexio1";
+		i2c12 = "i2chdmi";
 	};
 
 	chosen {
@@ -267,6 +269,17 @@
 		i2c-gpio,delay-us = <5>;
 	};
 
+	gpioi2c2: i2c-9 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio5 6 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio5 5 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	/*
 	 * IIC0/I2C0 is routed to EXIO connector A, pins 114 (SCL) + 116 (SDA) only.
 	 * We use the I2C demuxer, so the desired IP core can be selected at runtime
@@ -298,6 +311,69 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+        /*
+         * IIC2 and I2C2 may be switched using pinmux.
+         * A fallback to GPIO also provided.
+         */
+	i2chdmi: i2c-12 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&iic2>, <&i2c2>, <&gpioi2c2>;
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
+			compatible = "adi,adv7180";
+			reg = <0x20>;
+			remote = <&vin1>;
+
+			port {
+				adv7180: endpoint {
+					bus-width = <8>;
+					remote-endpoint = <&vin1ep0>;
+				};
+			};
+		};
+
+		hdmi at 39 {
+			compatible = "adi,adv7511w";
+			reg = <0x39>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
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
+						remote-endpoint = <&du_out_lvds0>;
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
 
 &du {
@@ -430,6 +506,11 @@
 		function = "iic1";
 	};
 
+	i2c2_pins: i2c2 {
+		groups = "i2c2";
+		function = "i2c2";
+	};
+
 	iic2_pins: iic2 {
 		groups = "iic2";
 		function = "iic2";
@@ -631,63 +712,18 @@
 	pinctrl-names = "i2c-exio1";
 };
 
-&iic2	{
-	status = "okay";
-	pinctrl-0 = <&iic2_pins>;
-	pinctrl-names = "default";
+&i2c2	{
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "i2c-hdmi";
 
 	clock-frequency = <100000>;
+};
 
-	ak4643: codec at 12 {
-		compatible = "asahi-kasei,ak4643";
-		#sound-dai-cells = <0>;
-		reg = <0x12>;
-	};
-
-	composite-in at 20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-		remote = <&vin1>;
-
-		port {
-			adv7180: endpoint {
-				bus-width = <8>;
-				remote-endpoint = <&vin1ep0>;
-			};
-		};
-	};
-
-	hdmi at 39 {
-		compatible = "adi,adv7511w";
-		reg = <0x39>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
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
-					remote-endpoint = <&du_out_lvds0>;
-				};
-			};
+&iic2	{
+	pinctrl-0 = <&iic2_pins>;
+	pinctrl-names = "i2c-hdmi";
 
-			port at 1 {
-				reg = <1>;
-				adv7511_out: endpoint {
-					remote-endpoint = <&hdmi_con>;
-				};
-			};
-		};
-	};
+	clock-frequency = <100000>;
 };
 
 &iic3 {
-- 
2.1.4
