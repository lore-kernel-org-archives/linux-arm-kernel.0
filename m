From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:31 +0900
Subject: [PATCH 01/25] ARM: shmobile: sh73a0: Add MSIOF clocks
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <23d711ab4dec7552cad8d03d12e253ac66e70a95.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The 4 MSIOF clocks are MSTP clocks, and children of the SUB clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi            | 28 ++++++++++++++++------------
 include/dt-bindings/clock/sh73a0-clock.h |  6 +++++-
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 319551f0fcdb..635564ab98ed 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -812,13 +812,13 @@
 		mstp0_clks: mstp0_clks at e6150130 {
 			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xe6150130 4>, <0xe6150030 4>;
-			clocks = <&cpg_clocks SH73A0_CLK_HP>;
+			clocks = <&cpg_clocks SH73A0_CLK_HP>, <&sub_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
-				SH73A0_CLK_IIC2
+				SH73A0_CLK_IIC2 SH73A0_CLK_MSIOF0
 			>;
 			clock-output-names =
-				"iic2";
+				"iic2", "msiof0";
 		};
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
@@ -848,20 +848,24 @@
 			reg = <0xe6150138 4>, <0xe6150040 4>;
 			clocks = <&sub_clk>, <&cpg_clocks SH73A0_CLK_HP>,
 				 <&cpg_clocks SH73A0_CLK_HP>, <&sub_clk>,
-				 <&sub_clk>, <&sub_clk>, <&sub_clk>, <&sub_clk>,
-				 <&sub_clk>, <&sub_clk>;
+				 <&sub_clk>, <&sub_clk>, <&sub_clk>,
+				 <&sub_clk>, <&sub_clk>, <&sub_clk>,
+				 <&sub_clk>, <&sub_clk>, <&sub_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				SH73A0_CLK_SCIFA7 SH73A0_CLK_SY_DMAC
-				SH73A0_CLK_MP_DMAC SH73A0_CLK_SCIFA5
-				SH73A0_CLK_SCIFB SH73A0_CLK_SCIFA0
-				SH73A0_CLK_SCIFA1 SH73A0_CLK_SCIFA2
-				SH73A0_CLK_SCIFA3 SH73A0_CLK_SCIFA4
+				SH73A0_CLK_MP_DMAC SH73A0_CLK_MSIOF3
+				SH73A0_CLK_MSIOF1 SH73A0_CLK_SCIFA5
+				SH73A0_CLK_SCIFB SH73A0_CLK_MSIOF2
+				SH73A0_CLK_SCIFA0 SH73A0_CLK_SCIFA1
+				SH73A0_CLK_SCIFA2 SH73A0_CLK_SCIFA3
+				SH73A0_CLK_SCIFA4
 			>;
 			clock-output-names =
-				"scifa7", "sy_dmac", "mp_dmac", "scifa5",
-				"scifb", "scifa0", "scifa1", "scifa2",
-				"scifa3", "scifa4";
+				"scifa7", "sy_dmac", "mp_dmac", "msiof3",
+				"msiof1", "scifa5", "scifb", "msiof2",
+				"scifa0", "scifa1", "scifa2", "scifa3",
+				"scifa4";
 		};
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/sh73a0-clock.h b/include/dt-bindings/clock/sh73a0-clock.h
index 53369568c24c..2eca353a29d7 100644
--- a/include/dt-bindings/clock/sh73a0-clock.h
+++ b/include/dt-bindings/clock/sh73a0-clock.h
@@ -28,7 +28,8 @@
 #define SH73A0_CLK_HP		14
 
 /* MSTP0 */
-#define SH73A0_CLK_IIC2	1
+#define SH73A0_CLK_IIC2		1
+#define SH73A0_CLK_MSIOF0	0
 
 /* MSTP1 */
 #define SH73A0_CLK_CEU1		29
@@ -45,8 +46,11 @@
 #define SH73A0_CLK_SCIFA7	19
 #define SH73A0_CLK_SY_DMAC	18
 #define SH73A0_CLK_MP_DMAC	17
+#define SH73A0_CLK_MSIOF3	15
+#define SH73A0_CLK_MSIOF1	8
 #define SH73A0_CLK_SCIFA5	7
 #define SH73A0_CLK_SCIFB	6
+#define SH73A0_CLK_MSIOF2	5
 #define SH73A0_CLK_SCIFA0	4
 #define SH73A0_CLK_SCIFA1	3
 #define SH73A0_CLK_SCIFA2	2
-- 
2.1.4
