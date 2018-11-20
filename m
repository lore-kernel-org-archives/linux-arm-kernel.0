From: andrea.merello@gmail.com (Andrea Merello)
Date: Tue, 20 Nov 2018 16:31:51 +0100
Subject: [PATCH v6 7/7] dmaengine: xilinx_dma: Drop SG support for VDMA IP
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
Message-ID: <20181120153151.18024-7-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xilinx_vdma_start_transfer() is used only for VDMA IP, still it contains
conditional code on has_sg variable. has_sg is set only whenever the HW
does support SG mode, that is never true for VDMA IP.

This patch drops the never-taken branches.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in V4: introduced this patch in series
Changes in v5:
	None
Changes in v6:
	None
---
 drivers/dma/xilinx/xilinx_dma.c | 84 +++++++++++++--------------------
 1 file changed, 32 insertions(+), 52 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 41bd8caca09e..a37e28a43885 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1100,6 +1100,8 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	struct xilinx_dma_tx_descriptor *desc, *tail_desc;
 	u32 reg, j;
 	struct xilinx_vdma_tx_segment *tail_segment;
+	struct xilinx_vdma_tx_segment *segment, *last = NULL;
+	int i = 0;
 
 	/* This function was invoked with lock held */
 	if (chan->err)
@@ -1119,14 +1121,6 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	tail_segment = list_last_entry(&tail_desc->segments,
 				       struct xilinx_vdma_tx_segment, node);
 
-	/*
-	 * If hardware is idle, then all descriptors on the running lists are
-	 * done, start new transfers
-	 */
-	if (chan->has_sg)
-		dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC,
-				desc->async_tx.phys);
-
 	/* Configure the hardware using info in the config structure */
 	if (chan->has_vflip) {
 		reg = dma_read(chan, XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP);
@@ -1143,15 +1137,11 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	else
 		reg &= ~XILINX_DMA_DMACR_FRAMECNT_EN;
 
-	/*
-	 * With SG, start with circular mode, so that BDs can be fetched.
-	 * In direct register mode, if not parking, enable circular mode
-	 */
-	if (chan->has_sg || !config->park)
-		reg |= XILINX_DMA_DMACR_CIRC_EN;
-
+	/* If not parking, enable circular mode */
 	if (config->park)
 		reg &= ~XILINX_DMA_DMACR_CIRC_EN;
+	else
+		reg |= XILINX_DMA_DMACR_CIRC_EN;
 
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
@@ -1173,48 +1163,38 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 		return;
 
 	/* Start the transfer */
-	if (chan->has_sg) {
-		dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
-				tail_segment->phys);
-		list_splice_tail_init(&chan->pending_list, &chan->active_list);
-		chan->desc_pendingcount = 0;
-	} else {
-		struct xilinx_vdma_tx_segment *segment, *last = NULL;
-		int i = 0;
-
-		if (chan->desc_submitcount < chan->num_frms)
-			i = chan->desc_submitcount;
-
-		list_for_each_entry(segment, &desc->segments, node) {
-			if (chan->ext_addr)
-				vdma_desc_write_64(chan,
-					XILINX_VDMA_REG_START_ADDRESS_64(i++),
-					segment->hw.buf_addr,
-					segment->hw.buf_addr_msb);
-			else
-				vdma_desc_write(chan,
+	if (chan->desc_submitcount < chan->num_frms)
+		i = chan->desc_submitcount;
+
+	list_for_each_entry(segment, &desc->segments, node) {
+		if (chan->ext_addr)
+			vdma_desc_write_64(chan,
+				   XILINX_VDMA_REG_START_ADDRESS_64(i++),
+				   segment->hw.buf_addr,
+				   segment->hw.buf_addr_msb);
+		else
+			vdma_desc_write(chan,
 					XILINX_VDMA_REG_START_ADDRESS(i++),
 					segment->hw.buf_addr);
 
-			last = segment;
-		}
-
-		if (!last)
-			return;
+		last = segment;
+	}
 
-		/* HW expects these parameters to be same for one transaction */
-		vdma_desc_write(chan, XILINX_DMA_REG_HSIZE, last->hw.hsize);
-		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
-				last->hw.stride);
-		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
+	if (!last)
+		return;
 
-		chan->desc_submitcount++;
-		chan->desc_pendingcount--;
-		list_del(&desc->node);
-		list_add_tail(&desc->node, &chan->active_list);
-		if (chan->desc_submitcount == chan->num_frms)
-			chan->desc_submitcount = 0;
-	}
+	/* HW expects these parameters to be same for one transaction */
+	vdma_desc_write(chan, XILINX_DMA_REG_HSIZE, last->hw.hsize);
+	vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
+			last->hw.stride);
+	vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
+
+	chan->desc_submitcount++;
+	chan->desc_pendingcount--;
+	list_del(&desc->node);
+	list_add_tail(&desc->node, &chan->active_list);
+	if (chan->desc_submitcount == chan->num_frms)
+		chan->desc_submitcount = 0;
 
 	chan->idle = false;
 }
-- 
2.17.1
