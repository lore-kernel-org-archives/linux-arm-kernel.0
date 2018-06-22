From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Fri, 22 Jun 2018 16:52:25 +0200
Subject: [PATCH 1/1] ARM: dts: imx53: PPD: Add fixed-regulator information
Message-ID: <20180622145225.17883-1-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add information about 3V3 power rail to avoid kernel warnings,
that dummy regulators have been added.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 37 +++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 4ddef5abda56..e0bbb70b42c6 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -140,6 +140,26 @@
 		regulator-always-on;
 	};
 
+	reg_3v3: regulator-3v3 {
+		/* TPS54320 */
+		compatible = "regulator-fixed";
+		regulator-name = "3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_3v3_lcd: regulator-3v3-lcd {
+		/* MIC2009 */
+		compatible = "regulator-fixed";
+		regulator-name = "LCD_3V3";
+		vin-supply = <&reg_3v3>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	pwm_bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm2 0 50000>;
@@ -154,6 +174,7 @@
 				     234 237 239 242 244 247 249 252 255>;
 		default-brightness-level = <0>;
 		enable-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3_lcd>;
 	};
 
 	leds {
@@ -198,8 +219,9 @@
 		};
 	};
 
-	usbphy2: usbphy2 {
+	usbphy2: usbphy-2 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
 		clock-names = "main_clk";
 		clock-frequency = <24000000>;
@@ -208,8 +230,9 @@
 		assigned-clock-parents = <&clks IMX5_CLK_OSC>;
 	};
 
-	usbphy3: usbphy3 {
+	usbphy3: usbphy-3 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
 		clock-names = "main_clk";
 
@@ -221,6 +244,7 @@
 
 	panel-lvds0 {
 		compatible = "nvd,9128";
+		power-supply = <&reg_3v3_lcd>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -230,6 +254,14 @@
 	};
 };
 
+&usbphy0 {
+	vcc-supply = <&reg_3v3>;
+};
+
+&usbphy1 {
+	vcc-supply = <&reg_3v3>;
+};
+
 &audmux {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
@@ -409,6 +441,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
+	phy-supply = <&reg_3v3>;
 	phy-mode = "rmii";
 	phy-reset-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
 	status = "okay";
-- 
2.17.1
