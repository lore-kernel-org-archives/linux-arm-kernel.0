From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:51:02 +0530
Subject: [PATCH v7 1/6] dmaengine: xilinx_dma: Check for channel idle state
 before submitting dma descriptor
In-Reply-To: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
References: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624067-13554-2-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add variable for checking channel idle state to ensure that dma
descriptor is not submitted when dmaengine is in progress.

This will avoid the polling for a bit in the status register to know
dma state in the driver hot path.

Reviewed-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v7:
---> None.
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

 drivers/dma/xilinx/xilinx_dma.c | 60 +++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 5eef133..c246563 100644
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
@@ -352,6 +353,7 @@ struct xilinx_dma_chan {
 	bool cyclic;
 	bool genlock;
 	bool err;
+	bool idle;
 	struct tasklet_struct tasklet;
 	struct xilinx_vdma_config config;
 	bool flush_on_fsync;
@@ -936,32 +938,6 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
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
  * xilinx_dma_stop_transfer - Halt DMA channel
  * @chan: Driver specific DMA channel
  */
@@ -1029,6 +1005,9 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
+	if (!chan->idle)
+		return;
+
 	if (list_empty(&chan->pending_list))
 		return;
 
@@ -1040,13 +1019,6 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
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
@@ -1143,6 +1115,8 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 		list_splice_tail_init(&chan->pending_list, &chan->active_list);
 		chan->desc_pendingcount = 0;
 	}
+
+	chan->idle = false;
 }
 
 /**
@@ -1158,6 +1132,9 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
+	if (!chan->idle)
+		return;
+
 	if (list_empty(&chan->pending_list))
 		return;
 
@@ -1203,6 +1180,7 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
 	chan->desc_pendingcount = 0;
+	chan->idle = false;
 }
 
 /**
@@ -1221,12 +1199,8 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (list_empty(&chan->pending_list))
 		return;
 
-	/* If it is SG mode and hardware is busy, cannot submit */
-	if (chan->has_sg && xilinx_dma_is_running(chan) &&
-	    !xilinx_dma_is_idle(chan)) {
-		dev_dbg(chan->dev, "DMA controller still busy\n");
+	if (!chan->idle)
 		return;
-	}
 
 	head_desc = list_first_entry(&chan->pending_list,
 				     struct xilinx_dma_tx_descriptor, node);
@@ -1324,6 +1298,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
 	chan->desc_pendingcount = 0;
+	chan->idle = false;
 }
 
 /**
@@ -1388,6 +1363,7 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
 	}
 
 	chan->err = false;
+	chan->idle = true;
 
 	return err;
 }
@@ -1469,6 +1445,7 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 	if (status & XILINX_DMA_DMASR_FRM_CNT_IRQ) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
+		chan->idle = true;
 		chan->start_transfer(chan);
 		spin_unlock(&chan->lock);
 	}
@@ -2029,6 +2006,7 @@ static int xilinx_dma_terminate_all(struct dma_chan *dchan)
 
 	/* Remove and free all of the descriptors in the lists */
 	xilinx_dma_free_descriptors(chan);
+	chan->idle = true;
 
 	if (chan->cyclic) {
 		reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
@@ -2344,6 +2322,12 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
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
2.7.4
