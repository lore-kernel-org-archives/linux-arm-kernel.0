From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Thu, 20 Aug 2015 16:00:56 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix holding lock while calling tx
 callback in cleanup path
Message-ID: <1440066656-15516-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the an locking issue where client callback performs
further submission.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---
 drivers/dma/xgene-dma.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index d1c8809..0b82bc0 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -763,12 +763,17 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
 	struct xgene_dma_ring *ring = &chan->rx_ring;
 	struct xgene_dma_desc_sw *desc_sw, *_desc_sw;
 	struct xgene_dma_desc_hw *desc_hw;
+	struct list_head ld_completed;
 	u8 status;

+	INIT_LIST_HEAD(&ld_completed);
+
+	spin_lock_bh(&chan->lock);
+
 	/* Clean already completed and acked descriptors */
 	xgene_dma_clean_completed_descriptor(chan);

-	/* Run the callback for each descriptor, in order */
+	/* Move all completed descriptors to ld completed queue, in order */
 	list_for_each_entry_safe(desc_sw, _desc_sw, &chan->ld_running, node) {
 		/* Get subsequent hw descriptor from DMA rx ring */
 		desc_hw = &ring->desc_hw[ring->head];
@@ -811,15 +816,17 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
 		/* Mark this hw descriptor as processed */
 		desc_hw->m0 = cpu_to_le64(XGENE_DMA_DESC_EMPTY_SIGNATURE);

-		xgene_dma_run_tx_complete_actions(chan, desc_sw);
-
-		xgene_dma_clean_running_descriptor(chan, desc_sw);
-
 		/*
 		 * Decrement the pending transaction count
 		 * as we have processed one
 		 */
 		chan->pending--;
+
+		/*
+		 * Delete this node from ld running queue and append it to
+		 * ld completed queue for further processing
+		 */
+		list_move_tail(&desc_sw->node, &ld_completed);
 	}

 	/*
@@ -828,6 +835,14 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
 	 * ahead and free the descriptors below.
 	 */
 	xgene_chan_xfer_ld_pending(chan);
+
+	spin_unlock_bh(&chan->lock);
+
+	/* Run the callback for each descriptor, in order */
+	list_for_each_entry_safe(desc_sw, _desc_sw, &ld_completed, node) {
+		xgene_dma_run_tx_complete_actions(chan, desc_sw);
+		xgene_dma_clean_running_descriptor(chan, desc_sw);
+	}
 }

 static int xgene_dma_alloc_chan_resources(struct dma_chan *dchan)
@@ -876,11 +891,11 @@ static void xgene_dma_free_chan_resources(struct dma_chan *dchan)
 	if (!chan->desc_pool)
 		return;

-	spin_lock_bh(&chan->lock);
-
 	/* Process all running descriptor */
 	xgene_dma_cleanup_descriptors(chan);

+	spin_lock_bh(&chan->lock);
+
 	/* Clean all link descriptor queues */
 	xgene_dma_free_desc_list(chan, &chan->ld_pending);
 	xgene_dma_free_desc_list(chan, &chan->ld_running);
@@ -1200,15 +1215,11 @@ static void xgene_dma_tasklet_cb(unsigned long data)
 {
 	struct xgene_dma_chan *chan = (struct xgene_dma_chan *)data;

-	spin_lock_bh(&chan->lock);
-
 	/* Run all cleanup for descriptors which have been completed */
 	xgene_dma_cleanup_descriptors(chan);

 	/* Re-enable DMA channel IRQ */
 	enable_irq(chan->rx_irq);
-
-	spin_unlock_bh(&chan->lock);
 }

 static irqreturn_t xgene_dma_chan_ring_isr(int irq, void *id)
--
1.8.2.1
