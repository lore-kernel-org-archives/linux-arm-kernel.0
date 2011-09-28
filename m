From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 28 Sep 2011 14:55:21 +0530
Subject: [PATCH v5 2/6] DMA: PL330: Infer transfer direction from transfer
	request instead of platform data
In-Reply-To: <1317201925-25148-1-git-send-email-thomas.abraham@linaro.org>
References: <1317201925-25148-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1317201925-25148-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The transfer direction for a channel can be inferred from the transfer
request and the need for specifying transfer direction in platfrom data
can be eliminated. So the structure definition 'struct dma_pl330_peri'
is no longer required.

The channel's private data is set to point to a channel id specified in
the platform data (instead of an instance of type 'struct dma_pl330_peri').
The filter function is correspondingly modified to match the channel id.

With the 'struct dma_pl330_peri' removed from platform data, the dma
controller transfer capabilities cannot be inferred any more. Hence,
the dma controller capabilities is specified using platform data.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/dma/pl330.c        |   65 +++++++++++---------------------------------
 include/linux/amba/pl330.h |   13 ++-------
 2 files changed, 19 insertions(+), 59 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 5f1d24c..992bf82 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -272,13 +272,13 @@ static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
 
 bool pl330_filter(struct dma_chan *chan, void *param)
 {
-	struct dma_pl330_peri *peri;
+	u8 *peri_id;
 
 	if (chan->device->dev->driver != &pl330_driver.drv)
 		return false;
 
-	peri = chan->private;
-	return peri->peri_id == (unsigned)param;
+	peri_id = chan->private;
+	return *peri_id == (unsigned)param;
 }
 EXPORT_SYMBOL(pl330_filter);
 
@@ -512,7 +512,7 @@ pluck_desc(struct dma_pl330_dmac *pdmac)
 static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
 {
 	struct dma_pl330_dmac *pdmac = pch->dmac;
-	struct dma_pl330_peri *peri = pch->chan.private;
+	u8 *peri_id = pch->chan.private;
 	struct dma_pl330_desc *desc;
 
 	/* Pluck one desc from the pool of DMAC */
@@ -537,13 +537,7 @@ static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan *pch)
 	desc->txd.cookie = 0;
 	async_tx_ack(&desc->txd);
 
-	if (peri) {
-		desc->req.rqtype = peri->rqtype;
-		desc->req.peri = pch->chan.chan_id;
-	} else {
-		desc->req.rqtype = MEMTOMEM;
-		desc->req.peri = 0;
-	}
+	desc->req.peri = peri_id ? pch->chan.chan_id : 0;
 
 	dma_async_tx_descriptor_init(&desc->txd, &pch->chan);
 
@@ -630,12 +624,14 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 	case DMA_TO_DEVICE:
 		desc->rqcfg.src_inc = 1;
 		desc->rqcfg.dst_inc = 0;
+		desc->req.rqtype = MEMTODEV;
 		src = dma_addr;
 		dst = pch->fifo_addr;
 		break;
 	case DMA_FROM_DEVICE:
 		desc->rqcfg.src_inc = 0;
 		desc->rqcfg.dst_inc = 1;
+		desc->req.rqtype = DEVTOMEM;
 		src = pch->fifo_addr;
 		dst = dma_addr;
 		break;
