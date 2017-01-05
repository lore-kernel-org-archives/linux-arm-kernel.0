From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu,  5 Jan 2017 09:09:40 +0100
Subject: [PATCH RESEND] dmaengine: stm32-dma: Add error messages if xlate fails
Message-ID: <1483603780-3368-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some error messages when a slave device fails to request a
channel.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
---
Resolve conflicts issue
---
 drivers/dma/stm32-dma.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index fc9738e..4eacd9d 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -987,30 +987,36 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 					   struct of_dma *ofdma)
 {
 	struct stm32_dma_device *dmadev = ofdma->of_dma_data;
+	struct device *dev = dmadev->ddev.dev;
 	struct stm32_dma_cfg cfg;
 	struct stm32_dma_chan *chan;
 	struct dma_chan *c;
 
-	if (dma_spec->args_count < 3)
+	if (dma_spec->args_count < 4) {
+		dev_err(dev, "Bad number of cells\n");
 		return NULL;
+	}
 
 	cfg.channel_id = dma_spec->args[0];
 	cfg.request_line = dma_spec->args[1];
 	cfg.stream_config = dma_spec->args[2];
-	cfg.threshold = 0;
+	cfg.threshold = dma_spec->args[3];
 
-	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) || (cfg.request_line >=
-				STM32_DMA_MAX_REQUEST_ID))
+	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) ||
+	    (cfg.request_line >= STM32_DMA_MAX_REQUEST_ID)) {
+		dev_err(dev, "Bad channel and/or request id\n");
 		return NULL;
-
-	if (dma_spec->args_count > 3)
-		cfg.threshold = dma_spec->args[3];
+	}
 
 	chan = &dmadev->chan[cfg.channel_id];
 
 	c = dma_get_slave_channel(&chan->vchan.chan);
-	if (c)
-		stm32_dma_set_config(chan, &cfg);
+	if (!c) {
+		dev_err(dev, "No more channel avalaible\n");
+		return NULL;
+	}
+
+	stm32_dma_set_config(chan, &cfg);
 
 	return c;
 }
-- 
1.9.1
