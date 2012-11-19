From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:05:00 +0100
Subject: [PATCH 22/30] dma: mv_xor: merge mv_xor_device and mv_xor_chan
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-23-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though the DMA engine infrastructure has support for multiple
channels per device, the mv_xor driver registers one DMA engine device
for each channel, because the mv_xor channels inside the same XOR
engine have different capabilities, and the DMA engine infrastructure
only allows to express capabilities at the DMA engine device level.

The mv_xor driver has therefore been registering one DMA engine device
and one DMA engine channel for each XOR channel since its introduction
in the kernel. However, it kept two separate internal structures,
mv_xor_device and mv_xor_channel, which didn't make a lot of sense
since there was a 1:1 mapping between those structures.

This patch gets rid of this duplication, and merges everything into
the mv_xor_chan structure.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   64 ++++++++++++++++++++++----------------------------
 drivers/dma/mv_xor.h |   25 +++++---------------
 2 files changed, 34 insertions(+), 55 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 75a8051..3b81ee1 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -40,7 +40,7 @@ static void mv_xor_issue_pending(struct dma_chan *chan);
 	container_of(tx, struct mv_xor_desc_slot, async_tx)
 
 #define mv_chan_to_devp(chan)           \
-	((chan)->device->dmadev.dev)
+	((chan)->dmadev.dev)
 
 static void mv_desc_init(struct mv_xor_desc_slot *desc, unsigned long flags)
 {
@@ -603,7 +603,7 @@ static int mv_xor_alloc_chan_resources(struct dma_chan *chan)
 	int idx;
 	struct mv_xor_chan *mv_chan = to_mv_xor_chan(chan);
 	struct mv_xor_desc_slot *slot = NULL;
-	int num_descs_in_pool = mv_chan->device->pool_size/MV_XOR_SLOT_SIZE;
+	int num_descs_in_pool = mv_chan->pool_size/MV_XOR_SLOT_SIZE;
 
 	/* Allocate descriptor slots */
 	idx = mv_chan->slots_allocated;
@@ -614,7 +614,7 @@ static int mv_xor_alloc_chan_resources(struct dma_chan *chan)
 				" %d descriptor slots", idx);
 			break;
 		}
-		hw_desc = (char *) mv_chan->device->dma_desc_pool_virt;
+		hw_desc = (char *) mv_chan->dma_desc_pool_virt;
 		slot->hw_desc = (void *) &hw_desc[idx * MV_XOR_SLOT_SIZE];
 
 		dma_async_tx_descriptor_init(&slot->async_tx, chan);
@@ -622,7 +622,7 @@ static int mv_xor_alloc_chan_resources(struct dma_chan *chan)
 		INIT_LIST_HEAD(&slot->chain_node);
 		INIT_LIST_HEAD(&slot->slot_node);
 		INIT_LIST_HEAD(&slot->tx_list);
-		hw_desc = (char *) mv_chan->device->dma_desc_pool;
+		hw_desc = (char *) mv_chan->dma_desc_pool;
 		slot->async_tx.phys =
 			(dma_addr_t) &hw_desc[idx * MV_XOR_SLOT_SIZE];
 		slot->idx = idx++;
@@ -1067,58 +1067,58 @@ out:
 	return err;
 }
 
