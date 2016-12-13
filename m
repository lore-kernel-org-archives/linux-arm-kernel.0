From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 13 Dec 2016 14:40:43 +0100
Subject: [PATCH 1/9] dmaengine: stm32-dma: Set correct args number for DMA
 request from DT
In-Reply-To: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
References: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1481636451-27863-2-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the right number of arguments to be used for DMA clients
which request channels from DT.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
---
 drivers/dma/stm32-dma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 3688d08..a884b85 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -972,21 +972,18 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 	struct stm32_dma_chan *chan;
 	struct dma_chan *c;
 
-	if (dma_spec->args_count < 3)
+	if (dma_spec->args_count < 4)
 		return NULL;
 
 	cfg.channel_id = dma_spec->args[0];
 	cfg.request_line = dma_spec->args[1];
 	cfg.stream_config = dma_spec->args[2];
-	cfg.threshold = 0;
+	cfg.threshold = dma_spec->args[3];
 
 	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) || (cfg.request_line >=
 				STM32_DMA_MAX_REQUEST_ID))
 		return NULL;
 
-	if (dma_spec->args_count > 3)
-		cfg.threshold = dma_spec->args[3];
-
 	chan = &dmadev->chan[cfg.channel_id];
 
 	c = dma_get_slave_channel(&chan->vchan.chan);
-- 
1.9.1
