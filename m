From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 15:23:59 +0900
Subject: [PATCH v11 4/8] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
In-Reply-To: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1444890243-6978-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the device nodes for all R-Car H3 SCIF serial ports, incl. clocks,
clock domain, and dma properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since V10 (Simon Horman <horms+renesas@verge.net.au>)
- As suggested by Geert Uyterhoven
  + R8A7795_CLK_SCIF2  is 310 not 210

Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
- Added SCIF2 DMA bits again
- Converted DT nodes for MSTP to MSSR, adjusted r8a7795-clock.h
- Include clock-output-names

Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
- Dropped SCIF2 DMA bits - thanks Laurent!
- Changed name of mstp2 and mstp3 nodes - thanks Geert!
- Added Acked-by from Laurent

Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
- Folded together above SCIF2 patches
- Added SCIF2 DMA bits
- Got rid of clock-output-names
- Replaced renesas,clock-indices with clock-indices

Based on:
 [PATCH 9/25] arm64: renesas: r8a7795: Add SCIF2 support
 [PATCH 1/6] arm64: renesas: r8a7795 dtsi: Mark scif2 disabled
 [PATCH 3/6] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 109 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |   6 ++
 2 files changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 3d97a089e8be..0d7ac639094f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -240,6 +240,11 @@
 			};
 
 			cpg_clocks: cpg_clocks at e6150000 {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				#clock-cells = <1>;
+				ranges;
+
 				compatible = "renesas,r8a7795-cpg-clocks",
 					     "renesas,rcar-gen3-cpg-clocks";
 				reg = <0 0xe6150000 0 0x1000>;
@@ -252,6 +257,38 @@
 				clock-output-names = "main", "pll0", "pll1",
 						     "pll2", "pll3", "pll4";
 				#power-domain-cells = <0>;
+
+				/* Module Standby and Software Reset */
+				mssr: mssr at e6150130 {
+					compatible =
+						"renesas,r8a7795-cpg-mssr";
+					reg = <0 0xe6150000 0 0x1000>;
+					#clock-cells = <1>;
+					clocks =
+						/* MSTP2 */
+						<&s3d4_clk>, <&s3d4_clk>,
+						<&s3d4_clk>, <&s3d4_clk>,
+						<&s3d4_clk>,
+						/* MSTP3 */
+						<&s3d4_clk>;
+					clock-indices = <
+						/* MSTP2 */
+						R8A7795_CLK_SCIF5
+						R8A7795_CLK_SCIF4
+						R8A7795_CLK_SCIF3
+						R8A7795_CLK_SCIF1
+						R8A7795_CLK_SCIF0
+						/* MSTP3 */
+						R8A7795_CLK_SCIF2
+					>;
+					clock-output-names =
+						/* MSTP2 */
+						"scif5", "scif4", "scif3",
+						"scif1", "scif0",
+						/* MSTP3 */
+						"scif2";
+					#reset-cells = <1>;
+				};
 			};
 		};
 
@@ -266,5 +303,77 @@
 		dmac2: dma-controller at e7310000 {
 			/* Empty node for now */
 		};
+
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mssr R8A7795_CLK_SCIF0>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mssr R8A7795_CLK_SCIF1>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif2: serial at e6e88000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mssr R8A7795_CLK_SCIF2>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif3: serial at e6c50000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6c50000 0 64>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mssr R8A7795_CLK_SCIF3>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif4: serial at e6c40000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6c40000 0 64>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mssr R8A7795_CLK_SCIF4>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif5: serial at e6f30000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			reg = <0 0xe6f30000 0 64>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mssr R8A7795_CLK_SCIF5>;
+			clock-names = "sci_ick";
+			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 334fa13d1bb4..51048d79f80d 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -22,8 +22,14 @@
 /* MSTP1 */
 
 /* MSTP2 */
+#define R8A7795_CLK_SCIF5		202
+#define R8A7795_CLK_SCIF4		203
+#define R8A7795_CLK_SCIF3		204
+#define R8A7795_CLK_SCIF1		206
+#define R8A7795_CLK_SCIF0		207
 
 /* MSTP3 */
+#define R8A7795_CLK_SCIF2		310
 
 /* MSTP5 */
 
-- 
2.1.4