-static int mv_xor_channel_remove(struct mv_xor_device *device)
+static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 {
 	struct dma_chan *chan, *_chan;
-	struct mv_xor_chan *mv_chan;
-	struct device *dev = device->dmadev.dev;
+	struct device *dev = mv_chan->dmadev.dev;
 
-	dma_async_device_unregister(&device->dmadev);
+	dma_async_device_unregister(&mv_chan->dmadev);
 
-	dma_free_coherent(dev, device->pool_size,
-			  device->dma_desc_pool_virt, device->dma_desc_pool);
+	dma_free_coherent(dev, mv_chan->pool_size,
+			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 
-	list_for_each_entry_safe(chan, _chan, &device->dmadev.channels,
+	list_for_each_entry_safe(chan, _chan, &mv_chan->dmadev.channels,
 				 device_node) {
-		mv_chan = to_mv_xor_chan(chan);
 		list_del(&chan->device_node);
 	}
 
 	return 0;
 }
 
-static struct mv_xor_device *
+static struct mv_xor_chan *
 mv_xor_channel_add(struct mv_xor_private *msp,
 		   struct platform_device *pdev,
 		   int hw_id, dma_cap_mask_t cap_mask,
 		   size_t pool_size, int irq)
 {
 	int ret = 0;
-	struct mv_xor_device *adev;
 	struct mv_xor_chan *mv_chan;
 	struct dma_device *dma_dev;
 
-	adev = devm_kzalloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
-	if (!adev)
-		return ERR_PTR(-ENOMEM);
+	mv_chan = devm_kzalloc(&pdev->dev, sizeof(*mv_chan), GFP_KERNEL);
+	if (!mv_chan) {
+		ret = -ENOMEM;
+		goto err_free_dma;
+	}
+
+	mv_chan->idx = hw_id;
 
-	dma_dev = &adev->dmadev;
+	dma_dev = &mv_chan->dmadev;
 
 	/* allocate coherent memory for hardware descriptors
 	 * note: writecombine gives slightly better performance, but
 	 * requires that we explicitly flush the writes
 	 */
-	adev->pool_size = pool_size;
-	adev->dma_desc_pool_virt = dma_alloc_writecombine(&pdev->dev,
-							  adev->pool_size,
-							  &adev->dma_desc_pool,
-							  GFP_KERNEL);
-	if (!adev->dma_desc_pool_virt)
+	mv_chan->pool_size = pool_size;
+	mv_chan->dma_desc_pool_virt =
+	  dma_alloc_writecombine(&pdev->dev, mv_chan->pool_size,
+				 &mv_chan->dma_desc_pool, GFP_KERNEL);
+	if (!mv_chan->dma_desc_pool_virt)
 		return ERR_PTR(-ENOMEM);
 
 	/* discover transaction capabilites from the platform data */
 	dma_dev->cap_mask = cap_mask;
-	adev->shared = msp;
+	mv_chan->shared = msp;
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
@@ -1139,15 +1139,7 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 		dma_dev->device_prep_dma_xor = mv_xor_prep_dma_xor;
 	}
 
-	mv_chan = devm_kzalloc(&pdev->dev, sizeof(*mv_chan), GFP_KERNEL);
-	if (!mv_chan) {
-		ret = -ENOMEM;
-		goto err_free_dma;
-	}
-	mv_chan->device = adev;
-	mv_chan->idx = hw_id;
-	mv_chan->mmr_base = adev->shared->xor_base;
-
+	mv_chan->mmr_base = msp->xor_base;
 	if (!mv_chan->mmr_base) {
 		ret = -ENOMEM;
 		goto err_free_dma;
@@ -1199,11 +1191,11 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 	  dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask) ? "intr " : "");
 
 	dma_async_device_register(dma_dev);
-	return adev;
+	return mv_chan;
 
  err_free_dma:
 	dma_free_coherent(&pdev->dev, pool_size,
-			adev->dma_desc_pool_virt, adev->dma_desc_pool);
+			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 84255e6..16de1f6 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -57,24 +57,7 @@ struct mv_xor_private {
 	void __iomem	     *xor_base;
 	void __iomem	     *xor_high_base;
 	struct clk	     *clk;
-	struct mv_xor_device *channels[MV_XOR_MAX_CHANNELS];
-};
-
-
-/**
- * struct mv_xor_device - internal representation of a XOR device
- * @pdev: Platform device
- * @id: HW XOR Device selector
- * @dma_desc_pool: base of DMA descriptor region (DMA address)
- * @dma_desc_pool_virt: base of DMA descriptor region (CPU address)
- * @common: embedded struct dma_device
- */
-struct mv_xor_device {
-	dma_addr_t			dma_desc_pool;
-	void				*dma_desc_pool_virt;
-	size_t                          pool_size;
-	struct dma_device		dmadev;
-	struct mv_xor_private	        *shared;
+	struct mv_xor_chan   *channels[MV_XOR_MAX_CHANNELS];
 };
 
 /**
@@ -100,7 +83,11 @@ struct mv_xor_chan {
 	enum dma_transaction_type	current_type;
 	struct list_head	chain;
 	struct list_head	completed_slots;
-	struct mv_xor_device	*device;
+	dma_addr_t		dma_desc_pool;
+	void			*dma_desc_pool_virt;
+	size_t                  pool_size;
+	struct dma_device	dmadev;
+	struct mv_xor_private	*shared;
 	struct dma_chan		dmachan;
 	struct mv_xor_desc_slot	*last_used;
 	struct list_head	all_slots;
-- 
1.7.9.5
