From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 18 Aug 2016 14:38:45 +0800
Subject: [PATCH v1 2/5] dma: Add device tree binding for QorIQ qDMA driver
In-Reply-To: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
References: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1471502328-28305-3-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

Adding devicetree binding for QorIQ queue direct memory access(QDMA).
This module can be found on QorIQ LS1021A and LS1043A SoCs.

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 .../devicetree/bindings/dma/qoriq-qdma.txt         | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qoriq-qdma.txt

diff --git a/Documentation/devicetree/bindings/dma/qoriq-qdma.txt b/Documentation/devicetree/bindings/dma/qoriq-qdma.txt
new file mode 100644
index 0000000..dfa286e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qoriq-qdma.txt
@@ -0,0 +1,38 @@
+* QorIQ queue Direct Memory Access Controller(qDMA) Controller
+
+  The QorIQ qDMA controller transfers blocks of data between one source and one or more
+destinations. The blocks of data transferred can be represented in memory as contiguous
+or non-contiguous using scatter/gather table(s). Channel virtualization is supported
+through enqueuing of DMA jobs to, or dequeuing DMA jobs from, different work
+queues.
+
+* qDMA Controller
+Required properties:
+- compatible :
+	- "fsl,ls1021a-qdma",
+	Or "fsl,ls1043a-qdma" followed by "fsl,ls1021a-qdma",
+- reg : Specifies base physical address(s) and size of the qDMA registers.
+	The region is qDMA control register's address and size.
+- interrupts : A list of interrupt-specifiers, one for each entry in
+	interrupt-names.
+- interrupt-names : Should contain:
+	"qdma-error" - the error interrupt
+	"qdma-queue" - the queue interrupt
+
+Optional properties:
+- big-endian: If present registers and hardware scatter/gather descriptors
+	of the qDMA are implemented in big endian mode, otherwise in little
+	mode.
+
+
+Examples:
+
+	qdma: qdma at 8390000 {
+		compatible = "fsl,ls1021a-qdma";
+		reg = <0x0 0x8398000 0x0 0x2000 /* Controller registers */
+		       0x0 0x839a000 0x0 0x2000>; /* Block registers */
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "qdma-error", "qdma-queue";
+		big-endian;
+	};
-- 
2.1.0.27.g96db324
