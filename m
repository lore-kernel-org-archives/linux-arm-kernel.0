From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 31 Jul 2013 16:37:59 +0200
Subject: [PATCH 9/10] ARM: dts: tx28: restructure and update DTS file
In-Reply-To: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375281480-25775-9-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts |  750 +++++++++++++++++++++++++++++++++-----
 1 files changed, 667 insertions(+), 83 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 37be532..7b2e6ce 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -1,106 +1,144 @@
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
 /dts-v1/;
-/include/ "imx28.dtsi"
+#include "imx28.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+#define USE_SPI_GPIO
 
 / {
 	model = "Ka-Ro electronics TX28 module";
 	compatible = "karo,tx28", "fsl,imx28";
 
+	aliases {
+		can0 = &can0;
+		can1 = &can1;
+		display = &display;
+		ds1339 = &ds1339;
+		gpio5 = &gpio5;
+		stk5led = &user_led;
+		usbotg = &usb0;
+		lcdif = &lcdif;
+		lcdif_24bit_pins_a = &lcdif_24bit_pins_a;
+		lcdif_23bit_pins_a = &lcdif_23bit_pins_a;
+	};
+
+	chosen {
+		bootargs = "init=/linuxrc console=ttyAMA0,115200 root=/dev/mtdblock3 rootfstype=jffs2 ro debug panic=1";
+	};
+
 	memory {
-		reg = <0x40000000 0x08000000>;
-	};
-
-	apb at 80000000 {
-		apbh at 80000000 {
-			ssp0: ssp at 80010000 {
-				compatible = "fsl,imx28-mmc";
-				pinctrl-names = "default";
-				pinctrl-0 = <&mmc0_4bit_pins_a
-					     &mmc0_cd_cfg
-					     &mmc0_sck_cfg>;
-				bus-width = <4>;
-				status = "okay";
-			};
+		reg = <0 0>; /* will be filled in by U-Boot */
+	};
 
-			pinctrl at 80018000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&hog_pins_a>;
-
-				hog_pins_a: hog at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						0x40a3 /* MX28_PAD_ENET0_RXD3__GPIO_4_10 */
-					>;
-					fsl,drive-strength = <0>;
-					fsl,voltage = <1>;
-					fsl,pull-up = <0>;
-				};
-
-				mac0_pins_gpio: mac0-gpio-mode at 0 {
-					reg = <0>;
-					fsl,pinmux-ids = <
-						0x4003 /* MX28_PAD_ENET0_MDC__GPIO_4_0 */
-						0x4013 /* MX28_PAD_ENET0_MDIO__GPIO_4_1 */
-						0x4023 /* MX28_PAD_ENET0_RX_EN__GPIO_4_2 */
-						0x4033 /* MX28_PAD_ENET0_RXD0__GPIO_4_3 */
-						0x4043 /* MX28_PAD_ENET0_RXD1__GPIO_4_4 */
-						0x4063 /* MX28_PAD_ENET0_TX_EN__GPIO_4_6 */
-						0x4073 /* MX28_PAD_ENET0_TXD0__GPIO_4_7 */
-						0x4083 /* MX28_PAD_ENET0_TXD1__GPIO_4_8 */
-						0x4103 /* MX28_PAD_ENET_CLK__GPIO_4_16 */
-					>;
-					fsl,drive-strength = <0>;
-					fsl,voltage = <1>;
-					fsl,pull-up = <0>;
-				};
-			};
+	onewire at 0 {
+		compatible = "w1-gpio";
+		gpios = <&gpio2 7 0>;
+		status = "disabled";
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_usb0_vbus: usb0_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb0_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio0 18 0>;
+			enable-active-high;
 		};
 
-		apbx at 80040000 {
-			i2c0: i2c at 80058000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&i2c0_pins_a>;
-				status = "okay";
+		reg_usb1_vbus: usb1_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 27 0>;
+			enable-active-high;
+		};
 
