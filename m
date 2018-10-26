From: peng.ma@nxp.com (Peng Ma)
Date: Fri, 26 Oct 2018 17:52:40 +0800
Subject: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA controller
 bindings
In-Reply-To: <20181026095240.33668-1-peng.ma@nxp.com>
References: <20181026095240.33668-1-peng.ma@nxp.com>
Message-ID: <20181026095240.33668-7-peng.ma@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the devicetree bindings for NXP Layerscape qDMA controller
which could be found on NXP QorIQ Layerscape SoCs.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
change in v10:
	- no

 Documentation/devicetree/bindings/dma/fsl-qdma.txt |   57 ++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
new file mode 100644
index 0000000..6a0ff90
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
@@ -0,0 +1,57 @@
+NXP Layerscape SoC qDMA Controller
+==================================
+
+This device follows the generic DMA bindings defined in dma/dma.txt.
+
+Required properties:
+
+- compatible:		Must be one of
+			 "fsl,ls1021a-qdma": for LS1021A Board
+			 "fsl,ls1043a-qdma": for ls1043A Board
+			 "fsl,ls1046a-qdma": for ls1046A Board
+- reg:			Should contain the register's base address and length.
+- interrupts:		Should contain a reference to the interrupt used by this
+			device.
+- interrupt-names:	Should contain interrupt names:
+			 "qdma-queue0": the block0 interrupt
+			 "qdma-queue1": the block1 interrupt
+			 "qdma-queue2": the block2 interrupt
+			 "qdma-queue3": the block3 interrupt
+			 "qdma-error":  the error interrupt
+- fsl,dma-queues:	Should contain number of queues supported.
+- dma-channels:	Number of DMA channels supported
+- block-number:	the virtual block number
+- block-offset:	the offset of different virtual block
+- status-sizes:	status queue size of per virtual block
+- queue-sizes:		command queue size of per virtual block, the size number
+			based on queues
+
+Optional properties:
+
+- dma-channels:		Number of DMA channels supported by the controller.
+- big-endian:		If present registers and hardware scatter/gather descriptors
+			of the qDMA are implemented in big endian mode, otherwise in little
+			mode.
+
+Examples:
+
+	qdma: dma-controller at 8390000 {
+			compatible = "fsl,ls1021a-qdma";
+			reg = <0x0 0x8388000 0x0 0x1000>, /* Controller regs */
+			      <0x0 0x8389000 0x0 0x1000>, /* Status regs */
+			      <0x0 0x838a000 0x0 0x2000>; /* Block regs */
+			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "qdma-error",
+				"qdma-queue0", "qdma-queue1";
+			dma-channels = <8>;
+			block-number = <2>;
+			block-offset = <0x1000>;
+			fsl,dma-queues = <2>;
+			status-sizes = <64>;
+			queue-sizes = <64 64>;
+			big-endian;
+		};
+
+DMA clients must use the format described in dma/dma.txt file.
-- 
1.7.1
