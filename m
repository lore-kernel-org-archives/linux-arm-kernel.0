From: andrea.merello@gmail.com (Andrea Merello)
Date: Wed, 20 Jun 2018 10:36:51 +0200
Subject: [PATCH 4/6] dmaengine: xilinx_dma: fix hardcoded maximum transfer
 length may be wrong
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
Message-ID: <20180620083653.17010-4-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The maximum transfer length is currently hardcoded in the driver, but
it depends by how the soft-IP is actually configured.

This seems to affect also max possible length for SG transfers.

This patch introduce a new DT property in order to operate with proper
maximum transfer length.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cf12f7147f07..bdbc8ba9092a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -439,6 +439,7 @@ struct xilinx_dma_device {
 	struct clk *rxs_clk;
 	u32 nr_channels;
 	u32 chan_id;
+	int max_transfer;
 };
 
 /* Macros */
@@ -1806,8 +1807,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 * the next chuck start address is aligned
 			 */
 			copy = sg_dma_len(sg) - sg_used;
-			if (copy > XILINX_DMA_MAX_TRANS_LEN)
-				copy = XILINX_DMA_MAX_TRANS_LEN &
+			if (copy > chan->xdev->max_transfer)
+				copy = chan->xdev->max_transfer &
 					chan->copy_mask;
 
 			hw = &segment->hw;
@@ -1914,8 +1915,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 * the next chuck start address is aligned
 			 */
 			copy = period_len - sg_used;
-			if (copy > XILINX_DMA_MAX_TRANS_LEN)
-				copy = XILINX_DMA_MAX_TRANS_LEN &
+			if (copy > chan->xdev->max_transfer)
+				copy = chan->xdev->max_transfer &
 					chan->copy_mask;
 
 			hw = &segment->hw;
@@ -2594,7 +2595,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
 	struct resource *io;
-	u32 num_frames, addr_width;
+	u32 num_frames, addr_width, lenreg_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -2625,9 +2626,18 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(xdev->regs);
 
 	/* Retrieve the DMA engine properties from the device tree */
-	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
+
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
+		err = of_property_read_u32(node, "xlnx,lengthregwidth",
+					&lenreg_width);
+		if (err < 0) {
+			dev_err(xdev->dev,
+				"missing xlnx,lengthregwidth property\n");
+			return err;
+		}
+		xdev->max_transfer = GENMASK(lenreg_width - 1, 0);
+	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 		err = of_property_read_u32(node, "xlnx,num-fstores",
-- 
2.17.1
