From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 11 Oct 2013 14:12:18 +0200
Subject: [PATCH v4 4/5] dma: mxs-dma: Update state after channel reset
In-Reply-To: <1381493539-31756-1-git-send-email-mpa@pengutronix.de>
References: <1381493539-31756-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1381493539-31756-5-git-send-email-mpa@pengutronix.de>
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
index 42b634a..9e136e8 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -235,6 +235,8 @@ static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 		writel(1 << (chan_id + BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL),
 			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + STMP_OFFSET_REG_SET);
 	}
+
+	mxs_chan->status = DMA_SUCCESS;
 }
 
 static void mxs_dma_enable_chan(struct mxs_dma_chan *mxs_chan)
@@ -362,7 +364,7 @@ static irqreturn_t mxs_dma_int_handler(int irq, void *dev_id)
 			chan);
 		mxs_chan->status = DMA_ERROR;
 		mxs_dma_reset_chan(mxs_chan);
-	} else {
+	} else if (mxs_chan->status != DMA_SUCCESS) {
 		if (mxs_chan->flags & MXS_DMA_SG_LOOP)
 			mxs_chan->status = DMA_IN_PROGRESS;
 		else
-- 
1.8.4.rc3
