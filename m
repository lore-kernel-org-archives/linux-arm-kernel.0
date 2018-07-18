From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 19 Jul 2018 01:37:06 +0530
Subject: [PATCH 1/4] dt-bindings: dma: Add binding for Actions Semi Owl SoCs
In-Reply-To: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
References: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180718200709.27102-2-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree binding for Actions Semi Owl SoCs DMA controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/dma/owl-dma.txt       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/owl-dma.txt b/Documentation/devicetree/bindings/dma/owl-dma.txt
new file mode 100644
index 000000000000..dd6ce237b216
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/owl-dma.txt
@@ -0,0 +1,46 @@
+* Actions Semi Owl SoCs DMA controller
+
+This binding follows the generic DMA bindings defined in dma.txt.
+
+Required properties:
+- compatible: Should be "actions,s900-dma".
+- reg: Should contain DMA registers location and length.
+- interrupts: Should contain 4 interrupts shared by all channel.
+- #dma-cells: Must be <1>. Used to represent the number of integer
+              cells in the dmas property of client device.
+- dma-channels: Physical channels supported.
+- dma-requests: Virtual channels supported.
+- clocks: Phandle and Specifier of the clock feeding the DMA controller.
+
+Example:
+
+Controller:
+                dma: dma-controller at e0260000 {
+                        compatible = "actions,s900-dma";
+                        reg = <0x0 0xe0260000 0x0 0x1000>;
+                        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+                                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+                                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+                        #dma-cells = <1>;
+                        dma-channels = <12>;
+                        dma-requests = <46>;
+                        clocks = <&clock CLK_DMAC>;
+                };
+
+Client:
+
+DMA clients connected to the Actions Semi Owl SoCs DMA controller must
+use the format described in the dma.txt file, using a two-cell specifier
+for each channel.
+
+The two cells in order are:
+1. A phandle pointing to the DMA controller.
+2. The channel id.
+
+uart5: serial at e012a000 {
+        ...
+        dma-names = "tx", "rx";
+        dmas = <&dma 26>, <&dma 27>;
+        ...
+};
-- 
2.17.1
