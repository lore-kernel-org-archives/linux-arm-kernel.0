From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Sep 2016 22:12:46 -0400
Subject: [PATCH V4 09/10] dmaengine: qcom_hidma: protect common data structures
In-Reply-To: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475115167-5898-10-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When MSI interrupts are supported, error and the transfer interrupt can
come from multiple processor contexts.

Each error interrupt is an MSI interrupt. If the channel is disabled by
the first error interrupt, the remaining error interrupts will gracefully
return in the interrupt handler.

If an error is observed while servicing the completions in success case,
the posting of the completions will be aborted as soon as channel disabled
state is observed. The error interrupt handler will take it from there and
finish the remaining completions. We don't want to create multiple success
and error messages to be delivered to the client in mixed order.

Also got rid of hidma_post_completed method and moved the locks inside
hidma_ll_int_handler_internal function. Rearranged the assignments so that
variables are updated only when a lock is held.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_ll.c | 142 ++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 84 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index f0630e0..386a64c 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -198,18 +198,50 @@ static void hidma_ll_tre_complete(unsigned long arg)
 	}
 }
 
-static int hidma_post_completed(struct hidma_lldev *lldev, int tre_iterator,
-				u8 err_info, u8 err_code)
+/*
+ * Called to handle the interrupt for the channel.
+ * Return a positive number if TRE or EVRE were consumed on this run.
+ * Return a positive number if there are pending TREs or EVREs.
+ * Return 0 if there is nothing to consume or no pending TREs/EVREs found.
+ */
+static int hidma_handle_tre_completion(struct hidma_lldev *lldev, u8 err_info,
+				       u8 err_code)
 {
+	u32 *current_evre;
 	struct hidma_tre *tre;
 	unsigned long flags;
+	u32 evre_write_off;
+	u32 cfg;
+	u32 offset;
+
+	evre_write_off = readl_relaxed(lldev->evca + HIDMA_EVCA_WRITE_PTR_REG);
+	if ((evre_write_off > lldev->evre_ring_size) ||
+			(evre_write_off % HIDMA_EVRE_SIZE)) {
+		dev_err(lldev->dev, "HW reports invalid EVRE write offset\n");
+		return -EINVAL;
+	}
 
 	spin_lock_irqsave(&lldev->lock, flags);
-	tre = lldev->pending_tre_list[tre_iterator / HIDMA_TRE_SIZE];
+	if (lldev->evre_processed_off == evre_write_off) {
+		spin_unlock_irqrestore(&lldev->lock, flags);
+		return 0;
+	}
+	current_evre = lldev->evre_ring + lldev->evre_processed_off;
+	cfg = current_evre[HIDMA_EVRE_CFG_IDX];
+	if (!err_info) {
+		err_info = cfg >> HIDMA_EVRE_ERRINFO_BIT_POS;
+		err_info &= HIDMA_EVRE_ERRINFO_MASK;
+	}
+	if (!err_code)
+		err_code = (cfg >> HIDMA_EVRE_CODE_BIT_POS) &
+					HIDMA_EVRE_CODE_MASK;
+
+	offset = lldev->tre_processed_off;
+	tre = lldev->pending_tre_list[offset / HIDMA_TRE_SIZE];
 	if (!tre) {
 		spin_unlock_irqrestore(&lldev->lock, flags);
 		dev_warn(lldev->dev, "tre_index [%d] and tre out of sync\n",
-			 tre_iterator / HIDMA_TRE_SIZE);
+			 lldev->tre_processed_off / HIDMA_TRE_SIZE);
 		return -EINVAL;
 	}
 	lldev->pending_tre_list[tre->tre_index] = NULL;
@@ -223,6 +255,14 @@ static int hidma_post_completed(struct hidma_lldev *lldev, int tre_iterator,
 		atomic_set(&lldev->pending_tre_count, 0);
 	}
 
+
+	HIDMA_INCREMENT_ITERATOR(lldev->tre_processed_off, HIDMA_TRE_SIZE,
+				 lldev->tre_ring_size);
+	HIDMA_INCREMENT_ITERATOR(lldev->evre_processed_off, HIDMA_EVRE_SIZE,
+				 lldev->evre_ring_size);
+
+	writel(lldev->evre_processed_off,
+			lldev->evca + HIDMA_EVCA_DOORBELL_REG);
 	spin_unlock_irqrestore(&lldev->lock, flags);
 
 	tre->err_info = err_info;
