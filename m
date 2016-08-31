From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 31 Aug 2016 11:10:28 -0400
Subject: [PATCH V4 2/3] dmaengine: qcom_hidma: report transfer errors with new
 interface
In-Reply-To: <1472656229-12955-1-git-send-email-okaya@codeaurora.org>
References: <1472656229-12955-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1472656229-12955-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the DMA errors to the client by passing a result argument. The HW only
supports a generic error when something goes wrong. That's why, using
DMA_TRANS_ABORTED all the time.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index b8493ba..ea24863 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -126,6 +126,7 @@ static void hidma_process_completed(struct hidma_chan *mchan)
 	list_for_each_entry_safe(mdesc, next, &list, node) {
 		enum dma_status llstat;
 		struct dmaengine_desc_callback cb;
+		struct dmaengine_result result;
 
 		desc = &mdesc->desc;
 
@@ -141,10 +142,15 @@ static void hidma_process_completed(struct hidma_chan *mchan)
 
 		spin_lock_irqsave(&mchan->lock, irqflags);
 		list_move(&mdesc->node, &mchan->free);
-		spin_unlock_irqrestore(&mchan->lock, irqflags);
 
 		if (llstat == DMA_COMPLETE)
-			dmaengine_desc_callback_invoke(&cb, NULL);
+			result.result = DMA_TRANS_NOERROR;
+		else
+			result.result = DMA_TRANS_ABORTED;
+
+		spin_unlock_irqrestore(&mchan->lock, irqflags);
+
+		dmaengine_desc_callback_invoke(&cb, &result);
 	}
 }
 
-- 
1.9.1
