From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 4 Jul 2014 09:36:10 +0200
Subject: [PATCH v2 2/2] ARM: dts: at_xdmac: add bindings documentation
In-Reply-To: <1404459370-3540-1-git-send-email-ludovic.desroches@atmel.com>
References: <1404459370-3540-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1404459370-3540-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings documentation for the new Atmel DMA controller (XDMAC)
introduced with SAMA5D4.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 .../devicetree/bindings/dma/atmel-xdma.txt         |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/atmel-xdma.txt

diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
new file mode 100644
index 0000000..1e09fda
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
@@ -0,0 +1,39 @@
+* Atmel Extensible Direct Memory Access Controller (XDMAC)
+
+Required properties:
+- compatible: Should be "atmel,<chip>-dma".
+- reg: Should contain DMA registers location and length.
+- interrupts: Should contain DMA interrupt.
+- #dma-cells: Must be <2>, used to represent the number of integer cells in
+the dmas property of client devices.
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
+DMA clients connected to the Atmel XDMA controller must use the format
+described in the dma.txt file, using a three-cell specifier for each channel:
+a phandle plus two integer cells.
+The two cells in order are:
+
+1. A phandle pointing to the DMA controller.
+2. The memory interface (16 most significant bits), the peripheral interface
+(16 less significant bits).
+3. Channel configuration register. Configurable fields are:
+  - bit 30-24: PERID, peripheral identifier.
+
+Example:
+
+i2c2: i2c at f8024000 {
+	compatible = "atmel,at91sam9x5-i2c";
+	reg = <0xf8024000 0x4000>;
+	interrupts = <34 4 6>;
+	dmas = <&dma0 0x00000001 0x06000000>,
+	       <&dma0 0x00000001 0x07000000>;
+	dma-names = "tx", "rx";
+};
-- 
1.7.9.5
