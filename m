From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 16 Nov 2015 13:09:03 +0200
Subject: [PATCH] dmaengine: bcm2835-dma: Convert to use DMA pool
Message-ID: <1447672143-14201-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

f93178291712 dmaengine: bcm2835-dma: Fix memory leak when stopping a
	     running transfer

Fixed the memleak, but introduced another issue: the terminate_all callback
might be called with interrupts disabled and the dma_free_coherent() is
not allowed to be called when IRQs are disabled.
Convert the driver to use dma_pool_* for managing the list of control
blocks for the transfer.

Fixes: f93178291712 ("dmaengine: bcm2835-dma: Fix memory leak when stopping a running transfer")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

It was brought to my attention that the memleak fix broke the bcm2835 DMA. I did
not noticed the use of dma_free_coherent() in the driver when I did the memleak
fix.
Since the driver does leaking memory every time the audio is stopped, the other
option is to convert it to use DMA pool.
I do not have access the Raspberry Pi, so I can not test this patch but it
compiles ;)
Can someone test this one outif it is working?

Regards,
Peter

 drivers/dma/bcm2835-dma.c | 78 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index c92d6a70ccf3..996c4b00d323 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -31,6 +31,7 @@
  */
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -62,6 +63,11 @@ struct bcm2835_dma_cb {
 	uint32_t pad[2];
 };
 
+struct bcm2835_cb_entry {
+	struct bcm2835_dma_cb *cb;
+	dma_addr_t paddr;
+};
+
 struct bcm2835_chan {
 	struct virt_dma_chan vc;
 	struct list_head node;
@@ -72,18 +78,18 @@ struct bcm2835_chan {
 
 	int ch;
 	struct bcm2835_desc *desc;
+	struct dma_pool *cb_pool;
 
 	void __iomem *chan_base;
 	int irq_number;
 };
 
 struct bcm2835_desc {
+	struct bcm2835_chan *c;
 	struct virt_dma_desc vd;
 	enum dma_transfer_direction dir;
 
-	unsigned int control_block_size;
-	struct bcm2835_dma_cb *control_block_base;
-	dma_addr_t control_block_base_phys;
+	struct bcm2835_cb_entry *cb_list;
 
 	unsigned int frames;
 	size_t size;
@@ -143,10 +149,13 @@ static inline struct bcm2835_desc *to_bcm2835_dma_desc(
 static void bcm2835_dma_desc_free(struct virt_dma_desc *vd)
 {
 	struct bcm2835_desc *desc = container_of(vd, struct bcm2835_desc, vd);
-	dma_free_coherent(desc->vd.tx.chan->device->dev,
-			desc->control_block_size,
-			desc->control_block_base,
-			desc->control_block_base_phys);
+	int i;
+
+	for (i = 0; i < desc->frames; i++)
+		dma_pool_free(desc->c->cb_pool, desc->cb_list[i].cb,
+			      desc->cb_list[i].paddr);
+
+	kfree(desc->cb_list);
 	kfree(desc);
 }
 
@@ -199,7 +208,7 @@ static void bcm2835_dma_start_desc(struct bcm2835_chan *c)
 
 	c->desc = d = to_bcm2835_dma_desc(&vd->tx);
 
-	writel(d->control_block_base_phys, c->chan_base + BCM2835_DMA_ADDR);
+	writel(d->cb_list[0].paddr, c->chan_base + BCM2835_DMA_ADDR);
 	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
 }
 
@@ -232,9 +241,16 @@ static irqreturn_t bcm2835_dma_callback(int irq, void *data)
 static int bcm2835_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
+	struct device *dev = c->vc.chan.device->dev;
+
+	dev_dbg(dev, "Allocating DMA channel %d\n", c->ch);
 
-	dev_dbg(c->vc.chan.device->dev,
-			"Allocating DMA channel %d\n", c->ch);
+	c->cb_pool = dma_pool_create(dev_name(dev), dev,
+				     sizeof(struct bcm2835_dma_cb), 0, 0);
+	if (!c->cb_pool) {
+		dev_err(dev, "unable to allocate descriptor pool\n");
+		return -ENOMEM;
+	}
 
 	return request_irq(c->irq_number,
 			bcm2835_dma_callback, 0, "DMA IRQ", c);
@@ -246,6 +262,7 @@ static void bcm2835_dma_free_chan_resources(struct dma_chan *chan)
 
 	vchan_free_chan_resources(&c->vc);
 	free_irq(c->irq_number, c);
+	dma_pool_destroy(c->cb_pool);
 
 	dev_dbg(c->vc.chan.device->dev, "Freeing DMA channel %u\n", c->ch);
 }
@@ -261,8 +278,7 @@ static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
 	size_t size;
 
 	for (size = i = 0; i < d->frames; i++) {
-		struct bcm2835_dma_cb *control_block =
-			&d->control_block_base[i];
+		struct bcm2835_dma_cb *control_block = d->cb_list[i].cb;
 		size_t this_size = control_block->length;
 		dma_addr_t dma;
 
@@ -343,6 +359,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	dma_addr_t dev_addr;
 	unsigned int es, sync_type;
 	unsigned int frame;
+	int i;
 
 	/* Grab configuration */
 	if (!is_slave_direction(direction)) {
@@ -374,27 +391,31 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	if (!d)
 		return NULL;
 
+	d->c = c;
 	d->dir = direction;
 	d->frames = buf_len / period_len;
 
-	/* Allocate memory for control blocks */
-	d->control_block_size = d->frames * sizeof(struct bcm2835_dma_cb);
-	d->control_block_base = dma_zalloc_coherent(chan->device->dev,
-			d->control_block_size, &d->control_block_base_phys,
-			GFP_NOWAIT);
-
-	if (!d->control_block_base) {
+	d->cb_list = kcalloc(d->frames, sizeof(*d->cb_list), GFP_KERNEL);
+	if (!d->cb_list) {
 		kfree(d);
 		return NULL;
 	}
+	/* Allocate memory for control blocks */
+	for (i = 0; i < d->frames; i++) {
+		struct bcm2835_cb_entry *cb_entry = &d->cb_list[i];
+
+		cb_entry->cb = dma_pool_zalloc(c->cb_pool, GFP_ATOMIC,
+					       &cb_entry->paddr);
+		if (!cb_entry->cb)
+			goto error_cb;
+	}
 
 	/*
 	 * Iterate over all frames, create a control block
 	 * for each frame and link them together.
 	 */
 	for (frame = 0; frame < d->frames; frame++) {
-		struct bcm2835_dma_cb *control_block =
-			&d->control_block_base[frame];
+		struct bcm2835_dma_cb *control_block = d->cb_list[frame].cb;
 
 		/* Setup adresses */
 		if (d->dir == DMA_DEV_TO_MEM) {
@@ -428,12 +449,21 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		 * This DMA engine driver currently only supports cyclic DMA.
 		 * Therefore, wrap around at number of frames.
 		 */
-		control_block->next = d->control_block_base_phys +
-			sizeof(struct bcm2835_dma_cb)
-			* ((frame + 1) % d->frames);
+		control_block->next = d->cb_list[((frame + 1) % d->frames)].paddr;
 	}
 
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
+error_cb:
+	i--;
+	for (; i >= 0; i--) {
+		struct bcm2835_cb_entry *cb_entry = &d->cb_list[i];
+
+		dma_pool_free(c->cb_pool, cb_entry->cb, cb_entry->paddr);
+	}
+
+	kfree(d->cb_list);
+	kfree(d);
+	return NULL;
 }
 
 static int bcm2835_dma_slave_config(struct dma_chan *chan,
-- 
2.6.2
