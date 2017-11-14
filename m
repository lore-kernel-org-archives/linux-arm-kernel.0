From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 14 Nov 2017 09:55:01 -0500
Subject: [PATCH] dmaengine: qcom_hidma: check pending interrupts
Message-ID: <1510671301-23223-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver is missing the interrupts if two requests are queued up at the same
time as the interrupt handler is servicing a request that was just
delivered.

The ISR clears the interrupt at the end but it could be clearing the
interrupt for an outstanding event. Therefore, second interrupt never
arrives.

Clear the interrupt first and then check for completions.

Also, make sure that request start and interrupt clear do not overlap in
time by using a spinlock.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_ll.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 4999e26..7c6e2ff 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -393,6 +393,8 @@ static int hidma_ll_reset(struct hidma_lldev *lldev)
  */
 static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev, int cause)
 {
+	unsigned long irqflags;
+
 	if (cause & HIDMA_ERR_INT_MASK) {
 		dev_err(lldev->dev, "error 0x%x, disabling...\n",
 				cause);
@@ -410,6 +412,10 @@ static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev, int cause)
 		return;
 	}
 
+	spin_lock_irqsave(&lldev->lock, irqflags);
+	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+	spin_unlock_irqrestore(&lldev->lock, irqflags);
+
 	/*
 	 * Fine tuned for this HW...
 	 *
@@ -421,9 +427,6 @@ static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev, int cause)
 	 * Try to consume as many EVREs as possible.
 	 */
 	hidma_handle_tre_completion(lldev);
-
-	/* We consumed TREs or there are pending TREs or EVREs. */
-	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
 }
 
 irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
-- 
1.9.1
