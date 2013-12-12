From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Dec 2013 14:28:00 +0100
Subject: [PATCH 4/4] ARM: dts: imx6qdl: add support for Ka-Ro TX6 modules
In-Reply-To: <1386854880-21805-1-git-send-email-LW@KARO-electronics.de>
References: <1386854880-21805-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1386854880-21805-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the Ka-Ro electronics GmbH TX6 modules.
There are four distinct module types.
Two equipped with an i.MX6Q processor, two with i.MX6DL.
Each of these has either an LVDS display interface or a parallel LCD
interface.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile             |    4 +
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts |  350 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts |  242 ++++++++++++++++++
 arch/arm/boot/dts/imx6q-tx6q-101x.dts  |  350 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-tx6q-111x.dts  |  246 ++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-tx6.dtsi     |  434 ++++++++++++++++++++++++++++++++
 6 files changed, 1626 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-801x.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-811x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-101x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-111x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 535c98f..40175a9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -152,6 +152,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6dl-gw54xx.dtb \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabresd.dtb \
+	imx6dl-tx6u-801x.dtb \
+	imx6dl-tx6u-811x.dtb \
 	imx6dl-wandboard.dtb \
 	imx6q-arm2.dtb \
 	imx6q-cm-fx6.dtb \
@@ -166,6 +168,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
 	imx6q-sbc6x.dtb \
+	imx6q-tx6q-101x.dtb \
+	imx6q-tx6q-111x.dtb \
 	imx6q-udoo.dtb \
 	imx6q-wandboard.dtb \
 	imx6sl-evk.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts b/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
