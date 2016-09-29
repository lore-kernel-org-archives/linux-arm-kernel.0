From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Sep 2016 22:12:42 -0400
Subject: [PATCH V4 05/10] dmaengine: qcom_hidma: make pending_tre_count atomic
In-Reply-To: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475115167-5898-6-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Getting ready for the MSI interrupts. The pending_tre_count is used
in the interrupt handler to make sure all outstanding requests are
serviced.

Making it atomic so that it can be updated from multiple contexts.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.h     |  2 +-
 drivers/dma/qcom/hidma_dbg.c |  3 ++-
 drivers/dma/qcom/hidma_ll.c  | 13 ++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index e52e207..3f2ddd4 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -58,7 +58,7 @@ struct hidma_lldev {
 	void __iomem *evca;		/* Event Channel address          */
 	struct hidma_tre
 		**pending_tre_list;	/* Pointers to pending TREs	  */
-	s32 pending_tre_count;		/* Number of TREs pending	  */
+	atomic_t pending_tre_count;	/* Number of TREs pending	  */
 
 	void *tre_ring;			/* TRE ring			  */
 	dma_addr_t tre_dma;		/* TRE ring to be shared with HW  */
diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
index fa827e5..87db285 100644
--- a/drivers/dma/qcom/hidma_dbg.c
+++ b/drivers/dma/qcom/hidma_dbg.c
@@ -74,7 +74,8 @@ static void hidma_ll_devstats(struct seq_file *s, void *llhndl)
 	seq_printf(s, "tre_ring_handle=%pap\n", &lldev->tre_dma);
 	seq_printf(s, "tre_ring_size = 0x%x\n", lldev->tre_ring_size);
 	seq_printf(s, "tre_processed_off = 0x%x\n", lldev->tre_processed_off);
-	seq_printf(s, "pending_tre_count=%d\n", lldev->pending_tre_count);
+	seq_printf(s, "pending_tre_count=%d\n",
+			atomic_read(&lldev->pending_tre_count));
 	seq_printf(s, "evca=%p\n", lldev->evca);
 	seq_printf(s, "evre_ring=%p\n", lldev->evre_ring);
 	seq_printf(s, "evre_ring_handle=%pap\n", &lldev->evre_dma);
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 3224f24..29fef4f 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -218,10 +218,9 @@ static int hidma_post_completed(struct hidma_lldev *lldev, int tre_iterator,
 	 * Keep track of pending TREs that SW is expecting to receive
 	 * from HW. We got one now. Decrement our counter.
 	 */
-	lldev->pending_tre_count--;
-	if (lldev->pending_tre_count < 0) {
+	if (atomic_dec_return(&lldev->pending_tre_count) < 0) {
 		dev_warn(lldev->dev, "tre count mismatch on completion");
-		lldev->pending_tre_count = 0;
+		atomic_set(&lldev->pending_tre_count, 0);
 	}
 
 	spin_unlock_irqrestore(&lldev->lock, flags);
@@ -321,7 +320,7 @@ void hidma_cleanup_pending_tre(struct hidma_lldev *lldev, u8 err_info,
 	u32 tre_read_off;
 
 	tre_iterator = lldev->tre_processed_off;
-	while (lldev->pending_tre_count) {
+	while (atomic_read(&lldev->pending_tre_count)) {
 		if (hidma_post_completed(lldev, tre_iterator, err_info,
 					 err_code))
 			break;
@@ -548,7 +547,7 @@ void hidma_ll_queue_request(struct hidma_lldev *lldev, u32 tre_ch)
 	tre->err_code = 0;
 	tre->err_info = 0;
 	tre->queued = 1;
-	lldev->pending_tre_count++;
+	atomic_inc(&lldev->pending_tre_count);
 	lldev->tre_write_offset = (lldev->tre_write_offset + HIDMA_TRE_SIZE)
 					% lldev->tre_ring_size;
 	spin_unlock_irqrestore(&lldev->lock, flags);
@@ -654,7 +653,7 @@ int hidma_ll_setup(struct hidma_lldev *lldev)
 	u32 val;
 	u32 nr_tres = lldev->nr_tres;
 
-	lldev->pending_tre_count = 0;
+	atomic_set(&lldev->pending_tre_count, 0);
 	lldev->tre_processed_off = 0;
 	lldev->evre_processed_off = 0;
 	lldev->tre_write_offset = 0;
@@ -816,7 +815,7 @@ int hidma_ll_uninit(struct hidma_lldev *lldev)
 	tasklet_kill(&lldev->task);
 	memset(lldev->trepool, 0, required_bytes);
 	lldev->trepool = NULL;
-	lldev->pending_tre_count = 0;
+	atomic_set(&lldev->pending_tre_count, 0);
 	lldev->tre_write_offset = 0;
 
 	rc = hidma_ll_reset(lldev);
-- 
1.9.1
