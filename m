From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:46 +0100
Subject: [PATCH 56/68] ARM: dts: r8a7779: Add BRG support for SCIF
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <f2be5f00d5eef701871cb1bc2b573dd5a75f66d3.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the device node for the external SCIF_CLK.
The presence of the SCIF_CLK crystal and its clock frequency depends on
the actual board.

Add the two optional clock sources (S1 and SCIF_CLK for the internal
resp. external clock) for the Baud Rate Generator for External Clock
(BRG) to all SCIF device nodes.

This increases the range and accuracy of supported baud rates on SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 8fddfae13865..a0cc08e6295b 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -215,8 +215,9 @@
 			     "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -226,8 +227,9 @@
 			     "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -237,8 +239,9 @@
 			     "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -248,8 +251,9 @@
 			     "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -259,8 +263,9 @@
 			     "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -270,8 +275,9 @@
 			     "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -447,6 +453,15 @@
 			clock-output-names = "extal";
 		};
 
+		/* External SCIF clock */
+		scif_clk: scif {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+			status = "disabled";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: clocks at ffc80000 {
 			compatible = "renesas,r8a7779-cpg-clocks";
-- 
2.7.0.rc3.207.g0ac5344
