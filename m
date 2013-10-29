From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Oct 2013 08:47:48 +0100
Subject: [PATCH v5 4/5] dma: mxs-dma: Update state after channel reset
In-Reply-To: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
References: <1383032869-12863-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1383032869-12863-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a channel reset, the channel stops running automatically. The
state update was missing so that a channel perperation right after a
channel reset failed.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/dma/mxs-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 5302670..f48f87f 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -235,6 +235,8 @@ static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 		writel(1 << (chan_id + BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL),
 			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + STMP_OFFSET_REG_SET);
 	}
+
+	mxs_chan->status = DMA_COMPLETE;
 }
 
 static void mxs_dma_enable_chan(struct mxs_dma_chan *mxs_chan)
@@ -362,7 +364,7 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 			chan);
 		mxs_chan->status = DMA_ERROR;
 		mxs_dma_reset_chan(mxs_chan);
-	} else {
+	} else if (mxs_chan->status != DMA_COMPLETE) {
 		if (mxs_chan->flags & MXS_DMA_SG_LOOP)
 			mxs_chan->status = DMA_IN_PROGRESS;
 		else
-- 
1.8.4.rc3
