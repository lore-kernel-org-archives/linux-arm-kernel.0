From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 23 Jun 2017 15:00:52 +0200
Subject: [PATCH v2 4/5] dmaengine: stm32-dma: Add support for STM32 DMAMUX
In-Reply-To: <1498222853-11110-1-git-send-email-pierre-yves.mordret@st.com>
References: <1498222853-11110-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1498222853-11110-5-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for STM32 DMAMUX.
When the STM32 DMA controller is behind a STM32 DMAMUX the request line
number has not to be handled by DMA but DMAMUX.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v2:
        * Use DMAMUX Configuration API's
        * DMAXMUX(if used) provides ChannelID
---
---
 drivers/dma/stm32-dma.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 786fc8f..a9e5884 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/stm32-dmamux.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
@@ -179,6 +180,7 @@ struct stm32_dma_device {
 	struct clk *clk;
 	struct reset_control *rst;
 	bool mem2mem;
+	bool dmamux;
 	struct stm32_dma_chan chan[STM32_DMA_MAX_CHANNELS];
 };
 
@@ -272,12 +274,18 @@ static int stm32_dma_slave_config(struct dma_chan *c,
 				  struct dma_slave_config *config)
 {
 	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
+	int ret = 0;
 
 	memcpy(&chan->dma_sconfig, config, sizeof(*config));
 
-	chan->config_init = true;
+	if (c->router)
+		ret = stm32_dmamux_set_config(c->router->dev, c->route_data,
+					      c->chan_id);
 
-	return 0;
+	if (!ret)
+		chan->config_init = true;
+
+	return ret;
 }
 
 static u32 stm32_dma_irq_status(struct stm32_dma_chan *chan)
@@ -998,18 +1006,26 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 	cfg.stream_config = dma_spec->args[2];
 	cfg.threshold = dma_spec->args[3];
 
-	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) ||
-	    (cfg.request_line >= STM32_DMA_MAX_REQUEST_ID)) {
-		dev_err(dev, "Bad channel and/or request id\n");
-		return NULL;
-	}
-
-	chan = &dmadev->chan[cfg.channel_id];
+	if (dmadev->dmamux) {
+		c = dma_get_any_slave_channel(&dmadev->ddev);
+		if (!c) {
+			dev_err(dev, "No more channel avalaible\n");
+			return NULL;
+		}
+		chan = &dmadev->chan[c->chan_id];
+	} else {
+		if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) ||
+		    (cfg.request_line >= STM32_DMA_MAX_REQUEST_ID)) {
+			dev_err(dev, "Bad channel and/or request id\n");
+			return NULL;
+		}
 
-	c = dma_get_slave_channel(&chan->vchan.chan);
-	if (!c) {
-		dev_err(dev, "No more channels available\n");
-		return NULL;
+		chan = &dmadev->chan[cfg.channel_id];
+		c = dma_get_slave_channel(&chan->vchan.chan);
+		if (!c) {
+			dev_err(dev, "No more channel avalaible\n");
+			return NULL;
+		}
 	}
 
 	stm32_dma_set_config(chan, &cfg);
@@ -1058,6 +1074,8 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	dmadev->mem2mem = of_property_read_bool(pdev->dev.of_node,
 						"st,mem2mem");
 
+	dmadev->dmamux = of_property_read_bool(pdev->dev.of_node, "st,dmamux");
+
 	dmadev->rst = devm_reset_control_get(&pdev->dev, NULL);
 	if (!IS_ERR(dmadev->rst)) {
 		reset_control_assert(dmadev->rst);
-- 
1.9.1
