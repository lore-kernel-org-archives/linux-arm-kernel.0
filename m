From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Thu, 15 Dec 2016 14:34:55 +0000
Subject: [PATCH] dmaengine: xilinx_dma: Add support for multiple buffers
Message-ID: <40ba7c24927eeffdcc66425f8ca1203589276c08.1481812291.git.joabreu@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xilinx VDMA supports multiple framebuffers. This patch
adds correct handling for the scenario where multiple
framebuffers are available in the HW and parking mode is
not set.

We corrected these situations:
	1) Do not start VDMA until all the framebuffers
	have been programmed with a valid address.
	2) Restart variables when VDMA halts/resets.
	3) Halt channel when all the framebuffers have
	finished and there is not anymore segments
	pending.
	4) Do not try to overlap framebuffers until they
	are completed.

All these situations, without this patch, can lead to data
corruption and even system memory corruption. If, for example,
user has a VDMA with 3 framebuffers, with direction
DMA_DEV_TO_MEM and user only submits one segment, VDMA will
write first to the segment the user submitted BUT if the user
doesn't submit another segment in a timelly manner then VDMA
will write to position 0 of system mem in the following VSYNC.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Carlos Palminha <palminha@synopsys.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dmaengine at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/dma/xilinx/xilinx_dma.c | 80 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8288fe4..30eec5a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -351,10 +351,12 @@ struct xilinx_dma_chan {
 	bool cyclic;
 	bool genlock;
 	bool err;
+	bool running;
 	struct tasklet_struct tasklet;
 	struct xilinx_vdma_config config;
 	bool flush_on_fsync;
 	u32 desc_pendingcount;
+	u32 seg_pendingcount;
 	bool ext_addr;
 	u32 desc_submitcount;
 	u32 residue;
@@ -946,6 +948,17 @@ static bool xilinx_dma_is_idle(struct xilinx_dma_chan *chan)
 }
 
 /**
+ * xilinx_vdma_is_multi_buffer - Check if VDMA has multiple framebuffers
+ * @chan: Driver specific DMA channel
+ *
+ * Return: '1' if is multi buffer, '0' if not.
+ */
+static bool xilinx_vdma_is_multi_buffer(struct xilinx_dma_chan *chan)
+{
+	return chan->num_frms > 1;
+}
+
+/**
  * xilinx_dma_halt - Halt DMA channel
  * @chan: Driver specific DMA channel
  */
@@ -966,6 +979,10 @@ static void xilinx_dma_halt(struct xilinx_dma_chan *chan)
 			chan, dma_ctrl_read(chan, XILINX_DMA_REG_DMASR));
 		chan->err = true;
 	}
+
+	chan->seg_pendingcount = 0;
+	chan->desc_submitcount = 0;
+	chan->running = false;
 }
 
 /**
@@ -1002,14 +1019,35 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	struct xilinx_dma_tx_descriptor *desc, *tail_desc;
 	u32 reg;
 	struct xilinx_vdma_tx_segment *tail_segment;
+	bool mbf = xilinx_vdma_is_multi_buffer(chan) && !config->park;
 
 	/* This function was invoked with lock held */
 	if (chan->err)
 		return;
 
-	if (list_empty(&chan->pending_list))
+	/*
+	 * Can't continue if we have already consumed all the available
+	 * framebuffers and they are not done yet.
+	 */
+	if (mbf && (chan->seg_pendingcount >= chan->num_frms))
 		return;
 
+	if (list_empty(&chan->pending_list)) {
+		/*
+		 * Can't keep running if there are no pending segments. Halt
+		 * the channel as security measure. Notice that this will not
+		 * corrupt current transactions because this function is
+		 * called after the pendingcount is decreased and after the
+		 * current transaction has finished.
+		 */
+		if (mbf && chan->running && !chan->seg_pendingcount) {
+			dev_dbg(chan->dev, "pending list empty: halting\n");
+			xilinx_dma_halt(chan);
+		}
+
+		return;
+	}
+
 	desc = list_first_entry(&chan->pending_list,
 				struct xilinx_dma_tx_descriptor, node);
 	tail_desc = list_last_entry(&chan->pending_list,
@@ -1079,6 +1117,8 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->has_sg) {
 		dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
 				tail_segment->phys);
+		list_splice_tail_init(&chan->pending_list, &chan->active_list);
+		chan->desc_pendingcount = 0;
 	} else {
 		struct xilinx_vdma_tx_segment *segment, *last = NULL;
 		int i = 0;
@@ -1097,29 +1137,34 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 					XILINX_VDMA_REG_START_ADDRESS(i++),
 					segment->hw.buf_addr);
 
+			chan->seg_pendingcount++;
 			last = segment;
 		}
 
 		if (!last)
 			return;
 
-		/* HW expects these parameters to be same for one transaction */
-		vdma_desc_write(chan, XILINX_DMA_REG_HSIZE, last->hw.hsize);
-		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
-				last->hw.stride);
-		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
-	}
-
-	if (!chan->has_sg) {
 		list_del(&desc->node);
 		list_add_tail(&desc->node, &chan->active_list);
 		chan->desc_submitcount++;
 		chan->desc_pendingcount--;
 		if (chan->desc_submitcount == chan->num_frms)
 			chan->desc_submitcount = 0;
-	} else {
-		list_splice_tail_init(&chan->pending_list, &chan->active_list);
-		chan->desc_pendingcount = 0;
+
+		/*
+		 * Can't start until all the framebuffers have been programmed
+		 * or else corruption can occur.
+		 */
+		if (mbf && !chan->running &&
+		   (chan->seg_pendingcount < chan->num_frms))
+			return;
+
+		/* HW expects these parameters to be same for one transaction */
+		vdma_desc_write(chan, XILINX_DMA_REG_HSIZE, last->hw.hsize);
+		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
+				last->hw.stride);
+		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
+		chan->running = true;
 	}
 }
 
@@ -1327,12 +1372,20 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
 static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *desc, *next;
+	struct xilinx_vdma_tx_segment *segment;
 
 	/* This function was invoked with lock held */
 	if (list_empty(&chan->active_list))
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
+		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
+			list_for_each_entry(segment, &desc->segments, node) {
+				if (chan->seg_pendingcount > 0)
+					chan->seg_pendingcount--;
+			}
+		}
+
 		list_del(&desc->node);
 		if (!desc->cyclic)
 			dma_cookie_complete(&desc->async_tx);
@@ -1366,6 +1419,9 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
 	}
 
 	chan->err = false;
+	chan->seg_pendingcount = 0;
+	chan->desc_submitcount = 0;
+	chan->running = false;
 
 	return err;
 }
-- 
1.9.1
