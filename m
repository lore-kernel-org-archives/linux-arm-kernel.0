From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 May 2015 15:07:32 +0200
Subject: [PATCH v2 1/5] dmaengine: mv_xor: bug fix for racing condition in
 descriptors cleanup
In-Reply-To: <1432645656-20504-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1432645656-20504-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1432645656-20504-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lior Amsalem <alior@marvell.com>

This patch fixes a bug in the XOR driver where the cleanup function can be
called and free descriptors that never been processed by the engine (which
result in data errors).

The cleanup function will free descriptors based on the ownership bit in
the descriptors.

Fixes: ff7b04796d98 ("dmaengine: DMA engine driver for Marvell XOR engine")
Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Ofer Heifetz <oferh@marvell.com>
Cc: stable at vger.kernel.org

---
 drivers/dma/mv_xor.c | 72 +++++++++++++++++++++++++++++++++-------------------
 drivers/dma/mv_xor.h |  1 +
 2 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 1c56001df676..50f1b422dee3 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -273,7 +273,8 @@ static void mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
 	dma_cookie_t cookie = 0;
 	int busy = mv_chan_is_busy(mv_chan);
 	u32 current_desc = mv_chan_get_current_desc(mv_chan);
-	int seen_current = 0;
+	int current_cleaned = 0;
+	struct mv_xor_desc *hw_desc;
 
 	dev_dbg(mv_chan_to_devp(mv_chan), "%s %d\n", __func__, __LINE__);
 	dev_dbg(mv_chan_to_devp(mv_chan), "current_desc %x\n", current_desc);
@@ -285,38 +286,57 @@ static void mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
 
 	list_for_each_entry_safe(iter, _iter, &mv_chan->chain,
 					chain_node) {
-		prefetch(_iter);
-		prefetch(&_iter->async_tx);
 
-		/* do not advance past the current descriptor loaded into the
-		 * hardware channel, subsequent descriptors are either in
-		 * process or have not been submitted
-		 */
-		if (seen_current)
-			break;
+		/* clean finished descriptors */
+		hw_desc = iter->hw_desc;
+		if (hw_desc->status & XOR_DESC_SUCCESS) {
+			cookie = mv_xor_run_tx_complete_actions(iter, mv_chan,
+								cookie);
 
-		/* stop the search if we reach the current descriptor and the
-		 * channel is busy
-		 */
-		if (iter->async_tx.phys == current_desc) {
-			seen_current = 1;
-			if (busy)
+			/* done processing desc, clean slot */
+			mv_xor_clean_slot(iter, mv_chan);
+
+			/* break if we did cleaned the current */
+			if (iter->async_tx.phys == current_desc) {
+				current_cleaned = 1;
+				break;
+			}
+		} else {
+			if (iter->async_tx.phys == current_desc) {
+				current_cleaned = 0;
 				break;
+			}
 		}
-
-		cookie = mv_xor_run_tx_complete_actions(iter, mv_chan, cookie);
-
-		if (mv_xor_clean_slot(iter, mv_chan))
-			break;
 	}
 
 	if ((busy == 0) && !list_empty(&mv_chan->chain)) {
-		struct mv_xor_desc_slot *chain_head;
-		chain_head = list_entry(mv_chan->chain.next,
-					struct mv_xor_desc_slot,
-					chain_node);
-
-		mv_xor_start_new_chain(mv_chan, chain_head);
+		if (current_cleaned) {
+			/*
+			 * current descriptor cleaned and removed, run
+			 * from list head
+			 */
+			iter = list_entry(mv_chan->chain.next,
+					  struct mv_xor_desc_slot,
+					  chain_node);
+			mv_xor_start_new_chain(mv_chan, iter);
+		} else {
+			if (!list_is_last(&iter->chain_node, &mv_chan->chain)) {
+				/*
+				 * descriptors are still waiting after
+				 * current, trigger them
+				 */
+				iter = list_entry(iter->chain_node.next,
+						  struct mv_xor_desc_slot,
+						  chain_node);
+				mv_xor_start_new_chain(mv_chan, iter);
+			} else {
+				/*
+				 * some descriptors are still waiting
+				 * to be cleaned
+				 */
+				tasklet_schedule(&mv_chan->irq_tasklet);
+			}
+		}
 	}
 
 	if (cookie > 0)
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 91958dba39a2..0e302b3a33ad 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -31,6 +31,7 @@
 #define XOR_OPERATION_MODE_XOR		0
 #define XOR_OPERATION_MODE_MEMCPY	2
 #define XOR_DESCRIPTOR_SWAP		BIT(14)
+#define XOR_DESC_SUCCESS		0x40000000
 
 #define XOR_DESC_DMA_OWNED		BIT(31)
 #define XOR_DESC_EOD_INT_EN		BIT(31)
-- 
2.4.1
