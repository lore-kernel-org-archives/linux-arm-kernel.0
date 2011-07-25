From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 25 Jul 2011 10:28:21 +0900
Subject: [PATCH V4 03/14] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1311557312-26107-4-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support DMA_SLAVE_CONFIG command.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 drivers/dma/pl330.c |   53 +++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 586ab39..880f010 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -256,25 +256,50 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
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
 
 	return 0;
 }
-- 
1.7.1
