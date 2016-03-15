From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Tue, 15 Mar 2016 22:53:10 +0530
Subject: [PATCH 5/7] dmaengine: xilinx_vdma: Remove unnecessary axi dma
 device-tree binding doc
In-Reply-To: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
Message-ID: <1458062592-27981-6-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXI DMA support is added to the existing AXI VDMA driver.
The binding doc for AXI DMA should also be updated in the
VDMA device-tree binding doc.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  | 65 ----------------------
 1 file changed, 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
deleted file mode 100644
index 2291c40..0000000
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-Xilinx AXI DMA engine, it does transfers between memory and AXI4 stream
-target devices. It can be configured to have one channel or two channels.
-If configured as two channels, one is to transmit to the device and another
-is to receive from the device.
-
-Required properties:
-- compatible: Should be "xlnx,axi-dma-1.00.a"
-- #dma-cells: Should be <1>, see "dmas" property below
-- reg: Should contain DMA registers location and length.
-- dma-channel child node: Should have atleast one channel and can have upto
-	two channels per device. This node specifies the properties of each
-	DMA channel (see child node properties below).
-
-Optional properties:
-- xlnx,include-sg: Tells whether configured for Scatter-mode in
-	the hardware.
-
-Required child node properties:
-- compatible: It should be either "xlnx,axi-dma-mm2s-channel" or
-	"xlnx,axi-dma-s2mm-channel".
-- interrupts: Should contain per channel DMA interrupts.
-- xlnx,datawidth: Should contain the stream data width, take values
-	{32,64...1024}.
-
-Option child node properties:
-- xlnx,include-dre: Tells whether hardware is configured for Data
-	Realignment Engine.
-
-Example:
-++++++++
-
-axi_dma_0: axidma at 40400000 {
-	compatible = "xlnx,axi-dma-1.00.a";
-	#dma_cells = <1>;
-	reg = < 0x40400000 0x10000 >;
-	dma-channel at 40400000 {
-		compatible = "xlnx,axi-dma-mm2s-channel";
-		interrupts = < 0 59 4 >;
-		xlnx,datawidth = <0x40>;
-	} ;
-	dma-channel at 40400030 {
-		compatible = "xlnx,axi-dma-s2mm-channel";
-		interrupts = < 0 58 4 >;
-		xlnx,datawidth = <0x40>;
-	} ;
-} ;
-
-
-* DMA client
-
-Required properties:
-- dmas: a list of <[DMA device phandle] [Channel ID]> pairs,
-	where Channel ID is '0' for write/tx and '1' for read/rx
-	channel.
-- dma-names: a list of DMA channel names, one per "dmas" entry
-
-Example:
-++++++++
-
-dmatest_0: dmatest at 0 {
-	compatible ="xlnx,axi-dma-test-1.00.a";
-	dmas = <&axi_dma_0 0
-		&axi_dma_0 1>;
-	dma-names = "dma0", "dma1";
-} ;
-- 
2.1.2
