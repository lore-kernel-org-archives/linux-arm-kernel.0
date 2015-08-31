From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 31 Aug 2015 21:18:58 +0800
Subject: [PATCH 3/3] spi: Mediatek: Document devicetree bindings update for
 spi bus
In-Reply-To: <1441027138-16458-1-git-send-email-leilk.liu@mediatek.com>
References: <1441027138-16458-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1441027138-16458-4-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates spi bindings, fixs clock usage description.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index dcefc43..6160ffb 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -15,17 +15,18 @@ Required properties:
 - interrupts: Should contain spi interrupt
 
 - clocks: phandles to input clocks.
-  The first should be <&topckgen CLK_TOP_SPI_SEL>.
-  The second should be one of the following.
+  The first should be one of the following. It's PLL.
    -  <&clk26m>: specify parent clock 26MHZ.
    -  <&topckgen CLK_TOP_SYSPLL3_D2>: specify parent clock 109MHZ.
 				      It's the default one.
    -  <&topckgen CLK_TOP_SYSPLL4_D2>: specify parent clock 78MHZ.
    -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
    -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
+  The second should be <&topckgen CLK_TOP_SPI_SEL>. It's clock mux.
+  The third is <&pericfg CLK_PERI_SPI0>. It's clock gate.
 
-- clock-names: shall be "spi-clk" for the controller clock, and
-  "parent-clk" for the parent clock.
+- clock-names: shall be "parent-clk" for the parent clock, "sel-clk" for the
+  muxes clock, and "spi-clk" for the clock gate.
 
 Optional properties:
 - mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
@@ -44,8 +45,11 @@ spi: spi at 1100a000 {
 	#size-cells = <0>;
 	reg = <0 0x1100a000 0 0x1000>;
 	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
-	clocks = <&topckgen CLK_TOP_SPI_SEL>, <&topckgen CLK_TOP_SYSPLL3_D2>;
-	clock-names = "spi-clk", "parent-clk";
+	clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+		 <&topckgen CLK_TOP_SPI_SEL>,
+		 <&pericfg CLK_PERI_SPI0>;
+	clock-names = "parent-clk", "sel-clk", "spi-clk";
+
 	mediatek,pad-select = <0>;
 	status = "disabled";
 };
-- 
1.8.1.1.dirty
