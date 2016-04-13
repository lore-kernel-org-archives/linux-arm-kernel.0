From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 13 Apr 2016 10:46:48 +0530
Subject: [PATCH v5 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma device
 tree binding documentation
Message-ID: <1460524609-8722-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device-tree binding documentation for Xilinx zynqmp dma engine used in
Zynq UltraScale+ MPSoC.

Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes in v5:
- Use dma-coherent flag for coherent transfers as suggested by rob.
- Removed unnecessary properties from binding doc as suggested by Rob.
Changes in v4:
- None
Changes in v3:
- None
Changes in v2:
- None.

 .../devicetree/bindings/dma/xilinx/zynqmp_dma.txt  | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
new file mode 100644
index 0000000..4ad0aea40
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
@@ -0,0 +1,50 @@
+Xilinx ZynqMP DMA engine, it does support memory to memory transfers,
+memory to device and device to memory transfers. It also has flow
+control and rate control support for slave/peripheral dma access.
+
+Required properties:
+- compatible		: Should be "xlnx,zynqmp-dma-1.0"
+- reg			: Memory map for gdma/adma module access.
+- interrupt-parent	: Interrupt controller the interrupt is routed through
+- interrupts		: Should contain DMA channel interrupt.
+- xlnx,bus-width	: Axi buswidth in bits. Should contain 128 or 64
+- clock-names		: List of input clocks "clk_main", "clk_apb"
+			  (see clock bindings for details)
+
+Optional properties:
+- xlnx,include-sg	: Indicates the controller to operate in simple or
+			  scatter gather dma mode
+- xlnx,ratectrl		: Scheduling interval in terms of clock cycles for
+			  source AXI transaction
+- xlnx,overfetch	: Tells whether the channel is allowed to over
+			  fetch the data
+- xlnx,src-issue	: Number of AXI outstanding transactions on source side
+- xlnx,desc-axi-cache	: AXI cache bits to be used for descriptor fetch
+- xlnx,src-axi-cache	: AXI cache bits to be used for data read
+- xlnx,dst-axi-cache	: AXI cache bits to be used for data write
+- xlnx,src-burst-len	: AXI length for data read. Support only power of
+			  2 values.
+- xlnx,dst-burst-len	: AXI length for data write. Support only power of
+			  2 values.
+- dma-coherent		: Present if dma operations are coherent.
+
+Example:
+++++++++
+fpd_dma_chan1: dma at FD500000 {
+	compatible = "xlnx,zynqmp-dma-1.0";
+	reg = <0x0 0xFD500000 0x1000>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 117 4>;
+	clock-names = "clk_main", "clk_apb";
+	xlnx,bus-width = <128>;
+	xlnx,include-sg;
+	xlnx,overfetch;
+	dma-coherent;
+	xlnx,ratectrl = <0>;
+	xlnx,src-issue = <16>;
+	xlnx,desc-axi-cache = <0xFF>;
+	xlnx,src-axi-cache = <0xFF>;
+	xlnx,dst-axi-cache = <0xFF>;
+	xlnx,src-burst-len = <4>;
+	xlnx,dst-burst-len = <4>;
+};
-- 
2.1.2
