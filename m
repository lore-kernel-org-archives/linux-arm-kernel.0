From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 23 Aug 2016 00:48:09 -0400
Subject: [PATCH V3 1/3] dmaengine: qcom_hidma: release the descriptor before
 the callback
In-Reply-To: <1471927691-28827-1-git-send-email-okaya@codeaurora.org>
References: <1471927691-28827-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1471927691-28827-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a race condition between data transfer callback and descriptor
free code. The callback routine may decide to clear the resources even
though the descriptor has not yet been freed.

Instead of calling the callback first and then releasing the memory,
this code is changing the order to return the descriptor back to the
free pool and then call the user provided callback.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 1197fbf..b8493ba 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -111,6 +111,7 @@ static void hidma_process_completed(struct hidma_chan *mchan)
 	struct dma_async_tx_descriptor *desc;
 	dma_cookie_t last_cookie;
 	struct hidma_desc *mdesc;
+	struct hidma_desc *next;
 	unsigned long irqflags;
 	struct list_head list;
 
@@ -122,8 +123,9 @@ static void hidma_process_completed(struct hidma_chan *mchan)
 	spin_unlock_irqrestore(&mchan->lock, irqflags);
 
 	/* Execute callbacks and run dependencies */
-	list_for_each_entry(mdesc, &list, node) {
+	list_for_each_entry_safe(mdesc, next, &list, node) {
 		enum dma_status llstat;
+		struct dmaengine_desc_callback cb;
 
 		desc = &mdesc->desc;
 
@@ -132,18 +134,18 @@ static void hidma_process_completed(struct hidma_chan *mchan)
 		spin_unlock_irqrestore(&mchan->lock, irqflags);
 
 		llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
-		if (llstat == DMA_COMPLETE)
-			dmaengine_desc_get_callback_invoke(desc, NULL);
+		dmaengine_desc_get_callback(desc, &cb);
 
 		last_cookie = desc->cookie;
 		dma_run_dependencies(desc);
-	}
 
-	/* Free descriptors */
-	spin_lock_irqsave(&mchan->lock, irqflags);
-	list_splice_tail_init(&list, &mchan->free);
-	spin_unlock_irqrestore(&mchan->lock, irqflags);
+		spin_lock_irqsave(&mchan->lock, irqflags);
+		list_move(&mdesc->node, &mchan->free);
+		spin_unlock_irqrestore(&mchan->lock, irqflags);
 
+		if (llstat == DMA_COMPLETE)
+			dmaengine_desc_callback_invoke(&cb, NULL);
+	}
 }
 
 /*
-- 
1.8.2.1
