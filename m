From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 26 Jul 2017 11:06:39 +0530
Subject: [PATCH 1/6] dma: bcm-sba-raid: Improve memory allocation in SBA RAID
 driver
In-Reply-To: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
References: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1501047404-14456-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch improves memory allocation in SBA RAID driver in
following ways:
1. Simplify struct sba_request to reduce memory consumption
2. Allocate sba resources before registering dma device

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 439 +++++++++++++++++++++++----------------------
 1 file changed, 226 insertions(+), 213 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index e41bbc7..6d15fed 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -48,7 +48,8 @@
 
 #include "dmaengine.h"
 
-/* SBA command related defines */
+/* ====== Driver macros and defines ===== */
+
 #define SBA_TYPE_SHIFT					48
 #define SBA_TYPE_MASK					GENMASK(1, 0)
 #define SBA_TYPE_A					0x0
@@ -82,39 +83,41 @@
 #define SBA_CMD_WRITE_BUFFER				0xc
 #define SBA_CMD_GALOIS					0xe
 
-/* Driver helper macros */
+#define SBA_MAX_REQ_PER_MBOX_CHANNEL			8192
+
 #define to_sba_request(tx)		\
 	container_of(tx, struct sba_request, tx)
 #define to_sba_device(dchan)		\
 	container_of(dchan, struct sba_device, dma_chan)
 
