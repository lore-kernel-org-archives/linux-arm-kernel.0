From: leilk.liu@mediatek.com (Leilk Liu)
Date: Fri, 7 Aug 2015 15:19:49 +0800
Subject: [PATCH v5 1/3] spi: Mediatek: Document devicetree bindings for spi bus
In-Reply-To: <1438931991-17044-1-git-send-email-leilk.liu@mediatek.com>
References: <1438931991-17044-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1438931991-17044-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
Change in this patch:
1. change this patch title.
2. change "MTK SPI device" to "MTK SPI controller".
3. "pad-select" is a vendor property, so change it to "mediatek,pad-select".
4. modify the property of clock and clock name.
5. explain what the pad-select values 0-3 mean.
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
new file mode 100644
index 0000000..dcefc43
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -0,0 +1,51 @@
+Binding for MTK SPI controller
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt8173-spi: for mt8173 platforms
+    - mediatek,mt8135-spi: for mt8135 platforms
+    - mediatek,mt6589-spi: for mt6589 platforms
+
+- #address-cells: should be 1.
+
+- #size-cells: should be 0.
+
+- reg: Address and length of the register set for the device
+
+- interrupts: Should contain spi interrupt
+
+- clocks: phandles to input clocks.
+  The first should be <&topckgen CLK_TOP_SPI_SEL>.
+  The second should be one of the following.
+   -  <&clk26m>: specify parent clock 26MHZ.
+   -  <&topckgen CLK_TOP_SYSPLL3_D2>: specify parent clock 109MHZ.
+				      It's the default one.
+   -  <&topckgen CLK_TOP_SYSPLL4_D2>: specify parent clock 78MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
+
+- clock-names: shall be "spi-clk" for the controller clock, and
+  "parent-clk" for the parent clock.
+
+Optional properties:
+- mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
+  controller used, this value should be 0~3, only required for MT8173.
+    0: specify GPIO69,70,71,72 for spi pins.
+    1: specify GPIO102,103,104,105 for spi pins.
+    2: specify GPIO128,129,130,131 for spi pins.
+    3: specify GPIO5,6,7,8 for spi pins.
+
+Example:
+
+- SoC Specific Portion:
+spi: spi at 1100a000 {
+	compatible = "mediatek,mt8173-spi";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0 0x1100a000 0 0x1000>;
+	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&topckgen CLK_TOP_SPI_SEL>, <&topckgen CLK_TOP_SYSPLL3_D2>;
+	clock-names = "spi-clk", "parent-clk";
+	mediatek,pad-select = <0>;
+	status = "disabled";
+};
-- 
1.8.1.1.dirty
