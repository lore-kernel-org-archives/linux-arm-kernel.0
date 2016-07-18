From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 18 Jul 2016 14:39:35 -0400
Subject: [PATCH 08/10] dmaengine: qcom_hidma: bring out interrupt cause
In-Reply-To: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1468867177-15007-9-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring out the interrupt cause to the top level so that MSI interrupts
can be hooked at a later stage.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_ll.c | 60 ++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 2753210..eb78952 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -403,12 +403,18 @@ static void hidma_ll_abort(unsigned long arg)
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
+		dev_err(lldev->dev, "error 0x%x, resetting...\n",
+				cause);
+
+		/* Clear out pending interrupts */
+		writel(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+
+		tasklet_schedule(&lldev->rst_task);
+		return;
+	}
 
 	/*
 	 * Fine tuned for this HW...
@@ -418,40 +424,28 @@ irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
 	 * interrupt delivery guarantees. Do not copy this code blindly and
 	 * expect that to work.
 	 */
-	status = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_STAT_REG);
-	enable = readl_relaxed(lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
-	cause = status & enable;
-
-	while (cause) {
-		if (cause & HIDMA_ERR_INT_MASK) {
-			dev_err(lldev->dev, "error 0x%x, resetting...\n",
-					cause);
-
-			/* Clear out pending interrupts */
-			writel(cause, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
-
-			tasklet_schedule(&lldev->rst_task);
-			goto out;
-		}
-
+	while (atomic_read(&lldev->pending_tre_count)) {
 		/*
 		 * Try to consume as many EVREs as possible.
 		 */
-		hidma_handle_tre_completion(lldev);
+		hidma_handle_tre_completion(lldev, 0, 0);
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
1.8.2.1
