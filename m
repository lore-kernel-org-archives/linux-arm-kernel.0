From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Fri, 24 Jun 2016 10:51:26 +0530
Subject: [PATCH v2 5/5] dmaengine: dma: Use different channel names for each
 dma
In-Reply-To: <1466745686-23898-1-git-send-email-appanad@xilinx.com>
References: <1466745686-23898-1-git-send-email-appanad@xilinx.com>
Message-ID: <1466745686-23898-6-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current driver assumes that child node channel name is either
"xlnx,axi-vdma-mm2s-channel" or "xlnx,axi-vdma-s2mm-channel"
which is confusing the users of AXI DMA and CDMA.
This patch fixes this issue by using different channel
names for the AXI DMA and AXI CDMA child nodes.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Chanes for v2:
---> New patch.

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    6 +++++-
 drivers/dma/xilinx/xilinx_dma.c                    |    8 ++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 0faa189..a2b8bfa 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -50,8 +50,12 @@ Optional properties for VDMA:
 	{3}, flush s2mm channel
 
 Required child node properties:
-- compatible: It should be either "xlnx,axi-vdma-mm2s-channel" or
+- compatible:
+	For VDMA: It should be either "xlnx,axi-vdma-mm2s-channel" or
 	"xlnx,axi-vdma-s2mm-channel".
+	For CDMA: It should be "xlnx,axi-cdma-channel".
+	For AXIDMA: It should be either "xlnx,axi-dma-mm2s-channel" or
+	"xlnx,axi-dma-s2mm-channel".
 - interrupts: Should contain per channel VDMA interrupts.
 - xlnx,datawidth: Should contain the stream data width, take values
 	{32,64...1024}.
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 0768d9f..cf47347 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2353,7 +2353,9 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	if (!has_dre)
 		xdev->common.copy_align = fls(width - 1);
 
-	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel")) {
+	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
+	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
+	    of_device_is_compatible(node, "xlnx,axi-cdma-channel")) {
 		chan->direction = DMA_MEM_TO_DEV;
 		chan->id = chan_id;
 		chan->tdest = chan_id;
@@ -2367,7 +2369,9 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 				chan->flush_on_fsync = true;
 		}
 	} else if (of_device_is_compatible(node,
-					    "xlnx,axi-vdma-s2mm-channel")) {
+					   "xlnx,axi-vdma-s2mm-channel") ||
+		   of_device_is_compatible(node,
+					   "xlnx,axi-dma-s2mm-channel")) {
 		chan->direction = DMA_DEV_TO_MEM;
 		chan->id = chan_id;
 		chan->tdest = chan_id - xdev->nr_channels;
-- 
1.7.1
