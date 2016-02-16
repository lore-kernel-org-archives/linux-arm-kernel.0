From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Tue, 16 Feb 2016 14:59:06 +0530
Subject: [PATCH] dmaengine: xilinx_vdma: Fix issues with non-parking mode
Message-ID: <1455614946-26197-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes issues with the Non-parking mode(Cirular mode).
With the  existing driver in cirular mode if we submit frames less than h/w
configured we simply end-up having misconfigured vdma h/w.
This patch fixes this issue by
----> By queing multiple descripotrs.
----> By configuring the frame count register.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_vdma.c | 193 ++++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 102 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 6f4b501..a73c8e1 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -190,8 +190,7 @@ struct xilinx_vdma_tx_descriptor {
  * @desc_offset: TX descriptor registers offset
  * @lock: Descriptor operation lock
  * @pending_list: Descriptors waiting
- * @active_desc: Active descriptor
- * @allocated_desc: Allocated descriptor
+ * @active_list: Descriptors ready to submit
  * @done_list: Complete descriptors
  * @common: DMA common channel
  * @desc_pool: Descriptors pool
@@ -203,9 +202,11 @@ struct xilinx_vdma_tx_descriptor {
  * @has_sg: Support scatter transfers
  * @genlock: Support genlock mode
  * @err: Channel has errors
+ * @idle: Check for channel idle
  * @tasklet: Cleanup work after irq
  * @config: Device configuration info
  * @flush_on_fsync: Flush on Frame sync
+ * @desc_pendingcount: Descriptor pending count
  */
 struct xilinx_vdma_chan {
 	struct xilinx_vdma_device *xdev;
@@ -213,8 +214,7 @@ struct xilinx_vdma_chan {
 	u32 desc_offset;
 	spinlock_t lock;
 	struct list_head pending_list;
-	struct xilinx_vdma_tx_descriptor *active_desc;
-	struct xilinx_vdma_tx_descriptor *allocated_desc;
+	struct list_head active_list;
 	struct list_head done_list;
 	struct dma_chan common;
 	struct dma_pool *desc_pool;
@@ -226,9 +226,11 @@ struct xilinx_vdma_chan {
 	bool has_sg;
 	bool genlock;
 	bool err;
+	bool idle;
 	struct tasklet_struct tasklet;
 	struct xilinx_vdma_config config;
 	bool flush_on_fsync;
+	u32 desc_pendingcount;
 };
 
 /**
@@ -342,19 +344,11 @@ static struct xilinx_vdma_tx_descriptor *
 xilinx_vdma_alloc_tx_descriptor(struct xilinx_vdma_chan *chan)
 {
 	struct xilinx_vdma_tx_descriptor *desc;
-	unsigned long flags;
-
-	if (chan->allocated_desc)
-		return chan->allocated_desc;
 
 	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 	if (!desc)
 		return NULL;
 
-	spin_lock_irqsave(&chan->lock, flags);
-	chan->allocated_desc = desc;
-	spin_unlock_irqrestore(&chan->lock, flags);
-
 	INIT_LIST_HEAD(&desc->segments);
 
 	return desc;
@@ -412,9 +406,7 @@ static void xilinx_vdma_free_descriptors(struct xilinx_vdma_chan *chan)
 
 	xilinx_vdma_free_desc_list(chan, &chan->pending_list);
 	xilinx_vdma_free_desc_list(chan, &chan->done_list);
-
-	xilinx_vdma_free_tx_descriptor(chan, chan->active_desc);
-	chan->active_desc = NULL;
+	xilinx_vdma_free_desc_list(chan, &chan->active_list);
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
@@ -529,32 +521,6 @@ static enum dma_status xilinx_vdma_tx_status(struct dma_chan *dchan,
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
@@ -614,45 +580,34 @@ static void xilinx_vdma_start(struct xilinx_vdma_chan *chan)
 static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 {
 	struct xilinx_vdma_config *config = &chan->config;
-	struct xilinx_vdma_tx_descriptor *desc;
-	unsigned long flags;
+	struct xilinx_vdma_tx_descriptor *desc, *tail_desc;
 	u32 reg;
-	struct xilinx_vdma_tx_segment *head, *tail = NULL;
+	struct xilinx_vdma_tx_segment *tail_segment;
 
 	if (chan->err)
 		return;
 
-	spin_lock_irqsave(&chan->lock, flags);
-
-	/* There's already an active descriptor, bail out. */
-	if (chan->active_desc)
-		goto out_unlock;
-
 	if (list_empty(&chan->pending_list))
-		goto out_unlock;
+		return;
+
+	if (!chan->idle)
+		return;
 
 	desc = list_first_entry(&chan->pending_list,
 				struct xilinx_vdma_tx_descriptor, node);
+	tail_desc = list_last_entry(&chan->pending_list,
+				    struct xilinx_vdma_tx_descriptor, node);
 
-	/* If it is SG mode and hardware is busy, cannot submit */
-	if (chan->has_sg && xilinx_vdma_is_running(chan) &&
-	    !xilinx_vdma_is_idle(chan)) {
-		dev_dbg(chan->dev, "DMA controller still busy\n");
-		goto out_unlock;
-	}
+	tail_segment = list_last_entry(&tail_desc->segments,
+				       struct xilinx_vdma_tx_segment, node);
 
 	/*
 	 * If hardware is idle, then all descriptors on the running lists are
 	 * done, start new transfers
 	 */
-	if (chan->has_sg) {
-		head = list_first_entry(&desc->segments,
-					struct xilinx_vdma_tx_segment, node);
-		tail = list_entry(desc->segments.prev,
-				  struct xilinx_vdma_tx_segment, node);
-
-		vdma_ctrl_write(chan, XILINX_VDMA_REG_CURDESC, head->phys);
-	}
+	if (chan->has_sg)
+		vdma_ctrl_write(chan, XILINX_VDMA_REG_CURDESC,
+				desc->async_tx.phys);
 
 	/* Configure the hardware using info in the config structure */
 	reg = vdma_ctrl_read(chan, XILINX_VDMA_REG_DMACR);
@@ -662,6 +617,9 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 	else
 		reg &= ~XILINX_VDMA_DMACR_FRAMECNT_EN;
 
+	vdma_ctrl_write(chan, XILINX_VDMA_REG_FRMSTORE,
+			chan->desc_pendingcount);
+
 	/*
 	 * With SG, start with circular mode, so that BDs can be fetched.
 	 * In direct register mode, if not parking, enable circular mode
@@ -690,16 +648,19 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 	xilinx_vdma_start(chan);
 
 	if (chan->err)
-		goto out_unlock;
+		return;
 
 	/* Start the transfer */
 	if (chan->has_sg) {
-		vdma_ctrl_write(chan, XILINX_VDMA_REG_TAILDESC, tail->phys);
+		vdma_ctrl_write(chan, XILINX_VDMA_REG_TAILDESC,
+				tail_segment->phys);
 	} else {
 		struct xilinx_vdma_tx_segment *segment, *last = NULL;
 		int i = 0;
 
-		list_for_each_entry(segment, &desc->segments, node) {
+		list_for_each_entry(desc, &chan->pending_list, node) {
+			segment = list_first_entry(&desc->segments,
+					   struct xilinx_vdma_tx_segment, node);
 			vdma_desc_write(chan,
 					XILINX_VDMA_REG_START_ADDRESS(i++),
 					segment->hw.buf_addr);
@@ -707,7 +668,7 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 		}
 
 		if (!last)
-			goto out_unlock;
+			return;
 
 		/* HW expects these parameters to be same for one transaction */
 		vdma_desc_write(chan, XILINX_VDMA_REG_HSIZE, last->hw.hsize);
@@ -716,11 +677,9 @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan *chan)
 		vdma_desc_write(chan, XILINX_VDMA_REG_VSIZE, last->hw.vsize);
 	}
 
-	list_del(&desc->node);
-	chan->active_desc = desc;
-
-out_unlock:
-	spin_unlock_irqrestore(&chan->lock, flags);
+	list_splice_tail_init(&chan->pending_list, &chan->active_list);
+	chan->desc_pendingcount = 0;
+	chan->idle = false;
 }
 
 /**
@@ -730,8 +689,11 @@ out_unlock:
 static void xilinx_vdma_issue_pending(struct dma_chan *dchan)
 {
 	struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
+	unsigned long flags;
 
+	spin_lock_irqsave(&chan->lock, flags);
 	xilinx_vdma_start_transfer(chan);
+	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
 /**
@@ -742,24 +704,16 @@ static void xilinx_vdma_issue_pending(struct dma_chan *dchan)
  */
 static void xilinx_vdma_complete_descriptor(struct xilinx_vdma_chan *chan)
 {
-	struct xilinx_vdma_tx_descriptor *desc;
-	unsigned long flags;
+	struct xilinx_vdma_tx_descriptor *desc, *next;
 
-	spin_lock_irqsave(&chan->lock, flags);
+	if (list_empty(&chan->active_list))
+		return;
 
-	desc = chan->active_desc;
-	if (!desc) {
-		dev_dbg(chan->dev, "no running descriptors\n");
-		goto out_unlock;
+	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
+		list_del(&desc->node);
+		dma_cookie_complete(&desc->async_tx);
+		list_add_tail(&desc->node, &chan->done_list);
 	}
-
-	dma_cookie_complete(&desc->async_tx);
-	list_add_tail(&desc->node, &chan->done_list);
-
-	chan->active_desc = NULL;
-
-out_unlock:
-	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
 /**
@@ -870,8 +824,11 @@ static irqreturn_t xilinx_vdma_irq_handler(int irq, void *data)
 	}
 
 	if (status & XILINX_VDMA_DMASR_FRM_CNT_IRQ) {
+		spin_lock(&chan->lock);
 		xilinx_vdma_complete_descriptor(chan);
+		chan->idle = true;
 		xilinx_vdma_start_transfer(chan);
+		spin_unlock(&chan->lock);
 	}
 
 	tasklet_schedule(&chan->tasklet);
@@ -879,6 +836,45 @@ static irqreturn_t xilinx_vdma_irq_handler(int irq, void *data)
 }
 
 /**
+ * append_desc_queue - Queuing descriptor
+ * @chan: Driver specific dma channel
+ * @desc: dma transaction descriptor
+ */
+static void append_desc_queue(struct xilinx_vdma_chan *chan,
+			      struct xilinx_vdma_tx_descriptor *desc)
+{
+	struct xilinx_vdma_tx_segment *tail_segment;
+	struct xilinx_vdma_tx_descriptor *tail_desc;
+
+	if (list_empty(&chan->pending_list))
+		goto append;
+
+	/*
+	 * Add the hardware descriptor to the chain of hardware descriptors
+	 * that already exists in memory.
+	 */
+	tail_desc = list_last_entry(&chan->pending_list,
+				    struct xilinx_vdma_tx_descriptor, node);
+	tail_segment = list_last_entry(&tail_desc->segments,
+				       struct xilinx_vdma_tx_segment, node);
+	tail_segment->hw.next_desc = (u32)desc->async_tx.phys;
+
+	/*
+	 * Add the software descriptor and all children to the list
+	 * of pending transactions
+	 */
+append:
+	list_add_tail(&desc->node, &chan->pending_list);
+	chan->desc_pendingcount++;
+
+	if (unlikely(chan->desc_pendingcount > chan->num_frms)) {
+		dev_dbg(chan->dev, "desc pendingcount is too high\n");
+		chan->desc_pendingcount = chan->num_frms;
+		BUG();
+	}
+}
+
+/**
  * xilinx_vdma_tx_submit - Submit DMA transaction
  * @tx: Async transaction descriptor
  *
@@ -906,11 +902,8 @@ static dma_cookie_t xilinx_vdma_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	cookie = dma_cookie_assign(tx);
 
-	/* Append the transaction to the pending transactions queue. */
-	list_add_tail(&desc->node, &chan->pending_list);
-
-	/* Free the allocated desc */
-	chan->allocated_desc = NULL;
+	/* Put this transaction onto the tail of the pending queue */
+	append_desc_queue(chan, desc);
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 
@@ -973,13 +966,6 @@ xilinx_vdma_dma_prep_interleaved(struct dma_chan *dchan,
 	else
 		hw->buf_addr = xt->src_start;
 
-	/* Link the previous next descriptor to current */
-	if (!list_empty(&desc->segments)) {
-		prev = list_last_entry(&desc->segments,
-				       struct xilinx_vdma_tx_segment, node);
-		prev->hw.next_desc = segment->phys;
-	}
-
 	/* Insert the segment into the descriptor segments list. */
 	list_add_tail(&segment->node, &desc->segments);
 
@@ -988,7 +974,7 @@ xilinx_vdma_dma_prep_interleaved(struct dma_chan *dchan,
 	/* Link the last hardware descriptor with the first. */
 	segment = list_first_entry(&desc->segments,
 				   struct xilinx_vdma_tx_segment, node);
-	prev->hw.next_desc = segment->phys;
+	desc->async_tx.phys = segment->phys;
 
 	return &desc->async_tx;
 
@@ -1127,10 +1113,12 @@ static int xilinx_vdma_chan_probe(struct xilinx_vdma_device *xdev,
 	chan->dev = xdev->dev;
 	chan->xdev = xdev;
 	chan->has_sg = xdev->has_sg;
+	chan->desc_pendingcount = 0x0;
 
 	spin_lock_init(&chan->lock);
 	INIT_LIST_HEAD(&chan->pending_list);
 	INIT_LIST_HEAD(&chan->done_list);
+	INIT_LIST_HEAD(&chan->active_list);
 
 	/* Retrieve the channel properties from the device tree */
 	has_dre = of_property_read_bool(node, "xlnx,include-dre");
@@ -1198,6 +1186,7 @@ static int xilinx_vdma_chan_probe(struct xilinx_vdma_device *xdev,
 
 	list_add_tail(&chan->common.device_node, &xdev->common.channels);
 	xdev->chan[chan->id] = chan;
+	chan->idle = true;
 
 	/* Reset the channel */
 	err = xilinx_vdma_chan_reset(chan);
-- 
2.1.2