-				ds1339: rtc at 68 {
-					compatible = "mxim,ds1339";
-					reg = <0x68>;
-				};
-			};
+		reg_2p5v: 2p5v {
+			compatible = "regulator-fixed";
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
 
-			pwm: pwm at 80064000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pwm0_pins_a>;
-				status = "okay";
-			};
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
 
-			duart: serial at 80074000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&duart_4pins_a>;
-				status = "okay";
-			};
+		reg_can_xcvr: can-xcvr {
+			compatible = "regulator-fixed";
+			regulator-name = "CAN XCVR";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio1 0 0>;
+			enable-active-low;
+			pinctrl-names = "default";
+			pinctrl-0 = <&flexcan_xcvr_pins_a>;
+		};
 
-			auart1: serial at 8006c000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&auart1_pins_a>;
-				status = "okay";
-			};
+		reg_lcd: lcd-power {
+			compatible = "regulator-fixed";
+			regulator-name = "LCD POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio1 31 0>;
+			enable-active-high;
+		};
+
+		reg_lcd_reset: lcd-reset {
+			compatible = "regulator-fixed";
+			regulator-name = "LCD RESET";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 30 0>;
+			startup-delay-us = <300000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
 		};
 	};
 
-	ahb at 80080000 {
-		mac0: ethernet at 800f0000 {
-			phy-mode = "rmii";
-			pinctrl-names = "default", "gpio_mode";
-			pinctrl-0 = <&mac0_pins_a>;
-			pinctrl-1 = <&mac0_pins_gpio>;
-			status = "okay";
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mclk: codec_clock {
+			compatible = "fixed-clock";
+			reg = <0>;
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
 		};
 	};
 
+	sound {
+		compatible = "fsl,imx28-tx28-sgtl5000",
+			     "fsl,mxs-audio-sgtl5000";
+		model = "imx28-tx28-sgtl5000";
+		saif-controllers = <&saif0 &saif1>;
+		audio-codec = <&sgtl5000>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
-		user {
+		user_led: user {
 			label = "Heartbeat";
 			gpios = <&gpio4 10 0>;
 			linux,default-trigger = "heartbeat";
@@ -109,8 +147,554 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 5000000>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
+		pwms = <&pwm 0 500000>;
+		/*
+		 * a silly way to create a 1:1 relationship between the
+		 * PWM value and the actual duty cycle
+		 */
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <50>;
+	};
+#ifdef USE_SPI_GPIO
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi_pins_gpio>;
+
+		gpio-sck = <&gpio2 24 0>;
+		gpio-mosi = <&gpio2 25 0>;
+		gpio-miso = <&gpio2 26 0>;
+		num-chipselects = <3>;
+		cs-gpios = <
+			&gpio3 8 1
+			&gpio3 9 1
+			&gpio2 27 1
+		>;
+
+		spidev0: spi at 0 {
+			compatible = "spidev";
+			reg = <0>;
+			spi-max-frequency = <57600000>;
+		};
+
+		spidev1: spi at 1 {
+			compatible = "spidev";
+			reg = <1>;
+			spi-max-frequency = <57600000>;
+		};
+
+		spidev2: spi at 2 {
+			compatible = "spidev";
+			reg = <2>;
+			spi-max-frequency = <57600000>;
+		};
 	};
+#endif
+	matrix_keypad: matrix-keypad at 0 {
+		compatible = "gpio-matrix-keypad";
+		col-gpios = <
+			&gpio5 0 0
+			&gpio5 1 0
+			&gpio5 2 0
+			&gpio5 3 0
+		>;
+
+		row-gpios = <
+			&gpio5 4 0
+			&gpio5 5 0
+			&gpio5 6 0
+			&gpio5 7 0
+		>;
+
+		/* sample keymap */
+		linux,keymap = <
+			0x00000074 /* row 0, col 0, KEY_POWER */
+			0x00010052 /* row 0, col 1, KEY_KP0 */
+			0x0002004f /* row 0, col 2, KEY_KP1 */
+			0x00030050 /* row 0, col 3, KEY_KP2 */
+			0x01000051 /* row 1, col 0, KEY_KP3 */
+			0x0101004b /* row 1, col 1, KEY_KP4 */
+			0x0102004c /* row 1, col 2, KEY_KP5 */
+			0x0103004d /* row 1, col 3, KEY_KP6 */
+			0x02000047 /* row 2, col 0, KEY_KP7 */
+			0x02010048 /* row 2, col 1, KEY_KP8 */
+			0x02020049 /* row 2, col 2, KEY_KP9 */
+		>;
+		gpio-activelow;
+		linux,wakeup;
+
+		debounce-delay-ms = <100>;
+		col-scan-delay-us = <5000>;
+		linux,no-autorepeat;
+	};
+};
+
+/* 2nd TX-Std UART - (A)UART1  */
+&auart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&auart1_pins_a>;
+	status = "okay";
+};
+
+/* 3rd TX-Std UART - (A)UART3  */
+&auart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&auart3_pins_a>;
+	status = "okay";
+};
+
+&can0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&can0_pins_a>;
+	xceiver-supply = <&reg_can_xcvr>;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&can1_pins_a>;
+	xceiver-supply = <&reg_can_xcvr>;
+	status = "okay";
+};
+
+&digctl {
+	status = "okay";
+};
+
+/* 1st TX-Std UART - (D)UART */
+&duart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&duart_4pins_a>;
+	status = "okay";
+};
+
+&gpmi {
+	pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	ds1339: rtc at 68 {
+		compatible = "mxim,ds1339";
+		reg = <0x68>;
+	};
+
+	gpio5: pca953x at 20 {
+		compatible = "nxp,pca9554";
+		reg = <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pca9554_pins>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <28 0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	touchscreen: tsc2007 at 48 {
+		compatible = "ti,tsc2007";
+		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tsc2007_pins>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <20 0>;
+		pendown-gpio = <&gpio3 20 1>;
+		ti,x-plate-ohms = <660>;
+	};
+
+	polytouch: edt-ft5x06 at 38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&edt_ft5x06_pins>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <5 0>;
+		reset-gpios = <&gpio2 6 1>;
+		wake-gpios = <&gpio4 9 0>;
+	};
+
+	sgtl5000: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+		clocks = <&mclk>;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcdif_24bit_pins_a &lcdif_sync_pins_a &lcdif_ctrl_pins_a>;
+	lcd-supply = <&reg_lcd>;
+	display = <&display>;
+	status = "okay";
+
+	display: display at 0 {
+		bits-per-pixel = <32>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing5>;
+			timing0: timing0 {
+				panel-name = "VGA";
+				clock-frequency = <25175000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hsync-len = <96>;
+				hfront-porch = <16>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			timing1: timing1 {
+				panel-name = "ETV570";
+				clock-frequency = <25175000>;
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
+				pixelclk-active = <1>;
+			};
+
+			timing2: timing2 {
+				panel-name = "ET0350";
+				clock-frequency = <6500000>;
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
+				pixelclk-active = <1>;
+			};
+
+			timing3: timing3 {
+				panel-name = "ET0430";
+				clock-frequency = <9000000>;
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
+			timing4: timing4 {
+				panel-name = "ET0500", "ET0700";
+				clock-frequency = <33260000>;
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
+				pixelclk-active = <1>;
+			};
+
+			timing5: timing5 {
+				panel-name = "ETQ570";
+				clock-frequency = <6400000>;
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
+				pixelclk-active = <1>;
+			};
+        	};
+	};
+};
+
+&lradc {
+	fsl,lradc-touchscreen-wires = <4>;
+	status = "okay";
+};
+
+&mac0 {
+	phy-mode = "rmii";
+	pinctrl-names = "default", "gpio_mode";
+	pinctrl-0 = <&mac0_pins_a>;
+	pinctrl-1 = <&mac0_pins_gpio>;
+	status = "okay";
+};
+
+&mac1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mac1_pins_a>;
+	/* not enabled by default */
+};
+
+&mxs_rtc {
+	status = "okay";
+};
+
+&ocotp {
+	status = "okay";
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>;
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hog_pins_a>;
+	edt_ft5x06_pins: edt-ft5x06-pins at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			0x2063 /* MX28_PAD_SSP0_DATA6__GPIO_2_6	RESET */
+			0x2053 /* MX28_PAD_SSP0_DATA5__GPIO_2_5 IRQ */
+			0x4093 /* MX28_PAD_ENET0_RXD2__GPIO_4_9 WAKE */
+		>;
+		fsl,drive-strength = <0>;
+		fsl,voltage = <1>;
+		fsl,pull-up = <0>;
+	};
+
+	flexcan_xcvr_pins_a: flexcan-xcvr {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			0x1003 /* MX28_PAD_LCD_D00__GPIO_1_0 */
+		>;
+		fsl,drive-strength = <0>;
+		fsl,voltage = <1>;
+		fsl,pull-up = <0>;
+	};
+
+	hog_pins_a: hog at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			0x40a3 /* MX28_PAD_ENET0_RXD3__GPIO_4_10 - module LED */
+		>;
+		fsl,drive-strength = <0>;
+		fsl,voltage = <1>;
+		fsl,pull-up = <0>;
+	};
+
+	lcdif_23bit_pins_a: lcdif-23bit at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			/* LCD_D00 may be used as Flexcan Transceiver Enable on STK5-V5 */
+			0x1010 /* MX28_PAD_LCD_D01__LCD_D1 */
+			0x1020 /* MX28_PAD_LCD_D02__LCD_D2 */
+			0x1030 /* MX28_PAD_LCD_D03__LCD_D3 */
+			0x1040 /* MX28_PAD_LCD_D04__LCD_D4 */
+			0x1050 /* MX28_PAD_LCD_D05__LCD_D5 */
+			0x1060 /* MX28_PAD_LCD_D06__LCD_D6 */
+			0x1070 /* MX28_PAD_LCD_D07__LCD_D7 */
+			0x1080 /* MX28_PAD_LCD_D08__LCD_D8 */
+			0x1090 /* MX28_PAD_LCD_D09__LCD_D9 */
+			0x10a0 /* MX28_PAD_LCD_D10__LCD_D10 */
+			0x10b0 /* MX28_PAD_LCD_D11__LCD_D11 */
+			0x10c0 /* MX28_PAD_LCD_D12__LCD_D12 */
+			0x10d0 /* MX28_PAD_LCD_D13__LCD_D13 */
+			0x10e0 /* MX28_PAD_LCD_D14__LCD_D14 */
+			0x10f0 /* MX28_PAD_LCD_D15__LCD_D15 */
+			0x1100 /* MX28_PAD_LCD_D16__LCD_D16 */
+			0x1110 /* MX28_PAD_LCD_D17__LCD_D17 */
+			0x1120 /* MX28_PAD_LCD_D18__LCD_D18 */
+			0x1130 /* MX28_PAD_LCD_D19__LCD_D19 */
+			0x1140 /* MX28_PAD_LCD_D20__LCD_D20 */
+			0x1150 /* MX28_PAD_LCD_D21__LCD_D21 */
+			0x1160 /* MX28_PAD_LCD_D22__LCD_D22 */
+			0x1170 /* MX28_PAD_LCD_D23__LCD_D23 */
+		>;
+		fsl,drive-strength = <0>;
+		fsl,voltage = <1>;
+		fsl,pull-up = <0>;
+	};
+
+	lcdif_ctrl_pins_a: lcdif-ctrl at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			0x11f3	/* MX28_PAD_LCD_ENABLE__GPIO_1_31 - Enable */
+			0x31e3	/* MX28_PAD_LCD_RESET__GPIO_3_30 - Reset */
+		>;
+		fsl,drive-strength = <0>;
+		fsl,voltage = <1>;
+		fsl,pull-up = <0>;
+	};
+
+	mac0_pins_gpio: mac0-gpio-mode at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			0x4003 /* MX28_PAD_ENET0_MDC__GPIO_4_0 */
+			0x4013 /* MX28_PAD_ENET0_MDIO__GPIO_4_1 */
+			0x4023 /* MX28_PAD_ENET0_RX_EN__GPIO_4_2 */
+			0x4033 /* MX28_PAD_ENET0_RXD0__GPIO_4_3 */
+			0x4043 /* MX28_PAD_ENET0_RXD1__GPIO_4_4 */
+			0x4063 /* MX28_PAD_ENET0_TX_EN__GPIO_4_6 */
+			0x4073 /* MX28_PAD_ENET0_TXD0__GPIO_4_7 */
+			0x4083 /* MX28_PAD_ENET0_TXD1__GPIO_4_8 */
+			0x4103 /* MX28_PAD_ENET_CLK__GPIO_4_16 */
+		>;
+		fsl,drive-strength = <0>;
+		fsl,voltage = <1>;
+		fsl,pull-up = <0>;
+	};
+
+	pca9554_pins: pca9554-pins at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 IRQ */
+		>;
+		fsl,drive-strength = <0>;
+		fsl,voltage = <1>;
+		fsl,pull-up = <0>;
+	};
+
+	spi_pins_gpio: spi at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			0x3083	/* MX28_PAD_AUART2_RX__GPIO_3_8 SS0 */
+			0x3093	/* MX28_PAD_AUART2_TX__GPIO_3_9 SS1 */
+			0x2183	/* MX28_PAD_SSP3_SCK__GPIO_2_24 SCK */
+			0x2193	/* MX28_PAD_SSP3_MOSI__GPIO_2_25 MOSI */
+			0x21A3	/* MX28_PAD_SSP3_MISO__GPIO_2_26 MISO */
+			0x21B3	/* MX28_PAD_SSP3_SS0__GPIO_2_27 SS2 */
+		>;
+		fsl,drive-strength = <1>;
+		fsl,voltage = <1>;
+		fsl,pull-up = <0>;
+	};
+
+	tsc2007_pins: tsc2007-pins at 0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			0x3143 /* MX28_PAD_SAIF0_MCLK__GPIO_3_20 - TSC2007 IRQ */
+		>;
+		fsl,drive-strength = <0>;
+		fsl,voltage = <1>;
+		fsl,pull-up = <0>;
+	};
+};
+
+&saif0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&saif0_pins_b>;
+	fsl,saif-master;
+	status = "okay";
+};
+
+&saif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&saif1_pins_a>;
+	status = "okay";
+};
+
+&ssp0 {
+	compatible = "fsl,imx28-mmc";
+	pinctrl-names = "default", "special";
+	pinctrl-0 = <&mmc0_4bit_pins_a
+		     &mmc0_cd_cfg
+		     &mmc0_sck_cfg>;
+	bus-width = <4>;
+	status = "okay";
+};
+#ifndef USE_SPI_GPIO
+&ssp3 {
+	compatible = "fsl,imx28-spi";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi3_pins_a>;
+	clock-frequency = <57600000>;
+	status = "okay";
+
+	spidev0: spi at 0 {
+		compatible = "spidev";
+		reg = <0>;
+		spi-max-frequency = <57600000>;
+	};
+
+	spidev1: spi at 1 {
+		compatible = "spidev";
+		reg = <1>;
+		spi-max-frequency = <57600000>;
+	};
+};
+#endif
+&timer {
+	status = "okay";
+};
+
+&usb0 {
+	vbus-supply = <&reg_usb0_vbus>;
+	disable-over-current;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb1 {
+	vbus-supply = <&reg_usb1_vbus>;
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usbphy0_pins_c>;
+	status = "okay";
+};
+
+&usbphy1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usbphy1_pins_b>;
+	status = "okay";
 };
-- 
1.7.2.5
