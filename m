From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 27 Dec 2013 12:38:34 +0100
Subject: [PATCH 3/3] dma: mv_xor: rename __mv_xor_slot_cleanup() to
 mv_xor_slot_cleanup()
In-Reply-To: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1388144314-1581-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mv_xor_slot_cleanup() has only one remaining caller: the mv_xor_tasklet(), we:

 1/ get rid of mv_xor_slot_cleanup(), and directly take/release the
    spinlock in mv_xor_tasklet()

 2/ rename __mv_xor_slot_cleanup() to mv_xor_slot_cleanup()

We take this opportunity to add a comment that makes it clear that the
channel spinlock should be held before calling mv_xor_slot_cleanup().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 3d7d36b..611795e 100644
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
@@ -368,18 +369,12 @@ static void __mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
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
+	spin_lock_bh(&chan->lock);
 	mv_xor_slot_cleanup(chan);
+	spin_unlock_bh(&chan->lock);
 }
 
 static struct mv_xor_desc_slot *
@@ -660,7 +655,7 @@ static void mv_xor_free_chan_resources(struct dma_chan *chan)
 
 	spin_lock_bh(&mv_chan->lock);
 
-	__mv_xor_slot_cleanup(mv_chan);
+	mv_xor_slot_cleanup(mv_chan);
 
 	list_for_each_entry_safe(iter, _iter, &mv_chan->chain,
 					chain_node) {
@@ -710,7 +705,7 @@ static enum dma_status mv_xor_status(struct dma_chan *chan,
 		spin_unlock_bh(&mv_chan->lock);
 		return ret;
 	}
-	__mv_xor_slot_cleanup(mv_chan);
+	mv_xor_slot_cleanup(mv_chan);
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 	spin_unlock_bh(&mv_chan->lock);
-- 
1.8.3.2
