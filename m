From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 21 Dec 2017 13:23:52 -0200
Subject: [PATCH v2] ARM: dts: imx51-babbage: Fix the 26MHz clock modelling
Message-ID: <20171221152352.31597-1-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx51-babbage there is a 26MHz oscillator that is gated by GPIO3_1.

The output of this clock feeds audio codec clock and USB PHY clocks,
which are gated by GPIO4_26 and GPIO2_1 respectively.

Fix the clock representation by properly using gpio-gate-clock.

The clock nodes can be moved out of the 'clocks' node.

Based on a commit from Lucas Stach for imx51-zii-rdu1 board.

This also fixes the following build warning with W=1:

arch/arm/boot/dts/imx51-babbage.dtb: Warning (unit_address_vs_reg): Node /clocks/codec_clock has a reg or ranges property, but no unit name

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Use hyphen rather than underscore in node name, and all
lowercase for node name (Shawn)

 arch/arm/boot/dts/imx51-babbage.dts | 67 +++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index c432de778850..4ac5ab614a7f 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -25,18 +25,41 @@
 		reg = <0x90000000 0x20000000>;
 	};
 
-	clocks {
-		ckih1 {
-			clock-frequency = <22579200>;
-		};
+	ckih1 {
+		clock-frequency = <22579200>;
+	};
 
-		clk_26M: codec_clock {
-			compatible = "fixed-clock";
-			reg=<0>;
-			#clock-cells = <0>;
-			clock-frequency = <26000000>;
-			gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
-		};
+	clk_osc: clk-osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	clk_osc_gate: clk-osc-gate {
+		compatible = "gpio-gate-clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_clk26mhz_osc>;
+		clocks = <&clk_osc>;
+		#clock-cells = <0>;
+		enable-gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	clk_audio: clk-audio {
+		compatible = "gpio-gate-clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_clk26mhz_audio>;
+		clocks = <&clk_osc_gate>;
+		#clock-cells = <0>;
+		enable-gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
+	};
+
+	clk_usb: clk-usb {
+		compatible = "gpio-gate-clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_clk26mhz_usb>;
+		clocks = <&clk_osc_gate>;
+		#clock-cells = <0>;
+		enable-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 	};
 
 	display1: disp1 {
@@ -162,7 +185,7 @@
 		usbh1phy: usbh1phy at 0 {
 			compatible = "usb-nop-xceiv";
 			reg = <0>;
-			clocks = <&clks IMX5_CLK_DUMMY>;
+			clocks = <&clk_usb>;
 			clock-names = "main_clk";
 			reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
 			vcc-supply = <&vusb_reg>;
@@ -345,10 +368,8 @@
 
 	sgtl5000: codec at a {
 		compatible = "fsl,sgtl5000";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_clkcodec>;
 		reg = <0x0a>;
-		clocks = <&clk_26M>;
+		clocks = <&clk_audio>;
 		VDDA-supply = <&vdig_reg>;
 		VDDIO-supply = <&vvideo_reg>;
 	};
@@ -441,9 +462,21 @@
 			>;
 		};
 
-		pinctrl_clkcodec: clkcodecgrp {
+		pinctrl_clk26mhz_audio: clk26mhzaudiocgrp {
+			fsl,pins = <
+				MX51_PAD_CSPI1_RDY__GPIO4_26		0x85
+			>;
+		};
+
+		pinctrl_clk26mhz_osc: clk26mhzoscgrp {
+			fsl,pins = <
+				MX51_PAD_DI1_PIN12__GPIO3_1		0x85
+			>;
+		};
+
+		pinctrl_clk26mhz_usb: clk26mhzusbgrp {
 			fsl,pins = <
-				MX51_PAD_CSPI1_RDY__GPIO4_26		0x80000000
+				MX51_PAD_EIM_D17__GPIO2_1		0x85
 			>;
 		};
 
-- 
2.14.1
