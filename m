From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:57 +0100
Subject: [PATCH 19/30] dma: mv_xor: in mv_xor_chan,
 rename 'common' to 'dmachan'
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-20-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv_xor_chan structure embeds a 'struct dma_chan', which is named
'common', a not very meaningful name. Rename it to 'dmachan', which
will help avoid confusions later as we merge the mv_xor_device and
mv_xor_chan structures together.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   12 ++++++------
 drivers/dma/mv_xor.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 6e705ea..491f506 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -34,7 +34,7 @@
 static void mv_xor_issue_pending(struct dma_chan *chan);
 
 #define to_mv_xor_chan(chan)		\
-	container_of(chan, struct mv_xor_chan, common)
+	container_of(chan, struct mv_xor_chan, dmachan)
 
 #define to_mv_xor_slot(tx)		\
 	container_of(tx, struct mv_xor_desc_slot, async_tx)
@@ -284,7 +284,7 @@ static void mv_xor_start_new_chain(struct mv_xor_chan *mv_chan,
 		mv_chan_set_next_descriptor(mv_chan, sw_desc->async_tx.phys);
 	}
 	mv_chan->pending += sw_desc->slot_cnt;
-	mv_xor_issue_pending(&mv_chan->common);
+	mv_xor_issue_pending(&mv_chan->dmachan);
 }
 
 static dma_cookie_t
@@ -437,7 +437,7 @@ static void __mv_xor_slot_cleanup(struct mv_xor_chan *mv_chan)
 	}
 
 	if (cookie > 0)
-		mv_chan->common.completed_cookie = cookie;
+		mv_chan->dmachan.completed_cookie = cookie;
 }
 
 static void
@@ -1177,10 +1177,10 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 	INIT_LIST_HEAD(&mv_chan->chain);
 	INIT_LIST_HEAD(&mv_chan->completed_slots);
 	INIT_LIST_HEAD(&mv_chan->all_slots);
-	mv_chan->common.device = dma_dev;
-	dma_cookie_init(&mv_chan->common);
+	mv_chan->dmachan.device = dma_dev;
+	dma_cookie_init(&mv_chan->dmachan);
 
-	list_add_tail(&mv_chan->common.device_node, &dma_dev->channels);
+	list_add_tail(&mv_chan->dmachan.device_node, &dma_dev->channels);
 
 	if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
 		ret = mv_xor_memcpy_self_test(adev);
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 05add24..ad18f64 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -101,7 +101,7 @@ struct mv_xor_chan {
 	struct list_head	chain;
 	struct list_head	completed_slots;
 	struct mv_xor_device	*device;
-	struct dma_chan		common;
+	struct dma_chan		dmachan;
 	struct mv_xor_desc_slot	*last_used;
 	struct list_head	all_slots;
 	int			slots_allocated;
-- 
1.7.9.5
