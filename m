From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 19 Aug 2014 15:21:14 -0300
Subject: [PATCH 4/4] ARM: dts: imx6sl-evk: Add LCD support
In-Reply-To: <1408472474-4914-1-git-send-email-fabio.estevam@freescale.com>
References: <1408472474-4914-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1408472474-4914-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the "MX28LCD Seiko 4.3' WVGA" panel.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 92 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6sl.dtsi    |  6 +++
 2 files changed, 98 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 366eb02..9925c4a 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -20,6 +20,13 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -74,6 +81,14 @@
 			regulator-max-microvolt = <4325000>;
 			regulator-boot-on;
 		};
+
+		reg_lcd_3v3: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "lcd-3v3";
+			gpio = <&gpio4 3 0>;
+			enable-active-high;
+		};
 	};
 
 	sound {
@@ -340,12 +355,51 @@
 			>;
 		};
 
+		pinctrl_lcd: lcdgrp {
+			fsl,pins = <
+				MX6SL_PAD_LCD_DAT0__LCD_DATA00 0x1b0b0
+				MX6SL_PAD_LCD_DAT1__LCD_DATA01 0x1b0b0
+				MX6SL_PAD_LCD_DAT2__LCD_DATA02 0x1b0b0
+				MX6SL_PAD_LCD_DAT3__LCD_DATA03 0x1b0b0
+				MX6SL_PAD_LCD_DAT4__LCD_DATA04 0x1b0b0
+				MX6SL_PAD_LCD_DAT5__LCD_DATA05 0x1b0b0
+				MX6SL_PAD_LCD_DAT6__LCD_DATA06 0x1b0b0
+				MX6SL_PAD_LCD_DAT7__LCD_DATA07 0x1b0b0
+				MX6SL_PAD_LCD_DAT8__LCD_DATA08 0x1b0b0
+				MX6SL_PAD_LCD_DAT9__LCD_DATA09 0x1b0b0
+				MX6SL_PAD_LCD_DAT10__LCD_DATA10 0x1b0b0
+				MX6SL_PAD_LCD_DAT11__LCD_DATA11 0x1b0b0
+				MX6SL_PAD_LCD_DAT12__LCD_DATA12 0x1b0b0
+				MX6SL_PAD_LCD_DAT13__LCD_DATA13 0x1b0b0
+				MX6SL_PAD_LCD_DAT14__LCD_DATA14 0x1b0b0
+				MX6SL_PAD_LCD_DAT15__LCD_DATA15 0x1b0b0
+				MX6SL_PAD_LCD_DAT16__LCD_DATA16 0x1b0b0
+				MX6SL_PAD_LCD_DAT17__LCD_DATA17 0x1b0b0
+				MX6SL_PAD_LCD_DAT18__LCD_DATA18 0x1b0b0
+				MX6SL_PAD_LCD_DAT19__LCD_DATA19 0x1b0b0
+				MX6SL_PAD_LCD_DAT20__LCD_DATA20 0x1b0b0
+				MX6SL_PAD_LCD_DAT21__LCD_DATA21 0x1b0b0
+				MX6SL_PAD_LCD_DAT22__LCD_DATA22 0x1b0b0
+				MX6SL_PAD_LCD_DAT23__LCD_DATA23 0x1b0b0
+				MX6SL_PAD_LCD_CLK__LCD_CLK 0x1b0b0
+				MX6SL_PAD_LCD_ENABLE__LCD_ENABLE 0x1b0b0
+				MX6SL_PAD_LCD_HSYNC__LCD_HSYNC 0x1b0b0
+				MX6SL_PAD_LCD_VSYNC__LCD_VSYNC 0x1b0b0
+			>;
+		};
+
 		pinctrl_led: ledgrp {
 			fsl,pins = <
 				MX6SL_PAD_HSIC_STROBE__GPIO3_IO20 0x17059
 			>;
 		};
 
+		pinctrl_pwm1: pwmgrp {
+			fsl,pins = <
+				MX6SL_PAD_PWM1__PWM1_OUT 0x110b0
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6SL_PAD_UART1_RXD__UART1_RX_DATA	0x1b0b1
@@ -488,6 +542,44 @@
 	status = "okay";
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd>;
+	lcd-supply = <&reg_lcd_3v3>;
+	display = <&display>;
+	status = "okay";
+
+	display: display {
+		bits-per-pixel = <32>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <33500000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <89>;
+				hfront-porch = <164>;
+				vback-porch = <23>;
+				vfront-porch = <10>;
+				hsync-len = <10>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
 &ssi2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 505da9e..abdcbf9 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -635,8 +635,14 @@
 			};
 
 			lcdif: lcdif at 020f8000 {
+				compatible = "fsl,imx6sl-lcdif", "fsl,imx28-lcdif";
 				reg = <0x020f8000 0x4000>;
 				interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_LCDIF_PIX>,
+					 <&clks IMX6SL_CLK_LCDIF_AXI>,
+					 <&clks IMX6SL_CLK_DUMMY>;
+				clock-names = "pix", "axi", "disp_axi";
+				status = "disabled";
 			};
 
 			dcp: dcp at 020fc000 {
-- 
1.9.1
