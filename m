From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:50:32 +0200
Subject: [PATCH 09/12] ARM: dts: imx6-tx6: move display configuration to .dtsi
 file
In-Reply-To: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
References: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507722635-30801-10-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the display (LCD or LVDS) configuration is duplicated with
slight variations in each TX6 module specific file.

Move it to an include file for simplification and consistency.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts    |  74 +------
 arch/arm/boot/dts/imx6dl-tx6s-8034.dts       | 171 +---------------
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts       | 171 +---------------
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts       | 161 +--------------
 arch/arm/boot/dts/imx6dl-tx6u-8033.dts       | 170 +---------------
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts       | 109 +---------
 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts   | 185 +----------------
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts |  74 +------
 arch/arm/boot/dts/imx6q-tx6q-1010.dts        | 159 +--------------
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts |  74 +------
 arch/arm/boot/dts/imx6q-tx6q-1020.dts        | 162 +--------------
 arch/arm/boot/dts/imx6q-tx6q-1036.dts        | 170 +---------------
 arch/arm/boot/dts/imx6q-tx6q-1110.dts        | 109 +---------
 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts    | 187 ++----------------
 arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi       | 252 +++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi      | 286 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-tx6.dtsi           |   4 +-
 17 files changed, 616 insertions(+), 1902 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi

diff --git a/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts b/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
index aac42ac..51a9bb9 100644
--- a/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,70 +42,16 @@
 /dts-v1/;
 #include "imx6dl.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6DL Module on CoMpact TFT";
 	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
+};
 
-	aliases {
-		display = &display;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 0>;
-		power-supply = <&reg_3v3>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		interface-pix-fmt = "rgb24";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_1>;
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
-		display-timings {
-			native-mode = <&ET070001DM6>;
-
-			ET070001DM6: CoMTFT { /* same as ET0700 but with inverted pixel clock */
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
-		};
-	};
+&backlight {
+	pwms = <&pwm2 0 500000 0>;
+	/delete-property/ turn-on-delay-ms;
 };
 
 &can1 {
@@ -116,14 +62,14 @@
 	xceiver-supply = <&reg_3v3>;
 };
 
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
-};
-
 &kpp {
 	status = "disabled";
 };
 
+&lcd_panel {
+	compatible = "edt,etm0700g0edh6";
+};
+
 &reg_can_xcvr {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
index ff8f7b1..9eb2ef1 100644
--- a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2015-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2015-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,174 +42,15 @@
 /dts-v1/;
 #include "imx6dl.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6S-8034 Module";
 	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
 
-	aliases {
-		display = &display;
-		ipu1 = &ipu1;
-	};
-
 	cpus {
 		/delete-node/ cpu at 1;
 	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd0_pwr>;
-		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
-		power-supply = <&reg_lcd1_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_2>;
-		interface-pix-fmt = "rgb24";
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
-		display-timings {
-			native-mode = <&vga>;
-
-			vga: VGA {
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <1>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-		};
-	};
 };
 
 &ds1339 {
@@ -227,11 +68,3 @@
 		MX6QDL_PAD_SD3_CMD__GPIO7_IO02		0x170b0 /* SD1 CD */
 	>;
 };
-
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
-};
-
-&reg_lcd0_pwr {
-	status = "disabled";
-};
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
index f988950..a5532ec 100644
--- a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2015-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2015-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,174 +42,15 @@
 /dts-v1/;
 #include "imx6dl.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6S-8035 Module";
 	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
 