@@ -232,86 +272,7 @@ static int hidma_post_completed(struct hidma_lldev *lldev, int tre_iterator,
 	kfifo_put(&lldev->handoff_fifo, tre);
 	tasklet_schedule(&lldev->task);
 
-	return 0;
-}
-
-/*
- * Called to handle the interrupt for the channel.
- * Return a positive number if TRE or EVRE were consumed on this run.
- * Return a positive number if there are pending TREs or EVREs.
- * Return 0 if there is nothing to consume or no pending TREs/EVREs found.
- */
-static int hidma_handle_tre_completion(struct hidma_lldev *lldev, u8 err_info,
-				       u8 err_code)
-{
-	u32 evre_ring_size = lldev->evre_ring_size;
-	u32 tre_ring_size = lldev->tre_ring_size;
-	u32 tre_iterator, evre_iterator;
-	u32 num_completed = 0;
-
-	evre_write_off = readl_relaxed(lldev->evca + HIDMA_EVCA_WRITE_PTR_REG);
-	tre_iterator = lldev->tre_processed_off;
-	evre_iterator = lldev->evre_processed_off;
-
-	if ((evre_write_off > evre_ring_size) ||
-	    (evre_write_off % HIDMA_EVRE_SIZE)) {
-		dev_err(lldev->dev, "HW reports invalid EVRE write offset\n");
-		return 0;
-	}
-
-	/*
-	 * By the time control reaches here the number of EVREs and TREs
-	 * may not match. Only consume the ones that hardware told us.
-	 */
-	while ((evre_iterator != evre_write_off)) {
-		u32 *current_evre = lldev->evre_ring + evre_iterator;
-		u32 cfg;
-
-		cfg = current_evre[HIDMA_EVRE_CFG_IDX];
-		if (!err_info) {
-			err_info = cfg >> HIDMA_EVRE_ERRINFO_BIT_POS;
-			err_info &= HIDMA_EVRE_ERRINFO_MASK;
-		}
-		if (!err_code)
-			err_code = (cfg >> HIDMA_EVRE_CODE_BIT_POS) &
-					HIDMA_EVRE_CODE_MASK;
-
-		if (hidma_post_completed(lldev, tre_iterator, err_info,
-					 err_code))
-			break;
-
-		HIDMA_INCREMENT_ITERATOR(tre_iterator, HIDMA_TRE_SIZE,
-					 tre_ring_size);
-		HIDMA_INCREMENT_ITERATOR(evre_iterator, HIDMA_EVRE_SIZE,
-					 evre_ring_size);
-
-		/*
-		 * Read the new event descriptor written by the HW.
-		 * As we are processing the delivered events, other events
-		 * get queued to the SW for processing.
-		 */
-		evre_write_off =
-		    readl_relaxed(lldev->evca + HIDMA_EVCA_WRITE_PTR_REG);
-		num_completed++;
-	}
-
-	if (num_completed) {
-		u32 evre_read_off = (lldev->evre_processed_off +
-				     HIDMA_EVRE_SIZE * num_completed);
-		u32 tre_read_off = (lldev->tre_processed_off +
-				    HIDMA_TRE_SIZE * num_completed);
-
-		evre_read_off = evre_read_off % evre_ring_size;
-		tre_read_off = tre_read_off % tre_ring_size;
-
-		writel(evre_read_off, lldev->evca + HIDMA_EVCA_DOORBELL_REG);
-
-		/* record the last processed tre offset */
-		lldev->tre_processed_off = tre_read_off;
-		lldev->evre_processed_off = evre_read_off;
-	}
-
-	return num_completed;
+	return 1;
 }
 
 void hidma_cleanup_pending_tre(struct hidma_lldev *lldev, u8 err_info,
@@ -399,6 +360,16 @@ static int hidma_ll_reset(struct hidma_lldev *lldev)
  */
 static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev, int cause)
 {
+	if ((lldev->trch_state == HIDMA_CH_DISABLED) ||
+		(lldev->evch_state == HIDMA_CH_DISABLED)) {
+		dev_err(lldev->dev, "error 0x%x, already disabled...\n",
+			cause);
+
+		/* Clear out pending interrupts */
+		writel(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+		return;
+	}
+
 	if (cause & HIDMA_ERR_INT_MASK) {
 		dev_err(lldev->dev, "error 0x%x, disabling...\n",
 				cause);
@@ -430,6 +401,9 @@ static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev, int cause)
 		 */
 		if (hidma_handle_tre_completion(lldev, 0, 0))
 			break;
+		if ((lldev->trch_state == HIDMA_CH_DISABLED) ||
+				(lldev->evch_state == HIDMA_CH_DISABLED))
+			break;
 	}
 
 	/* We consumed TREs or there are pending TREs or EVREs. */
-- 
1.9.1
