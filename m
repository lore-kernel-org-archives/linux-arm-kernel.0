From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Mon, 22 Feb 2016 11:24:37 +0530
Subject: [PATCH v2 4/4] dmaengine: xilinx_vdma: Improve channel idle checking
In-Reply-To: <1456120477-32134-1-git-send-email-appanad@xilinx.com>
References: <1456120477-32134-1-git-send-email-appanad@xilinx.com>
Message-ID: <1456120477-32134-4-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch improves the channel idle cheking by introduing
a new varibale in chan private structure.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
---> splitted the changes into multiple patches.

 drivers/dma/xilinx/xilinx_vdma.c | 41 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 8db07f7..51686d1 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -202,6 +202,7 @@ struct xilinx_vdma_tx_descriptor {
  * @has_sg: Support scatter transfers
  * @genlock: Support genlock mode
  * @err: Channel has errors
+ * @idle: Check for channel idle
  * @tasklet: Cleanup work after irq
  * @config: Device configuration info
  * @flush_on_fsync: Flush on Frame sync
@@ -225,6 +226,7 @@ struct xilinx_vdma_chan {
 	bool has_sg;
 	bool genlock;
 	bool err;
+	bool idle;
 	struct tasklet_struct tasklet;
 	struct xilinx_vdma_config config;
 	bool flush_on_fsync;
@@ -519,32 +521,6 @@ static enum dma_status xilinx_vdma_tx_status(struct dma_chan *dchan,
 }
 
 /**
- * xilinx_vdma_is_running - Check if VDMA channel is running
- * @chan: Driver specific VDMA channel
- *
- * Return: '1' if running, '0' if not.
- */
-static bool xilinx_vdma_is_running(struct xilinx_vdma_chan *chan)
-{
-	return !(vdma_ctrl_read(chan, XILINX_VDMA_REG_DMASR) &
-		 XILINX_VDMA_DMASR_HALTED) &&
-		(vdma_ctrl_read(chan, XILINX_VDMA_REG_DMACR) &
-		 XILINX_VDMA_DMACR_RUNSTOP);
-}
-
-/**
- * xilinx_vdma_is_idle - Check if VDMA channel is idle
- * @chan: Driver specific VDMA channel
- *
- * Return: '1' if idle, '0' if not.
- */
-static bool xilinx_vdma_is_idle(struct xilinx_vdma_chan *chan)
-{
-	return vdma_ctrl_read(chan, XILINX_VDMA_REG_DMASR) &
-		XILINX_VDMA_DMASR_IDLE;
-}
-
-/**
  * xilinx_vdma_halt - Halt VDMA channel
  * @chan: Driver specific VDMA channel
  */
@@ -614,6 +590,9 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 	if (list_empty(&chan->pending_list))
 		return;
 
+	if (!chan->idle)
+		return;
+
 	desc = list_first_entry(&chan->pending_list,
 				struct xilinx_vdma_tx_descriptor, node);
 	tail_desc = list_last_entry(&chan->pending_list,
@@ -622,13 +601,6 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 	tail_segment = list_last_entry(&tail_desc->segments,
 				       struct xilinx_vdma_tx_segment, node);
 
-	/* If it is SG mode and hardware is busy, cannot submit */
-	if (chan->has_sg && xilinx_vdma_is_running(chan) &&
-	    !xilinx_vdma_is_idle(chan)) {
-		dev_dbg(chan->dev, "DMA controller still busy\n");
-		return;
-	}
-
 	/*
 	 * If hardware is idle, then all descriptors on the running lists are
 	 * done, start new transfers
@@ -708,6 +680,7 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
 	chan->desc_pendingcount = 0;
+	chan->idle = false;
 }
 
 /**
@@ -854,6 +827,7 @@ static irqreturn_t xilinx_vdma_irq_handler(int irq, void *data)
 	if (status & XILINX_VDMA_DMASR_FRM_CNT_IRQ) {
 		spin_lock(&chan->lock);
 		xilinx_vdma_complete_descriptor(chan);
+		chan->idle = true;
 		xilinx_vdma_start_transfer(chan);
 		spin_unlock(&chan->lock);
 	}
@@ -1212,6 +1186,7 @@ static int xilinx_vdma_chan_probe(struct xilinx_vdma_device *xdev,
 
 	list_add_tail(&chan->common.device_node, &xdev->common.channels);
 	xdev->chan[chan->id] = chan;
+	chan->idle = true;
 
 	/* Reset the channel */
 	err = xilinx_vdma_chan_reset(chan);
-- 
2.1.2
