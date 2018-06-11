From: yibin.gong@nxp.com (Robin Gong)
Date: Mon, 11 Jun 2018 22:59:30 +0800
Subject: [PATCH v3 3/6] Revert "dmaengine: imx-sdma: fix pagefault when
 channel is disabled during interrupt"
In-Reply-To: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <1528729173-28684-4-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 2746e2c389f9d50043d21e2204270403efb9d62f.
Don't need this patch anymore,since we can easily check 'sdmac->desc' to avoid
handling dma interrupt after channel disabled if virt-dma used.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 474c105..e0af8ee 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -352,7 +352,6 @@ struct sdma_channel {
 	spinlock_t			lock;
 	enum dma_status			status;
 	struct imx_dma_data		data;
-	bool				enabled;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -613,14 +612,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
-	unsigned long flags;
-	struct sdma_channel *sdmac = &sdma->channel[channel];
-
 	writel(BIT(channel), sdma->regs + SDMA_H_START);
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = true;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 }
 
 /*
@@ -738,14 +730,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	struct sdma_buffer_descriptor *bd;
 	int error = 0;
 	enum dma_status	old_status = sdmac->status;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	if (!sdmac->enabled) {
-		spin_unlock_irqrestore(&sdmac->lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 
 	/*
 	 * loop mode. Iterate over descriptors, re-setup them and
@@ -1006,15 +990,10 @@ static int sdma_disable_channel(struct dma_chan *chan)
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 	int channel = sdmac->channel;
-	unsigned long flags;
 
 	writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
 	sdmac->status = DMA_ERROR;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = false;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
-
 	return 0;
 }
 
-- 
2.7.4
