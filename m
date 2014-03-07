From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Mar 2014 16:46:46 -0300
Subject: [PATCH v2 2/3] dma: mv_xor: Remove all callers of
 mv_xor_slot_cleanup()
In-Reply-To: <1394221607-15064-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394221607-15064-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394221607-15064-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to simplify the code, remove all the calls to the locked
mv_xor_slot_cleanup() and instead use the unlocked version only,

It's less error prone to have just one function, and require the caller
to ensure proper locking.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/dma/mv_xor.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 589917b..c60662a 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -379,7 +379,10 @@ mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
 static void mv_xor_tasklet(unsigned long data)
 {
 	struct mv_xor_chan *chan = (struct mv_xor_chan *) data;
-	mv_xor_slot_cleanup(chan);
+
+	spin_lock_bh(&chan->lock);
+	__mv_xor_slot_cleanup(chan);
+	spin_unlock_bh(&chan->lock);
 }
 
 static struct mv_xor_desc_slot *
@@ -658,9 +661,10 @@ static void mv_xor_free_chan_resources(struct dma_chan *chan)
 	struct mv_xor_desc_slot *iter, *_iter;
 	int in_use_descs = 0;
 
-	mv_xor_slot_cleanup(mv_chan);
-
 	spin_lock_bh(&mv_chan->lock);
+
+	__mv_xor_slot_cleanup(mv_chan);
+
 	list_for_each_entry_safe(iter, _iter, &mv_chan->chain,
 					chain_node) {
 		in_use_descs++;
@@ -704,7 +708,10 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;
-	mv_xor_slot_cleanup(mv_chan);
+
+	spin_lock_bh(&mv_chan->lock);
+	__mv_xor_slot_cleanup(mv_chan);
+	spin_unlock_bh(&mv_chan->lock);
 
 	return dma_cookie_status(chan, cookie, txstate);
 }
-- 
1.9.0