-	aliases {
-		display = &display;
-		ipu1 = &ipu1;
-	};
-
 	cpus {
 		/delete-node/ cpu at 1;
 	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd0_pwr>;
-		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
-		power-supply = <&reg_lcd1_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_2>;
-		interface-pix-fmt = "rgb24";
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
-		display-timings {
-			native-mode = <&vga>;
-
-			vga: VGA {
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <1>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-		};
-	};
 };
 
 &ds1339 {
@@ -220,14 +61,6 @@
 	status = "disabled";
 };
 
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
-};
-
-&reg_lcd0_pwr {
-	status = "disabled";
-};
-
 &usdhc4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc4>;
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts b/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
index d1f1298..67ed045 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,166 +42,9 @@
 /dts-v1/;
 #include "imx6dl.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6U-801x Module";
 	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
-
-	aliases {
-		display = &display;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-		power-supply = <&reg_3v3>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		interface-pix-fmt = "rgb24";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_1>;
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <1>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-		};
-	};
-};
-
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
 };
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-8033.dts b/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
index 4d3204a..7030b26 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,169 +42,11 @@
 /dts-v1/;
 #include "imx6dl.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6U-8033 Module";
 	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
-
-	aliases {
-		display = &display;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd0_pwr>;
-		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
-		power-supply = <&reg_lcd1_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_2>;
-		interface-pix-fmt = "rgb24";
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
-		display-timings {
-			native-mode = <&vga>;
-
-			vga: VGA {
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <1>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-		};
-	};
 };
 
 &ds1339 {
@@ -215,14 +57,6 @@
 	status = "disabled";
 };
 
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
-};
-
-&reg_lcd0_pwr {
-	status = "disabled";
-};
-
 &usdhc4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc4>;
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
index f0f759a..5342f2f 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-811x.dts
@@ -42,116 +42,9 @@
 /dts-v1/;
 #include "imx6dl.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lvds.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6U-811x Module";
 	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
