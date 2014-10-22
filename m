From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 22 Oct 2014 17:22:19 +0200
Subject: [PATCH v7 2/3] ARM: dts: at_xdmac: add bindings documentation
In-Reply-To: <1413991340-11617-1-git-send-email-ludovic.desroches@atmel.com>
References: <1413991340-11617-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1413991340-11617-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings documentation for the new Atmel DMA controller (XDMAC)
introduced with SAMA5D4.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/dma/atmel-xdma.txt         | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/atmel-xdma.txt

diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
new file mode 100644
index 0000000..e75c128
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
@@ -0,0 +1,54 @@
+* Atmel Extensible Direct Memory Access Controller (XDMAC)
+
+* XDMA Controller
+Required properties:
+- compatible: Should be "atmel,<chip>-dma".
+  <chip> compatible description:
+  - sama5d4: first SoC adding the XDMAC
+- reg: Should contain DMA registers location and length.
+- interrupts: Should contain DMA interrupt.
+- #dma-cells: Must be <1>, used to represent the number of integer cells in
+the dmas property of client devices.
+  - The 1st cell specifies the channel configuration register:
+    - bit 13: SIF, source interface identifier, used to get the memory
+    interface identifier,
+    - bit 14: DIF, destination interface identifier, used to get the peripheral
+    interface identifier,
+    - bit 30-24: PERID, peripheral identifier.
+
+Example:
+
+dma1: dma-controller at f0004000 {
+	compatible = "atmel,sama5d4-dma";
+	reg = <0xf0004000 0x200>;
+	interrupts = <50 4 0>;
+	#dma-cells = <2>;
+};
+
+
+* DMA clients
+DMA clients connected to the Atmel XDMA controller must use the format
+described in the dma.txt file, using a one-cell specifier for each channel.
+The two cells in order are:
+1. A phandle pointing to the DMA controller.
+2. Channel configuration register. Configurable fields are:
+    - bit 13: SIF, source interface identifier, used to get the memory
+    interface identifier,
+    - bit 14: DIF, destination interface identifier, used to get the peripheral
+    interface identifier,
+  - bit 30-24: PERID, peripheral identifier.
+
+Example:
+
+i2c2: i2c at f8024000 {
+	compatible = "atmel,at91sam9x5-i2c";
+	reg = <0xf8024000 0x4000>;
+	interrupts = <34 4 6>;
+	dmas = <&dma1
+		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+		 | AT91_XDMAC_DT_PERID(6))>,
+	       <&dma1
+		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+		| AT91_XDMAC_DT_PERID(7))>;
+	dma-names = "tx", "rx";
+};
-- 
2.0.3
