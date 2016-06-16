From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 17 Jun 2016 01:02:48 +0300
Subject: [PATCH 1/2] ARM: dts: r8a7792: add JPU clocks
In-Reply-To: <7346244.CEZI3u99oZ@wasted.cogentembedded.com>
References: <7346244.CEZI3u99oZ@wasted.cogentembedded.com>
Message-ID: <8298805.L3k84jpzv2@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add JPU clock and its parent, M2 clock to the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi            |   16 ++++++++++++++++
 include/dt-bindings/clock/r8a7792-clock.h |    1 +
 2 files changed, 17 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -280,8 +280,24 @@
 			clock-div = <48>;
 			clock-mult = <1>;
 		};
+		m2_clk: m2 {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+		};
 
 		/* Gate clocks */
+		mstp1_clks: mstp1_clks at e6150134 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
+			clocks = <&m2_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7792_CLK_JPU>;
+			clock-output-names = "jpu";
+		};
 		mstp2_clks: mstp2_clks at e6150138 {
 			compatible = "renesas,r8a7792-mstp-clocks",
 				     "renesas,cpg-mstp-clocks";
Index: renesas/include/dt-bindings/clock/r8a7792-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7792-clock.h
+++ renesas/include/dt-bindings/clock/r8a7792-clock.h
@@ -24,6 +24,7 @@
 #define R8A7792_CLK_MSIOF0		0
 
 /* MSTP1 */
+#define R8A7792_CLK_JPU			6
 #define R8A7792_CLK_TMU1		11
 #define R8A7792_CLK_TMU3		21
 #define R8A7792_CLK_TMU2		22