-
-	aliases {
-		display = &lvds0;
-		lvds0 = &lvds0;
-		lvds1 = &lvds1;
-	};
-
-	backlight0: backlight0 {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 0>;
-		power-supply = <&reg_lcd0_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	backlight1: backlight1 {
-		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 500000 0>;
-		power-supply = <&reg_lcd1_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-};
-
-&kpp {
-	status = "disabled"; /* pad conflict with backlight1 PWM */
-};
-
-&ldb {
-	status = "okay";
-
-	lvds0: lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "okay";
-
-		display-timings {
-			native-mode = <&lvds_timing0>;
-			lvds_timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
-
-	lvds1: lvds-channel at 1 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "disabled";
-
-		display-timings {
-			native-mode = <&lvds_timing1>;
-			lvds_timing1: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
-};
-
-&pwm1 {
-	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
index c817324..e43ff12 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
@@ -42,60 +42,21 @@
 /dts-v1/;
 #include "imx6dl.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lvds.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6U-81xx Module on MB7 baseboard";
 	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
+};
 
-	aliases {
-		display = &lvds0;
-		lvds0 = &lvds0;
-		lvds1 = &lvds1;
-	};
-
-	backlight0: backlight0 {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-		power-supply = <&reg_lcd0_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
+&backlight0 {
+	pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+	turn-on-delay-ms = <35>;
+};
 
-	backlight1: backlight1 {
-		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
-		power-supply = <&reg_lcd1_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
+&backlight1 {
+	pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
+	turn-on-delay-ms = <35>;
 };
 
 &can1 {
@@ -105,131 +66,3 @@
 &can2 {
 	xceiver-supply = <&reg_3v3>;
 };
-
-&kpp {
-	status = "disabled"; /* pads partially clash with backlight1 PWM */
-};
-
-&ldb {
-	status = "okay";
-
-	lvds0: lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "okay";
-
-		display-timings {
-			native-mode = <&lvds0_timing1>;
-
-			lvds0_timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-
-			lvds0_timing1: VGA {
-				clock-frequency = <25200000>;
-				hactive = <640>;
-				vactive = <480>;
-				hback-porch = <48>;
-				hfront-porch = <16>;
-				vback-porch = <31>;
-				vfront-porch = <12>;
-				hsync-len = <96>;
-				vsync-len = <2>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
-
-			lvds0_timing2: nl12880bc20 {
-				clock-frequency = <71000000>;
-				hactive = <1280>;
-				vactive = <800>;
-				hback-porch = <50>;
-				hfront-porch = <50>;
-				vback-porch = <5>;
-				vfront-porch = <5>;
-				hsync-len = <60>;
-				vsync-len = <13>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
-
-	lvds1: lvds-channel at 1 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "okay";
-
-		display-timings {
-			native-mode = <&lvds1_timing2>;
-
-			lvds1_timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-
-			lvds1_timing1: VGA {
-				clock-frequency = <25200000>;
-				hactive = <640>;
-				vactive = <480>;
-				hback-porch = <48>;
-				hfront-porch = <16>;
-				vback-porch = <31>;
-				vfront-porch = <12>;
-				hsync-len = <96>;
-				vsync-len = <2>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
-
-			lvds1_timing2: nl12880bc20 {
-				clock-frequency = <71000000>;
-				hactive = <1280>;
-				vactive = <800>;
-				hback-porch = <50>;
-				hfront-porch = <50>;
-				vback-porch = <5>;
-				vfront-porch = <5>;
-				hsync-len = <60>;
-				vsync-len = <13>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
-};
-
-&pwm1 {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
index 71746ed..ac3050a 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,70 +42,16 @@
 /dts-v1/;
 #include "imx6q.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6Q-1010 Module on CoMpact TFT";
 	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
+};
 
-	aliases {
-		display = &display;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 0>;
-		power-supply = <&reg_3v3>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		interface-pix-fmt = "rgb24";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_1>;
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
-		display-timings {
-			native-mode = <&ET070001DM6>;
-
-			ET070001DM6: CoMTFT { /* same as ET0700 but with inverted pixel clock */
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
-		};
-	};
+&backlight {
+	pwms = <&pwm2 0 500000 0>;
+	/delete-property/ turn-on-delay-ms;
 };
 
 &can1 {
@@ -116,14 +62,14 @@
 	xceiver-supply = <&reg_3v3>;
 };
 
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
-};
-
 &kpp {
 	status = "disabled";
 };
 
+&lcd_panel {
+	compatible = "edt,etm0700g0edh6";
+};
+
 &reg_can_xcvr {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010.dts b/arch/arm/boot/dts/imx6q-tx6q-1010.dts
index 54bc442..4ee860b 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1010.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1010.dts
@@ -42,166 +42,13 @@
 /dts-v1/;
 #include "imx6q.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6Q-1010/-1030 Module";
 	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
-
-	aliases {
-		display = &display;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-		power-supply = <&reg_3v3>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		interface-pix-fmt = "rgb24";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_1>;
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <1>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-		};
-	};
 };
 
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
+&ipu2 {
+	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
index 959ff3fb..a773f25 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,70 +42,16 @@
 /dts-v1/;
 #include "imx6q.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6Q-1020 Module on CoMpact TFT";
 	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
+};
 
-	aliases {
-		display = &display;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 0>;
-		power-supply = <&reg_3v3>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		interface-pix-fmt = "rgb24";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_1>;
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
-		display-timings {
-			native-mode = <&ET070001DM6>;
-
-			ET070001DM6: CoMTFT { /* same as ET0700 but with inverted pixel clock */
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
-		};
-	};
+&backlight {
+	pwms = <&pwm2 0 500000 0>;
+	/delete-property/ turn-on-delay-ms;
 };
 
 &can1 {
@@ -124,14 +70,14 @@
 	status = "disabled";
 };
 
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
-};
-
 &kpp {
 	status = "disabled";
 };
 
+&lcd_panel {
+	compatible = "edt,etm0700g0edh6";
+};
+
 &reg_can_xcvr {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020.dts b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
index b49133d..0a4daec 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,164 +42,11 @@
 /dts-v1/;
 #include "imx6q.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6Q-1020 Module";
 	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
-
-	aliases {
-		display = &display;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-		power-supply = <&reg_3v3>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		interface-pix-fmt = "rgb24";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_1>;
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <1>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-		};
-	};
 };
 
 &ds1339 {
@@ -210,14 +57,15 @@
 	status = "disabled";
 };
 
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
+&ipu2 {
+	status = "disabled";
 };
 
 &usdhc4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc4>;
 	bus-width = <4>;
+	non-removable;
 	no-1-8-v;
 	fsl,wp-controller;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1036.dts b/arch/arm/boot/dts/imx6q-tx6q-1036.dts
index 7c152e3..cb2fcb4 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1036.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1036.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ * Copyright 2014-2017 Lothar Wa?mann <LW@KARO-electronics.de>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -42,169 +42,11 @@
 /dts-v1/;
 #include "imx6q.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lcd.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6Q-1036 Module";
 	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
-
-	aliases {
-		display = &display;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd0_pwr>;
-		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
-		power-supply = <&reg_lcd1_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	display: display at di0 {
-		compatible = "fsl,imx-parallel-display";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_disp0_2>;
-		interface-pix-fmt = "rgb24";
-		status = "okay";
-
-		port {
-			display0_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
-		display-timings {
-			native-mode = <&vga>;
-
-			vga: VGA {
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <1>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-
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
-				pixelclk-active = <0>;
-			};
-		};
-	};
 };
 
 &ds1339 {
@@ -215,18 +57,10 @@
 	status = "disabled";
 };
 
-&ipu1_di0_disp0 {
-	remote-endpoint = <&display0_in>;
-};
-
 &ipu2 {
 	status = "disabled";
 };
 
-&reg_lcd0_pwr {
-	status = "disabled";
-};
-
 &usdhc4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc4>;
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1110.dts b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
index 900557d..f7b0acb 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1110.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1110.dts
@@ -42,118 +42,15 @@
 /dts-v1/;
 #include "imx6q.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lvds.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6Q-1110/-1130 Module";
 	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
-
-	aliases {
-		display = &lvds0;
-		lvds0 = &lvds0;
-		lvds1 = &lvds1;
-	};
-
-	backlight0: backlight0 {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 0>;
-		power-supply = <&reg_lcd0_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
-
-	backlight1: backlight1 {
-		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 500000 0>;
-		power-supply = <&reg_lcd1_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
 };
 
-&kpp {
-	status = "disabled"; /* pad conflict with backlight1 PWM */
-};
-
-&ldb {
-	status = "okay";
-
-	lvds0: lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "okay";
-
-		display-timings {
-			native-mode = <&lvds_timing0>;
-			lvds_timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
-
-	lvds1: lvds-channel at 1 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "disabled";
-
-		display-timings {
-			native-mode = <&lvds_timing1>;
-			lvds_timing1: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
-};
-
-&pwm1 {
-	status = "okay";
+&ipu2 {
+	status = "disabled";
 };
 
 &sata {
diff --git a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
index be9233d..9648c21 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
@@ -42,60 +42,23 @@
 /dts-v1/;
 #include "imx6q.dtsi"
 #include "imx6qdl-tx6.dtsi"
+#include "imx6qdl-tx6-lvds.dtsi"
 
 / {
 	model = "Ka-Ro electronics TX6Q-1110/-1130 Module on MB7 baseboard";
 	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
+};
 
-	aliases {
-		display = &lvds0;
-		lvds0 = &lvds0;
-		lvds1 = &lvds1;
-	};
-
-	backlight0: backlight0 {
-		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
-		power-supply = <&reg_lcd0_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
+&backlight0 {
+	pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+	turn-on-delay-ms = <35>;
+	power-supply = <&reg_lcd1_pwr>;
+};
 
-	backlight1: backlight1 {
-		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
-		power-supply = <&reg_lcd1_pwr>;
-		/*
-		 * a poor man's way to create a 1:1 relationship between
-		 * the PWM value and the actual duty cycle
-		 */
-		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
-				     10 11 12 13 14 15 16 17 18 19
-				     20 21 22 23 24 25 26 27 28 29
-				     30 31 32 33 34 35 36 37 38 39
-				     40 41 42 43 44 45 46 47 48 49
-				     50 51 52 53 54 55 56 57 58 59
-				     60 61 62 63 64 65 66 67 68 69
-				     70 71 72 73 74 75 76 77 78 79
-				     80 81 82 83 84 85 86 87 88 89
-				     90 91 92 93 94 95 96 97 98 99
-				    100>;
-		default-brightness-level = <50>;
-	};
+&backlight1 {
+	pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
+	turn-on-delay-ms = <35>;
+	power-supply = <&reg_lcd1_pwr>;
 };
 
 &can1 {
@@ -110,132 +73,12 @@
 	status = "disabled";
 };
 
-&kpp {
-	status = "disabled"; /* pads partially clash with backlight1 PWM */
+&lvds0_panel {
+	compatible = "edt,et057090dhu";
 };
 
-&ldb {
-	status = "okay";
-
-	lvds0: lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "okay";
-
-		display-timings {
-			native-mode = <&lvds0_timing1>;
-
-			lvds0_timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-
-			lvds0_timing1: VGA {
-				clock-frequency = <25200000>;
-				hactive = <640>;
-				vactive = <480>;
-				hback-porch = <48>;
-				hfront-porch = <16>;
-				vback-porch = <31>;
-				vfront-porch = <12>;
-				hsync-len = <96>;
-				vsync-len = <2>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
-
-			lvds0_timing2: nl12880bc20 {
-				clock-frequency = <71000000>;
-				hactive = <1280>;
-				vactive = <800>;
-				hback-porch = <50>;
-				hfront-porch = <50>;
-				vback-porch = <5>;
-				vfront-porch = <5>;
-				hsync-len = <60>;
-				vsync-len = <13>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
-
-	lvds1: lvds-channel at 1 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "okay";
-
-		display-timings {
-			native-mode = <&lvds1_timing2>;
-
-			lvds1_timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-
-			lvds1_timing1: VGA {
-				clock-frequency = <25200000>;
-				hactive = <640>;
-				vactive = <480>;
-				hback-porch = <48>;
-				hfront-porch = <16>;
-				vback-porch = <31>;
-				vfront-porch = <12>;
-				hsync-len = <96>;
-				vsync-len = <2>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
-
-			lvds1_timing2: nl12880bc20 {
-				clock-frequency = <71000000>;
-				hactive = <1280>;
-				vactive = <800>;
-				hback-porch = <50>;
-				hfront-porch = <50>;
-				vback-porch = <5>;
-				vfront-porch = <5>;
-				hsync-len = <60>;
-				vsync-len = <13>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <1>;
-			};
-		};
-	};
-};
-
-&pwm1 {
-	status = "okay";
+&lvds1_panel {
+	compatible = "edt,et057090dhu";
 };
 
 &sata {
diff --git a/arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi b/arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi
new file mode 100644
index 0000000..572c693
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi
@@ -0,0 +1,252 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/ {
+	aliases {
+		display = &display;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd1_pwr>;
+		enable-gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
+		turn-on-delay-ms = <35>;
+		/*
+		 * a poor man's way to create a 1:1 relationship between
+		 * the PWM value and the actual duty cycle
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
+
+	lcd_panel: lcd-panel {
+		compatible = "edt,etm0700g0dh6";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd0_pwr>;
+		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
+		backlight = <&backlight>;
+		bus-format-override = "rgb24";
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_out>;
+			};
+		};
+	};
+
+	display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_disp0_1>;
+		status = "okay";
+
+		port at 0 {
+			reg = <0>;
+
+			lcd_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			lcd_out: endpoint {
+				remote-endpoint = <&lcd_panel_in>;
+			};
+		};
+
+		display-timings {
+			VGA {
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
+			ETV570 {
+				u-boot,panel-name = "edt,et057090dhu";
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
+			ET0350 {
+				u-boot,panel-name = "edt,et0350g0dh6";
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
+			ET0430 {
+				u-boot,panel-name = "edt,et0430g0dh6";
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
+			ET0500 {
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
+			ET0700 { /* same as ET0500 */
+				u-boot,panel-name = "edt,etm0700g0dh6";
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
+			ETQ570 {
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
+
+			CoMTFT { /* same as ET0700 but with inverted pixel clock */
+				u-boot,panel-name = "edt,etm0700g0edh6";
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
+				pixelclk-active = <1>;
+			};
+		};
+	};
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&lcd_in>;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi b/arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi
new file mode 100644
index 0000000..2ca2eb3
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi
@@ -0,0 +1,286 @@
+/*
+ * Copyright 2017 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/ {
+	aliases {
+		display = &lvds0;
+		lvds0 = &lvds0;
+		lvds1 = &lvds1;
+	};
+
+	backlight0: backlight0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000 0>;
+		power-supply = <&reg_lcd0_pwr>;
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
+
+	backlight1: backlight1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000 0>;
+		power-supply = <&reg_lcd1_pwr>;
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
+
+	lvds0_panel: lvds0-panel {
+		compatible = "nlt,nl12880bc20-spwg-24";
+		backlight = <&backlight0>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in_lvds0: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+
+	lvds1_panel: lvds1-panel {
+		compatible = "nlt,nl12880bc20-spwg-24";
+		backlight = <&backlight1>;
+		power-supply = <&reg_3v3>;
+
+		port {
+			panel_in_lvds1: endpoint {
+				remote-endpoint = <&lvds1_out>;
+			};
+		};
+	};
+};
+
+&kpp {
+	status = "disabled"; /* pad conflict with backlight1 PWM */
+};
+
+&ldb {
+	status = "okay";
+
+	lvds0: lvds-channel at 0 {
+		fsl,data-width = <18>;
+		status = "okay";
+
+		port at 4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in_lvds0>;
+			};
+		};
+
+		display-timings {
+			hsd100pxn1 {
+				u-boot,panel-name = "hannstar,hsd100pxn1";
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vfront-porch = <12>;
+				hsync-len = <96>;
+				vsync-len = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			nl12880bc20 {
+				u-boot,panel-name = "nlt,nl12880bc20-spwg-24";
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				hsync-len = <60>;
+				vsync-len = <13>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			ET0700 {
+				u-boot,panel-name = "edt,etm0700g0dh6";
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
+			ETV570 {
+				u-boot,panel-name = "edt,et057090dhu";
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
+		};
+	};
+
+	lvds1: lvds-channel at 1 {
+		fsl,data-width = <18>;
+		status = "okay";
+
+		port at 4 {
+			reg = <4>;
+
+			lvds1_out: endpoint {
+				remote-endpoint = <&panel_in_lvds1>;
+			};
+		};
+
+		display-timings {
+			hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vfront-porch = <12>;
+				hsync-len = <96>;
+				vsync-len = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				hsync-len = <60>;
+				vsync-len = <13>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&reg_lcd0_pwr {
+	status = "okay";
+};
+
+&reg_lcd1_pwr {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 9b563d4..015757c 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -146,7 +146,7 @@
 		pinctrl-0 = <&pinctrl_lcd0_pwr>;
 		gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-boot-on;
+		status = "disabled";
 	};
 
 	reg_lcd1_pwr: regulator-lcd1-pwr {
@@ -158,7 +158,7 @@
 		pinctrl-0 = <&pinctrl_lcd1_pwr>;
 		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-boot-on;
+		status = "disabled";
 	};
 
 	reg_usbh1_vbus: regulator-usbh1-vbus {
-- 
2.1.4
