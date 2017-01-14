From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Sat, 14 Jan 2017 11:05:53 +0530
Subject: [PATCH v6 1/3] dmaengine: xilinx_dma: Check for channel idle state
 before submitting dma descriptor
In-Reply-To: <1484372155-19423-1-git-send-email-appanad@xilinx.com>
References: <1484372155-19423-1-git-send-email-appanad@xilinx.com>
Message-ID: <1484372155-19423-2-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add variable for checking channel idle state to ensure that dma descriptor is not
Submitted when DMA engine is in progress.

This will avoids the pollling for a bit in the status register to know
Dma state in the driver hot path.

Reviewed-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v6:
---> Updated commit message as suggested by Vinod.
---> Added Channel idle variable description in the driver
     as suggested by Vinod.
Changes for v5:
---> None.
Changes for v4:
---> None.
Changes for v3:
---> None.
Changes for v2:
---> Add idle check in the reset as suggested by Jose Abreu
---> Removed xilinx_dma_is_running/xilinx_dma_is_idle checks
    in the driver and used common idle checks across the driver
    as suggested by Laurent Pinchart.

 drivers/dma/xilinx/xilinx_dma.c | 61 +++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8288fe4..5eeea57 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -321,6 +321,7 @@ struct xilinx_dma_tx_descriptor {
  * @cyclic: Check for cyclic transfers.
  * @genlock: Support genlock mode
  * @err: Channel has errors
+ * @idle: Check for channel idle
  * @tasklet: Cleanup work after irq
  * @config: Device configuration info
  * @flush_on_fsync: Flush on Frame sync
@@ -351,6 +352,7 @@ struct xilinx_dma_chan {
 	bool cyclic;
 	bool genlock;
 	bool err;
+	bool idle;
 	struct tasklet_struct tasklet;
 	struct xilinx_vdma_config config;
 	bool flush_on_fsync;
@@ -920,32 +922,6 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 }
 
 /**
- * xilinx_dma_is_running - Check if DMA channel is running
- * @chan: Driver specific DMA channel
- *
- * Return: '1' if running, '0' if not.
- */
-static bool xilinx_dma_is_running(struct xilinx_dma_chan *chan)
-{
-	return !(dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
-		 XILINX_DMA_DMASR_HALTED) &&
-		(dma_ctrl_read(chan, XILINX_DMA_REG_DMACR) &
-		 XILINX_DMA_DMACR_RUNSTOP);
-}
-
-/**
- * xilinx_dma_is_idle - Check if DMA channel is idle
- * @chan: Driver specific DMA channel
- *
- * Return: '1' if idle, '0' if not.
- */
-static bool xilinx_dma_is_idle(struct xilinx_dma_chan *chan)
-{
-	return dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
-		XILINX_DMA_DMASR_IDLE;
-}
-
-/**
  * xilinx_dma_halt - Halt DMA channel
  * @chan: Driver specific DMA channel
  */
@@ -966,6 +942,7 @@ static void xilinx_dma_halt(struct xilinx_dma_chan *chan)
 			chan, dma_ctrl_read(chan, XILINX_DMA_REG_DMASR));
 		chan->err = true;
 	}
+	chan->idle = true;
 }
 
 /**
@@ -1007,6 +984,9 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
+	if (!chan->idle)
+		return;
+
 	if (list_empty(&chan->pending_list))
 		return;
 
@@ -1018,13 +998,6 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	tail_segment = list_last_entry(&tail_desc->segments,
 				       struct xilinx_vdma_tx_segment, node);
 
-	/* If it is SG mode and hardware is busy, cannot submit */
-	if (chan->has_sg && xilinx_dma_is_running(chan) &&
-	    !xilinx_dma_is_idle(chan)) {
-		dev_dbg(chan->dev, "DMA controller still busy\n");
-		return;
-	}
-
 	/*
 	 * If hardware is idle, then all descriptors on the running lists are
 	 * done, start new transfers
@@ -1110,6 +1083,7 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
 	}
 
+	chan->idle = false;
 	if (!chan->has_sg) {
 		list_del(&desc->node);
 		list_add_tail(&desc->node, &chan->active_list);
@@ -1136,6 +1110,9 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
+	if (!chan->idle)
+		return;
+
 	if (list_empty(&chan->pending_list))
 		return;
 
@@ -1181,6 +1158,7 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
 	chan->desc_pendingcount = 0;
+	chan->idle = false;
 }
 
 /**
@@ -1196,15 +1174,11 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
-	if (list_empty(&chan->pending_list))
+	if (!chan->idle)
 		return;
 
-	/* If it is SG mode and hardware is busy, cannot submit */
-	if (chan->has_sg && xilinx_dma_is_running(chan) &&
-	    !xilinx_dma_is_idle(chan)) {
-		dev_dbg(chan->dev, "DMA controller still busy\n");
+	if (list_empty(&chan->pending_list))
 		return;
-	}
 
 	head_desc = list_first_entry(&chan->pending_list,
 				     struct xilinx_dma_tx_descriptor, node);
@@ -1302,6 +1276,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
 	chan->desc_pendingcount = 0;
+	chan->idle = false;
 }
 
 /**
@@ -1366,6 +1341,7 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
 	}
 
 	chan->err = false;
+	chan->idle = true;
 
 	return err;
 }
@@ -1447,6 +1423,7 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 	if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
+		chan->idle = true;
 		chan->start_transfer(chan);
 		spin_unlock(&chan->lock);
 	}
@@ -2327,6 +2304,12 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	chan->has_sg = xdev->has_sg;
 	chan->desc_pendingcount = 0x0;
 	chan->ext_addr = xdev->ext_addr;
+	/* This variable enusres that descripotrs are not
+	 * Submited when dma engine is in progress. This variable is
+	 * Added to avoid pollling for a bit in the status register to
+	 * Know dma state in the driver hot path.
+	 */
+	chan->idle = true;
 
 	spin_lock_init(&chan->lock);
 	INIT_LIST_HEAD(&chan->pending_list);
-- 
2.1.2
