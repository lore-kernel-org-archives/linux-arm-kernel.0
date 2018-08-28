From: leilk.liu@mediatek.com (Leilk Liu)
Date: Tue, 28 Aug 2018 14:28:03 +0800
Subject: [PATCH 1/3] spis: mediatek: add bindings for Mediatek MT2712 soc
 platform
In-Reply-To: <1535437685-30230-1-git-send-email-leilk.liu@mediatek.com>
References: <1535437685-30230-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1535437685-30230-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a DT binding documentation for the MT2712 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
new file mode 100644
index 0000000..dcb8934
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
@@ -0,0 +1,39 @@
+Binding for MTK SPI Slave controller
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt2712-spi: for mt2712 platforms
+
+- reg: Address and length of the register set for the device
+
+- interrupts: Should contain spi interrupt
+
+- clocks: phandles to input clocks.
+  The first should be one of the following. It's PLL.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D2>: specify parent clock 312MHZ.
+				      It's the default one.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D4>: specify parent clock 156MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
+  The second should be <&topckgen CLK_TOP_SPISLV_SEL>. It's clock mux.
+  The third is <&infracfg CLK_INFRA_AO_SPI1>. It's clock gate.
+
+- clock-names: shall be "parent-clk" for the parent clock, "sel-clk" for the
+  muxes clock, and "spi-clk" for the clock gate.
+
+- spi-slave: Empty property indicating the SPI controller is used in slave mode.
+
+Example:
+
+- SoC Specific Portion:
+spis: spi at 10013000 {
+	compatible = "mediatek,mt2712-spi-slave";
+	reg = <0 0x10013000 0 0x100>;
+	interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&topckgen CLK_TOP_UNIVPLL1_D2>,
+		<&topckgen CLK_TOP_SPISLV_SEL>,
+		<&infracfg CLK_INFRA_AO_SPI1>;
+	clock-names = "parent-clk", "sel-clk", "spi-clk";
+	spi-slave;
+	status = "disabled";
+};
-- 
1.7.9.5
