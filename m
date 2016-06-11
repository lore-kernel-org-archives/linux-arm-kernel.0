From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 11 Jun 2016 19:04:50 +0200
Subject: [PATCH v2 3/3] dt: sun8i: Define the clocks of the A83T
In-Reply-To: <cover.1465666788.git.moinejf@free.fr>
References: <cover.1465666788.git.moinejf@free.fr>
Message-ID: <61aeb2c338f6c1a3dc00db4ad66d285e6b7f48d2.1465666788.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks are defined by the CCU binding.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index d3473f8..4fec56a 100644
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
@@ -210,7 +218,7 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&ccu CLK_BUS_UART0>;
 			status = "disabled";
 		};
 
-- 
2.8.4