@@ -661,16 +657,12 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 {
 	struct dma_pl330_desc *desc;
 	struct dma_pl330_chan *pch = to_pchan(chan);
-	struct dma_pl330_peri *peri = chan->private;
 	struct pl330_info *pi;
 	int burst;
 
 	if (unlikely(!pch || !len))
 		return NULL;
 
-	if (peri && peri->rqtype != MEMTOMEM)
-		return NULL;
-
 	pi = &pch->dmac->pif;
 
 	desc = __pl330_prep_dma_memcpy(pch, dst, src, len);
@@ -679,6 +671,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 
 	desc->rqcfg.src_inc = 1;
 	desc->rqcfg.dst_inc = 1;
+	desc->req.rqtype = MEMTOMEM;
 
 	/* Select max possible burst size */
 	burst = pi->pcfg.data_bus_width / 8;
@@ -707,24 +700,13 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 {
 	struct dma_pl330_desc *first, *desc = NULL;
 	struct dma_pl330_chan *pch = to_pchan(chan);
-	struct dma_pl330_peri *peri = chan->private;
 	struct scatterlist *sg;
 	unsigned long flags;
 	int i;
 	dma_addr_t addr;
 
-	if (unlikely(!pch || !sgl || !sg_len || !peri))
-		return NULL;
-
-	/* Make sure the direction is consistent */
-	if ((direction == DMA_TO_DEVICE &&
-				peri->rqtype != MEMTODEV) ||
-			(direction == DMA_FROM_DEVICE &&
-				peri->rqtype != DEVTOMEM)) {
-		dev_err(pch->dmac->pif.dev, "%s:%d Invalid Direction\n",
-				__func__, __LINE__);
+	if (unlikely(!pch || !sgl || !sg_len))
 		return NULL;
-	}
 
 	addr = pch->fifo_addr;
 
@@ -765,11 +747,13 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		if (direction == DMA_TO_DEVICE) {
 			desc->rqcfg.src_inc = 1;
 			desc->rqcfg.dst_inc = 0;
+			desc->req.rqtype = MEMTODEV;
 			fill_px(&desc->px,
 				addr, sg_dma_address(sg), sg_dma_len(sg));
 		} else {
 			desc->rqcfg.src_inc = 0;
 			desc->rqcfg.dst_inc = 1;
+			desc->req.rqtype = DEVTOMEM;
 			fill_px(&desc->px,
 				sg_dma_address(sg), addr, sg_dma_len(sg));
 		}
@@ -876,28 +860,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	for (i = 0; i < num_chan; i++) {
 		pch = &pdmac->peripherals[i];
-		if (pdat) {
-			struct dma_pl330_peri *peri = &pdat->peri[i];
-
-			switch (peri->rqtype) {
-			case MEMTOMEM:
-				dma_cap_set(DMA_MEMCPY, pd->cap_mask);
-				break;
-			case MEMTODEV:
-			case DEVTOMEM:
-				dma_cap_set(DMA_SLAVE, pd->cap_mask);
-				dma_cap_set(DMA_CYCLIC, pd->cap_mask);
-				break;
-			default:
-				dev_err(&adev->dev, "DEVTODEV Not Supported\n");
-				continue;
-			}
-			pch->chan.private = peri;
-		} else {
-			dma_cap_set(DMA_MEMCPY, pd->cap_mask);
-			pch->chan.private = NULL;
-		}
-
+		pch->chan.private = pdat ? &pdat->peri_id[i] : NULL;
 		INIT_LIST_HEAD(&pch->work_list);
 		spin_lock_init(&pch->lock);
 		pch->pl330_chid = NULL;
@@ -911,6 +874,10 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pd->dev = &adev->dev;
+	if (pdat)
+		pd->cap_mask = pdat->cap_mask;
+	else
+		dma_cap_set(DMA_MEMCPY, pd->cap_mask);
 
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
 	pd->device_free_chan_resources = pl330_free_chan_resources;
diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
index 6db72da..12e023c 100644
--- a/include/linux/amba/pl330.h
+++ b/include/linux/amba/pl330.h
@@ -15,15 +15,6 @@
 #include <linux/dmaengine.h>
 #include <asm/hardware/pl330.h>
 
-struct dma_pl330_peri {
-	/*
-	 * Peri_Req i/f of the DMAC that is
-	 * peripheral could be reached from.
-	 */
-	u8 peri_id; /* specific dma id */
-	enum pl330_reqtype rqtype;
-};
-
 struct dma_pl330_platdata {
 	/*
 	 * Number of valid peripherals connected to DMAC.
@@ -34,7 +25,9 @@ struct dma_pl330_platdata {
 	 */
 	u8 nr_valid_peri;
 	/* Array of valid peripherals */
-	struct dma_pl330_peri *peri;
+	u8 *peri_id;
+	/* Operational capabilities */
+	dma_cap_mask_t cap_mask;
 	/* Bytes to allocate for MC buffer */
 	unsigned mcbuf_sz;
 };
-- 
1.6.6.rc2
