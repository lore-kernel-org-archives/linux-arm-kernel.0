From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Sep 2016 22:12:44 -0400
Subject: [PATCH V4 07/10] dmaengine: qcom_hidma: bring out interrupt cause
In-Reply-To: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475115167-5898-8-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring out the interrupt cause to the top level so that MSI interrupts
can be hooked at a later stage.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_ll.c | 72 +++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index c911ca2..088935f 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -397,12 +397,24 @@ static int hidma_ll_reset(struct hidma_lldev *lldev)
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
@@ -412,45 +424,29 @@ irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
 	 * interrupt delivery guarantees. Do not copy this code blindly and
 	 * expect that to work.
 	 */
-	status = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_STAT_REG);
-	enable = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
-	cause = status & enable;
-
-	while (cause) {
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
+	while (atomic_read(&lldev->pending_tre_count)) {
 		/*
 		 * Try to consume as many EVREs as possible.
 		 */
-		hidma_handle_tre_completion(lldev);
+		if (hidma_handle_tre_completion(lldev, 0, 0))
+			break;
+	}
 
-		/* We consumed TREs or there are pending TREs or EVREs. */
-		writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+	/* We consumed TREs or there are pending TREs or EVREs. */
+	writel_relaxed(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+}
 
-		/*
-		 * Another interrupt might have arrived while we are
-		 * processing this one. Read the new cause.
-		 */
-		status = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_STAT_REG);
-		enable = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
-		cause = status & enable;
-	}
+irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
+{
+	struct hidma_lldev *lldev = arg;
+	u32 status;
+	u32 enable;
+	u32 cause;
 
-out:
+	status = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_STAT_REG);
+	enable = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
+	cause = status & enable;
+	hidma_ll_int_handler_internal(lldev, cause);
 	return IRQ_HANDLED;
 }
 
-- 
1.9.1
