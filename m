From: andrea.merello@gmail.com (Andrea Merello)
Date: Wed, 20 Jun 2018 10:36:48 +0200
Subject: [PATCH 1/6] dmaengine: xilinx_dma: fix splitting transfer causes
 misalignments
Message-ID: <20180620083653.17010-1-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whenever a single or cyclic transaction is prepared, the driver
could eventually split it over several SG descriptors in order
to deal with the HW maximum transfer length.

This could end up in DMA operations starting from a misaligned
address. This seems fatal for the HW.

This patch eventually adjusts the transfer size in order to make sure
all operations start from an aligned address.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 27b523530c4a..a516e7ffef21 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -376,6 +376,7 @@ struct xilinx_dma_chan {
 	void (*start_transfer)(struct xilinx_dma_chan *chan);
 	int (*stop_transfer)(struct xilinx_dma_chan *chan);
 	u16 tdest;
+	u32 copy_mask;
 };
 
 /**
@@ -1789,10 +1790,14 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 
 			/*
 			 * Calculate the maximum number of bytes to transfer,
-			 * making sure it is less than the hw limit
+			 * making sure it is less than the hw limit and that
+			 * the next chuck start address is aligned
 			 */
-			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = sg_dma_len(sg) - sg_used;
+			if (copy > XILINX_DMA_MAX_TRANS_LEN)
+				copy = XILINX_DMA_MAX_TRANS_LEN &
+					chan->copy_mask;
+
 			hw = &segment->hw;
 
 			/* Fill in the descriptor */
@@ -1894,10 +1899,14 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 
 			/*
 			 * Calculate the maximum number of bytes to transfer,
-			 * making sure it is less than the hw limit
+			 * making sure it is less than the hw limit and that
+			 * the next chuck start address is aligned
 			 */
-			copy = min_t(size_t, period_len - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = period_len - sg_used;
+			if (copy > XILINX_DMA_MAX_TRANS_LEN)
+				copy = XILINX_DMA_MAX_TRANS_LEN &
+					chan->copy_mask;
+
 			hw = &segment->hw;
 			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
 					  period_len * i);
@@ -2402,8 +2411,12 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	if (width > 8)
 		has_dre = false;
 
-	if (!has_dre)
+	if (has_dre) {
+		chan->copy_mask = ~0;
+	} else {
 		xdev->common.copy_align = fls(width - 1);
+		chan->copy_mask = ~(width - 1);
+	}
 
 	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
 	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
-- 
2.17.1
