From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 13 Dec 2016 14:40:49 +0100
Subject: [PATCH 7/9] dmaengine: stm32-dma: Add error messages if xlate fails
In-Reply-To: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
References: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1481636451-27863-8-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some error messages when a slave device fails to request a
channel.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
---
 drivers/dma/stm32-dma.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index ba929a9..35639f6 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -975,27 +975,36 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 					   struct of_dma *ofdma)
 {
 	struct stm32_dma_device *dmadev = ofdma->of_dma_data;
+	struct device *dev = dmadev->ddev.dev;
 	struct stm32_dma_cfg cfg;
 	struct stm32_dma_chan *chan;
 	struct dma_chan *c;
 
-	if (dma_spec->args_count < 4)
+	if (dma_spec->args_count < 4) {
+		dev_err(dev, "Bad number of cells\n");
 		return NULL;
+	}
 
 	cfg.channel_id = dma_spec->args[0];
 	cfg.request_line = dma_spec->args[1];
 	cfg.stream_config = dma_spec->args[2];
 	cfg.threshold = dma_spec->args[3];
 
-	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) || (cfg.request_line >=
-				STM32_DMA_MAX_REQUEST_ID))
+	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) ||
+	    (cfg.request_line >= STM32_DMA_MAX_REQUEST_ID)) {
+		dev_err(dev, "Bad channel and/or request id\n");
 		return NULL;
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
