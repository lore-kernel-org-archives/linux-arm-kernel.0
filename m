From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 11 Mar 2015 15:23:25 +0200
Subject: [PATCH v2 2/7] Documentation: devicetree: dma: Binding documentation
 for TI DMA crossbar
In-Reply-To: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1426080210-841-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRA7x has more peripherals with DMA requests than the sDMA can handle:
205 vs 127. All DMA requests are routed through the DMA crossbar, which can
be configured to route selected incoming DMA requests to specific request
line of the DMA controller.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti-dma-crossbar.txt    | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt

diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
new file mode 100644
index 000000000000..e5c2352081b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
@@ -0,0 +1,52 @@
+Texas Instruments DMA Crossbar (DMA request router)
+
+Required properties:
+- compatible:	"ti,dra7-dma-crossbar" for DRA7xx DMA crossbar
+- reg:		Memory map for accessing module
+- #dma-cells:	Should be set to <1>.
+		Clients should use the crossbar request number (input)
+- dma-requests:	Number of DMA requests the crossbar can receive
+- dma-device:	phandle pointing to the DMA controller
+
+The DMA controller node need to have the following poroperties:
+- dma-requests:	Number of DMA requests the controller can handle
+
+Optional properties:
+- ti,dma-safe-map: Safe routing value for unused request lines
+
+Example:
+
+/* DMA controller */
+sdma: dma-controller at 4a056000 {
+	compatible = "ti,omap4430-sdma";
+	reg = <0x4a056000 0x1000>;
+	interrupts =	<GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	#dma-cells = <1>;
+	dma-channels = <32>;
+	dma-requests = <127>;
+};
+
+/* DMA crossbar */
+sdma_xbar: dma-router at 4a002b78 {
+	compatible = "ti,dra7-dma-crossbar";
+	reg = <0x4a002b78 0xfc>;
+	#dma-cells = <1>;
+	dma-requests = <205>;
+	ti,dma-safe-map = <0>;
+	dma-device = <&sdma>;
+};
+
+/* DMA client */
+uart1: serial at 4806a000 {
+	compatible = "ti,omap4-uart";
+	reg = <0x4806a000 0x100>;
+	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+	ti,hwmods = "uart1";
+	clock-frequency = <48000000>;
+	status = "disabled";
+	dmas = <&sdma_xbar 49>, <&sdma_xbar 50>;
+	dma-names = "tx", "rx";
+};
-- 
2.3.0
