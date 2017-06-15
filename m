From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Thu, 15 Jun 2017 17:33:37 +0530
Subject: [PATCH v4 1/3] ARM: dts: imx6ul-isiot: Move common nodes in
 imx6ul-isiot.dtsi
Message-ID: <1497528219-20396-1-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Maintaining separate dtsi file with common nodes make unclear and
confusing since -isiot.dtsi is available for adding common nodes.
If the nodes are common between the dts files then mark status
as "okay" otherwise mark it "disabled" so-that respective dts
can mark status "okay"

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- new patch

 arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 141 -----------------------------
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts    |   1 -
 arch/arm/boot/dts/imx6ul-isiot-nand.dts    |   1 -
 arch/arm/boot/dts/imx6ul-isiot.dtsi        |  96 ++++++++++++++++++++
 4 files changed, 96 insertions(+), 143 deletions(-)
 delete mode 100644 arch/arm/boot/dts/imx6ul-isiot-common.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
deleted file mode 100644
index 2beaab6..0000000
--- a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * Copyright (C) 2016 Amarula Solutions B.V.
- * Copyright (C) 2016 Engicam S.r.l.
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-&i2c1 {
-	stmpe811: gpio-expander at 44 {
-		compatible = "st,stmpe811";
-		reg = <0x44>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_stmpe>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		stmpe: touchscreen {
-			compatible = "st,stmpe-ts";
-			st,sample-time = <4>;
-			st,mod-12b = <1>;
-			st,ref-sel = <0>;
-			st,adc-freq = <1>;
-			st,ave-ctrl = <1>;
-			st,touch-det-delay = <2>;
-			st,settling = <2>;
-			st,fraction-z = <7>;
-			st,i-drive = <1>;
-		};
-	};
-};
-
-&lcdif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lcdif_dat
-		     &pinctrl_lcdif_ctrl>;
-	display = <&display0>;
-	status = "okay";
-
-	display0: display {
-		bits-per-pixel = <16>;
-		bus-width = <18>;
-
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: timing0 {
-				clock-frequency = <28000000>;
-				hactive = <800>;
-				vactive = <480>;
-				hfront-porch = <30>;
-				hback-porch = <30>;
-				hsync-len = <64>;
-				vback-porch = <5>;
-				vfront-porch = <5>;
-				vsync-len = <20>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
-		};
-	};
-};
-
-&iomuxc {
-	pinctrl_lcdif_ctrl: lcdifctrlgrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_CLK__LCDIF_CLK	    0x79
-			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE  0x79
-			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC    0x79
-			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC    0x79
-		>;
-	};
-
-	pinctrl_lcdif_dat: lcdifdatgrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00  0x79
-			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01  0x79
-			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02  0x79
-			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03  0x79
-			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04  0x79
-			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05  0x79
-			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06  0x79
-			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07  0x79
-			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08  0x79
-			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09  0x79
-			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10  0x79
-			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11  0x79
-			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12  0x79
-			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13  0x79
-			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14  0x79
-			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15  0x79
-			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16  0x79
-			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17  0x79
-		>;
-	};
-
-	pinctrl_stmpe: stmpegrp  {
-		fsl,pins = <
-			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18 0x1b0b0
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
index 73a1d0f..f5b4228 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
+++ b/arch/arm/boot/dts/imx6ul-isiot-emmc.dts
@@ -43,7 +43,6 @@
 /dts-v1/;
 
 #include "imx6ul-isiot.dtsi"
-#include "imx6ul-isiot-common.dtsi"
 
 / {
 	model = "Engicam Is.IoT MX6UL eMMC Starter kit";
diff --git a/arch/arm/boot/dts/imx6ul-isiot-nand.dts b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
index da29a86..de15e1c 100644
--- a/arch/arm/boot/dts/imx6ul-isiot-nand.dts
+++ b/arch/arm/boot/dts/imx6ul-isiot-nand.dts
@@ -43,7 +43,6 @@
 /dts-v1/;
 
 #include "imx6ul-isiot.dtsi"
-#include "imx6ul-isiot-common.dtsi"
 
 / {
 	model = "Engicam Is.IoT MX6UL NAND Starter kit";
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index ea30380..3c442f6 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -76,6 +76,32 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
+
+	stmpe811: gpio-expander at 44 {
+		compatible = "st,stmpe811";
+		reg = <0x44>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_stmpe>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		stmpe: touchscreen {
+			compatible = "st,stmpe-ts";
+			st,sample-time = <4>;
+			st,mod-12b = <1>;
+			st,ref-sel = <0>;
+			st,adc-freq = <1>;
+			st,ave-ctrl = <1>;
+			st,touch-det-delay = <2>;
+			st,settling = <2>;
+			st,fraction-z = <7>;
+			st,i-drive = <1>;
+		};
+	};
 };
 
 &i2c2 {
@@ -85,6 +111,38 @@
 	status = "okay";
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display {
+		bits-per-pixel = <16>;
+		bus-width = <18>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <28000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <30>;
+				hback-porch = <30>;
+				hsync-len = <64>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				vsync-len = <20>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
 &pwm8 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm8>;
@@ -129,6 +187,38 @@
 		>;
 	};
 
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK	    0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE  0x79
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC    0x79
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC    0x79
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdifdatgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00  0x79
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01  0x79
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02  0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03  0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04  0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05  0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06  0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07  0x79
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08  0x79
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09  0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10  0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11  0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12  0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13  0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14  0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15  0x79
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16  0x79
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17  0x79
+		>;
+	};
+
 	pinctrl_pwm8: pwm8grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_RX_ER__PWM8_OUT   0x110b0
@@ -145,6 +235,12 @@
 		>;
 	};
 
+	pinctrl_stmpe: stmpegrp  {
+		fsl,pins = <
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18 0x1b0b0
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX 0x1b0b1
-- 
2.7.4
