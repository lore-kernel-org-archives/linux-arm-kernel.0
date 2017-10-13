From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 13 Oct 2017 12:43:00 +0200
Subject: [PATCH 4/7] ARM: dts: imx6ul-txul: use panel-simple driver for LCD
In-Reply-To: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
References: <1507891383-15452-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507891383-15452-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the TXUL board support to use the panel-simple driver.
The now obsolete 'display-timings' node is kept for compatibility with
U-Boot, which derives its display configuration therefrom.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi | 263 ++++++++++++++++++------------------
 1 file changed, 134 insertions(+), 129 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index 9e2a966..f8f7685 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -47,7 +47,7 @@
 	aliases {
 		can0 = &can2;
 		can1 = &can1;
-		display = &display;
+		display = &lcdif;
 		i2c0 = &i2c2;
 		i2c1 = &i2c_gpio;
 		i2c2 = &i2c1;
@@ -85,10 +85,10 @@
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd_rst>;
-		enable-gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_lcd_pwr>;
+		enable-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
 		pwms = <&pwm5 0 500000 PWM_POLARITY_INVERTED>;
-		power-supply = <&reg_lcd_pwr>;
+		power-supply = <&reg_3v3>;
 		/*
 		 * a poor man's way to create a 1:1 relationship between
 		 * the PWM value and the actual duty cycle
@@ -127,6 +127,22 @@
 		};
 	};
 
+	lcd-panel {
+		compatible = "edt,etm0700g0dh6";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd_rst>;
+		enable-gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
+		backlight = <&backlight>;
+		bus-format-override = "rgb24";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -176,19 +192,6 @@
 		gpio = <&gpio3 5 GPIO_ACTIVE_LOW>;
 	};
 
-	reg_lcd_pwr: regulator-lcdpwr {
-		compatible = "regulator-fixed";
-		regulator-name = "LCD POWER";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd_pwr>;
-		gpio = <&gpio5 4 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
 	reg_usbh1_vbus: regulator-usbh1vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usbh1_vbus";
@@ -424,127 +427,129 @@
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_disp0_1>;
-	lcd-supply = <&reg_lcd_pwr>;
-	display = <&display>;
 	status = "okay";
 
-	display: display at di0 {
-		bits-per-pixel = <32>;
-		bus-width = <24>;
-		status = "okay";
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
 
-		display-timings {
-			VGA {
-				clock-frequency = <25200000>;
-				hactive = <640>;
-				vactive = <480>;
-				hback-porch = <48>;
-				hsync-len = <96>;
-				hfront-porch = <16>;
-				vback-porch = <31>;
-				vsync-len = <2>;
-				vfront-porch = <12>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
+	display-timings {
+		VGA {
+			clock-frequency = <25200000>;
+			hactive = <640>;
+			vactive = <480>;
+			hback-porch = <48>;
+			hsync-len = <96>;
+			hfront-porch = <16>;
+			vback-porch = <31>;
+			vsync-len = <2>;
+			vfront-porch = <12>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
 
-			ETV570 {
-				clock-frequency = <25200000>;
-				hactive = <640>;
-				vactive = <480>;
-				hback-porch = <114>;
-				hsync-len = <30>;
-				hfront-porch = <16>;
-				vback-porch = <32>;
-				vsync-len = <3>;
-				vfront-porch = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
+		ETV570 {
+			u-boot,panel-name = "edt,et057090dhu";
+			clock-frequency = <25200000>;
+			hactive = <640>;
+			vactive = <480>;
+			hback-porch = <114>;
+			hsync-len = <30>;
+			hfront-porch = <16>;
+			vback-porch = <32>;
+			vsync-len = <3>;
+			vfront-porch = <10>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
 
-			ET0350 {
-				clock-frequency = <6413760>;
-				hactive = <320>;
-				vactive = <240>;
-				hback-porch = <34>;
-				hsync-len = <34>;
-				hfront-porch = <20>;
-				vback-porch = <15>;
-				vsync-len = <3>;
-				vfront-porch = <4>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
+		ET0350 {
+			u-boot,panel-name = "edt,et0350g0dh6";
+			clock-frequency = <6413760>;
+			hactive = <320>;
+			vactive = <240>;
+			hback-porch = <34>;
+			hsync-len = <34>;
+			hfront-porch = <20>;
+			vback-porch = <15>;
+			vsync-len = <3>;
+			vfront-porch = <4>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
 
-			ET0430 {
-				clock-frequency = <9009000>;
-				hactive = <480>;
-				vactive = <272>;
-				hback-porch = <2>;
-				hsync-len = <41>;
-				hfront-porch = <2>;
-				vback-porch = <2>;
-				vsync-len = <10>;
-				vfront-porch = <2>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
+		ET0430 {
+			u-boot,panel-name = "edt,et0430g0dh6";
+			clock-frequency = <9009000>;
+			hactive = <480>;
+			vactive = <272>;
+			hback-porch = <2>;
+			hsync-len = <41>;
+			hfront-porch = <2>;
+			vback-porch = <2>;
+			vsync-len = <10>;
+			vfront-porch = <2>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <0>;
+		};
 
-			ET0500 {
-				clock-frequency = <33264000>;
-				hactive = <800>;
-				vactive = <480>;
-				hback-porch = <88>;
-				hsync-len = <128>;
-				hfront-porch = <40>;
-				vback-porch = <33>;
-				vsync-len = <2>;
-				vfront-porch = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
+		ET0500 {
+			clock-frequency = <33264000>;
+			hactive = <800>;
+			vactive = <480>;
+			hback-porch = <88>;
+			hsync-len = <128>;
+			hfront-porch = <40>;
+			vback-porch = <33>;
+			vsync-len = <2>;
+			vfront-porch = <10>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
 
-			ET0700 { /* same as ET0500 */
-				clock-frequency = <33264000>;
-				hactive = <800>;
-				vactive = <480>;
-				hback-porch = <88>;
-				hsync-len = <128>;
-				hfront-porch = <40>;
-				vback-porch = <33>;
-				vsync-len = <2>;
-				vfront-porch = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
+		ET0700 { /* same timing as ET0500 */
+			u-boot,panel-name = "edt,etm0700g0dh6";
+			clock-frequency = <33264000>;
+			hactive = <800>;
+			vactive = <480>;
+			hback-porch = <88>;
+			hsync-len = <128>;
+			hfront-porch = <40>;
+			vback-porch = <33>;
+			vsync-len = <2>;
+			vfront-porch = <10>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
 
-			ETQ570 {
-				clock-frequency = <6596040>;
-				hactive = <320>;
-				vactive = <240>;
-				hback-porch = <38>;
-				hsync-len = <30>;
-				hfront-porch = <30>;
-				vback-porch = <16>;
-				vsync-len = <3>;
-				vfront-porch = <4>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
+		ETQ570 {
+			clock-frequency = <6596040>;
+			hactive = <320>;
+			vactive = <240>;
+			hback-porch = <38>;
+			hsync-len = <30>;
+			hfront-porch = <30>;
+			vback-porch = <16>;
+			vsync-len = <3>;
+			vfront-porch = <4>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
 		};
 	};
 };
-- 
2.1.4
