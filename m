From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Wed, 14 Oct 2015 19:25:07 +0530
Subject: [PATCH] dmaengine: xgene-dma: Remove memcpy offload support due to
 performance drop
Message-ID: <1444830907-8035-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA engine supports memory copy, RAID5 XOR, RAID6 PQ, and other
computations. But the bandwidth of the entire DMA engine is shared
among all channels. This patch re-configures operations availability
such that one can achieve maximum performance for XOR and PQ
computation by removing the memory offload operations.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
---
 drivers/dma/xgene-dma.c | 59 +------------------------------------------------
 1 file changed, 1 insertion(+), 58 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 8d57b1b..b291733 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -894,60 +894,6 @@ static void xgene_dma_free_chan_resources(struct dma_chan *dchan)
 	chan->desc_pool = NULL;
 }

-static struct dma_async_tx_descriptor *xgene_dma_prep_memcpy(
-	struct dma_chan *dchan, dma_addr_t dst, dma_addr_t src,
-	size_t len, unsigned long flags)
-{
-	struct xgene_dma_desc_sw *first = NULL, *new;
-	struct xgene_dma_chan *chan;
-	size_t copy;
-
-	if (unlikely(!dchan || !len))
-		return NULL;
-
-	chan = to_dma_chan(dchan);
-
-	do {
-		/* Allocate the link descriptor from DMA pool */
-		new = xgene_dma_alloc_descriptor(chan);
-		if (!new)
-			goto fail;
-
-		/* Create the largest transaction possible */
-		copy = min_t(size_t, len, XGENE_DMA_MAX_64B_DESC_BYTE_CNT);
-
-		/* Prepare DMA descriptor */
-		xgene_dma_prep_cpy_desc(chan, new, dst, src, copy);
-
-		if (!first)
-			first = new;
-
-		new->tx.cookie = 0;
-		async_tx_ack(&new->tx);
-
-		/* Update metadata */
-		len -= copy;
-		dst += copy;
-		src += copy;
-
-		/* Insert the link descriptor to the LD ring */
-		list_add_tail(&new->node, &first->tx_list);
-	} while (len);
-
-	new->tx.flags = flags; /* client is in control of this ack */
-	new->tx.cookie = -EBUSY;
-	list_splice(&first->tx_list, &new->tx_list);
-
-	return &new->tx;
-
-fail:
-	if (!first)
-		return NULL;
-
-	xgene_dma_free_desc_list(chan, &first->tx_list);
-	return NULL;
-}
-
 static struct dma_async_tx_descriptor *xgene_dma_prep_sg(
 	struct dma_chan *dchan, struct scatterlist *dst_sg,
 	u32 dst_nents, struct scatterlist *src_sg,
@@ -1707,7 +1653,6 @@ static void xgene_dma_set_caps(struct xgene_dma_chan *chan,
 	dma_cap_zero(dma_dev->cap_mask);

 	/* Set DMA device capability */
-	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
 	dma_cap_set(DMA_SG, dma_dev->cap_mask);

 	/* Basically here, the X-Gene SoC DMA engine channel 0 supports XOR
@@ -1734,7 +1679,6 @@ static void xgene_dma_set_caps(struct xgene_dma_chan *chan,
 	dma_dev->device_free_chan_resources = xgene_dma_free_chan_resources;
 	dma_dev->device_issue_pending = xgene_dma_issue_pending;
 	dma_dev->device_tx_status = xgene_dma_tx_status;
-	dma_dev->device_prep_dma_memcpy = xgene_dma_prep_memcpy;
 	dma_dev->device_prep_dma_sg = xgene_dma_prep_sg;

 	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
@@ -1787,8 +1731,7 @@ static int xgene_dma_async_register(struct xgene_dma *pdma, int id)

 	/* DMA capability info */
 	dev_info(pdma->dev,
-		 "%s: CAPABILITY ( %s%s%s%s)\n", dma_chan_name(&chan->dma_chan),
-		 dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask) ? "MEMCPY " : "",
+		 "%s: CAPABILITY ( %s%s%s)\n", dma_chan_name(&chan->dma_chan),
 		 dma_has_cap(DMA_SG, dma_dev->cap_mask) ? "SGCPY " : "",
 		 dma_has_cap(DMA_XOR, dma_dev->cap_mask) ? "XOR " : "",
 		 dma_has_cap(DMA_PQ, dma_dev->cap_mask) ? "PQ " : "");
--
1.8.2.1
