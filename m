From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon, 13 Mar 2017 15:15:57 +0100
Subject: [PATCH 1/5] dt-bindings: Document the STM32 DMAMUX bindings
In-Reply-To: <1489414561-28912-1-git-send-email-cedric.madianga@gmail.com>
References: <1489414561-28912-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1489414561-28912-2-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the documentation of device tree bindings for the STM32
DMAMUX.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 .../devicetree/bindings/dma/stm32-dmamux.txt       | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt

diff --git a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
new file mode 100644
index 0000000..1039420
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
@@ -0,0 +1,57 @@
+STM32 DMA MUX (DMA request router)
+
+Required properties:
+- compatible:	"st,stm32-dmamux"
+- reg:		Memory map for accessing module
+- #dma-cells:	Should be set to <4>.
+		For more details about the four cells, please see stm32-dma.txt
+		documentation binding file
+- dma-masters:	Phandle pointing to the DMA controller
+- clocks: Input clock of the DMAMUX instance.
+
+Optional properties:
+- dma-channels : Number of DMA channels supported.
+- dma-requests : Number of DMA requests supported.
+- resets: Reference to a reset controller asserting the DMA controller
+
+Example:
+
+/* DMA controller */
+dma2: dma-controller at 40026400 {
+	compatible = "st,stm32-dma";
+	reg = <0x40026400 0x400>;
+	interrupts = <56>,
+		     <57>,
+		     <58>,
+		     <59>,
+		     <60>,
+		     <68>,
+		     <69>,
+		     <70>;
+	clocks = <&clk_hclk>;
+	#dma-cells = <4>;
+	st,mem2mem;
+	resets = <&rcc 150>;
+	st,dmamux;
+	dma-channels = <8>;
+};
+
+/* DMA mux */
+dmamux2: dma-router at 40020820 {
+	compatible = "st,stm32-dmamux";
+	reg = <0x40020800 0x1c>;
+	#dma-cells = <4>;
+	dma-requests = <128>;
+	dma-masters = <&dma2>;
+};
+
+/* DMA client */
+usart1: serial at 40011000 {
+	compatible = "st,stm32-usart", "st,stm32-uart";
+	reg = <0x40011000 0x400>;
+	interrupts = <37>;
+	clocks = <&clk_pclk2>;
+	dmas = <&dmamux2 0 41 0x400 0x00>,
+	       <&dmamux2 1 42 0x400 0x00>;
+	dma-names = "rx", "tx";
+};
-- 
1.9.1
