From: zonque@gmail.com (Daniel Mack)
Date: Wed, 21 Aug 2013 14:08:55 +0200
Subject: [PATCH v5 2/5] dma: mmp_pdma: don't clear DCMD_ENDIRQEN at end of
 pending chain
In-Reply-To: <1377086938-29145-1-git-send-email-zonque@gmail.com>
References: <1377086938-29145-1-git-send-email-zonque@gmail.com>
Message-ID: <1377086938-29145-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to fully support multiple transactions per channel, we need to
assure we get an interrupt for each completed transaction. That flags
bit is also our only way to tell at which descriptor a transaction ends.

So, remove the manual clearing of that bit, and then inline the only
remaining command that is left in append_pending_queue() for better
readability.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 9929f85..31e9a71 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -279,25 +279,6 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 	spin_unlock_irqrestore(&pdev->phy_lock, flags);
 }
 
-/* desc->tx_list ==> pending list */
-static void append_pending_queue(struct mmp_pdma_chan *chan,
-					struct mmp_pdma_desc_sw *desc)
-{
-	struct mmp_pdma_desc_sw *tail =
-				to_mmp_pdma_desc(chan->chain_pending.prev);
-
-	if (list_empty(&chan->chain_pending))
-		goto out_splice;
-
-	/* one irq per queue, even appended */
-	tail->desc.ddadr = desc->async_tx.phys;
-	tail->desc.dcmd &= ~DCMD_ENDIRQEN;
-
-	/* softly link to pending list */
-out_splice:
-	list_splice_tail_init(&desc->tx_list, &chan->chain_pending);
-}
-
 /**
  * start_pending_queue - transfer any pending transactions
  * pending list ==> running list
@@ -360,7 +341,8 @@ static dma_cookie_t mmp_pdma_tx_submit(struct dma_async_tx_descriptor *tx)
 		cookie = dma_cookie_assign(&child->async_tx);
 	}
 
-	append_pending_queue(chan, desc);
+	/* softly link to pending list - desc->tx_list ==> pending list */
+	list_splice_tail_init(&desc->tx_list, &chan->chain_pending);
 
 	spin_unlock_irqrestore(&chan->desc_lock, flags);
 
-- 
1.8.3.1
