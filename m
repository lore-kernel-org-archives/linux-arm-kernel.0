From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:27:02 +0530
Subject: [PATCH v3 13/17] dmaengine: bcm-sba-raid: Re-factor
 sba_process_deferred_requests()
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-14-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, sba_process_deferred_requests() handles both pending
and completed sba_request which is unnecessary overhead for
sba_issue_pending() because completed sba_request handling is
not required in sba_issue_pending().

This patch breaks sba_process_deferred_requests() into two parts
sba_process_received_request() and _sba_process_pending_requests().

The sba_issue_pending() will only process pending sba_request
by calling _sba_process_pending_requests(). This will improve
sba_issue_pending().

The sba_receive_message() will only process received sba_request
by calling sba_process_received_request() for each received
sba_request. The sba_process_received_request() will also call
_sba_process_pending_requests() after handling received sba_request
because we might have pending sba_request not submitted by previous
call to sba_issue_pending().

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 109 +++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 62 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 2f444cc..cb6b2e2 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -419,22 +419,20 @@ static int sba_send_mbox_request(struct sba_device *sba,
 	return 0;
 }
 
-static void sba_process_deferred_requests(struct sba_device *sba)
+/* Note: Must be called with sba->reqs_lock held */
+static void _sba_process_pending_requests(struct sba_device *sba)
 {
 	int ret;
 	u32 count;
-	unsigned long flags;
 	struct sba_request *req;
-	struct dma_async_tx_descriptor *tx;
-
-	spin_lock_irqsave(&sba->reqs_lock, flags);
-
-	/* Count pending requests */
-	count = 0;
-	list_for_each_entry(req, &sba->reqs_pending_list, node)
-		count++;
 
-	/* Process pending requests */
+	/*
+	 * Process few pending requests
+	 *
+	 * For now, we process (<number_of_mailbox_channels> * 8)
+	 * number of requests at a time.
+	 */
+	count = sba->mchans_count * 8;
 	while (!list_empty(&sba->reqs_pending_list) && count) {
 		/* Get the first pending request */
 		req = list_first_entry(&sba->reqs_pending_list,
@@ -445,11 +443,7 @@ static void sba_process_deferred_requests(struct sba_device *sba)
 			break;
 
 		/* Send request to mailbox channel */
-		spin_unlock_irqrestore(&sba->reqs_lock, flags);
 		ret = sba_send_mbox_request(sba, req);
-		spin_lock_irqsave(&sba->reqs_lock, flags);
-
-		/* If something went wrong then keep request pending */
 		if (ret < 0) {
 			_sba_pending_request(sba, req);
 			break;
@@ -457,20 +451,18 @@ static void sba_process_deferred_requests(struct sba_device *sba)
 
 		count--;
 	}
+}
 
-	/* Count completed requests */
-	count = 0;
-	list_for_each_entry(req, &sba->reqs_completed_list, node)
-		count++;
-
-	/* Process completed requests */
-	while (!list_empty(&sba->reqs_completed_list) && count) {
-		req = list_first_entry(&sba->reqs_completed_list,
-					struct sba_request, node);
-		list_del_init(&req->node);
-		tx = &req->tx;
+static void sba_process_received_request(struct sba_device *sba,
+					 struct sba_request *req)
+{
+	unsigned long flags;
+	struct dma_async_tx_descriptor *tx;
+	struct sba_request *nreq, *first = req->first;
 
-		spin_unlock_irqrestore(&sba->reqs_lock, flags);
+	/* Process only after all chained requests are received */
+	if (!atomic_dec_return(&first->next_pending_count)) {
+		tx = &first->tx;
 
 		WARN_ON(tx->cookie < 0);
 		if (tx->cookie > 0) {
@@ -485,41 +477,34 @@ static void sba_process_deferred_requests(struct sba_device *sba)
 
 		spin_lock_irqsave(&sba->reqs_lock, flags);
 
-		/* If waiting for 'ack' then move to completed list */
-		if (!async_tx_test_ack(&req->tx))
-			_sba_complete_request(sba, req);
-		else
-			_sba_free_request(sba, req);
+		/* Free all requests chained to first request */
+		list_for_each_entry(nreq, &first->next, next)
+			_sba_free_request(sba, nreq);
+		INIT_LIST_HEAD(&first->next);
 
-		count--;
-	}
+		/* Mark request as received */
+		_sba_received_request(sba, first);
 
-	/* Re-check pending and completed work */
-	count = 0;
-	if (!list_empty(&sba->reqs_pending_list) ||
-	    !list_empty(&sba->reqs_completed_list))
-		count = 1;
-
-	spin_unlock_irqrestore(&sba->reqs_lock, flags);
-}
-
-static void sba_process_received_request(struct sba_device *sba,
-					 struct sba_request *req)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&sba->reqs_lock, flags);
+		/* The client is allowed to attach dependent operations
+		 * until 'ack' is set
+		 */
+		if (!async_tx_test_ack(tx))
+			_sba_complete_request(sba, first);
+		else
+			_sba_free_request(sba, first);
 
-	/* Mark request as received */
-	_sba_received_request(sba, req);
+		/* Cleanup completed requests */
+		list_for_each_entry_safe(req, nreq,
+					 &sba->reqs_completed_list, node) {
+			if (async_tx_test_ack(&req->tx))
+				_sba_free_request(sba, req);
+		}
 
-	/* Update request */
-	if (!atomic_dec_return(&req->first->next_pending_count))
-		_sba_complete_request(sba, req->first);
-	if (req->first != req)
-		_sba_free_request(sba, req);
+		/* Process pending requests */
+		_sba_process_pending_requests(sba);
 
-	spin_unlock_irqrestore(&sba->reqs_lock, flags);
+		spin_unlock_irqrestore(&sba->reqs_lock, flags);
+	}
 }
 
 /* ====== DMAENGINE callbacks ===== */
@@ -544,10 +529,13 @@ static int sba_device_terminate_all(struct dma_chan *dchan)
 
 static void sba_issue_pending(struct dma_chan *dchan)
 {
+	unsigned long flags;
 	struct sba_device *sba = to_sba_device(dchan);
 
-	/* Process deferred requests */
-	sba_process_deferred_requests(sba);
+	/* Process pending requests */
+	spin_lock_irqsave(&sba->reqs_lock, flags);
+	_sba_process_pending_requests(sba);
+	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 }
 
 static dma_cookie_t sba_tx_submit(struct dma_async_tx_descriptor *tx)
@@ -1482,9 +1470,6 @@ static void sba_receive_message(struct mbox_client *cl, void *msg)
 
 	/* Process received request */
 	sba_process_received_request(sba, req);
-
-	/* Process deferred requests */
-	sba_process_deferred_requests(sba);
 }
 
 /* ====== Platform driver routines ===== */
-- 
2.7.4
