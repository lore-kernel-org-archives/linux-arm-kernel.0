From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 16 Mar 2017 01:28:07 +0800
Subject: [PATCH v2 4/5] ARM: sun8i: h3: switch apb0-related clocks to r_ccu
In-Reply-To: <20170315172808.64011-1-icenowy@aosc.xyz>
References: <20170315172808.64011-1-icenowy@aosc.xyz>
Message-ID: <20170315172808.64011-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have driver for the PRCM CCU, switch to use it instead of
old-style clock nodes for apb0-related clocks in sunxi-h3-h5.dtsi .

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch in v2.

 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 46 +++++++++++++-------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 2494ea063cd4..710e429a3d03 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -41,8 +41,10 @@
  */
 
 #include <dt-bindings/clock/sun8i-h3-ccu.h>
+#include <dt-bindings/clock/sun8i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/sun8i-h3-ccu.h>
+#include <dt-bindings/reset/sun8i-r-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -68,31 +70,11 @@
 			clock-output-names = "osc32k";
 		};
 
-		apb0: apb0_clk {
-			compatible = "fixed-factor-clock";
+		osc32000: osc32000_clk {
 			#clock-cells = <0>;
-			clock-div = <1>;
-			clock-mult = <1>;
-			clocks = <&osc24M>;
-			clock-output-names = "apb0";
-		};
-
-		apb0_gates: clk at 01f01428 {
-			compatible = "allwinner,sun8i-h3-apb0-gates-clk",
-				     "allwinner,sun4i-a10-gates-clk";
-			reg = <0x01f01428 0x4>;
-			#clock-cells = <1>;
-			clocks = <&apb0>;
-			clock-indices = <0>, <1>;
-			clock-output-names = "apb0_pio", "apb0_ir";
-		};
-
-		ir_clk: ir_clk at 01f01454 {
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01f01454 0x4>;
-			#clock-cells = <0>;
-			clocks = <&osc32k>, <&osc24M>;
-			clock-output-names = "ir";
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			clock-output-names = "osc32000";
 		};
 	};
 
@@ -544,9 +526,12 @@
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		apb0_reset: reset at 01f014b0 {
-			reg = <0x01f014b0 0x4>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
+		r_ccu: clock at 1f01400 {
+			compatible = "allwinner,sun50i-a64-r-ccu";
+			reg = <0x01f01400 0x100>;
+			clocks = <&osc24M>, <&osc32k>, <&osc32000>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
@@ -557,9 +542,9 @@
 
 		ir: ir at 01f02000 {
 			compatible = "allwinner,sun5i-a13-ir";
-			clocks = <&apb0_gates 1>, <&ir_clk>;
+			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
-			resets = <&apb0_reset 1>;
+			resets = <&r_ccu RST_APB0_IR>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01f02000 0x40>;
 			status = "disabled";
@@ -569,9 +554,8 @@
 			compatible = "allwinner,sun8i-h3-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb0_gates 0>, <&osc24M>, <&osc32k>;
+			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
-			resets = <&apb0_reset 0>;
 			gpio-controller;
 			#gpio-cells = <3>;
 			interrupt-controller;
-- 
2.12.0
