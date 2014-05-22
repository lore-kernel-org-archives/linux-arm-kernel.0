From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 22 May 2014 14:33:16 +0200
Subject: [PATCH 1/2] ARM: shmobile: r8a7779 dtsi: Correct
 #address-cells/#size-cells for clocks
In-Reply-To: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
References: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1400761997-13512-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warning (ranges_format): /clocks has empty "ranges" property but its #address-cells (2) differs from / (1)
Warning (ranges_format): /clocks has empty "ranges" property but its #size-cells (2) differs from / (1)

As r8a7779 doesn't support LPAE, change #address-cells and #size-cells from
"<2>" to "<1>" to fix this.

Also correct the unit-address for the cpg_clocks node, and add missing
unit-addresses for the mstp*_clks nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Is it correct that r8a7779 doesn't support LPAE? I don't have the datasheet,
but the similar r8a7778 doesn't.

 arch/arm/boot/dts/r8a7779.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 038c16a18373..dc624e0d7506 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -284,8 +284,8 @@
 	};
 
 	clocks {
-		#address-cells = <2>;
-		#size-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 		ranges;
 
 		/* External root clock */
@@ -298,9 +298,9 @@
 		};
 
 		/* Special CPG clocks */
-		cpg_clocks: cpg_clocks at 0xe6150000 {
+		cpg_clocks: cpg_clocks at 0xffc80000 {
 			compatible = "renesas,r8a7779-cpg-clocks";
-			reg = <0 0xffc80000 0 0x30>;
+			reg = <0xffc80000 0x30>;
 			clocks = <&extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "plla", "z", "zs", "s",
@@ -342,10 +342,10 @@
 		};
 
 		/* Gate clocks */
-		mstp0_clks: mstp0_clks {
+		mstp0_clks: mstp0_clks at ffc80030 {
 			compatible = "renesas,r8a7779-mstp-clocks",
 			             "renesas,cpg-mstp-clocks";
-			reg = <0 0xffc80030 0 4>;
+			reg = <0xffc80030 4>;
 			clocks = <&cpg_clocks R8A7779_CLK_S>,
 			         <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
@@ -379,10 +379,10 @@
 				"scif1", "scif0", "i2c3", "i2c2", "i2c1",
 				"i2c0";
 		};
-		mstp1_clks: mstp1_clks {
+		mstp1_clks: mstp1_clks at ffc80034 {
 			compatible = "renesas,r8a7779-mstp-clocks",
 			             "renesas,cpg-mstp-clocks";
-			reg = <0 0xffc80034 0 4>, <0 0xffc80044 0 4>;
+			reg = <0xffc80034 4>, <0xffc80044 4>;
 			clocks = <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>,
@@ -408,10 +408,10 @@
 				"ether", "sata",
 				"pcie", "vin3";
 		};
-		mstp3_clks: mstp3_clks {
+		mstp3_clks: mstp3_clks at ffc8003c {
 			compatible = "renesas,r8a7779-mstp-clocks",
 			             "renesas,cpg-mstp-clocks";
-			reg = <0 0xffc8003c 0 4>;
+			reg = <0xffc8003c 4>;
 			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
 				 <&s4_clk>, <&s4_clk>;
 			#clock-cells = <1>;
-- 
1.9.1
