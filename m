From: zonque@gmail.com (Daniel Mack)
Date: Fri, 16 Aug 2013 19:05:04 +0200
Subject: [PATCH v4 1/4] dma: mmp_pdma: only complete one transaction from
 dma_do_tasklet()
In-Reply-To: <1376672707-24527-1-git-send-email-zonque@gmail.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
Message-ID: <1376672707-24527-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when an interrupt has occured for a channel, the tasklet
worker code will only look at the very last entry in the running list
and complete its cookie, and then dispose the entire running chain.
Hence, the first transaction's cookie will never complete.

In fact, the interrupt we should handle will be the one related to the
first descriptor in the chain with the ENDIRQEN bit set, so complete
the second transaction that is in fact still running.

As a result, the driver can't currently handle multiple transactions on
one chanel, and it's likely that no drivers exist that rely on this
feature.

Fix this by walking the running_chain and look for the first
descriptor that has the interrupt-enable bit set. Only queue
descriptors up to that point for completion handling, while leaving
the rest intact. Also, only make the channel idle if the list is
completely empty after such a cycle.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 579f79a..9929f85 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -710,25 +710,32 @@ static void dma_do_tasklet(unsigned long data)
 
 	spin_lock_irqsave(&chan->desc_lock, flags);
 
-	/* update the cookie if we have some descriptors to cleanup */
-	if (!list_empty(&chan->chain_running)) {
-		dma_cookie_t cookie;
-
-		desc = to_mmp_pdma_desc(chan->chain_running.prev);
-		cookie = desc->async_tx.cookie;
-		dma_cookie_complete(&desc->async_tx);
+	list_for_each_entry_safe(desc, _desc, &chan->chain_running, node) {
+		/*
+		 * move the descriptors to a temporary list so we can drop
+		 * the lock during the entire cleanup operation
+		 */
+		list_del(&desc->node);
+		list_add(&desc->node, &chain_cleanup);
 
-		dev_dbg(chan->dev, "completed_cookie=%d\n", cookie);
+		/*
+		 * Look for the first list entry which has the ENDIRQEN flag
+		 * set. That is the descriptor we got an interrupt for, so
+		 * complete that transaction and its cookie.
+		 */
+		if (desc->desc.dcmd & DCMD_ENDIRQEN) {
+			dma_cookie_t cookie = desc->async_tx.cookie;
+			dma_cookie_complete(&desc->async_tx);
+			dev_dbg(chan->dev, "completed_cookie=%d\n", cookie);
+			break;
+		}
 	}
 
 	/*
-	 * move the descriptors to a temporary list so we can drop the lock
-	 * during the entire cleanup operation
+	 * The hardware is idle and ready for more when the
+	 * chain_running list is empty.
 	 */
-	list_splice_tail_init(&chan->chain_running, &chain_cleanup);
-
-	/* the hardware is now idle and ready for more */
-	chan->idle = true;
+	chan->idle = list_empty(&chan->chain_running);
 
 	/* Start any pending transactions automatically */
 	start_pending_queue(chan);
-- 
1.8.3.1
