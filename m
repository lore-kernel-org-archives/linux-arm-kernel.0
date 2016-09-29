From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Sep 2016 22:12:43 -0400
Subject: [PATCH V4 06/10] dmaengine: qcom_hidma: make error and success path
 common
In-Reply-To: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475115167-5898-7-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove code duplication by feeding the error code from outside
into successful data transfer handler.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_ll.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 29fef4f..c911ca2 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -241,11 +241,11 @@ static int hidma_post_completed(struct hidma_lldev *lldev, int tre_iterator,
  * Return a positive number if there are pending TREs or EVREs.
  * Return 0 if there is nothing to consume or no pending TREs/EVREs found.
  */
-static int hidma_handle_tre_completion(struct hidma_lldev *lldev)
+static int hidma_handle_tre_completion(struct hidma_lldev *lldev, u8 err_info,
+				       u8 err_code)
 {
 	u32 evre_ring_size = lldev->evre_ring_size;
 	u32 tre_ring_size = lldev->tre_ring_size;
-	u32 err_info, err_code, evre_write_off;
 	u32 tre_iterator, evre_iterator;
 	u32 num_completed = 0;
 
@@ -268,10 +268,13 @@ static int hidma_handle_tre_completion(struct hidma_lldev *lldev)
 		u32 cfg;
 
 		cfg = current_evre[HIDMA_EVRE_CFG_IDX];
-		err_info = cfg >> HIDMA_EVRE_ERRINFO_BIT_POS;
-		err_info &= HIDMA_EVRE_ERRINFO_MASK;
-		err_code =
-		    (cfg >> HIDMA_EVRE_CODE_BIT_POS) & HIDMA_EVRE_CODE_MASK;
+		if (!err_info) {
+			err_info = cfg >> HIDMA_EVRE_ERRINFO_BIT_POS;
+			err_info &= HIDMA_EVRE_ERRINFO_MASK;
+		}
+		if (!err_code)
+			err_code = (cfg >> HIDMA_EVRE_CODE_BIT_POS) &
+					HIDMA_EVRE_CODE_MASK;
 
 		if (hidma_post_completed(lldev, tre_iterator, err_info,
 					 err_code))
@@ -314,27 +317,10 @@ static int hidma_handle_tre_completion(struct hidma_lldev *lldev)
 void hidma_cleanup_pending_tre(struct hidma_lldev *lldev, u8 err_info,
 			       u8 err_code)
 {
-	u32 tre_iterator;
-	u32 tre_ring_size = lldev->tre_ring_size;
-	int num_completed = 0;
-	u32 tre_read_off;
-
-	tre_iterator = lldev->tre_processed_off;
 	while (atomic_read(&lldev->pending_tre_count)) {
-		if (hidma_post_completed(lldev, tre_iterator, err_info,
-					 err_code))
+		if (hidma_handle_tre_completion(lldev, err_info, err_code))
 			break;
-		HIDMA_INCREMENT_ITERATOR(tre_iterator, HIDMA_TRE_SIZE,
-					 tre_ring_size);
-		num_completed++;
 	}
-	tre_read_off = (lldev->tre_processed_off +
-			HIDMA_TRE_SIZE * num_completed);
-
-	tre_read_off = tre_read_off % tre_ring_size;
-
-	/* record the last processed tre offset */
-	lldev->tre_processed_off = tre_read_off;
 }
 
 static int hidma_ll_reset(struct hidma_lldev *lldev)
-- 
1.9.1
