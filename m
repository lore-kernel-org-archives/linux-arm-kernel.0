From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 30 Jun 2015 23:44:11 +0200
Subject: [RFC 3/3] ARM: shmobile: r8a7790: rework dts to use i2c demuxer
In-Reply-To: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1435700651-3543-4-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Create a seperate bus for HDMI related I2C slaves and assign it
to a i2c-gpio master. It can be switched to the i2c-rcar or
i2c-sh_mobile core at runtime.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 141 ++++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index aaa4f258e279cc..c695728b451506 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -49,6 +49,8 @@
 	aliases {
 		serial0 = &scifa0;
 		serial1 = &scifa1;
+		i2c8 = &i2chdmi;
+		i2c9 = &gpioi2c;
 	};
 
 	chosen {
@@ -245,6 +247,79 @@
 		#clock-cells = <0>;
 		clock-frequency = <148500000>;
 	};
+
+
+	gpioi2c: i2c at 9 {
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
+	i2chdmi: i2c at 8 {
+
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&gpioi2c>, <&iic2>, <&i2c2>;
+		i2c-bus-name = "i2c-hdmi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ak4643: sound-codec at 12 {
+			compatible = "asahi-kasei,ak4643";
+
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
+			interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
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
@@ -340,6 +415,11 @@
 		renesas,function = "iic1";
 	};
 
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
 	iic2_pins: iic2 {
 		renesas,groups = "iic2";
 		renesas,function = "iic2";
@@ -518,63 +598,18 @@
 	pinctrl-names = "default";
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
 
-	ak4643: sound-codec at 12 {
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
-		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
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
