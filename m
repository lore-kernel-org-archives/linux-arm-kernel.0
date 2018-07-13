From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 13 Jul 2018 15:58:27 +0800
Subject: [PATCH 3/3] ARM: dts: imx6sll-evk: enable SEIKO 43WVF1G lcdif panel
In-Reply-To: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
References: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1531468707-25737-3-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SEIKO 43WVF1G lcdif panel for DRM driver,
add necessary properties according to SEIKO 43WVF1G
driver's requirement, such as "dvdd-supply", "avdd-supply"
and "backlight" etc..

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 76 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 41e87e6..dc34da5 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -23,7 +23,7 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
-	backlight {
+	backlight_display: backlight-display {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -69,15 +69,22 @@
 		regulator-boot-on;
 	};
 
-	reg_lcd: regulator-lcd {
+	reg_lcd_3v3: regulator-lcd-3v3 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_lcd>;
-		regulator-name = "lcd-pwr";
+		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
+		regulator-name = "lcd-3v3";
 		gpio = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
+	reg_lcd_5v: regulator-lcd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
 	reg_sd1_vmmc: regulator-sd1-vmmc {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -99,6 +106,19 @@
 		gpio = <&gpio4 4 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	panel {
+		compatible = "sii,43wvf1g";
+		backlight = <&backlight_display>;
+		dvdd-supply = <&reg_lcd_3v3>;
+		avdd-supply = <&reg_lcd_5v>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
 };
 
 &cpu0 {
@@ -213,6 +233,18 @@
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
@@ -287,7 +319,7 @@
 		>;
 	};
 
-	pinctrl_reg_lcd: reglcdgrp {
+	pinctrl_reg_lcd_3v3: reglcd3v3grp {
 		fsl,pins = <
 			MX6SLL_PAD_KEY_ROW5__GPIO4_IO03 0x17059
 		>;
@@ -388,6 +420,40 @@
 		>;
 	};
 
+	pinctrl_lcd: lcdgrp {
+		fsl,pins = <
+			MX6SLL_PAD_LCD_DATA00__LCD_DATA00	0x79
+			MX6SLL_PAD_LCD_DATA01__LCD_DATA01	0x79
+			MX6SLL_PAD_LCD_DATA02__LCD_DATA02	0x79
+			MX6SLL_PAD_LCD_DATA03__LCD_DATA03	0x79
+			MX6SLL_PAD_LCD_DATA04__LCD_DATA04	0x79
+			MX6SLL_PAD_LCD_DATA05__LCD_DATA05	0x79
+			MX6SLL_PAD_LCD_DATA06__LCD_DATA06	0x79
+			MX6SLL_PAD_LCD_DATA07__LCD_DATA07	0x79
+			MX6SLL_PAD_LCD_DATA08__LCD_DATA08	0x79
+			MX6SLL_PAD_LCD_DATA09__LCD_DATA09	0x79
+			MX6SLL_PAD_LCD_DATA10__LCD_DATA10	0x79
+			MX6SLL_PAD_LCD_DATA11__LCD_DATA11	0x79
+			MX6SLL_PAD_LCD_DATA12__LCD_DATA12	0x79
+			MX6SLL_PAD_LCD_DATA13__LCD_DATA13	0x79
+			MX6SLL_PAD_LCD_DATA14__LCD_DATA14	0x79
+			MX6SLL_PAD_LCD_DATA15__LCD_DATA15	0x79
+			MX6SLL_PAD_LCD_DATA16__LCD_DATA16	0x79
+			MX6SLL_PAD_LCD_DATA17__LCD_DATA17	0x79
+			MX6SLL_PAD_LCD_DATA18__LCD_DATA18	0x79
+			MX6SLL_PAD_LCD_DATA19__LCD_DATA19	0x79
+			MX6SLL_PAD_LCD_DATA20__LCD_DATA20	0x79
+			MX6SLL_PAD_LCD_DATA21__LCD_DATA21	0x79
+			MX6SLL_PAD_LCD_DATA22__LCD_DATA22	0x79
+			MX6SLL_PAD_LCD_DATA23__LCD_DATA23	0x79
+			MX6SLL_PAD_LCD_CLK__LCD_CLK		0x79
+			MX6SLL_PAD_LCD_ENABLE__LCD_ENABLE	0x79
+			MX6SLL_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+			MX6SLL_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+			MX6SLL_PAD_LCD_RESET__LCD_RESET		0x79
+		>;
+	};
+
 	pinctrl_pwm1: pmw1grp {
 		fsl,pins = <
 			MX6SLL_PAD_PWM1__PWM1_OUT   0x110b0
-- 
2.7.4
