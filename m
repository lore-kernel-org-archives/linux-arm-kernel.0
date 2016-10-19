From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 19 Oct 2016 13:51:48 -0400
Subject: [PATCH V6 06/10] dmaengine: qcom_hidma: bring out interrupt cause
In-Reply-To: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
References: <1476899512-20431-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1476899512-20431-7-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring out the interrupt cause to the top level so that MSI interrupts
can be hooked at a later stage.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_ll.c | 62 ++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 29fef4f..6bdea90 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -411,12 +411,24 @@ static int hidma_ll_reset(struct hidma_lldev *lldev)
  * requests traditionally to the destination, this concept does not apply
  * here for this HW.
  */
-irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
+static void hidma_ll_int_handler_internal(struct hidma_lldev *lldev, int cause)
 {
-	struct hidma_lldev *lldev = arg;
-	u32 status;
-	u32 enable;
-	u32 cause;
+	if (cause & HIDMA_ERR_INT_MASK) {
+		dev_err(lldev->dev, "error 0x%x, disabling...\n",
+				cause);
+
+		/* Clear out pending interrupts */
+		writel(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+
+		/* No further submissions. */
+		hidma_ll_disable(lldev);
+
+		/* Driver completes the txn and intimates the client.*/
+		hidma_cleanup_pending_tre(lldev, 0xFF,
+					  HIDMA_EVRE_STATUS_ERROR);
+
+		return;
+	}
 
 	/*
 	 * Fine tuned for this HW...
@@ -425,35 +437,28 @@ irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
 	 * read and write accessors are used for performance reasons due to
 	 * interrupt delivery guarantees. Do not copy this code blindly and
 	 * expect that to work.
+	 *
+	 * Try to consume as many EVREs as possible.
 	 */
+	hidma_handle_tre_completion(lldev);
+
+	/* We consumed TREs or there are pending TREs or EVREs. */
+	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+}
+
+irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
+{
+	struct hidma_lldev *lldev = arg;
+	u32 status;
+	u32 enable;
+	u32 cause;
+
 	status = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_STAT_REG);
 	enable = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
 	cause = status & enable;
 
 	while (cause) {
-		if (cause & HIDMA_ERR_INT_MASK) {
-			dev_err(lldev->dev, "error 0x%x, disabling...\n",
-					cause);
-
-			/* Clear out pending interrupts */
-			writel(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
-
-			/* No further submissions. */
-			hidma_ll_disable(lldev);
-
-			/* Driver completes the txn and intimates the client.*/
-			hidma_cleanup_pending_tre(lldev, 0xFF,
-						  HIDMA_EVRE_STATUS_ERROR);
-			goto out;
-		}
-
-		/*
-		 * Try to consume as many EVREs as possible.
-		 */
-		hidma_handle_tre_completion(lldev);
-
-		/* We consumed TREs or there are pending TREs or EVREs. */
-		writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+		hidma_ll_int_handler_internal(lldev, cause);
 
 		/*
 		 * Another interrupt might have arrived while we are
@@ -464,7 +469,6 @@ irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
 		cause = status & enable;
 	}
 
-out:
 	return IRQ_HANDLED;
 }
 
-- 
1.9.1
