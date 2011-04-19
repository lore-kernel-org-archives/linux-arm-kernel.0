From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Apr 2011 02:31:32 +0200
Subject: [PATCH] dmaengine: implement pause and resume for dw_dmac
Message-ID: <1303173092-21785-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that the SPEAr needs this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/dw_dmac.c      |   22 ++++++++++++++++++++--
 drivers/dma/dw_dmac_regs.h |    1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 9c25c7d..60ac779 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -801,8 +801,7 @@ static int dwc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	struct dw_desc		*desc, *_desc;
 	LIST_HEAD(list);
 
-	/* Only supports DMA_TERMINATE_ALL */
-	if (cmd != DMA_TERMINATE_ALL)
+	if (cmd != DMA_TERMINATE_ALL && cmd != DMA_PAUSE && cmd != DMA_RESUME)
 		return -ENXIO;
 
 	/*
@@ -813,11 +812,30 @@ static int dwc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	 */
 	spin_lock_bh(&dwc->lock);
 
+	if (cmd == DMA_RESUME) {
+		if (dwc->paused) {
+			channel_set_bit(dw, CH_EN, dwc->mask);
+			while (!dma_readl(dw, CH_EN) & dwc->mask)
+				cpu_relax();
+		}
+		spin_unlock_bh(&dwc->lock);
+		return 0;
+	}
+
 	channel_clear_bit(dw, CH_EN, dwc->mask);
 
 	while (dma_readl(dw, CH_EN) & dwc->mask)
 		cpu_relax();
 
+	if (cmd == DMA_PAUSE) {
+		dwc->paused = true;
+		spin_unlock_bh(&dwc->lock);
+		return 0;
+	}
+
+	/* Terminating a paused transfer */
+	dwc->paused = false;
+
 	/* active_list entries will end up before queued entries */
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
diff --git a/drivers/dma/dw_dmac_regs.h b/drivers/dma/dw_dmac_regs.h
index 720f821..c968597 100644
--- a/drivers/dma/dw_dmac_regs.h
+++ b/drivers/dma/dw_dmac_regs.h
@@ -138,6 +138,7 @@ struct dw_dma_chan {
 	void __iomem		*ch_regs;
 	u8			mask;
 	u8			priority;
+	bool			paused;
 
 	spinlock_t		lock;
 
-- 
1.7.4
