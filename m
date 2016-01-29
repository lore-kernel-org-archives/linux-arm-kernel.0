From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 11:04:39 +0100
Subject: [PATCH v4 3/7] ARM: dts: r8a7790: Add BRG support for (H)SCIF
In-Reply-To: <1454061883-4043-1-git-send-email-geert+renesas@glider.be>
References: <1454061883-4043-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454061883-4043-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device node for the external SCIF_CLK.
The presence of the SCIF_CLK crystal and its clock frequency depends on
the actual board.

Add the two optional clock sources (ZS_CLK and SCIF_CLK for the internal
resp. external clock) for the Baud Rate Generator for External Clock
(BRG) to all SCIF and HSCIF device nodes.

This increases the range and accuracy of supported baud rates on
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - New.
---
 arch/arm/boot/dts/r8a7790.dtsi | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c5672745a1e51939..c9583fa6cae7139f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -667,8 +667,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -680,8 +681,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -693,8 +695,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -706,8 +709,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -996,6 +1000,15 @@
 			clock-output-names = "audio_clk_c";
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
 		/* External USB clock - can be overridden by the board */
 		usb_extal_clk: usb_extal_clk {
 			compatible = "fixed-clock";
-- 
1.9.1
