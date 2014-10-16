From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:30 +0200
Subject: [PATCH v2 31/53] dmaengine: pl330: Split device_control
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-32-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split the device_control callback of the AMBA PL330 DMA driver to make use
of the newly introduced callbacks, that will eventually be used to retrieve
slave capabilities.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/pl330.c | 106 ++++++++++++++++++++++++++--------------------------
 1 file changed, 52 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 8904891ed5d5..1e3d3459e62c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2069,72 +2069,69 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 	return 1;
 }
 
-static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd, unsigned long arg)
+static int pl330_config(struct dma_chan *chan,
+			struct dma_slave_config *slave_config)
+{
+	struct dma_pl330_chan *pch = to_pchan(chan);
+
+	if (slave_config->direction == DMA_MEM_TO_DEV) {
+		if (slave_config->dst_addr)
+			pch->fifo_addr = slave_config->dst_addr;
+		if (slave_config->dst_addr_width)
+			pch->burst_sz = __ffs(slave_config->dst_addr_width);
+		if (slave_config->dst_maxburst)
+			pch->burst_len = slave_config->dst_maxburst;
+	} else if (slave_config->direction == DMA_DEV_TO_MEM) {
+		if (slave_config->src_addr)
+			pch->fifo_addr = slave_config->src_addr;
+		if (slave_config->src_addr_width)
+			pch->burst_sz = __ffs(slave_config->src_addr_width);
+		if (slave_config->src_maxburst)
+			pch->burst_len = slave_config->src_maxburst;
+	}
+
+	return 0;
+}
+
+static int pl330_terminate_all(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct dma_pl330_desc *desc;
 	unsigned long flags;
 	struct pl330_dmac *pl330 = pch->dmac;
-	struct dma_slave_config *slave_config;
 	LIST_HEAD(list);
 
-	switch (cmd) {
-	case DMA_TERMINATE_ALL:
-		spin_lock_irqsave(&pch->lock, flags);
-
-		spin_lock(&pl330->lock);
-		_stop(pch->thread);
-		spin_unlock(&pl330->lock);
+	spin_lock_irqsave(&pch->lock, flags);
 
-		pch->thread->req[0].desc = NULL;
-		pch->thread->req[1].desc = NULL;
-		pch->thread->req_running = -1;
+	spin_lock(&pl330->lock);
+	_stop(pch->thread);
+	spin_unlock(&pl330->lock);
 
-		/* Mark all desc done */
-		list_for_each_entry(desc, &pch->submitted_list, node) {
-			desc->status = FREE;
-			dma_cookie_complete(&desc->txd);
-		}
+	pch->thread->req[0].desc = NULL;
+	pch->thread->req[1].desc = NULL;
+	pch->thread->req_running = -1;
 
-		list_for_each_entry(desc, &pch->work_list , node) {
-			desc->status = FREE;
-			dma_cookie_complete(&desc->txd);
-		}
+	/* Mark all desc done */
+	list_for_each_entry(desc, &pch->submitted_list, node) {
+		desc->status = FREE;
+		dma_cookie_complete(&desc->txd);
+	}
 
-		list_for_each_entry(desc, &pch->completed_list , node) {
-			desc->status = FREE;
-			dma_cookie_complete(&desc->txd);
-		}
+	list_for_each_entry(desc, &pch->work_list , node) {
+		desc->status = FREE;
+		dma_cookie_complete(&desc->txd);
+	}
 
-		list_splice_tail_init(&pch->submitted_list, &pl330->desc_pool);
-		list_splice_tail_init(&pch->work_list, &pl330->desc_pool);
-		list_splice_tail_init(&pch->completed_list, &pl330->desc_pool);
-		spin_unlock_irqrestore(&pch->lock, flags);
-		break;
-	case DMA_SLAVE_CONFIG:
-		slave_config = (struct dma_slave_config *)arg;
-
-		if (slave_config->direction == DMA_MEM_TO_DEV) {
-			if (slave_config->dst_addr)
-				pch->fifo_addr = slave_config->dst_addr;
-			if (slave_config->dst_addr_width)
-				pch->burst_sz = __ffs(slave_config->dst_addr_width);
-			if (slave_config->dst_maxburst)
-				pch->burst_len = slave_config->dst_maxburst;
-		} else if (slave_config->direction == DMA_DEV_TO_MEM) {
-			if (slave_config->src_addr)
-				pch->fifo_addr = slave_config->src_addr;
-			if (slave_config->src_addr_width)
-				pch->burst_sz = __ffs(slave_config->src_addr_width);
-			if (slave_config->src_maxburst)
-				pch->burst_len = slave_config->src_maxburst;
-		}
-		break;
-	default:
-		dev_err(pch->dmac->ddma.dev, "Not supported command.\n");
-		return -ENXIO;
+	list_for_each_entry(desc, &pch->completed_list , node) {
+		desc->status = FREE;
+		dma_cookie_complete(&desc->txd);
 	}
 
+	list_splice_tail_init(&pch->submitted_list, &pl330->desc_pool);
+	list_splice_tail_init(&pch->work_list, &pl330->desc_pool);
+	list_splice_tail_init(&pch->completed_list, &pl330->desc_pool);
+	spin_unlock_irqrestore(&pch->lock, flags);
+
 	return 0;
 }
 
@@ -2708,7 +2705,8 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
-	pd->device_control = pl330_control;
+	pd->device_config = pl330_config;
+	pd->device_terminate_all = pl330_terminate_all;
 	pd->device_issue_pending = pl330_issue_pending;
 	pd->device_slave_caps = pl330_dma_device_slave_caps;
 
@@ -2755,7 +2753,7 @@ probe_err3:
 		list_del(&pch->chan.device_node);
 
 		/* Flush the channel */
-		pl330_control(&pch->chan, DMA_TERMINATE_ALL, 0);
+		pl330_terminate_all(&pch->chan);
 		pl330_free_chan_resources(&pch->chan);
 	}
 probe_err2:
-- 
2.1.1