new file mode 100644
index 0000000..453a05b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
@@ -0,0 +1,350 @@
+/*
+ * Copyright 2013 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6DL Module";
+	compatible = "fsl,imx6dl-tx6dl", "fsl,imx6dl";
+
+	aliases {
+		display = &display;
+		lcdif_23bit_pins_a = &pinctrl_disp0_1;
+		lcdif_24bit_pins_a = &pinctrl_disp0_2;
+	};
+
+	backlight at 0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000>;
+		power-supply = <&reg_3v3>;
+		/*
+		 * a poor man's way to create an inverse 1:1 relationship
+		 * between the PWM value and the actual duty cycle
+		 */
+		brightness-levels = <100
+				      99 98 97 96 95 94 93 92 91 90
+				      89 88 87 86 85 84 83 82 81 80
+				      79 78 77 76 75 74 73 72 71 70
+				      69 68 67 66 65 64 63 62 61 60
+				      59 58 57 56 55 54 53 52 51 50
+				      49 48 47 46 45 44 43 42 41 40
+				      39 38 37 36 35 34 33 32 31 30
+				      29 28 27 26 25 24 23 22 21 20
+				      19 18 17 16 15 14 13 12 11 10
+				       9  8  7  6  5  4  3  2  1  0>;
+		default-brightness-level = <50>;
+	};
+
+	display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		crtcs = <&ipu1 0>;
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_disp0_1>;
+		status = "okay";
+
+		display-timings {
+			timing at 0 {
+				panel-name = "VGA";
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hsync-len = <96>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vsync-len = <2>;
+				vfront-porch = <12>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 1 {
+				panel-name = "ETV570";
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <114>;
+				hsync-len = <30>;
+				hfront-porch = <16>;
+				vback-porch = <32>;
+				vsync-len = <3>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 2 {
+				panel-name = "ET0350";
+				clock-frequency = <6413760>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <34>;
+				hsync-len = <34>;
+				hfront-porch = <20>;
+				vback-porch = <15>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 3 {
+				panel-name = "ET0430";
+				clock-frequency = <9009000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <2>;
+				hsync-len = <41>;
+				hfront-porch = <2>;
+				vback-porch = <2>;
+				vsync-len = <10>;
+				vfront-porch = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			timing at 4 {
+				panel-name = "ET0500";
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 5 {
+				panel-name = "ET0700"; /* same as ET0500 */
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 6 {
+				panel-name = "ETQ570";
+				clock-frequency = <6596040>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <38>;
+				hsync-len = <30>;
+				hfront-porch = <30>;
+				vback-porch = <16>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+        };
+
+	regulators {
+		reg_lcd_pwr: regulator at 6 {
+			compatible = "regulator-fixed";
+			regulator-name = "LCD POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+
+		reg_lcd_reset: regulator at 7 {
+			compatible = "regulator-fixed";
+			regulator-name = "LCD RESET";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+			startup-delay-us = <300000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+};
+
+&i2c3 {
+	touchscreen: tsc2007 at 48 {
+		compatible = "ti,tsc2007";
+		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc2007>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 0>;
+		gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
+		ti,x-plate-ohms = <660>;
+		linux,wakeup;
+	};
+
+	polytouch: edt-ft5x06 at 38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_edt_ft5x06>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <15 0>;
+		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+		wake-gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&iomuxc {
+	display {
+		pinctrl_disp0_1: disp0grp-1 {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
+				/* PAD DISP0_DAT0 is used for the Flexcan transceiver control */
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+			>;
+		};
+
+		pinctrl_disp0_2: disp0grp-2 {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
+				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+			>;
+		};
+	};
+
+	kpp {
+		pinctrl_kpp: kppgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_9__KEY_COL6 0x1b0b1
+				MX6QDL_PAD_GPIO_4__KEY_COL7 0x1b0b1
+				MX6QDL_PAD_KEY_COL2__KEY_COL2 0x1b0b1
+				MX6QDL_PAD_KEY_COL3__KEY_COL3 0x1b0b1
+
+				MX6QDL_PAD_GPIO_2__KEY_ROW6 0x1b0b1
+				MX6QDL_PAD_GPIO_5__KEY_ROW7 0x1b0b1
+				MX6QDL_PAD_KEY_ROW2__KEY_ROW2 0x1b0b1
+				MX6QDL_PAD_KEY_ROW3__KEY_ROW3 0x1b0b1
+			>;
+		};
+	};
+
+	touchpanel {
+		pinctrl_tsc2007: tsc2007grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D26__GPIO3_IO26 0x1b0b0 /* Interrupt */
+			>;
+		};
+
+		pinctrl_edt_ft5x06: edt-ft5x06grp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x1b0b0 /* Interrupt */
+				MX6QDL_PAD_EIM_A16__GPIO2_IO22   0x1b0b0 /* Reset */
+				MX6QDL_PAD_EIM_A17__GPIO2_IO21   0x1b0b0 /* Wake */
+			>;
+		};
+	};
+};
+
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp>;
+	status = "okay";
+
+	/* sample keymap */
+	/* row/col 0,1 are mapped to KPP row/col 6,7 */
+	linux,keymap = <
+		0x06060074 /* row 6, col 6, KEY_POWER */
+		0x06070052 /* row 6, col 7, KEY_KP0 */
+		0x0602004f /* row 6, col 2, KEY_KP1 */
+		0x06030050 /* row 6, col 3, KEY_KP2 */
+		0x07060051 /* row 7, col 6, KEY_KP3 */
+		0x0707004b /* row 7, col 7, KEY_KP4 */
+		0x0702004c /* row 7, col 2, KEY_KP5 */
+		0x0703004d /* row 7, col 3, KEY_KP6 */
+		0x02060047 /* row 2, col 6, KEY_KP7 */
+		0x02070048 /* row 2, col 7, KEY_KP8 */
+		0x02020049 /* row 2, col 2, KEY_KP9 */
+	>;
+};
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
new file mode 100644
index 0000000..1c4b24e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
@@ -0,0 +1,242 @@
+/*
+ * Copyright 2013 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6DL (LVDS) Module";
+	compatible = "fsl,imx6dl-tx6dl", "fsl,imx6dl";
+
+	aliases {
+		display = &lvds0;
+		lvds0 = &lvds0;
+		lvds1 = &lvds1;
+	};
+
+	backlight at 0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000>;
+		power-supply = <&reg_3v3>;
+		brightness-levels = <
+			  0  1  2  3  4  5  6  7  8  9
+			 10 11 12 13 14 15 16 17 18 19
+			 20 21 22 23 24 25 26 27 28 29
+			 30 31 32 33 34 35 36 37 38 39
+			 40 41 42 43 44 45 46 47 48 49
+			 50 51 52 53 54 55 56 57 58 59
+			 60 61 62 63 64 65 66 67 68 69
+			 70 71 72 73 74 75 76 77 78 79
+			 80 81 82 83 84 85 86 87 88 89
+			 90 91 92 93 94 95 96 97 98 99
+			100
+		>;
+		default-brightness-level = <50>;
+	};
+
+	backlight1: pwm-backlight at 1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000>;
+		power-supply = <&reg_3v3>;
+		brightness-levels = <
+			  0  1  2  3  4  5  6  7  8  9
+			 10 11 12 13 14 15 16 17 18 19
+			 20 21 22 23 24 25 26 27 28 29
+			 30 31 32 33 34 35 36 37 38 39
+			 40 41 42 43 44 45 46 47 48 49
+			 50 51 52 53 54 55 56 57 58 59
+			 60 61 62 63 64 65 66 67 68 69
+			 70 71 72 73 74 75 76 77 78 79
+			 80 81 82 83 84 85 86 87 88 89
+			 90 91 92 93 94 95 96 97 98 99
+			100
+		>;
+		default-brightness-level = <50>;
+	};
+
+
+	regulators {
+		reg_lcd_pwr: regulator at 6 {
+			compatible = "regulator-fixed";
+			regulator-name = "LVDS0 POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+
+		reg_lcd_reset: regulator at 7 {
+			compatible = "regulator-fixed";
+			regulator-name = "LVDS1 POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+
+	touchscreen2: eeti at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eeti_2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <23 0>;
+		wakeup-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+		linux,wakeup;
+	};
+};
+
+&i2c3 {
+	touchscreen1: eeti at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eeti_1>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 0>;
+		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		linux,wakeup;
+	};
+};
+
+&iomuxc {
+	i2c {
+		pinctrl_i2c2: i2c2-grp1 {
+			fsl,pins = <MX6QDL_I2C2_PINGRP2>;
+		};
+	};
+
+	kpp {
+		pinctrl_kpp: kppgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_9__KEY_COL6 0x1b0b1
+				MX6QDL_PAD_GPIO_4__KEY_COL7 0x1b0b1
+				MX6QDL_PAD_KEY_COL2__KEY_COL2 0x1b0b1
+
+				MX6QDL_PAD_GPIO_2__KEY_ROW6 0x1b0b1
+				MX6QDL_PAD_GPIO_5__KEY_ROW7 0x1b0b1
+				MX6QDL_PAD_KEY_ROW2__KEY_ROW2 0x1b0b1
+			>;
+		};
+	};
+
+	pwm {
+		pinctrl_pwm1: pwm1grp {
+			fsl,pins = <MX6QDL_PAD_GPIO_9__PWM1_OUT 0x80000000>;
+		};
+	};
+
+	touchpanel {
+		pinctrl_eeti_1: eetigrp-1 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0xe0 /* Interrupt */
+			>;
+		};
+
+		pinctrl_eeti_2: eetigrp-2 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D23__GPIO3_IO23 0xe0 /* Interrupt */
+			>;
+		};
+	};
+};
+
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp>;
+	status = "okay";
+
+	/* sample keymap */
+	/* row/col 0,1 are mapped to KPP row/col 6,7
+	 * row/col 3 are used for I2C2 (second touch controller on hsd100pxn1)
+	 */
+	linux,keymap = <
+		0x06060074 /* row 6, col 6, KEY_POWER */
+		0x06070052 /* row 6, col 7, KEY_KP0 */
+		0x0602004f /* row 6, col 2, KEY_KP1 */
+		0x07060050 /* row 7, col 6, KEY_KP2 */
+		0x07070051 /* row 7, col 7, KEY_KP3 */
+		0x0702004b /* row 7, col 2, KEY_KP4 */
+		0x0206004c /* row 2, col 6, KEY_KP5 */
+		0x0207004d /* row 2, col 7, KEY_KP6 */
+		0x02020047 /* row 2, col 2, KEY_KP7 */
+	>;
+};
+
+&ldb {
+	status = "okay";
+//	fsl,dual-channel;
+
+	lvds0: lvds-channel at 0 {
+		fsl,data-mapping = "jeida";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&lvds_timing0>;
+			lvds_timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hsync-len = <60>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vsync-len = <10>;
+				vfront-porch = <7>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+
+	lvds1: lvds-channel at 1 {
+		fsl,data-mapping = "jeida";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&lvds_timing1>;
+			lvds_timing1: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hsync-len = <60>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vsync-len = <10>;
+				vfront-porch = <7>;
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
+};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-101x.dts b/arch/arm/boot/dts/imx6q-tx6q-101x.dts
new file mode 100644
index 0000000..066bbee
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-tx6q-101x.dts
@@ -0,0 +1,350 @@
+/*
+ * Copyright 2013 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6Q Module";
+	compatible = "fsl,imx6q-tx6q", "fsl,imx6q";
+
+	aliases {
+		display = &display;
+		lcdif_23bit_pins_a = &pinctrl_disp0_1;
+		lcdif_24bit_pins_a = &pinctrl_disp0_2;
+	};
+
+	backlight at 0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000>;
+		power-supply = <&reg_3v3>;
+		/*
+		 * a poor man's way to create an inverse 1:1 relationship
+		 * between the PWM value and the actual duty cycle
+		 */
+		brightness-levels = <100
+				      99 98 97 96 95 94 93 92 91 90
+				      89 88 87 86 85 84 83 82 81 80
+				      79 78 77 76 75 74 73 72 71 70
+				      69 68 67 66 65 64 63 62 61 60
+				      59 58 57 56 55 54 53 52 51 50
+				      49 48 47 46 45 44 43 42 41 40
+				      39 38 37 36 35 34 33 32 31 30
+				      29 28 27 26 25 24 23 22 21 20
+				      19 18 17 16 15 14 13 12 11 10
+				       9  8  7  6  5  4  3  2  1  0>;
+		default-brightness-level = <50>;
+	};
+
+	display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		crtcs = <&ipu1 0>;
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_disp0_1>;
+		status = "okay";
+
+		display-timings {
+			timing at 0 {
+				panel-name = "VGA";
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hsync-len = <96>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vsync-len = <2>;
+				vfront-porch = <12>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 1 {
+				panel-name = "ETV570";
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <114>;
+				hsync-len = <30>;
+				hfront-porch = <16>;
+				vback-porch = <32>;
+				vsync-len = <3>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 2 {
+				panel-name = "ET0350";
+				clock-frequency = <6413760>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <34>;
+				hsync-len = <34>;
+				hfront-porch = <20>;
+				vback-porch = <15>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 3 {
+				panel-name = "ET0430";
+				clock-frequency = <9009000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <2>;
+				hsync-len = <41>;
+				hfront-porch = <2>;
+				vback-porch = <2>;
+				vsync-len = <10>;
+				vfront-porch = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			timing at 4 {
+				panel-name = "ET0500";
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 5 {
+				panel-name = "ET0700"; /* same as ET0500 */
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			timing at 6 {
+				panel-name = "ETQ570";
+				clock-frequency = <6596040>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <38>;
+				hsync-len = <30>;
+				hfront-porch = <30>;
+				vback-porch = <16>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+        };
+
+	regulators {
+		reg_lcd_pwr: regulator at 6 {
+			compatible = "regulator-fixed";
+			regulator-name = "LCD POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+
+		reg_lcd_reset: regulator at 7 {
+			compatible = "regulator-fixed";
+			regulator-name = "LCD RESET";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+			startup-delay-us = <300000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+};
+
+&i2c3 {
+	touchscreen: tsc2007 at 48 {
+		compatible = "ti,tsc2007";
+		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc2007>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 0>;
+		gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
+		ti,x-plate-ohms = <660>;
+		linux,wakeup;
+	};
+
+	polytouch: edt-ft5x06 at 38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_edt_ft5x06>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <15 0>;
+		reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+		wake-gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&iomuxc {
+	display {
+		pinctrl_disp0_1: disp0grp-1 {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
+				/* PAD DISP0_DAT0 is used for the Flexcan transceiver control */
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+			>;
+		};
+
+		pinctrl_disp0_2: disp0grp-2 {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
+				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
+				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
+				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
+				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
+				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
+				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
+				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+			>;
+		};
+	};
+
+	kpp {
+		pinctrl_kpp: kppgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_9__KEY_COL6 0x1b0b1
+				MX6QDL_PAD_GPIO_4__KEY_COL7 0x1b0b1
+				MX6QDL_PAD_KEY_COL2__KEY_COL2 0x1b0b1
+				MX6QDL_PAD_KEY_COL3__KEY_COL3 0x1b0b1
+
+				MX6QDL_PAD_GPIO_2__KEY_ROW6 0x1b0b1
+				MX6QDL_PAD_GPIO_5__KEY_ROW7 0x1b0b1
+				MX6QDL_PAD_KEY_ROW2__KEY_ROW2 0x1b0b1
+				MX6QDL_PAD_KEY_ROW3__KEY_ROW3 0x1b0b1
+			>;
+		};
+	};
+
+	touchpanel {
+		pinctrl_tsc2007: tsc2007grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D26__GPIO3_IO26 0x1b0b0 /* Interrupt */
+			>;
+		};
+
+		pinctrl_edt_ft5x06: edt-ft5x06grp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x1b0b0 /* Interrupt */
+				MX6QDL_PAD_EIM_A16__GPIO2_IO22   0x1b0b0 /* Reset */
+				MX6QDL_PAD_EIM_A17__GPIO2_IO21   0x1b0b0 /* Wake */
+			>;
+		};
+	};
+};
+
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp>;
+	status = "okay";
+
+	/* sample keymap */
+	/* row/col 0,1 are mapped to KPP row/col 6,7 */
+	linux,keymap = <
+		0x06060074 /* row 6, col 6, KEY_POWER */
+		0x06070052 /* row 6, col 7, KEY_KP0 */
+		0x0602004f /* row 6, col 2, KEY_KP1 */
+		0x06030050 /* row 6, col 3, KEY_KP2 */
+		0x07060051 /* row 7, col 6, KEY_KP3 */
+		0x0707004b /* row 7, col 7, KEY_KP4 */
+		0x0702004c /* row 7, col 2, KEY_KP5 */
+		0x0703004d /* row 7, col 3, KEY_KP6 */
+		0x02060047 /* row 2, col 6, KEY_KP7 */
+		0x02070048 /* row 2, col 7, KEY_KP8 */
+		0x02020049 /* row 2, col 2, KEY_KP9 */
+	>;
+};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-111x.dts b/arch/arm/boot/dts/imx6q-tx6q-111x.dts
new file mode 100644
index 0000000..102666a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-tx6q-111x.dts
@@ -0,0 +1,246 @@
+/*
+ * Copyright 2013 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6Q (LVDS) Module";
+	compatible = "fsl,imx6q-tx6q", "fsl,imx6q";
+
+	aliases {
+		display = &lvds0;
+		lvds0 = &lvds0;
+		lvds1 = &lvds1;
+	};
+
+	backlight at 0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000>;
+		power-supply = <&reg_3v3>;
+		brightness-levels = <
+			  0  1  2  3  4  5  6  7  8  9
+			 10 11 12 13 14 15 16 17 18 19
+			 20 21 22 23 24 25 26 27 28 29
+			 30 31 32 33 34 35 36 37 38 39
+			 40 41 42 43 44 45 46 47 48 49
+			 50 51 52 53 54 55 56 57 58 59
+			 60 61 62 63 64 65 66 67 68 69
+			 70 71 72 73 74 75 76 77 78 79
+			 80 81 82 83 84 85 86 87 88 89
+			 90 91 92 93 94 95 96 97 98 99
+			100
+		>;
+		default-brightness-level = <50>;
+	};
+
+	backlight1: pwm-backlight at 1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000>;
+		power-supply = <&reg_3v3>;
+		brightness-levels = <
+			  0  1  2  3  4  5  6  7  8  9
+			 10 11 12 13 14 15 16 17 18 19
+			 20 21 22 23 24 25 26 27 28 29
+			 30 31 32 33 34 35 36 37 38 39
+			 40 41 42 43 44 45 46 47 48 49
+			 50 51 52 53 54 55 56 57 58 59
+			 60 61 62 63 64 65 66 67 68 69
+			 70 71 72 73 74 75 76 77 78 79
+			 80 81 82 83 84 85 86 87 88 89
+			 90 91 92 93 94 95 96 97 98 99
+			100
+		>;
+		default-brightness-level = <50>;
+	};
+
+
+	regulators {
+		reg_lcd_pwr: regulator at 6 {
+			compatible = "regulator-fixed";
+			regulator-name = "LVDS0 POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+
+		reg_lcd_reset: regulator at 7 {
+			compatible = "regulator-fixed";
+			regulator-name = "LVDS1 POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+
+	touchscreen2: eeti at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eeti_2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <23 0>;
+		wakeup-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+		linux,wakeup;
+	};
+};
+
+&i2c3 {
+	touchscreen1: eeti at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eeti_1>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 0>;
+		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		linux,wakeup;
+	};
+};
+
+&iomuxc {
+	i2c {
+		pinctrl_i2c2: i2c2-grp1 {
+			fsl,pins = <MX6QDL_I2C2_PINGRP2>;
+		};
+	};
+
+	kpp {
+		pinctrl_kpp: kppgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_9__KEY_COL6 0x1b0b1
+				MX6QDL_PAD_GPIO_4__KEY_COL7 0x1b0b1
+				MX6QDL_PAD_KEY_COL2__KEY_COL2 0x1b0b1
+
+				MX6QDL_PAD_GPIO_2__KEY_ROW6 0x1b0b1
+				MX6QDL_PAD_GPIO_5__KEY_ROW7 0x1b0b1
+				MX6QDL_PAD_KEY_ROW2__KEY_ROW2 0x1b0b1
+			>;
+		};
+	};
+
+	pwm {
+		pinctrl_pwm1: pwm1grp {
+			fsl,pins = <MX6QDL_PAD_GPIO_9__PWM1_OUT 0x80000000>;
+		};
+	};
+
+	touchpanel {
+		pinctrl_eeti_1: eetigrp-1 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0xe0 /* Interrupt */
+			>;
+		};
+
+		pinctrl_eeti_2: eetigrp-2 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D23__GPIO3_IO23 0xe0 /* Interrupt */
+			>;
+		};
+	};
+};
+
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp>;
+	status = "okay";
+
+	/* sample keymap */
+	/* row/col 0,1 are mapped to KPP row/col 6,7
+	 * row/col 3 are used for I2C2 (second touch controller on hsd100pxn1)
+	 */
+	linux,keymap = <
+		0x06060074 /* row 6, col 6, KEY_POWER */
+		0x06070052 /* row 6, col 7, KEY_KP0 */
+		0x0602004f /* row 6, col 2, KEY_KP1 */
+		0x07060050 /* row 7, col 6, KEY_KP2 */
+		0x07070051 /* row 7, col 7, KEY_KP3 */
+		0x0702004b /* row 7, col 2, KEY_KP4 */
+		0x0206004c /* row 2, col 6, KEY_KP5 */
+		0x0207004d /* row 2, col 7, KEY_KP6 */
+		0x02020047 /* row 2, col 2, KEY_KP7 */
+	>;
+};
+
+&ldb {
+	status = "okay";
+//	fsl,dual-channel;
+
+	lvds0: lvds-channel at 0 {
+		fsl,data-mapping = "jeida";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&lvds_timing0>;
+			lvds_timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hsync-len = <60>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vsync-len = <10>;
+				vfront-porch = <7>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+
+	lvds1: lvds-channel at 1 {
+		fsl,data-mapping = "jeida";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&lvds_timing1>;
+			lvds_timing1: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hsync-len = <60>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vsync-len = <10>;
+				vfront-porch = <7>;
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
+};
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
new file mode 100644
index 0000000..af315db
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -0,0 +1,434 @@
+/*
+ * Copyright 2013 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		can0 = &can1;
+		can1 = &can2;
+		ethernet0 = &fec;
+		reg_can_xcvr = &reg_can_xcvr;
+		stk5led = &user_led;
+		usbotg = &usbotg;
+	};
+
+	chosen {
+	};
+
+	memory {
+		reg = <0 0>; /* will be filled by U-Boot */
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mclk: codec_clock {
+			compatible = "fixed-clock";
+			reg = <0>;
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power Button";
+			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led>;
+
+		user_led: user {
+			label = "Heartbeat";
+			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3v3_etn: regulator at 0 {
+			compatible = "regulator-fixed";
+			regulator-name = "3V3_ETN";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		reg_2v5: regulator at 1 {
+			compatible = "regulator-fixed";
+			regulator-name = "2V5";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+		};
+
+		reg_3v3: regulator at 2 {
+			compatible = "regulator-fixed";
+			regulator-name = "3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		reg_can_xcvr: regulator at 3 {
+			compatible = "regulator-fixed";
+			regulator-name = "CAN XCVR";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
+			enable-active-low;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_flexcan_xcvr>;
+		};
+
+		reg_usbh1_vbus: regulator at 4 {
+			compatible = "regulator-fixed";
+			regulator-name = "usbh1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbh1_vbus>;
+			gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		reg_usbotg_vbus: regulator at 5 {
+			compatible = "regulator-fixed";
+			regulator-name = "usbotg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbotg_vbus>;
+			gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx6qdl-tx6qdl-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "sgtl5000-audio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_audmux>;
+		ssi-controller = <&ssi1>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <1>;
+		mux-ext-port = <5>;
+	};
+};
+
+&audmux {
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can_xcvr>;
+
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can_xcvr>;
+
+	status = "okay";
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <
+		&gpio2 30 GPIO_ACTIVE_HIGH
+		&gpio3 19 GPIO_ACTIVE_HIGH
+	>;
+	status = "okay";
+
+	spidev at 0 {
+		compatible = "spidev";
+		reg = <0>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
+	phy-supply = <&reg_3v3_etn>;
+	status = "okay";
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	ds1339: rtc at 68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	sgtl5000: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&reg_2v5>;
+		VDDIO-supply = <&reg_3v3>;
+		clocks = <&mclk>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	audmux {
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <MX6QDL_AUDMUX_PINGRP5>;
+		};
+	};
+
+	enet {
+		pinctrl_enet: enetgrp {
+			fsl,pins = <MX6QDL_ENET_PINGRP4>;
+		};
+	};
+
+	flexcan {
+		pinctrl_flexcan1: flexcan1grp {
+		};
+
+		pinctrl_flexcan2: flexcan2grp {
+		};
+
+		pinctrl_flexcan_xcvr: flexcan-xcvrgrp {
+			fsl,pins = <MX6QDL_PAD_DISP0_DAT0__GPIO4_IO21 0x1b0b0>; /* Flexcan XCVR enable */
+		};
+	};
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_A18__GPIO2_IO20 0x1b0b1 /* LED */
+				MX6QDL_PAD_SD3_DAT2__GPIO7_IO06 0x1b0b1 /* ETN PHY RESET */
+				MX6QDL_PAD_EIM_D20__GPIO3_IO20 0x1b0b1 /* ETN PHY POWER */
+				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1b0b1 /* ETN PHY INT
+				MX6QDL_PAD_SD3_CMD__GPIO7_IO02 0x1b0b0 /* SD1 CD */
+				MX6QDL_PAD_SD3_CLK__GPIO7_IO03 0x1b0b0 /* SD2 CD */
+				MX6QDL_PAD_EIM_EB3__GPIO2_IO31 0x1b0b1 /* LCD Power Enable */
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1b0b1 /* LCD Reset */
+				MX6QDL_PAD_EIM_A25__GPIO5_IO02 0x1b0b1 /* PWR BTN */
+			>;
+		};
+	};
+
+	i2c {
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <MX6QDL_I2C1_PINGRP1>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <MX6QDL_I2C3_PINGRP2>;
+		};
+	};
+
+	led {
+		pinctrl_led: ledgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_A18__GPIO2_IO20 0x1b0b1 /* LED */
+			>;
+		};
+	};
+
+	nand {
+		pinctrl_gpmi_nand: gpmi-nand {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
+				MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
+				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
+				MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
+				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
+				MX6QDL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
+				MX6QDL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
+				MX6QDL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
+				MX6QDL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
+				MX6QDL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
+				MX6QDL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
+				MX6QDL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
+				MX6QDL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
+				MX6QDL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
+				MX6QDL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
+			>;
+		};
+	};
+
+	pwm {
+		pinctrl_pwm2: pwm2grp {
+			fsl,pins = <MX6QDL_PAD_GPIO_1__PWM2_OUT 0xb0b1>;
+		};
+	};
+
+	ecspi {
+		pinctrl_ecspi1: ecspi1grp {
+			fsl,pins = <MX6QDL_ECSPI1_PINGRP1
+				MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x1b0b1
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19 0x1b0b1
+				MX6QDL_PAD_GPIO_19__ECSPI1_RDY 0x1b0b1
+			>;
+		};
+	};
+
+	uart {
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <MX6QDL_UART1_PINGRP2
+				MX6QDL_PAD_SD3_DAT0__UART1_CTS_B 0x1b0b1
+				MX6QDL_PAD_SD3_DAT1__UART1_RTS_B 0x1b0b1
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <MX6QDL_UART2_PINGRP3
+				MX6QDL_PAD_SD4_DAT6__UART2_CTS_B 0x1b0b1
+				MX6QDL_PAD_SD4_DAT5__UART2_RTS_B 0x1b0b1
+			>;
+		};
+
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <MX6QDL_UART3_PINGRP3
+				MX6QDL_PAD_SD3_DAT3__UART3_CTS_B 0x1b0b1
+				MX6QDL_PAD_SD3_RST__UART3_RTS_B 0x1b0b1
+			>;
+		};
+	};
+
+	usbh1 {
+		pinctrl_usbh1_vbus: usbh1-vbusgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D31__GPIO3_IO31 0x1b0b0 /* USBH1_VBUSEN */
+			>;
+		};
+	};
+
+	usbotg {
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D23__GPIO3_IO23 0x17059
+			>;
+		};
+
+		pinctrl_usbotg_vbus: usbotg-vbusgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_7__GPIO1_IO07 0x1b0b0 /* USBOTG_VBUSEN */
+			>;
+		};
+	};
+
+	usdhc {
+		pinctrl_usdhc1: ussdhc1grp {
+			fsl,pins = <MX6QDL_USDHC1_PINGRP_D4_200MHZ>;
+		};
+
+		pinctrl_usdhc2: ussdhc2grp {
+			fsl,pins = <MX6QDL_USDHC2_PINGRP_D4_200MHZ>;
+		};
+	};
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usbh1_vbus>;
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usbotg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	dr_mode = "peripheral";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	cd-gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	cd-gpios = <&gpio7 3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
-- 
1.7.2.5
