From: andrea.merello@gmail.com (Andrea Merello)
Date: Fri,  7 Sep 2018 08:24:57 +0200
Subject: [PATCH v5 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
In-Reply-To: <20180907062502.8241-1-andrea.merello@gmail.com>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
Message-ID: <20180907062502.8241-2-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whenever a single or cyclic transaction is prepared, the driver
could eventually split it over several SG descriptors in order
to deal with the HW maximum transfer length.

This could end up in DMA operations starting from a misaligned
address. This seems fatal for the HW if DRE (Data Realignment Engine)
is not enabled.

This patch eventually adjusts the transfer size in order to make sure
all operations start from an aligned address.

Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
        - don't introduce copy_mask field, rather rely on already-esistent
          copy_align field. Suggested by Radhey Shyam Pandey
        - reword title
Changes in v3:
	- fix bug introduced in v2: wrong copy size when DRE is enabled
	- use implementation suggested by Radhey Shyam Pandey
Changes in v4:
	- rework on the top of 1/6
Changes in v5:
	- fix typo in commit title
	- add hint about "DRE" meaning in commit message
---
 drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a3aaa0e34cc7..aaa6de8a70e4 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -954,15 +954,28 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 
 /**
  * xilinx_dma_calc_copysize - Calculate the amount of data to copy
+ * @chan: Driver specific DMA channel
  * @size: Total data that needs to be copied
  * @done: Amount of data that has been already copied
  *
  * Return: Amount of data that has to be copied
  */
-static int xilinx_dma_calc_copysize(int size, int done)
+static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
+				    int size, int done)
 {
-	return min_t(size_t, size - done,
+	size_t copy = min_t(size_t, size - done,
 		     XILINX_DMA_MAX_TRANS_LEN);
+
+	if ((copy + done < size) &&
+	    chan->xdev->common.copy_align) {
+		/*
+		 * If this is not the last descriptor, make sure
+		 * the next one will be properly aligned
+		 */
+		copy = rounddown(copy,
+				 (1 << chan->xdev->common.copy_align));
+	}
+	return copy;
 }
 
 /**
@@ -1804,7 +1817,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 * Calculate the maximum number of bytes to transfer,
 			 * making sure it is less than the hw limit
 			 */
-			copy = xilinx_dma_calc_copysize(sg_dma_len(sg),
+			copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg),
 							sg_used);
 			hw = &segment->hw;
 
@@ -1909,7 +1922,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 * Calculate the maximum number of bytes to transfer,
 			 * making sure it is less than the hw limit
 			 */
-			copy = xilinx_dma_calc_copysize(period_len, sg_used);
+			copy = xilinx_dma_calc_copysize(chan,
+							period_len, sg_used);
 			hw = &segment->hw;
 			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
 					  period_len * i);
-- 
2.17.1
