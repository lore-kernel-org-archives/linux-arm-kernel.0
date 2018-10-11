From: peng.ma@nxp.com (Peng Ma)
Date: Thu, 11 Oct 2018 17:46:55 +0800
Subject: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA controller
 bindings
In-Reply-To: <20181011094655.45707-1-peng.ma@nxp.com>
References: <20181011094655.45707-1-peng.ma@nxp.com>
Message-ID: <20181011094655.45707-7-peng.ma@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the devicetree bindings for NXP Layerscape qDMA controller
which could be found on NXP QorIQ Layerscape SoCs.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-qdma.txt |   53 ++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
new file mode 100644
index 0000000..7e2160b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
@@ -0,0 +1,53 @@
+NXP Layerscape SoC qDMA Controller
+==================================
+
+The qDMA supports channel virtualization by allowing DMA jobs to be enqueued into
+different command queues. Core can initiate a DMA transaction by preparing a command
+descriptor for each DMA job and enqueuing this job to a command queue.
+
+Required properties:
+- compatible:	Must be one of
+	"fsl,ls1021a-qdma": for LS1021A Board
+	"fsl,ls1043a-qdma": for ls1043A Board
+	"fsl,ls1046a-qdma": for ls1046A Board
+- reg : Specifies base physical address(s) and size of the qDMA registers.
+	The 1st region is qDMA control register's address and size.
+	The 2nd region is status queue control register's address and size.
+	The 3rd region is virtual block control register's address and size.
+- interrupts : A list of interrupt-specifiers, one for each entry in
+	interrupt-names.
+- interrupt-names : Should contain:
+	"qdma-queue0" - the block0 interrupt
+	"qdma-queue1" - the block1 interrupt
+	"qdma-queue2" - the block2 interrupt
+	"qdma-queue3" - the block3 interrupt
+	"qdma-error"  - the error interrupt
+- channels : Number of DMA channels supported
+- block-number : the virtual block number
+- block-offset : the offset of different virtual block
+- queues : the number of command queue per virtual block
+- status-sizes : status queue size of per virtual block
+- queue-sizes : command queue size of per virtual block, the size number based on queues
+- big-endian: If present registers and hardware scatter/gather descriptors
+	of the qDMA are implemented in big endian mode, otherwise in little
+	mode.
+
+Examples:
+	qdma: qdma at 8390000 {
+				compatible = "fsl,ls1021a-qdma";
+				reg = <0x0 0x8388000 0x0 0x1000>, /* Controller regs */
+				      <0x0 0x8389000 0x0 0x1000>, /* Status regs */
+				      <0x0 0x838a000 0x0 0x2000>; /* Block regs */
+				interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "qdma-error",
+					"qdma-queue0", "qdma-queue1";
+				channels = <8>;
+				block-number = <2>;
+				block-offset = <0x1000>;
+				queues = <2>;
+				status-sizes = <64>;
+				queue-sizes = <64 64>;
+				big-endian;
+			};
-- 
1.7.1
