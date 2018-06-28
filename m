From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Thu, 28 Jun 2018 18:36:38 +0200
Subject: [PATCHv2 1/2] ARM: dts: imx53: PPD: Add fixed-regulator information
Message-ID: <20180628163639.1078-1-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add information about 3V3 power rail to avoid kernel warnings,
that dummy regulators have been added.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Changes since PATCHv1:
 * split usbphy rename into its own patch
 * drop useless regulator-boot-on
---
 arch/arm/boot/dts/imx53-ppd.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 4ddef5abda56..daed979b6e40 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -140,6 +140,25 @@
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
+	};
+
 	pwm_bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm2 0 50000>;
@@ -154,6 +173,7 @@
 				     234 237 239 242 244 247 249 252 255>;
 		default-brightness-level = <0>;
 		enable-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3_lcd>;
 	};
 
 	leds {
@@ -200,6 +220,7 @@
 
 	usbphy2: usbphy2 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
 		clock-names = "main_clk";
 		clock-frequency = <24000000>;
@@ -210,6 +231,7 @@
 
 	usbphy3: usbphy3 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_3v3>;
 		reset-gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
 		clock-names = "main_clk";
 
@@ -221,6 +243,7 @@
 
 	panel-lvds0 {
 		compatible = "nvd,9128";
+		power-supply = <&reg_3v3_lcd>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -230,6 +253,14 @@
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
@@ -409,6 +440,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
+	phy-supply = <&reg_3v3>;
 	phy-mode = "rmii";
 	phy-reset-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
 	status = "okay";
-- 
2.18.0
