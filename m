From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Tue, 10 Mar 2015 19:46:23 +0530
Subject: [PATCH] dma: Add Xilinx ZDMA device tree Binding Documentation
Message-ID: <BN1AFFO11FD032F933FA09686353911532C8180@BN1AFFO11FD032.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device-tree binding documentation for Xilinx ZDMA Engine

Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
---
 .../devicetree/bindings/dma/xilinx/zdma.txt        |   76 ++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/zdma.txt

diff --git a/Documentation/devicetree/bindings/dma/xilinx/zdma.txt b/Documentation/devicetree/bindings/dma/xilinx/zdma.txt
new file mode 100644
index 0000000..399a3bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/zdma.txt
@@ -0,0 +1,76 @@
+Xilinx ZDMA engine, it does support memory to memory transfers,
+memory to device and device to memory transfers. It also has flow
+control and rate control support for slave/peripheral dma access.
+
+Xilinx ZynqMP has two instances of general purpose DMA(ZDMA).
+one is located in FPD(full power domain) and other is located in
+LPD(low power domain).
+
+ZDMA instance located in FPD is referred as FPDMA and instance located
+in LPD is referred as LPDMA.
+
+FPDMA is configured with 8 DMA channels and AXI bus width is 128 byte.
+LPDMA is configured with 8 DMA channels and AXI bus width is 64 byte.
+
+Each channel in a instance has its own address space and interrupt line
+but shares common reference and APB clock. So, each channel will be treated
+as a standalone dma device.
+Since its a general purpose dma controller, it has a rich set of configurable
+options with respect to data and descriptor attributes.
+
+Required properties:
+- compatible: Should be "xlnx,fpdma-1.0" or "xlnx,lpdma-1.0"
+- reg: Memory map for dma module access.
+- interrupt-parent: Interrupt controller the interrupt is routed through
+- interrupts: Should contain DMA channel interrupt.
+- xlnx,id: Channel Id
+
+Optional properties:
+- xlnx,include-sg: Indicates the controller to operate in simple or scatter
+		   gather dma mode
+- xlnx,ratectrl: Scheduling interval in terms of clock cycles for
+		 source AXI transaction
+- xlnx,overfetch: Tells whether the channel is allowed to over fetch the data
+- xlnx,src-issue: Number of AXI outstanding transactions on source side
+- xlnx,desc-axi-cohrnt: Tells whether the AXI transactions generated for the
+			descriptor read are marked Non-coherent
+- xlnx,src-axi-cohrnt: Tells whether the AXI transactions generated for the
+			source descriptor payload are marked Non-coherent
+- xlnx,dst-axi-cohrnt: Tells whether the AXI transactions generated for the
+			dst descriptor payload are marked Non-coherent
+- xlnx,desc-axi-qos: AXI QOS bits to be used for descriptor fetch
+- xlnx,src-axi-qos: AXI QOS bits to be used for data read
+- xlnx,dst-axi-qos: Axi QOS bits to be used for data write
+- xlnx,desc-axi-cache: AXI cache bits to be used for descriptor fetch
+- xlnx,desc-axi-cache: AXI cache bits to be used for data read
+- xlnx,desc-axi-cache: AXI cache bits to be used for data write
+- xlnx,src-burst-len: AXI length for data read. Support only power of 2 values
+		      i.e 1,2,4,8 and 16.
+- xlnx,dst-burst-len: AXI length for data write. Support only power of 2 values
+		      i.e 1,2,4,8 and 16.
+
+Example:
+++++++++
+fpdma0: dma at fd500000 {
+	compatible = "xlnx,fpdma-1.0";
+	reg = <0x0 0xfd500000 0x1000>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 117 4>;
+	xlnx,include-sg;
+	xlnx,overfetch;
+	xlnx,ratectrl = <0>;
+	xlnx,src-issue = <16>;
+	xlnx,id = <0>;
+	xlnx,desc-axi-cohrnt;
+	xlnx,src-axi-cohrnt;
+	xlnx,dst-axi-cohrnt;
+	xlnx,desc-axi-qos = <0>;
+	xlnx,desc-axi-cache = <0>;
+	xlnx,src-axi-qos = <0>;
+	xlnx,src-axi-cache = <2>;
+	xlnx,dst-axi-qos = <0>;
+	xlnx,dst-axi-cache = <2>;
+	xlnx,src-burst-len = <4>;
+	xlnx,dst-burst-len = <4>;
+};
+
-- 
1.7.4
