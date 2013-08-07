From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 12:19:30 +0200
Subject: [PATCH 12/12] dma: mmp_pdma: add support for cyclic DMA descriptors
In-Reply-To: <1375870770-14263-1-git-send-email-zonque@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
Message-ID: <1375870770-14263-13-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a callback to prepare cyclic DMA transfers.
This is for instance needed for audio channel transport.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 0c4a2d5..e95a685 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -97,6 +97,8 @@ struct mmp_pdma_chan {
 	struct dma_async_tx_descriptor desc;
 	struct mmp_pdma_phy *phy;
 	enum dma_transfer_direction dir;
+	struct mmp_pdma_desc_sw *cyclic_first;	/* first desc_sw if channel
+						 * is in cyclic mode */
 	/*
 	 * We memorize the original start address of the first descriptor as
 	 * well as the original total length so we can later determine the
@@ -530,6 +532,8 @@ mmp_pdma_prep_memcpy(struct dma_chan *dchan,
 	new->desc.ddadr = DDADR_STOP;
 	new->desc.dcmd |= DCMD_ENDIRQEN;
 
+	chan->cyclic_first = NULL;
+
 	return &first->async_tx;
 
 fail:
@@ -611,6 +615,96 @@ mmp_pdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	new->desc.ddadr = DDADR_STOP;
 	new->desc.dcmd |= DCMD_ENDIRQEN;
 
+	chan->dir = dir;
+	chan->cyclic_first = NULL;
+
+	return &first->async_tx;
+
+fail:
+	if (first)
+		mmp_pdma_free_desc_list(chan, &first->tx_list);
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *mmp_pdma_prep_dma_cyclic(
+	struct dma_chan *dchan, dma_addr_t buf_addr, size_t len,
+	size_t period_len, enum dma_transfer_direction direction,
+	unsigned long flags, void *context)
+{
+	struct mmp_pdma_chan *chan;
+	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new;
+	dma_addr_t dma_src, dma_dst;
+
+	if (!dchan || !len || !period_len)
+		return NULL;
+
+	/* the buffer length must be a multiple of period_len */
+	if (len % period_len != 0)
+		return NULL;
+
+	if (period_len > PDMA_MAX_DESC_BYTES)
+		return NULL;
+
+	chan = to_mmp_pdma_chan(dchan);
+
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		dma_src = buf_addr;
+		dma_dst = chan->dev_addr;
+		break;
+	case DMA_DEV_TO_MEM:
+		dma_dst = buf_addr;
+		dma_src = chan->dev_addr;
+		break;
+	default:
+		dev_err(chan->dev, "Unsupported direction for cyclic DMA\n");
+		return NULL;
+	}
+
+	chan->start_addr = buf_addr;
+	chan->total_len = len;
+	chan->dir = direction;
+
+	do {
+		/* Allocate the link descriptor from DMA pool */
+		new = mmp_pdma_alloc_descriptor(chan);
+		if (!new) {
+			dev_err(chan->dev, "no memory for desc\n");
+			goto fail;
+		}
+
+		new->desc.dcmd = chan->dcmd | DCMD_ENDIRQEN |
+					(DCMD_LENGTH & period_len);
+		new->desc.dsadr = dma_src;
+		new->desc.dtadr = dma_dst;
+
+		if (!first)
+			first = new;
+		else
+			prev->desc.ddadr = new->async_tx.phys;
+
+		new->async_tx.cookie = 0;
+		async_tx_ack(&new->async_tx);
+
+		prev = new;
+		len -= period_len;
+
+		if (chan->dir == DMA_MEM_TO_DEV)
+			dma_src += period_len;
+		else
+			dma_dst += period_len;
+
+		/* Insert the link descriptor to the LD ring */
+		list_add_tail(&new->node, &first->tx_list);
+	} while (len);
+
+	first->async_tx.flags = flags; /* client is in control of this ack */
+	first->async_tx.cookie = -EBUSY;
+
+	/* make the cyclic link */
+	new->desc.ddadr = first->async_tx.phys;
+	chan->cyclic_first = first;
+
 	return &first->async_tx;
 
 fail:
@@ -746,8 +840,25 @@ static void dma_do_tasklet(unsigned long data)
 	LIST_HEAD(chain_cleanup);
 	unsigned long flags;
 
-	/* submit pending list; callback for each desc; free desc */
+	if (chan->cyclic_first) {
+		dma_async_tx_callback cb = NULL;
+		void *cb_data = NULL;
+
+		spin_lock_irqsave(&chan->desc_lock, flags);
+		desc = chan->cyclic_first;
+		cb = desc->async_tx.callback;
+		cb_data = desc->async_tx.callback_param;
+		spin_unlock_irqrestore(&chan->desc_lock, flags);
+
+		start_pending_queue(chan);
 
+		if (cb)
+			cb(cb_data);
+
+		return;
+	}
+
+	/* submit pending list; callback for each desc; free desc */
 	spin_lock_irqsave(&chan->desc_lock, flags);
 
 	/* update the cookie if we have some descriptors to cleanup */
@@ -780,6 +891,7 @@ static void dma_do_tasklet(unsigned long data)
 
 		/* Remove from the list of transactions */
 		list_del(&desc->node);
+
 		/* Run the link descriptor callback function */
 		if (txd->callback)
 			txd->callback(txd->callback_param);
@@ -908,12 +1020,14 @@ static int mmp_pdma_probe(struct platform_device *op)
 
 	dma_cap_set(DMA_SLAVE, pdev->device.cap_mask);
 	dma_cap_set(DMA_MEMCPY, pdev->device.cap_mask);
+	dma_cap_set(DMA_CYCLIC, pdev->device.cap_mask);
 	pdev->device.dev = &op->dev;
 	pdev->device.device_alloc_chan_resources = mmp_pdma_alloc_chan_resources;
 	pdev->device.device_free_chan_resources = mmp_pdma_free_chan_resources;
 	pdev->device.device_tx_status = mmp_pdma_tx_status;
 	pdev->device.device_prep_dma_memcpy = mmp_pdma_prep_memcpy;
 	pdev->device.device_prep_slave_sg = mmp_pdma_prep_slave_sg;
+	pdev->device.device_prep_dma_cyclic = mmp_pdma_prep_dma_cyclic;
 	pdev->device.device_issue_pending = mmp_pdma_issue_pending;
 	pdev->device.device_control = mmp_pdma_control;
 	pdev->device.copy_align = PDMA_ALIGNMENT;
-- 
1.8.3.1
