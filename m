From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 25 Aug 2011 11:13:34 +0900
Subject: [PATCH v7 04/15] DMA: PL330: Add DMA_CYCLIC capability
In-Reply-To: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
References: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314238425-6480-5-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA_CYCLIC capability that is used for audio driver.
DMA driver activated with it reuses the dma requests that were submitted
through tx_submit().

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/dma/pl330.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 59943ec..95976cf 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -75,6 +75,9 @@ struct dma_pl330_chan {
 	int burst_sz; /* the peripheral fifo width */
 	int burst_len; /* the number of burst */
 	dma_addr_t fifo_addr;
+
+	/* for cyclic capability */
+	bool cyclic;
 };
 
 struct dma_pl330_dmac {
@@ -161,6 +164,31 @@ static inline void free_desc_list(struct list_head *list)
 	spin_unlock_irqrestore(&pdmac->pool_lock, flags);
 }
 
+static inline void handle_cyclic_desc_list(struct list_head *list)
+{
+	struct dma_pl330_desc *desc;
+	struct dma_pl330_chan *pch;
+	unsigned long flags;
+
+	if (list_empty(list))
+		return;
+
+	list_for_each_entry(desc, list, node) {
+		dma_async_tx_callback callback;
+
+		/* Change status to reload it */
+		desc->status = PREP;
+		pch = desc->pchan;
+		callback = desc->txd.callback;
+		if (callback)
+			callback(desc->txd.callback_param);
+	}
+
+	spin_lock_irqsave(&pch->lock, flags);
+	list_splice_tail_init(list, &pch->work_list);
+	spin_unlock_irqrestore(&pch->lock, flags);
+}
+
 static inline void fill_queue(struct dma_pl330_chan *pch)
 {
 	struct dma_pl330_desc *desc;
@@ -214,7 +242,10 @@ static void pl330_tasklet(unsigned long data)
 
 	spin_unlock_irqrestore(&pch->lock, flags);
 
-	free_desc_list(&list);
+	if (pch->cyclic)
+		handle_cyclic_desc_list(&list);
+	else
+		free_desc_list(&list);
 }
 
 static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
@@ -245,6 +276,7 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 	spin_lock_irqsave(&pch->lock, flags);
 
 	pch->completed = chan->cookie = 1;
+	pch->cyclic = false;
 
 	pch->pl330_chid = pl330_request_channel(&pdmac->pif);
 	if (!pch->pl330_chid) {
@@ -324,6 +356,9 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	pl330_release_channel(pch->pl330_chid);
 	pch->pl330_chid = NULL;
 
+	if (pch->cyclic)
+		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
+
 	spin_unlock_irqrestore(&pch->lock, flags);
 }
 
@@ -347,7 +382,9 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 static void pl330_issue_pending(struct dma_chan *chan)
 {
-	pl330_tasklet((unsigned long) to_pchan(chan));
+	struct dma_pl330_chan *pch = to_pchan(chan);
+
+	pl330_tasklet((unsigned long) pch);
 }
 
 /*
@@ -560,6 +597,51 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
 	return burst_len;
 }
 
+static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
+		struct dma_chan *chan, dma_addr_t dma_addr, size_t len,
+		size_t period_len, enum dma_data_direction direction)
+{
+	struct dma_pl330_desc *desc;
+	struct dma_pl330_chan *pch = to_pchan(chan);
+	dma_addr_t dst;
+	dma_addr_t src;
+
+	desc = pl330_get_desc(pch);
+	if (!desc) {
+		dev_err(pch->dmac->pif.dev, "%s:%d Unable to fetch desc\n",
+			__func__, __LINE__);
+		return NULL;
+	}
+
+	switch (direction) {
+	case DMA_TO_DEVICE:
+		desc->rqcfg.src_inc = 1;
+		desc->rqcfg.dst_inc = 0;
+		src = dma_addr;
+		dst = pch->fifo_addr;
+		break;
+	case DMA_FROM_DEVICE:
+		desc->rqcfg.src_inc = 0;
+		desc->rqcfg.dst_inc = 1;
+		src = pch->fifo_addr;
+		dst = dma_addr;
+		break;
+	default:
+		dev_err(pch->dmac->pif.dev, "%s:%d Invalid dma direction\n",
+		__func__, __LINE__);
+		return NULL;
+	}
+
+	desc->rqcfg.brst_size = pch->burst_sz;
+	desc->rqcfg.brst_len = 1;
+
+	pch->cyclic = true;
+
+	fill_px(&desc->px, dst, src, period_len);
+
+	return &desc->txd;
+}
+
 static struct dma_async_tx_descriptor *
 pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 		dma_addr_t src, size_t len, unsigned long flags)
@@ -791,6 +873,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 			case MEMTODEV:
 			case DEVTOMEM:
 				dma_cap_set(DMA_SLAVE, pd->cap_mask);
+				dma_cap_set(DMA_CYCLIC, pd->cap_mask);
 				break;
 			default:
 				dev_err(&adev->dev, "DEVTODEV Not Supported\n");
@@ -819,6 +902,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
 	pd->device_free_chan_resources = pl330_free_chan_resources;
 	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
+	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
 	pd->device_control = pl330_control;
-- 
1.7.1
