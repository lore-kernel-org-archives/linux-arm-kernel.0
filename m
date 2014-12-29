From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 29 Dec 2014 23:19:16 +0300
Subject: [PATCH] ARM: shmobile: r8a7791: add ADSP clocks
Message-ID: <1937156.Ii2YrGkOFy@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ADSP clocks to the CPG and MSTP5 nodes of the R8A7791 device tree.

Based on the original patch by Konstantin Kozhevnikov
<konstantin.kozhevnikov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against 'renesas-devel-20141229-v3.19-rc2' tag of Simon Horman's
'renesas.git' repo plus the R8A7791 CAN patches posted last week. It depends on
the patch adding the ADSP clock support to  the 'clk-rcar-gen2' driver in order
to work.

 arch/arm/boot/dts/r8a7791.dtsi            |   11 +++++++----
 include/dt-bindings/clock/r8a7791-clock.h |    4 +++-
 2 files changed, 10 insertions(+), 5 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -909,7 +909,7 @@
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z",
-					     "rcan";
+					     "adsp", "rcan";
 		};
 
 		/* Variable factor clocks */
@@ -1164,13 +1164,16 @@
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>, <&p_clk>;
+			clocks = <&hp_clk>, <&hp_clk>, <&cpg_clocks R8A7791_CLK_ADSP>,
+				 <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7791_CLK_AUDIO_DMAC0 R8A7791_CLK_AUDIO_DMAC1
-				R8A7791_CLK_THERMAL R8A7791_CLK_PWM
+				R8A7791_CLK_ADSP_MOD R8A7791_CLK_THERMAL
+				R8A7791_CLK_PWM
 			>;
-			clock-output-names = "audmac0", "audmac1", "thermal", "pwm";
+			clock-output-names = "audmac0", "audmac1", "adsp_mod",
+					     "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
Index: renesas/include/dt-bindings/clock/r8a7791-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7791-clock.h
+++ renesas/include/dt-bindings/clock/r8a7791-clock.h
@@ -20,7 +20,8 @@
 #define R8A7791_CLK_SDH			6
 #define R8A7791_CLK_SD0			7
 #define R8A7791_CLK_Z			8
-#define R8A7791_CLK_RCAN		9
+#define R8A7791_CLK_ADSP		9
+#define R8A7791_CLK_RCAN		10
 
 /* MSTP0 */
 #define R8A7791_CLK_MSIOF0		0
@@ -72,6 +73,7 @@
 /* MSTP5 */
 #define R8A7791_CLK_AUDIO_DMAC1		1
 #define R8A7791_CLK_AUDIO_DMAC0		2
+#define R8A7791_CLK_ADSP_MOD		6
 #define R8A7791_CLK_THERMAL		22
 #define R8A7791_CLK_PWM			23
 
