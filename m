From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri,  5 Dec 2014 18:44:56 +0530
Subject: [PATCH] dma: pl330: revert commit 04abf5daf7d
Message-ID: <1417785296-4435-1-git-send-email-jaswinder.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From Documentation/crypto/async-tx-api.txt
  "... Once a driver-specific threshold is met the driver
automatically issues pending operations.  An application can force
this event by calling async_tx_issue_pending_all() ..."
 That is, the DMA controller drivers may buffer transfer requests
for optimization. However it is perfectly legal to start dma as soon
as the user calls .tx_submit() on the descriptor, as the documentation
specifies in include/linux/dmaengine.h

It is also consistent with the expected behaviour. For example, if a
channel is already active when a client submits a request, we do not
expect the channel to stop after the current request is done and wait
for explicit issue_pending() from the user (the user has already done
prep() and submit()) on the last request.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/dma/pl330.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 19a9974..8ec5f1f 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -411,9 +411,7 @@ struct dma_pl330_chan {
 	/* DMA-Engine Channel */
 	struct dma_chan chan;
 
-	/* List of submitted descriptors */
-	struct list_head submitted_list;
-	/* List of issued descriptors */
+	/* List of to be xfered descriptors */
 	struct list_head work_list;
 	/* List of completed descriptors */
 	struct list_head completed_list;
@@ -2084,11 +2082,6 @@ static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd, unsigned
 		pch->thread->req_running = -1;
 
 		/* Mark all desc done */
-		list_for_each_entry(desc, &pch->submitted_list, node) {
-			desc->status = FREE;
-			dma_cookie_complete(&desc->txd);
-		}
-
 		list_for_each_entry(desc, &pch->work_list , node) {
 			desc->status = FREE;
 			dma_cookie_complete(&desc->txd);
@@ -2099,7 +2092,6 @@ static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd, unsigned
 			dma_cookie_complete(&desc->txd);
 		}
 
-		list_splice_tail_init(&pch->submitted_list, &pl330->desc_pool);
 		list_splice_tail_init(&pch->work_list, &pl330->desc_pool);
 		list_splice_tail_init(&pch->completed_list, &pl330->desc_pool);
 		spin_unlock_irqrestore(&pch->lock, flags);
@@ -2158,14 +2150,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 static void pl330_issue_pending(struct dma_chan *chan)
 {
-	struct dma_pl330_chan *pch = to_pchan(chan);
-	unsigned long flags;
-
-	spin_lock_irqsave(&pch->lock, flags);
-	list_splice_tail_init(&pch->submitted_list, &pch->work_list);
-	spin_unlock_irqrestore(&pch->lock, flags);
-
-	pl330_tasklet((unsigned long)pch);
+	pl330_tasklet((unsigned long) to_pchan(chan));
 }
 
 /*
@@ -2192,11 +2177,11 @@ static dma_cookie_t pl330_tx_submit(struct dma_async_tx_descriptor *tx)
 
 		dma_cookie_assign(&desc->txd);
 
-		list_move_tail(&desc->node, &pch->submitted_list);
+		list_move_tail(&desc->node, &pch->work_list);
 	}
 
 	cookie = dma_cookie_assign(&last->txd);
-	list_add_tail(&last->node, &pch->submitted_list);
+	list_add_tail(&last->node, &pch->work_list);
 	spin_unlock_irqrestore(&pch->lock, flags);
 
 	return cookie;
@@ -2680,7 +2665,6 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		else
 			pch->chan.private = adev->dev.of_node;
 
-		INIT_LIST_HEAD(&pch->submitted_list);
 		INIT_LIST_HEAD(&pch->work_list);
 		INIT_LIST_HEAD(&pch->completed_list);
 		spin_lock_init(&pch->lock);
-- 
1.9.1
