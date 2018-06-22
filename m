From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 22 Jun 2018 20:45:38 +0800
Subject: [PATCH v2 5/7] arm64: allwinner: a64: add necessary device tree nodes
 for DE2 CCU
In-Reply-To: <20180622124540.56203-1-icenowy@aosc.io>
References: <20180622124540.56203-1-icenowy@aosc.io>
Message-ID: <20180622124540.56203-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have all necessary parts to enable the DE2 CCU on the Allwinner
A64 SoC, add the needed device tree nodes, including the DE2 CCU itself
and the DE2 bus.

The "mixer0-lcd0" simplefb device node is updated to use the DE2 CCU.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Drop SRAM controller device tree node addition (as it's already added
  as part of syscon change.)
- Fix the clock reference in LCD SimpleFB.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index ff2ddde1e117..318c4ba8ae9f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -43,9 +43,11 @@
  */
 
 #include <dt-bindings/clock/sun50i-a64-ccu.h>
+#include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun8i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
+#include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun8i-r-ccu.h>
 
 / {
@@ -58,17 +60,12 @@
 		#size-cells = <1>;
 		ranges;
 
-/*
- * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2 CCU.
- * However there is no support for this clock on A64 yet, so we depend
- * on the upstream clocks here to keep them (and thus CLK_MIXER0) up.
- */
 		simplefb_lcd: framebuffer-lcd {
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "mixer0-lcd0";
 			clocks = <&ccu CLK_TCON0>,
-				 <&ccu CLK_DE>, <&ccu CLK_BUS_DE>;
+				 <&display_clocks CLK_MIXER0>;
 			status = "disabled";
 		};
 	};
@@ -169,6 +166,27 @@
 		#size-cells = <1>;
 		ranges;
 
+		de2 at 1000000 {
+			compatible = "allwinner,sun50i-a64-de2";
+			reg = <0x1000000 0x400000>;
+			allwinner,sram = <&de2_sram 1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1000000 0x400000>;
+
+			display_clocks: clock at 0 {
+				compatible = "allwinner,sun50i-a64-de2-clk";
+				reg = <0x0 0x100000>;
+				clocks = <&ccu CLK_DE>,
+					 <&ccu CLK_BUS_DE>;
+				clock-names = "mod",
+					      "bus";
+				resets = <&ccu RST_BUS_DE>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+		};
+
 		syscon: syscon at 1c00000 {
 			compatible = "allwinner,sun50i-a64-system-control";
 			reg = <0x01c00000 0x1000>;
-- 
2.17.1