-enum sba_request_state {
-	SBA_REQUEST_STATE_FREE = 1,
-	SBA_REQUEST_STATE_ALLOCED = 2,
-	SBA_REQUEST_STATE_PENDING = 3,
-	SBA_REQUEST_STATE_ACTIVE = 4,
-	SBA_REQUEST_STATE_RECEIVED = 5,
-	SBA_REQUEST_STATE_COMPLETED = 6,
-	SBA_REQUEST_STATE_ABORTED = 7,
+/* ===== Driver data structures ===== */
+
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
-	unsigned int next_count;
 	atomic_t next_pending_count;
 	/* BRCM message data */
-	void *resp;
-	dma_addr_t resp_dma;
-	struct brcm_sba_command *cmds;
 	struct brcm_message msg;
 	struct dma_async_tx_descriptor tx;
+	/* SBA commands */
+	struct brcm_sba_command cmds[0];
 };
 
 enum sba_version {
@@ -128,11 +131,11 @@ struct sba_device {
 	/* DT configuration parameters */
 	enum sba_version ver;
 	/* Derived configuration parameters */
-	u32 max_req;
 	u32 hw_buf_size;
 	u32 hw_resp_size;
 	u32 max_pq_coefs;
 	u32 max_pq_srcs;
+	u32 max_req;
 	u32 max_cmd_per_req;
 	u32 max_xor_srcs;
 	u32 max_resp_pool_size;
@@ -152,7 +155,6 @@ struct sba_device {
 	void *cmds_base;
 	dma_addr_t cmds_dma_base;
 	spinlock_t reqs_lock;
-	struct sba_request *reqs;
 	bool reqs_fence;
 	struct list_head reqs_alloc_list;
 	struct list_head reqs_pending_list;
@@ -161,10 +163,9 @@ struct sba_device {
 	struct list_head reqs_completed_list;
 	struct list_head reqs_aborted_list;
 	struct list_head reqs_free_list;
-	int reqs_free_count;
 };
 
-/* ====== SBA command helper routines ===== */
+/* ====== Command helper routines ===== */
 
 static inline u64 __pure sba_cmd_enc(u64 cmd, u32 val, u32 shift, u32 mask)
 {
@@ -196,7 +197,7 @@ static inline u32 __pure sba_cmd_pq_c_mdata(u32 d, u32 b1, u32 b0)
 	       ((d & SBA_C_MDATA_DNUM_MASK) << SBA_C_MDATA_DNUM_SHIFT);
 }
 
-/* ====== Channel resource management routines ===== */
+/* ====== General helper routines ===== */
 
 static struct sba_request *sba_alloc_request(struct sba_device *sba)
 {
@@ -204,24 +205,20 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 	struct sba_request *req = NULL;
 
 	spin_lock_irqsave(&sba->reqs_lock, flags);
-
 	req = list_first_entry_or_null(&sba->reqs_free_list,
 				       struct sba_request, node);
-	if (req) {
+	if (req)
 		list_move_tail(&req->node, &sba->reqs_alloc_list);
-		req->state = SBA_REQUEST_STATE_ALLOCED;
-		req->fence = false;
-		req->first = req;
-		INIT_LIST_HEAD(&req->next);
-		req->next_count = 1;
-		atomic_set(&req->next_pending_count, 1);
-
-		sba->reqs_free_count--;
+	spin_unlock_irqrestore(&sba->reqs_lock, flags);
+	if (!req)
+		return NULL;
 
-		dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
-	}
+	req->flags = SBA_REQUEST_STATE_ALLOCED;
+	req->first = req;
+	INIT_LIST_HEAD(&req->next);
+	atomic_set(&req->next_pending_count, 1);
 
-	spin_unlock_irqrestore(&sba->reqs_lock, flags);
+	dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
 
 	return req;
 }
@@ -231,7 +228,8 @@ static void _sba_pending_request(struct sba_device *sba,
 				 struct sba_request *req)
 {
 	lockdep_assert_held(&sba->reqs_lock);
-	req->state = SBA_REQUEST_STATE_PENDING;
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_PENDING;
 	list_move_tail(&req->node, &sba->reqs_pending_list);
 	if (list_empty(&sba->reqs_active_list))
 		sba->reqs_fence = false;
@@ -246,9 +244,10 @@ static bool _sba_active_request(struct sba_device *sba,
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
@@ -258,7 +257,8 @@ static void _sba_abort_request(struct sba_device *sba,
 			       struct sba_request *req)
 {
 	lockdep_assert_held(&sba->reqs_lock);
-	req->state = SBA_REQUEST_STATE_ABORTED;
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_ABORTED;
 	list_move_tail(&req->node, &sba->reqs_aborted_list);
 	if (list_empty(&sba->reqs_active_list))
 		sba->reqs_fence = false;
@@ -269,42 +269,34 @@ static void _sba_free_request(struct sba_device *sba,
 			      struct sba_request *req)
 {
 	lockdep_assert_held(&sba->reqs_lock);
-	req->state = SBA_REQUEST_STATE_FREE;
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_FREE;
 	list_move_tail(&req->node, &sba->reqs_free_list);
 	if (list_empty(&sba->reqs_active_list))
 		sba->reqs_fence = false;
-	sba->reqs_free_count++;
 }
 
-static void sba_received_request(struct sba_request *req)
+/* Note: Must be called with sba->reqs_lock held */
+static void _sba_complete_request(struct sba_device *sba,
+				  struct sba_request *req)
 {
-	unsigned long flags;
-	struct sba_device *sba = req->sba;
-
-	spin_lock_irqsave(&sba->reqs_lock, flags);
-	req->state = SBA_REQUEST_STATE_RECEIVED;
-	list_move_tail(&req->node, &sba->reqs_received_list);
-	spin_unlock_irqrestore(&sba->reqs_lock, flags);
+	lockdep_assert_held(&sba->reqs_lock);
+	req->flags &= ~SBA_REQUEST_STATE_MASK;
+	req->flags |= SBA_REQUEST_STATE_COMPLETED;
+	list_move_tail(&req->node, &sba->reqs_completed_list);
+	if (list_empty(&sba->reqs_active_list))
+		sba->reqs_fence = false;
 }
 
-static void sba_complete_chained_requests(struct sba_request *req)
+/* Note: Must be called with sba->reqs_lock held */
+static void _sba_received_request(struct sba_device *sba,
+				  struct sba_request *req)
 {
-	unsigned long flags;
-	struct sba_request *nreq;
-	struct sba_device *sba = req->sba;
-
-	spin_lock_irqsave(&sba->reqs_lock, flags);
-
-	req->state = SBA_REQUEST_STATE_COMPLETED;
-	list_move_tail(&req->node, &sba->reqs_completed_list);
-	list_for_each_entry(nreq, &req->next, next) {
-		nreq->state = SBA_REQUEST_STATE_COMPLETED;
-		list_move_tail(&nreq->node, &sba->reqs_completed_list);
-	}
+	lockdep_assert_held(&sba->reqs_lock);
+	req->flags = SBA_REQUEST_STATE_RECEIVED;
+	list_move_tail(&req->node, &sba->reqs_received_list);
 	if (list_empty(&sba->reqs_active_list))
 		sba->reqs_fence = false;
-
-	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 }
 
 static void sba_free_chained_requests(struct sba_request *req)
@@ -332,8 +324,7 @@ static void sba_chain_request(struct sba_request *first,
 
 	list_add_tail(&req->next, &first->next);
 	req->first = first;
-	first->next_count++;
-	atomic_set(&first->next_pending_count, first->next_count);
+	atomic_inc(&first->next_pending_count);
 
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 }
@@ -383,26 +374,6 @@ static void sba_cleanup_pending_requests(struct sba_device *sba)
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 }
 
-/* ====== DMAENGINE callbacks ===== */
-
-static void sba_free_chan_resources(struct dma_chan *dchan)
-{
-	/*
-	 * Channel resources are pre-alloced so we just free-up
-	 * whatever we can so that we can re-use pre-alloced
-	 * channel resources next time.
-	 */
-	sba_cleanup_nonpending_requests(to_sba_device(dchan));
-}
-
-static int sba_device_terminate_all(struct dma_chan *dchan)
-{
-	/* Cleanup all pending requests */
-	sba_cleanup_pending_requests(to_sba_device(dchan));
-
-	return 0;
-}
-
 static int sba_send_mbox_request(struct sba_device *sba,
 				 struct sba_request *req)
 {
@@ -428,17 +399,27 @@ static int sba_send_mbox_request(struct sba_device *sba,
 	return 0;
 }
 
-static void sba_issue_pending(struct dma_chan *dchan)
+static void sba_process_deferred_requests(struct sba_device *sba)
 {
 	int ret;
+	u32 count;
 	unsigned long flags;
-	struct sba_request *req, *req1;
-	struct sba_device *sba = to_sba_device(dchan);
+	struct sba_request *req;
+	struct dma_async_tx_descriptor *tx;
 
 	spin_lock_irqsave(&sba->reqs_lock, flags);
 
-	/* Process all pending request */
-	list_for_each_entry_safe(req, req1, &sba->reqs_pending_list, node) {
+	/* Count pending requests */
+	count = 0;
+	list_for_each_entry(req, &sba->reqs_pending_list, node)
+		count++;
+
+	/* Process pending requests */
+	while (!list_empty(&sba->reqs_pending_list) && count) {
+		/* Get the first pending request */
+		req = list_first_entry(&sba->reqs_pending_list,
+				       struct sba_request, node);
+
 		/* Try to make request active */
 		if (!_sba_active_request(sba, req))
 			break;
@@ -453,11 +434,102 @@ static void sba_issue_pending(struct dma_chan *dchan)
 			_sba_pending_request(sba, req);
 			break;
 		}
+
+		count--;
 	}
 
+	/* Count completed requests */
+	count = 0;
+	list_for_each_entry(req, &sba->reqs_completed_list, node)
+		count++;
+
+	/* Process completed requests */
+	while (!list_empty(&sba->reqs_completed_list) && count) {
+		req = list_first_entry(&sba->reqs_completed_list,
+					struct sba_request, node);
+		list_del_init(&req->node);
+		tx = &req->tx;
+
+		spin_unlock_irqrestore(&sba->reqs_lock, flags);
+
+		WARN_ON(tx->cookie < 0);
+		if (tx->cookie > 0) {
+			dma_cookie_complete(tx);
+			dmaengine_desc_get_callback_invoke(tx, NULL);
+			dma_descriptor_unmap(tx);
+			tx->callback = NULL;
+			tx->callback_result = NULL;
+		}
+
+		dma_run_dependencies(tx);
+
+		spin_lock_irqsave(&sba->reqs_lock, flags);
+
+		/* If waiting for 'ack' then move to completed list */
+		if (!async_tx_test_ack(&req->tx))
+			_sba_complete_request(sba, req);
+		else
+			_sba_free_request(sba, req);
+
+		count--;
+	}
+
+	/* Re-check pending and completed work */
+	count = 0;
+	if (!list_empty(&sba->reqs_pending_list) ||
+	    !list_empty(&sba->reqs_completed_list))
+		count = 1;
+
 	spin_unlock_irqrestore(&sba->reqs_lock, flags);
 }
 
+static void sba_process_received_request(struct sba_device *sba,
+					 struct sba_request *req)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sba->reqs_lock, flags);
+
+	/* Mark request as received */
+	_sba_received_request(sba, req);
+
+	/* Update request */
+	if (!atomic_dec_return(&req->first->next_pending_count))
+		_sba_complete_request(sba, req->first);
+	if (req->first != req)
+		_sba_free_request(sba, req);
+
+	spin_unlock_irqrestore(&sba->reqs_lock, flags);
+}
+
+/* ====== DMAENGINE callbacks ===== */
+
+static void sba_free_chan_resources(struct dma_chan *dchan)
+{
+	/*
+	 * Channel resources are pre-alloced so we just free-up
+	 * whatever we can so that we can re-use pre-alloced
+	 * channel resources next time.
+	 */
+	sba_cleanup_nonpending_requests(to_sba_device(dchan));
+}
+
+static int sba_device_terminate_all(struct dma_chan *dchan)
+{
+	/* Cleanup all pending requests */
+	sba_cleanup_pending_requests(to_sba_device(dchan));
+
+	return 0;
+}
+
+static void sba_issue_pending(struct dma_chan *dchan)
+{
+	struct sba_device *sba = to_sba_device(dchan);
+
+	/* Process deferred requests */
+	sba_process_deferred_requests(sba);
+}
+
 static dma_cookie_t sba_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	unsigned long flags;
@@ -506,6 +578,7 @@ static void sba_fillup_interrupt_msg(struct sba_request *req,
 {
 	u64 cmd;
 	u32 c_mdata;
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	/* Type-B command to load dummy data into buf0 */
@@ -521,7 +594,7 @@ static void sba_fillup_interrupt_msg(struct sba_request *req,
 	cmdsp->cmd = cmd;
 	*cmdsp->cmd_dma = cpu_to_le64(cmd);
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_B;
-	cmdsp->data = req->resp_dma;
+	cmdsp->data = resp_dma;
 	cmdsp->data_len = req->sba->hw_resp_size;
 	cmdsp++;
 
@@ -542,11 +615,11 @@ static void sba_fillup_interrupt_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
-	cmdsp->data = req->resp_dma;
+	cmdsp->data = resp_dma;
 	cmdsp->data_len = req->sba->hw_resp_size;
 	cmdsp++;
 
@@ -573,7 +646,7 @@ sba_prep_dma_interrupt(struct dma_chan *dchan, unsigned long flags)
 	 * Force fence so that no requests are submitted
 	 * until DMA callback for this request is invoked.
 	 */
-	req->fence = true;
+	req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request message */
 	sba_fillup_interrupt_msg(req, req->cmds, &req->msg);
@@ -593,6 +666,7 @@ static void sba_fillup_memcpy_msg(struct sba_request *req,
 {
 	u64 cmd;
 	u32 c_mdata;
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	/* Type-B command to load data into buf0 */
@@ -629,7 +703,7 @@ static void sba_fillup_memcpy_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -656,7 +730,8 @@ sba_prep_dma_memcpy_req(struct sba_device *sba,
 	req = sba_alloc_request(sba);
 	if (!req)
 		return NULL;
-	req->fence = (flags & DMA_PREP_FENCE) ? true : false;
+	if (flags & DMA_PREP_FENCE)
+		req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request message */
 	sba_fillup_memcpy_msg(req, req->cmds, &req->msg,
@@ -711,6 +786,7 @@ static void sba_fillup_xor_msg(struct sba_request *req,
 	u64 cmd;
 	u32 c_mdata;
 	unsigned int i;
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	/* Type-B command to load data into buf0 */
@@ -766,7 +842,7 @@ static void sba_fillup_xor_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -793,7 +869,8 @@ sba_prep_dma_xor_req(struct sba_device *sba,
 	req = sba_alloc_request(sba);
 	if (!req)
 		return NULL;
-	req->fence = (flags & DMA_PREP_FENCE) ? true : false;
+	if (flags & DMA_PREP_FENCE)
+		req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request message */
 	sba_fillup_xor_msg(req, req->cmds, &req->msg,
@@ -854,6 +931,7 @@ static void sba_fillup_pq_msg(struct sba_request *req,
 	u64 cmd;
 	u32 c_mdata;
 	unsigned int i;
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	if (pq_continue) {
@@ -947,7 +1025,7 @@ static void sba_fillup_pq_msg(struct sba_request *req,
 		cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 		if (req->sba->hw_resp_size) {
 			cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-			cmdsp->resp = req->resp_dma;
+			cmdsp->resp = resp_dma;
 			cmdsp->resp_len = req->sba->hw_resp_size;
 		}
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -974,7 +1052,7 @@ static void sba_fillup_pq_msg(struct sba_request *req,
 		cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 		if (req->sba->hw_resp_size) {
 			cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-			cmdsp->resp = req->resp_dma;
+			cmdsp->resp = resp_dma;
 			cmdsp->resp_len = req->sba->hw_resp_size;
 		}
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -1002,7 +1080,8 @@ sba_prep_dma_pq_req(struct sba_device *sba, dma_addr_t off,
 	req = sba_alloc_request(sba);
 	if (!req)
 		return NULL;
-	req->fence = (flags & DMA_PREP_FENCE) ? true : false;
+	if (flags & DMA_PREP_FENCE)
+		req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request messages */
 	sba_fillup_pq_msg(req, dmaf_continue(flags),
@@ -1027,6 +1106,7 @@ static void sba_fillup_pq_single_msg(struct sba_request *req,
 	u64 cmd;
 	u32 c_mdata;
 	u8 pos, dpos = raid6_gflog[scf];
+	dma_addr_t resp_dma = req->tx.phys;
 	struct brcm_sba_command *cmdsp = cmds;
 
 	if (!dst_p)
@@ -1105,7 +1185,7 @@ static void sba_fillup_pq_single_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -1226,7 +1306,7 @@ static void sba_fillup_pq_single_msg(struct sba_request *req,
 	cmdsp->flags = BRCM_SBA_CMD_TYPE_A;
 	if (req->sba->hw_resp_size) {
 		cmdsp->flags |= BRCM_SBA_CMD_HAS_RESP;
-		cmdsp->resp = req->resp_dma;
+		cmdsp->resp = resp_dma;
 		cmdsp->resp_len = req->sba->hw_resp_size;
 	}
 	cmdsp->flags |= BRCM_SBA_CMD_HAS_OUTPUT;
@@ -1255,7 +1335,8 @@ sba_prep_dma_pq_single_req(struct sba_device *sba, dma_addr_t off,
 	req = sba_alloc_request(sba);
 	if (!req)
 		return NULL;
-	req->fence = (flags & DMA_PREP_FENCE) ? true : false;
+	if (flags & DMA_PREP_FENCE)
+		req->flags |= SBA_REQUEST_FENCE;
 
 	/* Fillup request messages */
 	sba_fillup_pq_single_msg(req,  dmaf_continue(flags),
@@ -1370,40 +1451,10 @@ sba_prep_dma_pq(struct dma_chan *dchan, dma_addr_t *dst, dma_addr_t *src,
 
 /* ====== Mailbox callbacks ===== */
 
-static void sba_dma_tx_actions(struct sba_request *req)
-{
-	struct dma_async_tx_descriptor *tx = &req->tx;
-
-	WARN_ON(tx->cookie < 0);
-
-	if (tx->cookie > 0) {
-		dma_cookie_complete(tx);
-
-		/*
-		 * Call the callback (must not sleep or submit new
-		 * operations to this channel)
-		 */
-		if (tx->callback)
-			tx->callback(tx->callback_param);
-
-		dma_descriptor_unmap(tx);
-	}
-
-	/* Run dependent operations */
-	dma_run_dependencies(tx);
-
-	/* If waiting for 'ack' then move to completed list */
-	if (!async_tx_test_ack(&req->tx))
-		sba_complete_chained_requests(req);
-	else
-		sba_free_chained_requests(req);
-}
-
 static void sba_receive_message(struct mbox_client *cl, void *msg)
 {
-	unsigned long flags;
 	struct brcm_message *m = msg;
-	struct sba_request *req = m->ctx, *req1;
+	struct sba_request *req = m->ctx;
 	struct sba_device *sba = req->sba;
 
 	/* Error count if message has error */
@@ -1411,36 +1462,11 @@ static void sba_receive_message(struct mbox_client *cl, void *msg)
 		dev_err(sba->dev, "%s got message with error %d",
 			dma_chan_name(&sba->dma_chan), m->error);
 
-	/* Mark request as received */
-	sba_received_request(req);
-
-	/* Wait for all chained requests to be completed */
-	if (atomic_dec_return(&req->first->next_pending_count))
-		goto done;
-
-	/* Point to first request */
-	req = req->first;
-
-	/* Update request */
-	if (req->state == SBA_REQUEST_STATE_RECEIVED)
-		sba_dma_tx_actions(req);
-	else
-		sba_free_chained_requests(req);
-
-	spin_lock_irqsave(&sba->reqs_lock, flags);
-
-	/* Re-check all completed request waiting for 'ack' */
-	list_for_each_entry_safe(req, req1, &sba->reqs_completed_list, node) {
-		spin_unlock_irqrestore(&sba->reqs_lock, flags);
-		sba_dma_tx_actions(req);
-		spin_lock_irqsave(&sba->reqs_lock, flags);
-	}
-
-	spin_unlock_irqrestore(&sba->reqs_lock, flags);
+	/* Process received request */
+	sba_process_received_request(sba, req);
 
-done:
-	/* Try to submit pending request */
-	sba_issue_pending(&sba->dma_chan);
+	/* Process deferred requests */
+	sba_process_deferred_requests(sba);
 }
 
 /* ====== Platform driver routines ===== */
@@ -1450,13 +1476,13 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 	int i, j, p, ret = 0;
 	struct sba_request *req = NULL;
 
-	sba->resp_base = dma_alloc_coherent(sba->dma_dev.dev,
+	sba->resp_base = dma_alloc_coherent(sba->mbox_dev,
 					    sba->max_resp_pool_size,
 					    &sba->resp_dma_base, GFP_KERNEL);
 	if (!sba->resp_base)
 		return -ENOMEM;
 
-	sba->cmds_base = dma_alloc_coherent(sba->dma_dev.dev,
+	sba->cmds_base = dma_alloc_coherent(sba->mbox_dev,
 					    sba->max_cmds_pool_size,
 					    &sba->cmds_dma_base, GFP_KERNEL);
 	if (!sba->cmds_base) {
@@ -1474,31 +1500,21 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 	INIT_LIST_HEAD(&sba->reqs_aborted_list);
 	INIT_LIST_HEAD(&sba->reqs_free_list);
 
-	sba->reqs = devm_kcalloc(sba->dev, sba->max_req,
-				 sizeof(*req), GFP_KERNEL);
-	if (!sba->reqs) {
-		ret = -ENOMEM;
-		goto fail_free_cmds_pool;
-	}
-
 	for (i = 0, p = 0; i < sba->max_req; i++) {
-		req = &sba->reqs[i];
+		req = devm_kzalloc(sba->dev,
+				sizeof(*req) +
+				sba->max_cmd_per_req * sizeof(req->cmds[0]),
+				GFP_KERNEL);
+		if (!req) {
+			ret = -ENOMEM;
+			goto fail_free_cmds_pool;
+		}
 		INIT_LIST_HEAD(&req->node);
 		req->sba = sba;
-		req->state = SBA_REQUEST_STATE_FREE;
+		req->flags = SBA_REQUEST_STATE_FREE;
 		INIT_LIST_HEAD(&req->next);
-		req->next_count = 1;
 		atomic_set(&req->next_pending_count, 0);
-		req->fence = false;
-		req->resp = sba->resp_base + p;
-		req->resp_dma = sba->resp_dma_base + p;
 		p += sba->hw_resp_size;
-		req->cmds = devm_kcalloc(sba->dev, sba->max_cmd_per_req,
-					 sizeof(*req->cmds), GFP_KERNEL);
-		if (!req->cmds) {
-			ret = -ENOMEM;
-			goto fail_free_cmds_pool;
-		}
 		for (j = 0; j < sba->max_cmd_per_req; j++) {
 			req->cmds[j].cmd = 0;
 			req->cmds[j].cmd_dma = sba->cmds_base +
@@ -1510,20 +1526,18 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 		memset(&req->msg, 0, sizeof(req->msg));
 		dma_async_tx_descriptor_init(&req->tx, &sba->dma_chan);
 		req->tx.tx_submit = sba_tx_submit;
-		req->tx.phys = req->resp_dma;
+		req->tx.phys = sba->resp_dma_base + i * sba->hw_resp_size;
 		list_add_tail(&req->node, &sba->reqs_free_list);
 	}
 
-	sba->reqs_free_count = sba->max_req;
-
 	return 0;
 
 fail_free_cmds_pool:
-	dma_free_coherent(sba->dma_dev.dev,
+	dma_free_coherent(sba->mbox_dev,
 			  sba->max_cmds_pool_size,
 			  sba->cmds_base, sba->cmds_dma_base);
 fail_free_resp_pool:
-	dma_free_coherent(sba->dma_dev.dev,
+	dma_free_coherent(sba->mbox_dev,
 			  sba->max_resp_pool_size,
 			  sba->resp_base, sba->resp_dma_base);
 	return ret;
@@ -1532,9 +1546,9 @@ static int sba_prealloc_channel_resources(struct sba_device *sba)
 static void sba_freeup_channel_resources(struct sba_device *sba)
 {
 	dmaengine_terminate_all(&sba->dma_chan);
-	dma_free_coherent(sba->dma_dev.dev, sba->max_cmds_pool_size,
+	dma_free_coherent(sba->mbox_dev, sba->max_cmds_pool_size,
 			  sba->cmds_base, sba->cmds_dma_base);
-	dma_free_coherent(sba->dma_dev.dev, sba->max_resp_pool_size,
+	dma_free_coherent(sba->mbox_dev, sba->max_resp_pool_size,
 			  sba->resp_base, sba->resp_dma_base);
 	sba->resp_base = NULL;
 	sba->resp_dma_base = 0;
@@ -1625,6 +1639,13 @@ static int sba_probe(struct platform_device *pdev)
 	sba->dev = &pdev->dev;
 	platform_set_drvdata(pdev, sba);
 
+	/* Number of channels equals number of mailbox channels */
+	ret = of_count_phandle_with_args(pdev->dev.of_node,
+					 "mboxes", "#mbox-cells");
+	if (ret <= 0)
+		return -ENODEV;
+	mchans_count = ret;
+
 	/* Determine SBA version from DT compatible string */
 	if (of_device_is_compatible(sba->dev->of_node, "brcm,iproc-sba"))
 		sba->ver = SBA_VER_1;
@@ -1637,14 +1658,12 @@ static int sba_probe(struct platform_device *pdev)
 	/* Derived Configuration parameters */
 	switch (sba->ver) {
 	case SBA_VER_1:
-		sba->max_req = 1024;
 		sba->hw_buf_size = 4096;
 		sba->hw_resp_size = 8;
 		sba->max_pq_coefs = 6;
 		sba->max_pq_srcs = 6;
 		break;
 	case SBA_VER_2:
-		sba->max_req = 1024;
 		sba->hw_buf_size = 4096;
 		sba->hw_resp_size = 8;
 		sba->max_pq_coefs = 30;
@@ -1658,6 +1677,7 @@ static int sba_probe(struct platform_device *pdev)
 	default:
 		return -EINVAL;
 	}
+	sba->max_req = SBA_MAX_REQ_PER_MBOX_CHANNEL * mchans_count;
 	sba->max_cmd_per_req = sba->max_pq_srcs + 3;
 	sba->max_xor_srcs = sba->max_cmd_per_req - 1;
 	sba->max_resp_pool_size = sba->max_req * sba->hw_resp_size;
@@ -1671,22 +1691,14 @@ static int sba_probe(struct platform_device *pdev)
 	sba->client.knows_txdone	= false;
 	sba->client.tx_tout		= 0;
 
-	/* Number of channels equals number of mailbox channels */
-	ret = of_count_phandle_with_args(pdev->dev.of_node,
-					 "mboxes", "#mbox-cells");
-	if (ret <= 0)
-		return -ENODEV;
-	mchans_count = ret;
-	sba->mchans_count = 0;
-	atomic_set(&sba->mchans_current, 0);
-
 	/* Allocate mailbox channel array */
-	sba->mchans = devm_kcalloc(&pdev->dev, sba->mchans_count,
+	sba->mchans = devm_kcalloc(&pdev->dev, mchans_count,
 				   sizeof(*sba->mchans), GFP_KERNEL);
 	if (!sba->mchans)
 		return -ENOMEM;
 
 	/* Request mailbox channels */
+	sba->mchans_count = 0;
 	for (i = 0; i < mchans_count; i++) {
 		sba->mchans[i] = mbox_request_channel(&sba->client, i);
 		if (IS_ERR(sba->mchans[i])) {
@@ -1695,6 +1707,7 @@ static int sba_probe(struct platform_device *pdev)
 		}
 		sba->mchans_count++;
 	}
+	atomic_set(&sba->mchans_current, 0);
 
 	/* Find-out underlying mailbox device */
 	ret = of_parse_phandle_with_args(pdev->dev.of_node,
@@ -1723,15 +1736,15 @@ static int sba_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Register DMA device with linux async framework */
-	ret = sba_async_register(sba);
+	/* Prealloc channel resource */
+	ret = sba_prealloc_channel_resources(sba);
 	if (ret)
 		goto fail_free_mchans;
 
-	/* Prealloc channel resource */
-	ret = sba_prealloc_channel_resources(sba);
+	/* Register DMA device with linux async framework */
+	ret = sba_async_register(sba);
 	if (ret)
-		goto fail_async_dev_unreg;
+		goto fail_free_resources;
 
 	/* Print device info */
 	dev_info(sba->dev, "%s using SBAv%d and %d mailbox channels",
@@ -1740,8 +1753,8 @@ static int sba_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail_async_dev_unreg:
-	dma_async_device_unregister(&sba->dma_dev);
+fail_free_resources:
+	sba_freeup_channel_resources(sba);
 fail_free_mchans:
 	for (i = 0; i < sba->mchans_count; i++)
 		mbox_free_channel(sba->mchans[i]);
@@ -1753,10 +1766,10 @@ static int sba_remove(struct platform_device *pdev)
 	int i;
 	struct sba_device *sba = platform_get_drvdata(pdev);
 
-	sba_freeup_channel_resources(sba);
-
 	dma_async_device_unregister(&sba->dma_dev);
 
+	sba_freeup_channel_resources(sba);
+
 	for (i = 0; i < sba->mchans_count; i++)
 		mbox_free_channel(sba->mchans[i]);
 
-- 
2.7.4
