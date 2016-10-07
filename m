From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri,  7 Oct 2016 01:25:14 -0400
Subject: [PATCH V5 09/10] dmaengine: qcom_hidma: break completion processing
 on error
In-Reply-To: <1475817915-11976-1-git-send-email-okaya@codeaurora.org>
References: <1475817915-11976-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475817915-11976-10-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We try to consume as much successful transfers as possible. Now that we
support MSI interrupts, an error interrupt might be observed by another
processor while we are finishing the successful ones.

Try to abort successful processing if this is the case.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_ll.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index c4e8b64..aa76ec1 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -291,6 +291,13 @@ static int hidma_handle_tre_completion(struct hidma_lldev *lldev)
 		evre_write_off =
 		    readl_relaxed(lldev->evca + HIDMA_EVCA_WRITE_PTR_REG);
 		num_completed++;
+
+		/*
+		 * An error interrupt might have arrived while we are processing
+		 * the completed interrupt.
+		 */
+		if (!hidma_ll_isenabled(lldev))
+			break;
 	}
 
 	if (num_completed) {
-- 
1.9.1
