From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 15:44:16 +0900
Subject: [PATCH V3 03/13] DMA: PL330: Add DMA capabilities
In-Reply-To: <1310798666-7659-1-git-send-email-kgene.kim@samsung.com>
References: <1310798666-7659-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1310798666-7659-4-git-send-email-kgene.kim@samsung.com>
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
 drivers/dma/pl330.c |  175 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 160 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 9bdda7b..980a145 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -69,6 +69,9 @@ struct dma_pl330_chan {
 	 * NULL if the channel is available to be acquired.
 	 */
 	void *pl330_chid;
+
+	/* taks for cyclic capability */
+	struct tasklet_struct *cyclic_task;
 };
 
 struct dma_pl330_dmac {
@@ -105,6 +108,7 @@ struct dma_pl330_desc {
 
 	/* The channel which currently holds this desc */
 	struct dma_pl330_chan *pchan;
+	bool cyclic;
 };
 
 static inline struct dma_pl330_chan *
@@ -184,6 +188,41 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
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
+		if ((desc->status == DONE) && desc->cyclic) {
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
@@ -227,7 +266,10 @@ static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
 
 	spin_unlock_irqrestore(&pch->lock, flags);
 
-	tasklet_schedule(&pch->task);
+	if (pch->cyclic_task)
+		tasklet_schedule(pch->cyclic_task);
+	else
+		tasklet_schedule(&pch->task);
 }
 
 static int pl330_alloc_chan_resources(struct dma_chan *chan)
@@ -256,27 +298,68 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd, unsigned long arg)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
-	struct dma_pl330_desc *desc;
+	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
+	struct dma_pl330_dmac *pdmac = pch->dmac;
+	struct dma_slave_config *slave_config;
+	struct dma_pl330_peri *peri;
+	LIST_HEAD(list);
 
-	/* Only supports DMA_TERMINATE_ALL */
-	if (cmd != DMA_TERMINATE_ALL)
-		return -ENXIO;
+	switch (cmd) {
+	case DMA_TERMINATE_ALL:
+		spin_lock_irqsave(&pch->lock, flags);
 
-	spin_lock_irqsave(&pch->lock, flags);
+		/* FLUSH the PL330 Channel thread */
+		pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
+
+		/* Mark all desc done */
+		list_for_each_entry_safe(desc, _dt, &pch->work_list , node) {
+			desc->status = DONE;
+			pch->completed = desc->txd.cookie;
+			list_move_tail(&desc->node, &list);
+		}
+
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
+			if (slave_config->dst_addr_width)
+				peri->burst_sz = __ffs(slave_config->dst_addr_width);
+		} else if (slave_config->direction == DMA_FROM_DEVICE) {
+			if (slave_config->src_addr)
+				peri->fifo_addr = slave_config->src_addr;
+			if (slave_config->src_addr_width)
+				peri->burst_sz = __ffs(slave_config->src_addr_width);
+		}
+		break;
+	default:
+		dev_err(pch->dmac->pif.dev, "Not supported command.\n");
+		return -ENXIO;
+	}
 
-	/* FLUSH the PL330 Channel thread */
-	pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
+	return 0;
+}
 
-	/* Mark all desc done */
-	list_for_each_entry(desc, &pch->work_list, node)
-		desc->status = DONE;
+static void pl330_cyclic_free(struct dma_pl330_chan *pch)
+{
+	struct dma_pl330_dmac *pdmac = pch->dmac;
+	struct dma_pl330_desc *desc, *_dt;
+	LIST_HEAD(list);
 
-	spin_unlock_irqrestore(&pch->lock, flags);
+	list_for_each_entry_safe(desc, _dt, &pch->work_list, node)
+		if (desc->cyclic)
+			list_move_tail(&desc->node, &list);
 
-	pl330_tasklet((unsigned long) pch);
+	list_splice_tail_init(&list, &pdmac->desc_pool);
 
-	return 0;
+	tasklet_kill(pch->cyclic_task);
+	pch->cyclic_task = NULL;
 }
 
 static void pl330_free_chan_resources(struct dma_chan *chan)
@@ -291,6 +374,9 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	pl330_release_channel(pch->pl330_chid);
 	pch->pl330_chid = NULL;
 
+	if (pch->cyclic_task)
+		pl330_cyclic_free(pch);
+
 	spin_unlock_irqrestore(&pch->lock, flags);
 }
 
@@ -522,6 +608,63 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
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
+	desc->cyclic = true;
+
+	fill_px(&desc->px, dst, src, period_len);
+
+	return &desc->txd;
+}
+
 static struct dma_async_tx_descriptor *
 pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 		dma_addr_t src, size_t len, unsigned long flags)
@@ -691,7 +834,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	res = &adev->res;
 	request_mem_region(res->start,
-		resource_size(res), dev_name(&adev->dev));
+		resource_size(res), "dma-pl330");
 
 	pi->base = ioremap(res->start, resource_size(res));
 	if (!pi->base) {
@@ -756,6 +899,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 			case MEMTODEV:
 			case DEVTOMEM:
 				dma_cap_set(DMA_SLAVE, pd->cap_mask);
+				dma_cap_set(DMA_CYCLIC, pd->cap_mask);
 				break;
 			default:
 				dev_err(&adev->dev, "DEVTODEV Not Supported\n");
@@ -781,6 +925,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
 	pd->device_free_chan_resources = pl330_free_chan_resources;
 	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
+	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
 	pd->device_control = pl330_control;
-- 
1.7.1
