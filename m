From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 05 Sep 2016 23:55:01 +0300
Subject: [PATCH 1/2] ARM: dts: r8a7792: add MSIOF clocks
In-Reply-To: <2481458.x1iQg26kO7@wasted.cogentembedded.com>
References: <2481458.x1iQg26kO7@wasted.cogentembedded.com>
Message-ID: <1642221.rsatzvhHS5@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the MSIOF0/1 clocks and their parent, MP clock in the R8A7792
device  tree.

Based  on the original (and large) patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -763,6 +763,13 @@
 			clock-div = <48>;
 			clock-mult = <1>;
 		};
+		mp_clk: mp {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-div = <15>;
+			clock-mult = <1>;
+		};
 		m2_clk: m2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
@@ -793,6 +800,15 @@
 		};
 
 		/* Gate clocks */
+		mstp0_clks: mstp0_clks at e6150130 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
+			clocks = <&mp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7792_CLK_MSIOF0>;
+			clock-output-names = "msiof0";
+		};
 		mstp1_clks: mstp1_clks at e6150134 {
 			compatible = "renesas,r8a7792-mstp-clocks",
 				     "renesas,cpg-mstp-clocks";
@@ -811,12 +827,13 @@
 			compatible = "renesas,r8a7792-mstp-clocks",
 				     "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
-			clocks = <&zs_clk>, <&zs_clk>;
+			clocks = <&mp_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
+				R8A7792_CLK_MSIOF1
 				R8A7792_CLK_SYS_DMAC1 R8A7792_CLK_SYS_DMAC0
 			>;
-			clock-output-names = "sys-dmac1", "sys-dmac0";
+			clock-output-names = "msiof1", "sys-dmac1", "sys-dmac0";
 		};
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7792-mstp-clocks",
