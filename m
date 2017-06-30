From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 30 Jun 2017 10:43:05 -0400
Subject: [PATCH V2] dmaengine: qcom_hidma: correct API violation for submit
Message-ID: <1498833785-22632-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code is violating the DMA Engine API by putting the submitted
requests directly into the HW queue. This causes queued transactions
to be started by another thread as soon as the first one finishes.

The DMA Engine document clearly states this.

"dmaengine_submit() will not start the DMA operation".

Move HW queuing of the requests into the issue_pending() routine
to comply with API requirements also create a new queued state for
temporarily holding the requests.

A descriptor goes through these transitions now.

free->prepared->queued->active->completed->free

as opposed to

free->prepared->active->completed->free

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 15 ++++++++++++---
 drivers/dma/qcom/hidma.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 84e3699..34fb6af 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -210,6 +210,7 @@ static int hidma_chan_init(struct hidma_dev *dmadev, u32 dma_sig)
 	INIT_LIST_HEAD(&mchan->prepared);
 	INIT_LIST_HEAD(&mchan->active);
 	INIT_LIST_HEAD(&mchan->completed);
+	INIT_LIST_HEAD(&mchan->queued);
 
 	spin_lock_init(&mchan->lock);
 	list_add_tail(&mchan->chan.device_node, &ddev->channels);
@@ -230,9 +231,15 @@ static void hidma_issue_pending(struct dma_chan *dmach)
 	struct hidma_chan *mchan = to_hidma_chan(dmach);
 	struct hidma_dev *dmadev = mchan->dmadev;
 	unsigned long flags;
+	struct hidma_desc *qdesc, *next;
 	int status;
 
 	spin_lock_irqsave(&mchan->lock, flags);
+	list_for_each_entry_safe(qdesc, next, &mchan->queued, node) {
+		hidma_ll_queue_request(dmadev->lldev, qdesc->tre_ch);
+		list_move_tail(&qdesc->node, &mchan->active);
+	}
+
 	if (!mchan->running) {
 		struct hidma_desc *desc = list_first_entry(&mchan->active,
 							   struct hidma_desc,
@@ -315,17 +322,18 @@ static dma_cookie_t hidma_tx_submit(struct dma_async_tx_descriptor *txd)
 		pm_runtime_put_autosuspend(dmadev->ddev.dev);
 		return -ENODEV;
 	}
+	pm_runtime_mark_last_busy(dmadev->ddev.dev);
+	pm_runtime_put_autosuspend(dmadev->ddev.dev);
 
 	mdesc = container_of(txd, struct hidma_desc, desc);
 	spin_lock_irqsave(&mchan->lock, irqflags);
 
-	/* Move descriptor to active */
-	list_move_tail(&mdesc->node, &mchan->active);
+	/* Move descriptor to queued */
+	list_move_tail(&mdesc->node, &mchan->queued);
 
 	/* Update cookie */
 	cookie = dma_cookie_assign(txd);
 
-	hidma_ll_queue_request(dmadev->lldev, mdesc->tre_ch);
 	spin_unlock_irqrestore(&mchan->lock, irqflags);
 
 	return cookie;
@@ -431,6 +439,7 @@ static int hidma_terminate_channel(struct dma_chan *chan)
 	list_splice_init(&mchan->active, &list);
 	list_splice_init(&mchan->prepared, &list);
 	list_splice_init(&mchan->completed, &list);
+	list_splice_init(&mchan->queued, &list);
 	spin_unlock_irqrestore(&mchan->lock, irqflags);
 
 	/* this suspends the existing transfer */
diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index c7d0142..41e0aa2 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -104,6 +104,7 @@ struct hidma_chan {
 	struct dma_chan			chan;
 	struct list_head		free;
 	struct list_head		prepared;
+	struct list_head		queued;
 	struct list_head		active;
 	struct list_head		completed;
 
-- 
1.9.1
