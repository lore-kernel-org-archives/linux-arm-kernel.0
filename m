From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 27 Dec 2013 12:38:33 +0100
Subject: [PATCH 2/3] dma: mv_xor: use __mv_xor_slot_cleanup() in
 mv_xor_free_chan_resources()
In-Reply-To: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388144314-1581-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1388144314-1581-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv_xor_free_chan_resources() was doing:

 1/ Call mv_xor_slot_cleanup, which take the channel spinlock, does
    its work, and releases the channel spinlock
 2/ Take the channel spinlock
 3/ Do its work
 4/ Release the channel spinlock

This commit changes the function to use the __mv_xor_slot_cleanup()
variant of mv_xor_slot_cleanup(), which assumes the caller already
holds the channel spinlock. The sequence becomes:

 1/ Take the channel spinlock
 2/ Call __mv_xor_slot_cleanup
 3/ Do the rest of the work
 4/ Release the channel spinlock

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 526ab27..3d7d36b 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -658,9 +658,10 @@ static void mv_xor_free_chan_resources(struct dma_chan *chan)
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
-- 
1.8.3.2
