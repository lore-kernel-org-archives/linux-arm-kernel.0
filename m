From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon,  4 Jul 2011 21:18:31 +0900
Subject: [PATCH 3/7] DMA: PL330: Add DMA capabilities
In-Reply-To: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309781915-31549-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch adds DMA_CYCLIC capability that is used for audio driver
and SLAVE_CONFIG capability for transmit between device and memory.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/dma/pl330.c |  114 ++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 100 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 0f80af8..e2a59c2 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -254,25 +254,58 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd, unsigned long arg)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
-	struct dma_pl330_desc *desc;
+	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
+	struct dma_pl330_dmac *pdmac = pch->dmac;
+	struct dma_slave_config *slave_config;
+	struct dma_pl330_peri *peri;
+	int i;
+	LIST_HEAD(list);
 
-	/* Only supports DMA_TERMINATE_ALL */
-	if (cmd != DMA_TERMINATE_ALL)
-		return -ENXIO;
-
-	spin_lock_irqsave(&pch->lock, flags);
-
-	/* FLUSH the PL330 Channel thread */
-	pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
+	switch (cmd) {
+	case DMA_TERMINATE_ALL:
+		spin_lock_irqsave(&pch->lock, flags);
 
-	/* Mark all desc done */
-	list_for_each_entry(desc, &pch->work_list, node)
-		desc->status = DONE;
+		/* FLUSH the PL330 Channel thread */
+		pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
 
-	spin_unlock_irqrestore(&pch->lock, flags);
+		/* Mark all desc done */
+		list_for_each_entry_safe(desc, _dt, &pch->work_list , node) {
+			desc->status = DONE;
+			pch->completed = desc->txd.cookie;
+			list_move_tail(&desc->node, &list);
+		}
 
-	pl330_tasklet((unsigned long) pch);
+		list_splice_tail_init(&list, &pdmac->desc_pool);
+		spin_unlock_irqrestore(&pch->lock, flags);
+		break;
+	case DMA_SLAVE_CONFIG:
+		slave_config = (struct dma_slave_config *)arg;
+		peri = pch->chan.private;
+
+		if (slave_config->direction == DMA_TO_DEVICE) {
+			if (slave_config->dst_addr)
+				peri->fifo_addr = slave_config->dst_addr;
+			if (slave_config->dst_addr_width) {
+				i = 0;
+				while (slave_config->dst_addr_width != (1 << i))
+					i++;
+				peri->burst_sz = i;
+			}
+		} else if (slave_config->direction == DMA_FROM_DEVICE) {
+			if (slave_config->src_addr)
+				peri->fifo_addr = slave_config->src_addr;
+			if (slave_config->src_addr_width) {
+				i = 0;
+				while (slave_config->src_addr_width != (1 << i))
+					i++;
+				peri->burst_sz = i;
+			}
+		}
+		break;
+	default:
+		return -ENXIO;
+	}
 
 	return 0;
 }
@@ -520,6 +553,57 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
 	return burst_len;
 }
 
+static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
+		struct dma_chan *chan, dma_addr_t dma_addr, size_t len,
+		size_t period_len, enum dma_data_direction direction)
+{
+	struct dma_pl330_desc *desc;
+	struct dma_pl330_chan *pch = to_pchan(chan);
+	struct dma_pl330_peri *peri = chan->private;
+	dma_addr_t dst;
+	dma_addr_t src;
+
+	pch = to_pchan(chan);
+	if (!pch) {
+		dev_err(pch->dmac->pif.dev, "%s:%d Unable to fetch desc\n",
+			__func__, __LINE__);
+		return NULL;
+	}
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
+		dst = peri->fifo_addr;
+		break;
+	case DMA_FROM_DEVICE:
+		desc->rqcfg.src_inc = 0;
+		desc->rqcfg.dst_inc = 1;
+		src = peri->fifo_addr;
+		dst = dma_addr;
+		break;
+	default:
+		dev_err(pch->dmac->pif.dev, "%s:%d Invalid dma direction\n",
+		__func__, __LINE__);
+		return NULL;
+	}
+
+	desc->rqcfg.brst_size = peri->burst_sz;
+	desc->rqcfg.brst_len = 1;
+
+	fill_px(&desc->px, dst, src, period_len);
+
+	return &desc->txd;
+}
+
 static struct dma_async_tx_descriptor *
 pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 		dma_addr_t src, size_t len, unsigned long flags)
@@ -752,6 +836,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 			case MEMTODEV:
 			case DEVTOMEM:
 				dma_cap_set(DMA_SLAVE, pd->cap_mask);
+				dma_cap_set(DMA_CYCLIC, pd->cap_mask);
 				break;
 			default:
 				dev_err(&adev->dev, "DEVTODEV Not Supported\n");
@@ -777,6 +862,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
 	pd->device_free_chan_resources = pl330_free_chan_resources;
 	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
+	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
 	pd->device_control = pl330_control;
-- 
1.7.1
