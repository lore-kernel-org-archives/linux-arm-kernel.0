From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 25 Aug 2011 11:13:33 +0900
Subject: [PATCH v7 03/15] DMA: PL330: Modify device_control()
In-Reply-To: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
References: <1314238425-6480-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314238425-6480-4-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies device_control() to support both DMA_TERMINATE_ALL
and DMA_SLAVE_CONFIG command.
First, modify the flush control for DMA_TERMINATE_ALL command.
Second, add the slave configuration control for DMA_SLAVE_CONFIG command.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/dma/pl330.c |   56 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index d5829c7..59943ec 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -73,6 +73,7 @@ struct dma_pl330_chan {
 
 	/* For D-to-M and M-to-D channels */
 	int burst_sz; /* the peripheral fifo width */
+	int burst_len; /* the number of burst */
 	dma_addr_t fifo_addr;
 };
 
@@ -261,25 +262,52 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd, unsigned long arg)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
-	struct dma_pl330_desc *desc;
+	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
+	struct dma_pl330_dmac *pdmac = pch->dmac;
+	struct dma_slave_config *slave_config;
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
+
+		if (slave_config->direction == DMA_TO_DEVICE) {
+			if (slave_config->dst_addr)
+				pch->fifo_addr = slave_config->dst_addr;
+			if (slave_config->dst_addr_width)
+				pch->burst_sz = __ffs(slave_config->dst_addr_width);
+			if (slave_config->dst_maxburst)
+				pch->burst_len = slave_config->dst_maxburst;
+		} else if (slave_config->direction == DMA_FROM_DEVICE) {
+			if (slave_config->src_addr)
+				pch->fifo_addr = slave_config->src_addr;
+			if (slave_config->src_addr_width)
+				pch->burst_sz = __ffs(slave_config->src_addr_width);
+			if (slave_config->src_maxburst)
+				pch->burst_len = slave_config->src_maxburst;
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
