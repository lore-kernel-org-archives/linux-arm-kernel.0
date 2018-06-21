From: andrea.merello@gmail.com (Andrea Merello)
Date: Thu, 21 Jun 2018 13:58:18 +0200
Subject: [PATCH v2 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
Message-ID: <20180621115822.20058-1-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whenever a single or cyclic transaction is prepared, the driver
could eventually split it over several SG descriptors in order
to deal with the HW maximum transfer length.

This could end up in DMA operations starting from a misaligned
address. This seems fatal for the HW if DRE is not enabled.

This patch eventually adjusts the transfer size in order to make sure
all operations start from an aligned address.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
Changes in v2:
	- don't introduce copy_mask field, rather rely on already-esistent
	  copy_align field. Suggested by Radhey Shyam Pandey
	- reword title
---
 drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 27b523530c4a..22d7a6b85e65 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1789,10 +1789,15 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 
 			/*
 			 * Calculate the maximum number of bytes to transfer,
-			 * making sure it is less than the hw limit
+			 * making sure it is less than the hw limit and that
+			 * the next chunck start address is aligned
 			 */
-			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = sg_dma_len(sg) - sg_used;
+			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
+			    chan->xdev->common.copy_align)
+				copy = rounddown(XILINX_DMA_MAX_TRANS_LEN,
+					 (1 << chan->xdev->common.copy_align));
+
 			hw = &segment->hw;
 
 			/* Fill in the descriptor */
@@ -1894,10 +1899,15 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 
 			/*
 			 * Calculate the maximum number of bytes to transfer,
-			 * making sure it is less than the hw limit
+			 * making sure it is less than the hw limit and that
+			 * the next chunck start address is aligned
 			 */
-			copy = min_t(size_t, period_len - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = period_len - sg_used;
+			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
+			    chan->xdev->common.copy_align)
+				copy = rounddown(XILINX_DMA_MAX_TRANS_LEN,
+					 (1 << chan->xdev->common.copy_align));
+
 			hw = &segment->hw;
 			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
 					  period_len * i);
-- 
2.17.1
