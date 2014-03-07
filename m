From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Mar 2014 16:46:47 -0300
Subject: [PATCH v2 3/3] dma: mv_xor: Rename __mv_xor_slot_cleanup() to
 mv_xor_slot_cleanup()
In-Reply-To: <1394221607-15064-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394221607-15064-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394221607-15064-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mv_xor_slot_cleanup() has no remaining callers, we remove it
and rename __mv_xor_slot_cleanup() to mv_xor_slot_cleanup().

We take this opportunity to add a comment that makes it clear that the
channel spinlock should be held before calling mv_xor_slot_cleanup().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/dma/mv_xor.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index c60662a..5031b78 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -312,7 +312,8 @@ mv_xor_clean_slot(struct mv_xor_desc_slot *desc,
 	return 0;
 }
 
-static void __mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
+/* This function must be called with the mv_xor_chan spinlock held */
+static void mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
 {
 	struct mv_xor_desc_slot *iter, *_iter;
 	dma_cookie_t cookie = 0;
@@ -368,20 +369,12 @@ static void __mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
 		mv_chan->dmachan.completed_cookie = cookie;
 }
 
-static void
-mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
-{
-	spin_lock_bh(&mv_chan->lock);
-	__mv_xor_slot_cleanup(mv_chan);
-	spin_unlock_bh(&mv_chan->lock);
-}
-
 static void mv_xor_tasklet(unsigned long data)
 {
 	struct mv_xor_chan *chan = (struct mv_xor_chan *) data;
 
 	spin_lock_bh(&chan->lock);
-	__mv_xor_slot_cleanup(chan);
+	mv_xor_slot_cleanup(chan);
 	spin_unlock_bh(&chan->lock);
 }
 
@@ -663,7 +656,7 @@ static void mv_xor_free_chan_resources(struct dma_chan *chan)
 
 	spin_lock_bh(&mv_chan->lock);
 
-	__mv_xor_slot_cleanup(mv_chan);
+	mv_xor_slot_cleanup(mv_chan);
 
 	list_for_each_entry_safe(iter, _iter, &mv_chan->chain,
 					chain_node) {
@@ -710,7 +703,7 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
 		return ret;
 
 	spin_lock_bh(&mv_chan->lock);
-	__mv_xor_slot_cleanup(mv_chan);
+	mv_xor_slot_cleanup(mv_chan);
 	spin_unlock_bh(&mv_chan->lock);
 
 	return dma_cookie_status(chan, cookie, txstate);
-- 
1.9.0
