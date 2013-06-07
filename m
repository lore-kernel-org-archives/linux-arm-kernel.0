From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 7 Jun 2013 17:15:29 +0200
Subject: [PATCH] dmaengine: at_hdmac: remove unsuded atc_cleanup_descriptors()
Message-ID: <1370618129-18049-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since patch 7c407d3e54dcc0c79119553c8d5ef176c1d5bc3a (DMA: AT91:
Get residual bytes in dma buffer), the function
atc_cleanup_descriptors() is not used anymore. We remove it to prevent
warnings.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 4499dcf..50953a7 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -417,37 +417,6 @@ static void atc_complete_all(struct at_dma_chan *atchan)
 }
 
 /**
- * atc_cleanup_descriptors - cleanup up finished descriptors in active_list
- * @atchan: channel to be cleaned up
- *
- * Called with atchan->lock held and bh disabled
- */
-static void atc_cleanup_descriptors(struct at_dma_chan *atchan)
-{
-	struct at_desc	*desc, *_desc;
-	struct at_desc	*child;
-
-	dev_vdbg(chan2dev(&atchan->chan_common), "cleanup descriptors\n");
-
-	list_for_each_entry_safe(desc, _desc, &atchan->active_list, desc_node) {
-		if (!(desc->lli.ctrla & ATC_DONE))
-			/* This one is currently in progress */
-			return;
-
-		list_for_each_entry(child, &desc->tx_list, desc_node)
-			if (!(child->lli.ctrla & ATC_DONE))
-				/* Currently in progress */
-				return;
-
-		/*
-		 * No descriptors so far seem to be in progress, i.e.
-		 * this chain must be done.
-		 */
-		atc_chain_complete(atchan, desc);
-	}
-}
-
-/**
  * atc_advance_work - at the end of a transaction, move forward
  * @atchan: channel where the transaction ended
  *
-- 
1.8.2.2
