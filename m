From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 28 Jun 2016 19:22:50 +0200
Subject: [PATCH 3/3] dt: sun8i: Define the clocks of the A83T
In-Reply-To: <cover.1467135898.git.moinejf@free.fr>
References: <cover.1467135898.git.moinejf@free.fr>
Message-ID: <96c1b4e0bb74e3c8a543975f0beb6f057d034323.1467135898.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the clock definition using the CCU.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  7 ++++---
 arch/arm/boot/dts/sun8i-a83t.dtsi                 | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 8f7619d..8e1f832 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -61,7 +61,6 @@ Required properties:
 	"allwinner,sun9i-a80-apb1-gates-clk" - for the APB1 gates on A80
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
-	"allwinner,sun8i-a83t-bus-gates-clk" - for the bus gates on A83T
 	"allwinner,sun8i-h3-bus-gates-clk" - for the bus gates on H3
 	"allwinner,sun9i-a80-apbs-gates-clk" - for the APBS gates on A80
 	"allwinner,sun4i-a10-display-clk" - for the display clocks on the A10
@@ -87,6 +86,7 @@ Required properties:
 	"allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
 	"allwinner,sun4i-a10-ve-clk" - for the Video Engine clock
 	"allwinner,sun6i-a31-display-clk" - for the display clocks
+	"allwinner,sun8i-a83t-ccu" - for the CCU clocks/resets on A83T
 
 Required properties for all clocks:
 - reg : shall be the control register address for the clock.
@@ -98,12 +98,13 @@ Required properties for all clocks:
 	"allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
 	"allwinner,sun4i-pll6-clk", "allwinner,sun6i-a31-pll6-clk",
 	"allwinner,*-usb-clk", "allwinner,*-mmc-clk",
-	"allwinner,*-mmc-config-clk"
+	"allwinner,*-mmc-config-clk",
+	"allwinner,*-ccu"
 - clock-output-names : shall be the corresponding names of the outputs.
 	If the clock module only has one output, the name shall be the
 	module name.
 
-And "allwinner,*-usb-clk" clocks also require:
+"allwinner,*-usb-clk" and "allwinner,*-ccu" clocks also require:
 - reset-cells : shall be set to 1
 
 The "allwinner,sun4i-a10-ve-clk" clock also requires:
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index d3473f8..6e0acca 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -45,9 +45,10 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/clock/sun8i-a83t.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-
 #include <dt-bindings/pinctrl/sun4i-a10.h>
+#include <dt-bindings/reset/sun8i-a83t.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -138,13 +139,13 @@
 			clock-output-names = "osc16M";
 		};
 
-		osc16Md512: osc16Md512_clk {
+		osc32k: osc32k_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <512>;
 			clock-mult = <1>;
 			clocks = <&osc16M>;
-			clock-output-names = "osc16M-d512";
+			clock-output-names = "osc32k";
 		};
 	};
 
@@ -154,13 +155,20 @@
 		#size-cells = <1>;
 		ranges;
 
+		ccu: clock at 01c20000 {
+			compatible = "allwinner,sun8i-a83t-ccu";
+			reg = <0x01c20000 0x400>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun8i-a83t-pinctrl";
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01c20800 0x400>;
-			clocks = <&osc24M>;
+			clocks = <&ccu CLK_BUS_PIO>;
 			gpio-controller;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-- 
2.9.0
