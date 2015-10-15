From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu, 15 Oct 2015 14:14:17 +0200
Subject: [PATCH v3 1/4] dt-bindings: Document the STM32 DMA bindings
In-Reply-To: <1444911260-31993-1-git-send-email-cedric.madianga@gmail.com>
References: <1444911260-31993-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1444911260-31993-2-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the STM32 dma
controller.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 .../devicetree/bindings/dma/stm32-dma.txt          | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
new file mode 100644
index 0000000..54d0326
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
@@ -0,0 +1,82 @@
+* STMicroelectronics STM32 DMA controller
+
+The STM32 DMA is a general-purpose direct memory access controller capable of
+supporting 8 independent DMA channels. Each channel can have up to 8 requests.
+
+Required properties:
+- compatible: Should be "st,stm32-dma"
+- reg: Should contain DMA registers location and length. This should include
+  all of the per-channel registers.
+- interrupts: Should contain all of the per-channel DMA interrupts ordering by
+  channel index.
+- clocks: Should contain the input clock of the DMA instance.
+- #dma-cells : Must be <4>. See DMA client paragraph for more details.
+
+Optional properties:
+- resets: Reference to a reset controller asserting the DMA controller
+- st,mem2mem: boolean; if defined, it indicates that the controller supports
+  memory-to-memory transfer
+
+Example:
+
+	dma2: dma-controller at 40026400 {
+		compatible = "st,stm32-dma";
+		reg = <0x40026400 0x400>;
+		interrupts = <56>,
+			     <57>,
+			     <58>,
+			     <59>,
+			     <60>,
+			     <68>,
+			     <69>,
+			     <70>;
+		clocks = <&clk_hclk>;
+		#dma-cells = <4>;
+		st,mem2mem;
+		resets = <&rcc 150>;
+	};
+
+* DMA client
+
+DMA clients connected to the STM32 DMA controller must use the format
+described in the dma.txt file, using a five-cell specifier for each
+channel: a phandle plus four integer cells.
+The four cells in order are:
+
+1. The channel id
+2. The request line number
+3. A 32bit mask specifying the DMA channel configuration which are device
+   dependent:
+  -bit 9: Peripheral Increment Address
+	0x0: no address increment between transfers
+	0x1: increment address between transfers
+ -bit 10: Memory Increment Address
+	0x0: no address increment between transfers
+	0x1: increment address between transfers
+ -bit 15: Peripheral Increment Offset Size
+	0x0: offset size is linked to the peripheral bus width
+	0x1: offset size is fixed to 4 (32-bit alignment)
+ -bit 16-17: Priority level
+	0x0: low
+	0x1: medium
+	0x2: high
+	0x3: very high
+5. A 32bit mask specifying the DMA FIFO threshold configuration which are device
+   dependent:
+ -bit 0-1: Fifo threshold
+	0x0: 1/4 full FIFO
+	0x1: 1/2 full FIFO
+	0x2: 3/4 full FIFO
+	0x3: full FIFO
+
+Example:
+
+	usart1: serial at 40011000 {
+		compatible = "st,stm32-usart", "st,stm32-uart";
+		reg = <0x40011000 0x400>;
+		interrupts = <37>;
+		clocks = <&clk_pclk2>;
+		dmas = <&dma2 2 4 0x10400 0x3>,
+		       <&dma2 7 5 0x10200 0x3>;
+		dma-names = "rx", "tx";
+	};
-- 
1.9.1
