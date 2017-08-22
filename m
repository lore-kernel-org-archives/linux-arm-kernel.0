From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:27:03 +0530
Subject: [PATCH v3 14/17] dmaengine: bcm-sba-raid: Remove redundant
 SBA_REQUEST_STATE_RECEIVED
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-15-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SBA_REQUEST_STATE_RECEIVED state is now redundant because
received sba_request are immediately freed or moved to completed
list in sba_process_received_request().

This patch removes redundant SBA_REQUEST_STATE_RECEIVED state.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index cb6b2e2..f0a0e80 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -98,9 +98,8 @@ enum sba_request_flags {
 	SBA_REQUEST_STATE_ALLOCED	= 0x002,
 	SBA_REQUEST_STATE_PENDING	= 0x004,
 	SBA_REQUEST_STATE_ACTIVE	= 0x008,
-	SBA_REQUEST_STATE_RECEIVED	= 0x010,
-	SBA_REQUEST_STATE_COMPLETED	= 0x020,
-	SBA_REQUEST_STATE_ABORTED	= 0x040,
+	SBA_REQUEST_STATE_COMPLETED	= 0x010,
+	SBA_REQUEST_STATE_ABORTED	= 0x020,
 	SBA_REQUEST_STATE_MASK		= 0x0ff,
 	SBA_REQUEST_FENCE		= 0x100,
 };
@@ -160,7 +159,6 @@ struct sba_device {
 	struct list_head reqs_alloc_list;
 	struct list_head reqs_pending_list;
 	struct list_head reqs_active_list;
-	struct list_head reqs_received_list;
 	struct list_head reqs_completed_list;
 	struct list_head reqs_aborted_list;
 	struct list_head reqs_free_list;
@@ -307,18 +305,6 @@ static void _sba_complete_request(struct sba_device *sba,
 		sba->reqs_fence = false;
 }
 
-/* Note: Must be called with sba->reqs_lock held */
-static void _sba_received_request(struct sba_device *sba,
-				  struct sba_request *req)
-{
-	lockdep_assert_held(&sba->reqs_lock);
-	req->flags &= ~SBA_REQUEST_STATE_MASK;
-	req->flags |= SBA_REQUEST_STATE_RECEIVED;
-	list_move_tail(&req->node, &sba->reqs_received_list);
-	if (list_empty(&sba->reqs_active_list))
-		sba->reqs_fence = false;
-}
-
 static void sba_free_chained_requests(struct sba_request *req)
 {
 	unsigned long flags;
@@ -360,10 +346,6 @@ static void sba_cleanup_nonpending_requests(struct sba_device *sba)
 	list_for_each_entry_safe(req, req1, &sba->reqs_alloc_list, node)
 		_sba_free_request(sba, req);
 
-	/* Freeup all received request */
-	list_for_each_entry_safe(req, req1, &sba->reqs_received_list, node)
-		_sba_free_request(sba, req);
-
 	/* Freeup all completed request */
 	list_for_each_entry_safe(req, req1, &sba->reqs_completed_list, node)
 		_sba_free_request(sba, req);
@@ -482,9 +464,6 @@ static void sba_process_received_request(struct sba_device *sba,
 			_sba_free_request(sba, nreq);
 		INIT_LIST_HEAD(&first->next);
 
-		/* Mark request as received */
-		_sba_received_request(sba, first);
-
 		/* The client is allowed to attach dependent operations
 		 * until 'ack' is set
 		 */
@@ -1498,7 +1477,6 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 	INIT_LIST_HEAD(&sba->reqs_alloc_list);
 	INIT_LIST_HEAD(&sba->reqs_pending_list);
 	INIT_LIST_HEAD(&sba->reqs_active_list);
-	INIT_LIST_HEAD(&sba->reqs_received_list);
 	INIT_LIST_HEAD(&sba->reqs_completed_list);
 	INIT_LIST_HEAD(&sba->reqs_aborted_list);
 	INIT_LIST_HEAD(&sba->reqs_free_list);
-- 
2.7.4
