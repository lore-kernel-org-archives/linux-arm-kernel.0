From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:27:06 +0530
Subject: [PATCH v3 17/17] dmaengine: bcm-sba-raid: Remove redundant
 SBA_REQUEST_STATE_COMPLETED
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-18-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SBA_REQUEST_STATE_COMPLETED state was added to keep track
of sba_request which got completed but cannot be freed because
underlying Async Tx descriptor was not ACKed by DMA client.

Instead of above, we can free the sba_request with non-ACKed
Async Tx descriptor and sba_alloc_request() will ensure that
it always allocates sba_request with ACKed Async Tx descriptor.
This alternate approach makes SBA_REQUEST_STATE_COMPLETED state
redundant hence this patch removes it.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 63 +++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 0c41136..5b1595f 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -99,8 +99,7 @@ enum sba_request_flags {
 	SBA_REQUEST_STATE_ALLOCED	= 0x002,
 	SBA_REQUEST_STATE_PENDING	= 0x004,
 	SBA_REQUEST_STATE_ACTIVE	= 0x008,
-	SBA_REQUEST_STATE_COMPLETED	= 0x010,
-	SBA_REQUEST_STATE_ABORTED	= 0x020,
+	SBA_REQUEST_STATE_ABORTED	= 0x010,
 	SBA_REQUEST_STATE_MASK		= 0x0ff,
 	SBA_REQUEST_FENCE		= 0x100,
 };
@@ -160,7 +159,6 @@ struct sba_device {
 	struct list_head reqs_alloc_list;
 	struct list_head reqs_pending_list;
 	struct list_head reqs_active_list;
-	struct list_head reqs_completed_list;
 	struct list_head reqs_aborted_list;
 	struct list_head reqs_free_list;
 	/* DebugFS directory entries */
@@ -212,17 +210,21 @@ static void sba_peek_mchans(struct sba_device *sba)
 
 static struct sba_request *sba_alloc_request(struct sba_device *sba)
 {
+	bool found = false;
 	unsigned long flags;
 	struct sba_request *req = NULL;
 
 	spin_lock_irqsave(&sba->reqs_lock, flags);
-	req = list_first_entry_or_null(&sba->reqs_free_list,
-				       struct sba_request, node);
-	if (req)
-		list_move_tail(&req->node, &sba->reqs_alloc_list);
+	list_for_each_entry(req, &sba->reqs_free_list, node) {
+		if (async_tx_test_ack(&req->tx)) {
+			list_move_tail(&req->node, &sba->reqs_alloc_list);
+			found = true;
+			break;
+		}
+	}
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 
-	if (!req) {
+	if (!found) {
 		/*
 		 * We have no more free requests so, we peek
 		 * mailbox channels hoping few active requests
@@ -297,18 +299,6 @@ static void _sba_free_request(struct sba_device *sba,
 		sba->reqs_fence = false;
 }
 
-/* Note: Must be called with sba->reqs_lock held */
-static void _sba_complete_request(struct sba_device *sba,
-				  struct sba_request *req)
-{
-	lockdep_assert_held(&sba->reqs_lock);
-	req->flags &= ~SBA_REQUEST_STATE_MASK;
-	req->flags |= SBA_REQUEST_STATE_COMPLETED;
-	list_move_tail(&req->node, &sba->reqs_completed_list);
-	if (list_empty(&sba->reqs_active_list))
-		sba->reqs_fence = false;
-}
-
 static void sba_free_chained_requests(struct sba_request *req)
 {
 	unsigned long flags;
@@ -350,10 +340,6 @@ static void sba_cleanup_nonpending_requests(struct sba_device *sba)
 	list_for_each_entry_safe(req, req1, &sba->reqs_alloc_list, node)
 		_sba_free_request(sba, req);
 
-	/* Freeup all completed request */
-	list_for_each_entry_safe(req, req1, &sba->reqs_completed_list, node)
-		_sba_free_request(sba, req);
-
 	/* Set all active requests as aborted */
 	list_for_each_entry_safe(req, req1, &sba->reqs_active_list, node)
 		_sba_abort_request(sba, req);
@@ -472,20 +458,8 @@ static void sba_process_received_request(struct sba_device *sba,
 			_sba_free_request(sba, nreq);
 		INIT_LIST_HEAD(&first->next);
 
-		/* The client is allowed to attach dependent operations
-		 * until 'ack' is set
-		 */
-		if (!async_tx_test_ack(tx))
-			_sba_complete_request(sba, first);
-		else
-			_sba_free_request(sba, first);
-
-		/* Cleanup completed requests */
-		list_for_each_entry_safe(req, nreq,
-					 &sba->reqs_completed_list, node) {
-			if (async_tx_test_ack(&req->tx))
-				_sba_free_request(sba, req);
-		}
+		/* Free the first request */
+		_sba_free_request(sba, first);
 
 		/* Process pending requests */
 		_sba_process_pending_requests(sba);
@@ -499,13 +473,14 @@ static void sba_write_stats_in_seqfile(struct sba_device *sba,
 {
 	unsigned long flags;
 	struct sba_request *req;
-	u32 free_count = 0, alloced_count = 0, pending_count = 0;
-	u32 active_count = 0, aborted_count = 0, completed_count = 0;
+	u32 free_count = 0, alloced_count = 0;
+	u32 pending_count = 0, active_count = 0, aborted_count = 0;
 
 	spin_lock_irqsave(&sba->reqs_lock, flags);
 
 	list_for_each_entry(req, &sba->reqs_free_list, node)
-		free_count++;
+		if (async_tx_test_ack(&req->tx))
+			free_count++;
 
 	list_for_each_entry(req, &sba->reqs_alloc_list, node)
 		alloced_count++;
@@ -519,9 +494,6 @@ static void sba_write_stats_in_seqfile(struct sba_device *sba,
 	list_for_each_entry(req, &sba->reqs_aborted_list, node)
 		aborted_count++;
 
-	list_for_each_entry(req, &sba->reqs_completed_list, node)
-		completed_count++;
-
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 
 	seq_printf(file, "maximum requests   = %d\n", sba->max_req);
@@ -530,7 +502,6 @@ static void sba_write_stats_in_seqfile(struct sba_device *sba,
 	seq_printf(file, "pending requests   = %d\n", pending_count);
 	seq_printf(file, "active requests    = %d\n", active_count);
 	seq_printf(file, "aborted requests   = %d\n", aborted_count);
-	seq_printf(file, "completed requests = %d\n", completed_count);
 }
 
 /* ====== DMAENGINE callbacks ===== */
@@ -1537,7 +1508,6 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 	INIT_LIST_HEAD(&sba->reqs_alloc_list);
 	INIT_LIST_HEAD(&sba->reqs_pending_list);
 	INIT_LIST_HEAD(&sba->reqs_active_list);
-	INIT_LIST_HEAD(&sba->reqs_completed_list);
 	INIT_LIST_HEAD(&sba->reqs_aborted_list);
 	INIT_LIST_HEAD(&sba->reqs_free_list);
 
@@ -1565,6 +1535,7 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 		}
 		memset(&req->msg, 0, sizeof(req->msg));
 		dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
+		async_tx_ack(&req->tx);
 		req->tx.tx_submit = sba_tx_submit;
 		req->tx.phys = sba->resp_dma_base + i * sba->hw_resp_size;
 		list_add_tail(&req->node, &sba->reqs_free_list);
-- 
2.7.4
