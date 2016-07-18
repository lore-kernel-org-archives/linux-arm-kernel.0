From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 18 Jul 2016 14:39:34 -0400
Subject: [PATCH 07/10] dmaengine: qcom_hidma: eliminate processed variables
In-Reply-To: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1468867177-15007-8-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of tracking the read/write pointers in SW, track the
current state by reading from HW directly. This is an attempt
to eliminate potential race conditions.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.h     |  5 +++--
 drivers/dma/qcom/hidma_dbg.c |  6 ++++--
 drivers/dma/qcom/hidma_ll.c  | 29 +++++++----------------------
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index 158bf1f..03c20f6 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -28,6 +28,9 @@
 #define HIDMA_TRE_DEST_LOW_IDX		4
 #define HIDMA_TRE_DEST_HI_IDX		5
 
+#define HIDMA_EVCA_READ_PTR_REG                0x018
+#define HIDMA_TRCA_READ_PTR_REG                0x018
+
 struct hidma_tre {
 	atomic_t allocated;		/* if this channel is allocated	    */
 	bool queued;			/* flag whether this is pending     */
@@ -63,12 +66,10 @@ struct hidma_lldev {
 	void *tre_ring;			/* TRE ring			  */
 	dma_addr_t tre_dma;		/* TRE ring to be shared with HW  */
 	u32 tre_ring_size;		/* Byte size of the ring	  */
-	u32 tre_processed_off;		/* last processed TRE		  */
 
 	void *evre_ring;		/* EVRE ring			   */
 	dma_addr_t evre_dma;		/* EVRE ring to be shared with HW  */
 	u32 evre_ring_size;		/* Byte size of the ring	   */
-	u32 evre_processed_off;		/* last processed EVRE		   */
 
 	u32 tre_write_offset;           /* TRE write location              */
 	struct tasklet_struct task;	/* task delivering notifications   */
diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
index 87db285..d741b9d 100644
--- a/drivers/dma/qcom/hidma_dbg.c
+++ b/drivers/dma/qcom/hidma_dbg.c
@@ -73,14 +73,16 @@ static void hidma_ll_devstats(struct seq_file *s, void *llhndl)
 	seq_printf(s, "tre_ring=%p\n", lldev->tre_ring);
 	seq_printf(s, "tre_ring_handle=%pap\n", &lldev->tre_dma);
 	seq_printf(s, "tre_ring_size = 0x%x\n", lldev->tre_ring_size);
-	seq_printf(s, "tre_processed_off = 0x%x\n", lldev->tre_processed_off);
+	seq_printf(s, "tre_processed_off = 0x%x\n",
+			readl(lldev->trca + HIDMA_TRCA_READ_PTR_REG));
 	seq_printf(s, "pending_tre_count=%d\n",
 			atomic_read(&lldev->pending_tre_count));
 	seq_printf(s, "evca=%p\n", lldev->evca);
 	seq_printf(s, "evre_ring=%p\n", lldev->evre_ring);
 	seq_printf(s, "evre_ring_handle=%pap\n", &lldev->evre_dma);
 	seq_printf(s, "evre_ring_size = 0x%x\n", lldev->evre_ring_size);
-	seq_printf(s, "evre_processed_off = 0x%x\n", lldev->evre_processed_off);
+	seq_printf(s, "evre_processed_off = 0x%x\n",
+			readl(lldev->evca + HIDMA_EVCA_READ_PTR_REG));
 	seq_printf(s, "tre_write_offset = 0x%x\n", lldev->tre_write_offset);
 }
 
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index a71f0c7..2753210 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -245,13 +245,13 @@ static int hidma_handle_tre_completion(struct hidma_lldev *lldev, u8 err_info,
 				       u8 err_code)
 {
 	u32 evre_ring_size = lldev->evre_ring_size;
-	u32 tre_ring_size = lldev->tre_ring_size;
+	u32 evre_write_off;
 	u32 tre_iterator, evre_iterator;
 	u32 num_completed = 0;
 
 	evre_write_off = readl_relaxed(lldev->evca + HIDMA_EVCA_WRITE_PTR_REG);
-	tre_iterator = lldev->tre_processed_off;
-	evre_iterator = lldev->evre_processed_off;
+	evre_iterator = readl_relaxed(lldev->evca + HIDMA_EVCA_READ_PTR_REG);
+	tre_iterator = (evre_iterator / HIDMA_EVRE_SIZE) * HIDMA_TRE_SIZE;
 
 	if ((evre_write_off > evre_ring_size) ||
 	    (evre_write_off % HIDMA_EVRE_SIZE)) {
@@ -280,10 +280,10 @@ static int hidma_handle_tre_completion(struct hidma_lldev *lldev, u8 err_info,
 					 err_code))
 			break;
 
-		HIDMA_INCREMENT_ITERATOR(tre_iterator, HIDMA_TRE_SIZE,
-					 tre_ring_size);
 		HIDMA_INCREMENT_ITERATOR(evre_iterator, HIDMA_EVRE_SIZE,
 					 evre_ring_size);
+		tre_iterator = (evre_iterator / HIDMA_EVRE_SIZE) *
+					HIDMA_TRE_SIZE;
 
 		/*
 		 * Read the new event descriptor written by the HW.
@@ -295,21 +295,8 @@ static int hidma_handle_tre_completion(struct hidma_lldev *lldev, u8 err_info,
 		num_completed++;
 	}
 
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
+	if (num_completed)
+		writel(evre_iterator, lldev->evca + HIDMA_EVCA_DOORBELL_REG);
 
 	return num_completed;
 }
@@ -654,8 +641,6 @@ int hidma_ll_setup(struct hidma_lldev *lldev)
 	u32 nr_tres = lldev->nr_tres;
 
 	atomic_set(&lldev->pending_tre_count, 0);
-	lldev->tre_processed_off = 0;
-	lldev->evre_processed_off = 0;
 	lldev->tre_write_offset = 0;
 
 	/* disable interrupts */
-- 
1.8.2.1
