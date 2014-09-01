From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 1 Sep 2014 14:50:03 -0300
Subject: [PATCH 2/2] ARM: dts: imx6x-sdb: Add LCD support
In-Reply-To: <1409593803-12368-1-git-send-email-fabio.estevam@freescale.com>
References: <1409593803-12368-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1409593803-12368-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the "MX28LCD Seiko 4.3' WVGA" panel.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts | 93 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index a3980d9..e2c244d 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -24,6 +24,13 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm3 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -90,6 +97,14 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 		};
+
+		reg_lcd_3v3: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "lcd-3v3";
+			gpio = <&gpio3 27 0>;
+			enable-active-high;
+		};
 	};
 
 	sound {
@@ -251,6 +266,44 @@
 	};
 };
 
+&lcdif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd>;
+	lcd-supply = <&reg_lcd_3v3>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display {
+		bits-per-pixel = <16>;
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
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
 &ssi2 {
 	status = "okay";
 };
@@ -365,6 +418,46 @@
 			>;
 		};
 
+		pinctrl_lcd: lcdgrp {
+			fsl,pins = <
+				MX6SX_PAD_LCD1_DATA00__LCDIF1_DATA_0 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA01__LCDIF1_DATA_1 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA02__LCDIF1_DATA_2 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA03__LCDIF1_DATA_3 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA04__LCDIF1_DATA_4 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA05__LCDIF1_DATA_5 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA06__LCDIF1_DATA_6 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA07__LCDIF1_DATA_7 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA08__LCDIF1_DATA_8 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA09__LCDIF1_DATA_9 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA10__LCDIF1_DATA_10 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA11__LCDIF1_DATA_11 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA12__LCDIF1_DATA_12 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA13__LCDIF1_DATA_13 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA14__LCDIF1_DATA_14 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA15__LCDIF1_DATA_15 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA16__LCDIF1_DATA_16 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA17__LCDIF1_DATA_17 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA18__LCDIF1_DATA_18 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA19__LCDIF1_DATA_19 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA20__LCDIF1_DATA_20 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA21__LCDIF1_DATA_21 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA22__LCDIF1_DATA_22 0x4001b0b0
+				MX6SX_PAD_LCD1_DATA23__LCDIF1_DATA_23 0x4001b0b0
+				MX6SX_PAD_LCD1_CLK__LCDIF1_CLK	0x4001b0b0
+				MX6SX_PAD_LCD1_ENABLE__LCDIF1_ENABLE 0x4001b0b0
+				MX6SX_PAD_LCD1_VSYNC__LCDIF1_VSYNC 0x4001b0b0
+				MX6SX_PAD_LCD1_HSYNC__LCDIF1_HSYNC 0x4001b0b0
+				MX6SX_PAD_LCD1_RESET__GPIO3_IO_27 0x4001b0b0
+			>;
+		};
+
+		pinctrl_pwm3: pwm3grp-1 {
+			fsl,pins = <
+				MX6SX_PAD_SD1_DATA2__PWM3_OUT 0x110b0
+			>;
+		};
+
 		pinctrl_vcc_sd3: vccsd3grp {
 			fsl,pins = <
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
-- 
1.9.1
