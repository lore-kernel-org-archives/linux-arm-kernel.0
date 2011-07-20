From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 20 Jul 2011 19:46:12 +0900
Subject: [PATCH V4 03-2/13] DMA: PL330: Add DMA_CYCLIC capability
In-Reply-To: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1311158773-30314-4-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA_CYCLIC capability that is used for audio driver.
DMA driver activated with it reuses the dma requests that were submitted
through tx_submit().

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/dma/pl330.c |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 880f010..121c75a 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -69,6 +69,11 @@ struct dma_pl330_chan {
 	 * NULL if the channel is available to be acquired.
 	 */
 	void *pl330_chid;
+
+	/* taks for cyclic capability */
+	struct tasklet_struct *cyclic_task;
+
+	bool cyclic;
 };
 
 struct dma_pl330_dmac {
@@ -184,6 +189,41 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 	}
 }
 
+static void pl330_tasklet_cyclic(unsigned long data)
+{
+	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
+	struct dma_pl330_desc *desc, *_dt;
+	unsigned long flags;
+	LIST_HEAD(list);
+
+	spin_lock_irqsave(&pch->lock, flags);
+
+	/* Pick up ripe tomatoes */
+	list_for_each_entry_safe(desc, _dt, &pch->work_list, node)
+		if (desc->status == DONE) {
+			dma_async_tx_callback callback;
+
+			list_move_tail(&desc->node, &pch->work_list);
+			pch->completed = desc->txd.cookie;
+
+			desc->status = PREP;
+
+			/* Try to submit a req imm.
+			next to the last completed cookie */
+			fill_queue(pch);
+
+			/* Make sure the PL330 Channel thread is active */
+			pl330_chan_ctrl(pch->pl330_chid, PL330_OP_START);
+
+			callback = desc->txd.callback;
+			if (callback)
+				callback(desc->txd.callback_param);
+
+		}
+
+	spin_unlock_irqrestore(&pch->lock, flags);
+}
+
 static void pl330_tasklet(unsigned long data)
 {
 	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
@@ -227,6 +267,9 @@ static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
 
 	spin_unlock_irqrestore(&pch->lock, flags);
 
+	if (pch->cyclic_task)
+		tasklet_schedule(pch->cyclic_task);
+	else
 	tasklet_schedule(&pch->task);
 }
 
@@ -316,6 +359,15 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	pl330_release_channel(pch->pl330_chid);
 	pch->pl330_chid = NULL;
 
+	if (pch->cyclic) {
+		pch->cyclic = false;
+		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
+		if (pch->cyclic_task) {
+			tasklet_kill(pch->cyclic_task);
+			pch->cyclic_task = NULL;
+		}
+	}
+
 	spin_unlock_irqrestore(&pch->lock, flags);
 }
 
@@ -547,6 +599,63 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
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
+	if (!pch)
+		return NULL;
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
+	if (!pch->cyclic_task) {
+		pch->cyclic_task =
+			kmalloc(sizeof(struct tasklet_struct), GFP_KERNEL);
+		tasklet_init(pch->cyclic_task,
+			pl330_tasklet_cyclic, (unsigned int)pch);
+	}
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
@@ -780,6 +889,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 			case MEMTODEV:
 			case DEVTOMEM:
 				dma_cap_set(DMA_SLAVE, pd->cap_mask);
+				dma_cap_set(DMA_CYCLIC, pd->cap_mask);
 				break;
 			default:
 				dev_err(&adev->dev, "DEVTODEV Not Supported\n");
@@ -805,6 +915,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
 	pd->device_free_chan_resources = pl330_free_chan_resources;
 	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
+	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
 	pd->device_control = pl330_control;
-- 
1.7.1
