From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:52 +0530
Subject: [PATCH v3 03/17] dmaengine: bcm-sba-raid: Common flags for
 sba_request state and fence
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch merges sba_request state and fence into common
sba_request flags. The sba_request flags not only saves
memory but it can also be extended in-future without adding
new members.

We also make each sba_request state as separate bit in
sba_request flags to help debugging situations where a
sba_request is accidently in two states.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 66 ++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index f81d5ac..6fa3df1 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -91,22 +91,23 @@
 
 /* ===== Driver data structures ===== */
 
-enum sba_request_state {
-	SBA_REQUEST_STATE_FREE = 1,
-	SBA_REQUEST_STATE_ALLOCED = 2,
-	SBA_REQUEST_STATE_PENDING = 3,
-	SBA_REQUEST_STATE_ACTIVE = 4,
-	SBA_REQUEST_STATE_RECEIVED = 5,
-	SBA_REQUEST_STATE_COMPLETED = 6,
-	SBA_REQUEST_STATE_ABORTED = 7,
+enum sba_request_flags {
+	SBA_REQUEST_STATE_FREE		= 0x001,
+	SBA_REQUEST_STATE_ALLOCED	= 0x002,
+	SBA_REQUEST_STATE_PENDING	= 0x004,
+	SBA_REQUEST_STATE_ACTIVE	= 0x008,
+	SBA_REQUEST_STATE_RECEIVED	= 0x010,
+	SBA_REQUEST_STATE_COMPLETED	= 0x020,
+	SBA_REQUEST_STATE_ABORTED	= 0x040,
+	SBA_REQUEST_STATE_MASK		= 0x0ff,
+	SBA_REQUEST_FENCE		= 0x100,
 };
 
 struct sba_request {
 	/* Global state */
 	struct list_head node;
 	struct sba_device *sba;
-	enum sba_request_state state;
-	bool fence;
+	u32 flags;
 	/* Chained requests management */
 	struct sba_request *first;
 	struct list_head next;
@@ -217,8 +218,7 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 	if (!req)
 		return NULL;
 
-	req->state = SBA_REQUEST_STATE_ALLOCED;
-	req->fence = false;
+	req->flags = SBA_REQUEST_STATE_ALLOCED;
 	req->first = req;
 	INIT_LIST_HEAD(&req->next);
 	req->next_count = 1;
@@ -234,7 +234,8 @@ static void _sba_pending_request(struct sba_device *sba,
 				 struct sba_request *req)
 {
 	lockdep_assert_held(&sba->reqs_lock);
-	req->state = SBA_REQUEST_STATE_PENDING;
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_PENDING;
 	list_move_tail(&req->node, &sba->reqs_pending_list);
 	if (list_empty(&sba->reqs_active_list))
 		sba->reqs_fence = false;
@@ -249,9 +250,10 @@ static bool _sba_active_request(struct sba_device *sba,
 		sba->reqs_fence = false;
 	if (sba->reqs_fence)
 		return false;
-	req->state = SBA_REQUEST_STATE_ACTIVE;
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_ACTIVE;
 	list_move_tail(&req->node, &sba->reqs_active_list);
-	if (req->fence)
+	if (req->flags & SBA_REQUEST_FENCE)
 		sba->reqs_fence = true;
 	return true;
 }
@@ -261,7 +263,8 @@ static void _sba_abort_request(struct sba_device *sba,
 			       struct sba_request *req)
 {
 	lockdep_assert_held(&sba->reqs_lock);
-	req->state = SBA_REQUEST_STATE_ABORTED;
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_ABORTED;
 	list_move_tail(&req->node, &sba->reqs_aborted_list);
 	if (list_empty(&sba->reqs_active_list))
 		sba->reqs_fence = false;
@@ -272,7 +275,8 @@ static void _sba_free_request(struct sba_device *sba,
 			      struct sba_request *req)
 {
 	lockdep_assert_held(&sba->reqs_lock);
-	req->state = SBA_REQUEST_STATE_FREE;
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_FREE;
 	list_move_tail(&req->node, &sba->reqs_free_list);
 	if (list_empty(&sba->reqs_active_list))
 		sba->reqs_fence = false;
@@ -285,7 +289,8 @@ static void sba_received_request(struct sba_request *req)
 	struct sba_device *sba = req->sba;
 
 	spin_lock_irqsave(&sba->reqs_lock, flags);
-	req->state = SBA_REQUEST_STATE_RECEIVED;
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_RECEIVED;
 	list_move_tail(&req->node, &sba->reqs_received_list);
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 }
@@ -298,10 +303,12 @@ static void sba_complete_chained_requests(struct sba_request *req)
 
 	spin_lock_irqsave(&sba->reqs_lock, flags);
 
-	req->state = SBA_REQUEST_STATE_COMPLETED;
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_COMPLETED;
 	list_move_tail(&req->node, &sba->reqs_completed_list);
 	list_for_each_entry(nreq, &req->next, next) {
-		nreq->state = SBA_REQUEST_STATE_COMPLETED;
+		nreq->flags &= ~SBA_REQUEST_STATE_MASK;
+		nreq->flags |= SBA_REQUEST_STATE_COMPLETED;
 		list_move_tail(&nreq->node, &sba->reqs_completed_list);
 	}
 	if (list_empty(&sba->reqs_active_list))
@@ -576,7 +583,7 @@ sba_prep_dma_interrupt(struct dma_chan *dchan, unsigned long flags)
 	 * Force fence so that no requests are submitted
 	 * until DMA callback for this request is invoked.
 	 */
-	req->fence = true;
+	req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request message */
 	sba_fillup_interrupt_msg(req, req->cmds, &req->msg);
@@ -659,7 +666,8 @@ sba_prep_dma_memcpy_req(struct sba_device *sba,
 	req = sba_alloc_request(sba);
 	if (!req)
 		return NULL;
-	req->fence = (flags & DMA_PREP_FENCE) ? true : false;
+	if (flags & DMA_PREP_FENCE)
+		req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request message */
 	sba_fillup_memcpy_msg(req, req->cmds, &req->msg,
@@ -796,7 +804,8 @@ sba_prep_dma_xor_req(struct sba_device *sba,
 	req = sba_alloc_request(sba);
 	if (!req)
 		return NULL;
-	req->fence = (flags & DMA_PREP_FENCE) ? true : false;
+	if (flags & DMA_PREP_FENCE)
+		req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request message */
 	sba_fillup_xor_msg(req, req->cmds, &req->msg,
@@ -1005,7 +1014,8 @@ sba_prep_dma_pq_req(struct sba_device *sba, dma_addr_t off,
 	req = sba_alloc_request(sba);
 	if (!req)
 		return NULL;
-	req->fence = (flags & DMA_PREP_FENCE) ? true : false;
+	if (flags & DMA_PREP_FENCE)
+		req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request messages */
 	sba_fillup_pq_msg(req, dmaf_continue(flags),
@@ -1258,7 +1268,8 @@ sba_prep_dma_pq_single_req(struct sba_device *sba, dma_addr_t off,
 	req = sba_alloc_request(sba);
 	if (!req)
 		return NULL;
-	req->fence = (flags & DMA_PREP_FENCE) ? true : false;
+	if (flags & DMA_PREP_FENCE)
+		req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request messages */
 	sba_fillup_pq_single_msg(req,  dmaf_continue(flags),
@@ -1425,7 +1436,7 @@ static void sba_receive_message(struct mbox_client *cl, void *msg)
 	req = req->first;
 
 	/* Update request */
-	if (req->state == SBA_REQUEST_STATE_RECEIVED)
+	if (req->flags & SBA_REQUEST_STATE_RECEIVED)
 		sba_dma_tx_actions(req);
 	else
 		sba_free_chained_requests(req);
@@ -1488,11 +1499,10 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 		req = &sba->reqs[i];
 		INIT_LIST_HEAD(&req->node);
 		req->sba = sba;
-		req->state = SBA_REQUEST_STATE_FREE;
+		req->flags = SBA_REQUEST_STATE_FREE;
 		INIT_LIST_HEAD(&req->next);
 		req->next_count = 1;
 		atomic_set(&req->next_pending_count, 0);
-		req->fence = false;
 		req->resp = sba->resp_base + p;
 		req->resp_dma = sba->resp_dma_base + p;
 		p += sba->hw_resp_size;
-- 
2.7.4
