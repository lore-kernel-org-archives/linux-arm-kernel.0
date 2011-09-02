From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri,  2 Sep 2011 09:44:32 +0900
Subject: [PATCH v8 04/16] DMA: PL330: Remove the start operation for handling
	DMA_TERMINATE_ALL command
In-Reply-To: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314924284-25554-5-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Origianl code carries out the start operation after flush operation.
But start operation is not required for DMA_TERMINATE_ALL command.
So, This patch removes the unnecessary start operation and only carries out
the flush oeration for handling DMA_TERMINATE_ALL command.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/dma/pl330.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index e7f9d1d..59943ec 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -262,10 +262,11 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd, unsigned long arg)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
-	struct dma_pl330_desc *desc;
+	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
 	struct dma_pl330_dmac *pdmac = pch->dmac;
 	struct dma_slave_config *slave_config;
+	LIST_HEAD(list);
 
 	switch (cmd) {
 	case DMA_TERMINATE_ALL:
@@ -275,12 +276,14 @@ static int pl330_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd, unsigned
 		pl330_chan_ctrl(pch->pl330_chid, PL330_OP_FLUSH);
 
 		/* Mark all desc done */
-		list_for_each_entry(desc, &pch->work_list, node)
+		list_for_each_entry_safe(desc, _dt, &pch->work_list , node) {
 			desc->status = DONE;
+			pch->completed = desc->txd.cookie;
+			list_move_tail(&desc->node, &list);
+		}
 
+		list_splice_tail_init(&list, &pdmac->desc_pool);
 		spin_unlock_irqrestore(&pch->lock, flags);
-
-		pl330_tasklet((unsigned long) pch);
 		break;
 	case DMA_SLAVE_CONFIG:
 		slave_config = (struct dma_slave_config *)arg;
-- 
1.7.1
