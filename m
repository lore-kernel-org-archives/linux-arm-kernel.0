From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 23 Aug 2016 00:48:11 -0400
Subject: [PATCH V3 3/3] dmaengine: qcom_hidma: add error reporting for
 tx_status
In-Reply-To: <1471927691-28827-1-git-send-email-okaya@codeaurora.org>
References: <1471927691-28827-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1471927691-28827-4-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HIDMA driver is capable of error detection. However, the error was
not being passed back to the client when tx_status API is called.

Changing the error handling behavior to follow this oder.

1. dmaengine asserts error interrupt
2. Driver receives and mark's the txn as error
3. Driver completes the txn and intimates the client. No further
   submissions. Drop the locks before calling callback, as subsequent
   processing by client maybe in callback thread.
4. Client invokes status and you can return error
5. On error, client calls terminate_all. You can reset channel, free all
   descriptors in the active, pending and completed lists
6. Client prepares new txn and so on.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c    | 30 +++++++++++++++++++++++++-----
 drivers/dma/qcom/hidma.h    |  1 +
 drivers/dma/qcom/hidma_ll.c | 32 +++++++-------------------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index ea24863..e244e10 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -129,6 +129,7 @@ static void hidma_process_completed(struct hidma_chan *mchan)
 		struct dmaengine_result result;
 
 		desc = &mdesc->desc;
+		last_cookie = desc->cookie;
 
 		spin_lock_irqsave(&mchan->lock, irqflags);
 		dma_cookie_complete(desc);
@@ -137,15 +138,15 @@ static void hidma_process_completed(struct hidma_chan *mchan)
 		llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
 		dmaengine_desc_get_callback(desc, &cb);
 
-		last_cookie = desc->cookie;
 		dma_run_dependencies(desc);
 
 		spin_lock_irqsave(&mchan->lock, irqflags);
 		list_move(&mdesc->node, &mchan->free);
 
-		if (llstat == DMA_COMPLETE)
+		if (llstat == DMA_COMPLETE) {
+			mchan->last_success = last_cookie;
 			result.result = DMA_TRANS_NOERROR;
-		else
+		} else
 			result.result = DMA_TRANS_ABORTED;
 
 		spin_unlock_irqrestore(&mchan->lock, irqflags);
@@ -246,6 +247,19 @@ static void hidma_issue_pending(struct dma_chan *dmach)
 		hidma_ll_start(dmadev->lldev);
 }
 
+static inline bool hidma_txn_is_success(dma_cookie_t cookie,
+		dma_cookie_t last_success, dma_cookie_t last_used)
+{
+	if (last_success <= last_used) {
+		if ((cookie <= last_success) || (cookie > last_used))
+			return true;
+	} else {
+		if ((cookie <= last_success) && (cookie > last_used))
+			return true;
+	}
+	return false;
+}
+
 static enum dma_status hidma_tx_status(struct dma_chan *dmach,
 				       dma_cookie_t cookie,
 				       struct dma_tx_state *txstate)
@@ -254,8 +268,13 @@ static enum dma_status hidma_tx_status(struct dma_chan *dmach,
 	enum dma_status ret;
 
 	ret = dma_cookie_status(dmach, cookie, txstate);
-	if (ret == DMA_COMPLETE)
-		return ret;
+	if (ret == DMA_COMPLETE) {
+		bool is_success;
+
+		is_success = hidma_txn_is_success(cookie, mchan->last_success,
+						  dmach->cookie);
+		return is_success ? ret : DMA_ERROR;
+	}
 
 	if (mchan->paused && (ret == DMA_IN_PROGRESS)) {
 		unsigned long flags;
@@ -406,6 +425,7 @@ static int hidma_terminate_channel(struct dma_chan *chan)
 	hidma_process_completed(mchan);
 
 	spin_lock_irqsave(&mchan->lock, irqflags);
+	mchan->last_success = 0;
 	list_splice_init(&mchan->active, &list);
 	list_splice_init(&mchan->prepared, &list);
 	list_splice_init(&mchan->completed, &list);
diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index db413a5..f78aef0 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -89,6 +89,7 @@ struct hidma_chan {
 	bool				allocated;
 	char				dbg_name[16];
 	u32				dma_sig;
+	dma_cookie_t			last_success;
 
 	/*
 	 * active descriptor on this channel
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index ad20dfb..3224f24 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -381,27 +381,6 @@ static int hidma_ll_reset(struct hidma_lldev *lldev)
 }
 
 /*
- * Abort all transactions and perform a reset.
- */
-static void hidma_ll_abort(unsigned long arg)
-{
-	struct hidma_lldev *lldev = (struct hidma_lldev *)arg;
-	u8 err_code = HIDMA_EVRE_STATUS_ERROR;
-	u8 err_info = 0xFF;
-	int rc;
-
-	hidma_cleanup_pending_tre(lldev, err_info, err_code);
-
-	/* reset the channel for recovery */
-	rc = hidma_ll_setup(lldev);
-	if (rc) {
-		dev_err(lldev->dev, "channel reinitialize failed after error\n");
-		return;
-	}
-	writel(ENABLE_IRQS, lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
-}
-
-/*
  * The interrupt handler for HIDMA will try to consume as many pending
  * EVRE from the event queue as possible. Each EVRE has an associated
  * TRE that holds the user interface parameters. EVRE reports the
@@ -454,13 +433,18 @@ irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
 
 	while (cause) {
 		if (cause & HIDMA_ERR_INT_MASK) {
-			dev_err(lldev->dev, "error 0x%x, resetting...\n",
+			dev_err(lldev->dev, "error 0x%x, disabling...\n",
 					cause);
 
 			/* Clear out pending interrupts */
 			writel(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
 
-			tasklet_schedule(&lldev->rst_task);
+			/* No further submissions. */
+			hidma_ll_disable(lldev);
+
+			/* Driver completes the txn and intimates the client.*/
+			hidma_cleanup_pending_tre(lldev, 0xFF,
+						  HIDMA_EVRE_STATUS_ERROR);
 			goto out;
 		}
 
@@ -808,7 +792,6 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 		return NULL;
 
 	spin_lock_init(&lldev->lock);
-	tasklet_init(&lldev->rst_task, hidma_ll_abort, (unsigned long)lldev);
 	tasklet_init(&lldev->task, hidma_ll_tre_complete, (unsigned long)lldev);
 	lldev->initialized = 1;
 	writel(ENABLE_IRQS, lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
@@ -831,7 +814,6 @@ int hidma_ll_uninit(struct hidma_lldev *lldev)
 
 	required_bytes = sizeof(struct hidma_tre) * lldev->nr_tres;
 	tasklet_kill(&lldev->task);
-	tasklet_kill(&lldev->rst_task);
 	memset(lldev->trepool, 0, required_bytes);
 	lldev->trepool = NULL;
 	lldev->pending_tre_count = 0;
-- 
1.8.2.1
