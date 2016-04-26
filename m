From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 26 Apr 2016 17:30:37 +0100
Subject: [PATCH] dmaengine: pl330: Fix race in pl330_get_desc()
Message-ID: <bc03a8073460ebac253b80466d11654ee81f540e.1461687536.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current logic in pl330_get_desc() contains a clear race condition,
whereby if the descriptor pool is empty, we will create a new
descriptor, add it to the pool with the lock held, *release the lock*,
then try to remove it from the pool again.

Furthermore, if that second attempt then finds the pool empty because
someone else got there first, we conclude that something must have gone
terribly wrong and it's the absolute end of the world. In practice,
however, this can be hit relatively easily by dmatest with a suitably
aggressive number of threads and channels on a multi-core system, and
the fallout is a veritable storm of this sort of thing:

...
[  709.328891] dma-pl330 7ff00000.dma: pl330_get_desc:2459 ALERT!
** 10 printk messages dropped ** [  709.352280] dma-pl330 7ff00000.dma: __pl330_prep_dma_memcpy:2493 Unable to fetch desc
** 11 printk messages dropped ** [  709.372930] dma-pl330 7ff00000.dma: pl330_get_desc:2459 ALERT!
** 2 printk messages dropped ** [  709.372953] dma-pl330 7ff00000.dma: pl330_get_desc:2459 ALERT!
** 8 printk messages dropped ** [  709.374157] dma-pl330 7ff00000.dma: __pl330_prep_dma_memcpy:2493 Unable to fetch desc
** 41 printk messages dropped ** [  709.393095] dmatest: dma0chan4-copy1: result #4545: 'prep error' with src_off=0x3a32 dst_off=0x46dd len=0xc5c3 (0)
...

Down with this sort of thing! The most sensible thing to do is avoid the
allocate-add-remove dance entirely and simply use the freshly-allocated
descriptor straight away. We can then further simplify the code and save
unnecessary work by also inlining the initial pool allocation and
removing add_desc() entirely.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

I'm also seeing what looks like another occasional race under the same
conditions where pl330_tx_submit() blows up from dma_cookie_assign()
dereferencing a bogus tx->chan, but I think that's beyond my ability to
figure out right now. Similarly the storm of WARNs from pl330_issue_pending()
when using a large number of small buffers and dmatest.noverify=1. This
one was some obvious low-hanging fruit.

Robin.

 drivers/dma/pl330.c | 45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 372b4359da97..a196adb358f1 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2393,29 +2393,6 @@ static inline void _init_desc(struct dma_pl330_desc *desc)
 	INIT_LIST_HEAD(&desc->node);
 }
 
-/* Returns the number of descriptors added to the DMAC pool */
-static int add_desc(struct pl330_dmac *pl330, gfp_t flg, int count)
-{
-	struct dma_pl330_desc *desc;
-	unsigned long flags;
-	int i;
-
-	desc = kcalloc(count, sizeof(*desc), flg);
-	if (!desc)
-		return 0;
-
-	spin_lock_irqsave(&pl330->pool_lock, flags);
-
-	for (i = 0; i < count; i++) {
-		_init_desc(&desc[i]);
-		list_add_tail(&desc[i].node, &pl330->desc_pool);
-	}
-
-	spin_unlock_irqrestore(&pl330->pool_lock, flags);
-
-	return count;
-}
-
 static struct dma_pl330_desc *pluck_desc(struct pl330_dmac *pl330)
 {
 	struct dma_pl330_desc *desc = NULL;
@@ -2428,9 +2405,6 @@ static struct dma_pl330_desc *pluck_desc(struct pl330_dmac *pl330)
 				struct dma_pl330_desc, node);
 
 		list_del_init(&desc->node);
-
-		desc->status = PREP;
-		desc->txd.callback = NULL;
 	}
 
 	spin_unlock_irqrestore(&pl330->pool_lock, flags);
@@ -2449,19 +2423,18 @@ static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
 
 	/* If the DMAC pool is empty, alloc new */
 	if (!desc) {
-		if (!add_desc(pl330, GFP_ATOMIC, 1))
-			return NULL;
-
-		/* Try again */
-		desc = pluck_desc(pl330);
+		desc = kzalloc(sizeof(*desc), GFP_ATOMIC);
 		if (!desc) {
 			dev_err(pch->dmac->ddma.dev,
 				"%s:%d ALERT!\n", __func__, __LINE__);
 			return NULL;
 		}
+		_init_desc(desc);
 	}
 
 	/* Initialize the descriptor */
+	desc->status = PREP;
+	desc->txd.callback = NULL;
 	desc->pchan = pch;
 	desc->txd.cookie = 0;
 	async_tx_ack(&desc->txd);
@@ -2814,6 +2787,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	struct pl330_config *pcfg;
 	struct pl330_dmac *pl330;
 	struct dma_pl330_chan *pch, *_p;
+	struct dma_pl330_desc *desc;
 	struct dma_device *pd;
 	struct resource *res;
 	int i, ret, irq;
@@ -2874,8 +2848,15 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	spin_lock_init(&pl330->pool_lock);
 
 	/* Create a descriptor pool of default size */
-	if (!add_desc(pl330, GFP_KERNEL, NR_DEFAULT_DESC))
+	desc = kcalloc(NR_DEFAULT_DESC, sizeof(*desc), GFP_KERNEL);
+	if (desc) {
+		for (i = 0; i < NR_DEFAULT_DESC; i++) {
+			_init_desc(&desc[i]);
+			list_add_tail(&desc[i].node, &pl330->desc_pool);
+		}
+	} else {
 		dev_warn(&adev->dev, "unable to allocate desc\n");
+	}
 
 	INIT_LIST_HEAD(&pd->channels);
 
-- 
2.8.1.dirty
