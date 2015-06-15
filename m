From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:18:57 -0700
Subject: [PATCH 02/10] dma: imx-sdma: pass sdma engine into functions
In-Reply-To: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
References: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1434385144-4432-3-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ostensibly dma channel centric functions do their work
either exclusively or primarily on the sdma engine struct.
Change these functions to pass a struct sdma_engine and integer channel

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/dma/imx-sdma.c | 65 +++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0671d6d..c255664 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -467,11 +467,9 @@ static inline u32 chnenbl_ofs(struct sdma_engine *sdma, unsigned int event)
 	return chnenbl0 + event * 4;
 }
 
-static int sdma_config_ownership(struct sdma_channel *sdmac,
+static int sdma_config_ownership(struct sdma_engine *sdma, int channel,
 		bool event_override, bool mcu_override, bool dsp_override)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	int channel = sdmac->channel;
 	unsigned long evt, mcu, dsp;
 
 	if (event_override && mcu_override && dsp_override)
@@ -569,10 +567,9 @@ static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 	return ret;
 }
 
-static void sdma_event_enable(struct sdma_channel *sdmac, unsigned int event)
+static void sdma_event_enable(struct sdma_engine *sdma, int channel,
+			unsigned int event)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	int channel = sdmac->channel;
 	unsigned long val;
 	u32 chnenbl = chnenbl_ofs(sdma, event);
 
@@ -581,10 +578,9 @@ static void sdma_event_enable(struct sdma_channel *sdmac, unsigned int event)
 	writel_relaxed(val, sdma->regs + chnenbl);
 }
 
-static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
+static void sdma_event_disable(struct sdma_engine *sdma, int channel,
+		unsigned int event)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	int channel = sdmac->channel;
 	u32 chnenbl = chnenbl_ofs(sdma, event);
 	unsigned long val;
 
@@ -830,20 +826,19 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	return ret;
 }
 
-static void sdma_disable_channel(struct sdma_channel *sdmac)
+static void sdma_disable_channel(struct sdma_engine *sdma, int channel)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	int channel = sdmac->channel;
-
 	writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
-	sdmac->status = DMA_ERROR;
+	sdma->channel[channel].status = DMA_ERROR;
 }
 
 static int sdma_config_channel(struct sdma_channel *sdmac)
 {
 	int ret;
+	int channel = sdmac->channel;
+	struct sdma_engine *sdma = sdmac->sdma;
 
-	sdma_disable_channel(sdmac);
+	sdma_disable_channel(sdma, channel);
 
 	sdmac->event_mask[0] = 0;
 	sdmac->event_mask[1] = 0;
@@ -851,20 +846,20 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
 	sdmac->per_addr = 0;
 
 	if (sdmac->event_id0) {
-		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
+		if (sdmac->event_id0 >= sdma->drvdata->num_events)
 			return -EINVAL;
-		sdma_event_enable(sdmac, sdmac->event_id0);
+		sdma_event_enable(sdma, channel, sdmac->event_id0);
 	}
 
 	switch (sdmac->peripheral_type) {
 	case IMX_DMATYPE_DSP:
-		sdma_config_ownership(sdmac, false, true, true);
+		sdma_config_ownership(sdma, channel, false, true, true);
 		break;
 	case IMX_DMATYPE_MEMORY:
-		sdma_config_ownership(sdmac, false, true, false);
+		sdma_config_ownership(sdma, channel, false, true, false);
 		break;
 	default:
-		sdma_config_ownership(sdmac, true, true, false);
+		sdma_config_ownership(sdma, channel, true, true, false);
 		break;
 	}
 
@@ -896,12 +891,9 @@ static int sdma_config_channel(struct sdma_channel *sdmac)
 	return ret;
 }
 
-static int sdma_set_channel_priority(struct sdma_channel *sdmac,
+static int sdma_set_channel_priority(struct sdma_engine *sdma, int channel,
 		unsigned int priority)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	int channel = sdmac->channel;
-
 	if (priority < MXC_SDMA_MIN_PRIORITY
 	    || priority > MXC_SDMA_MAX_PRIORITY) {
 		return -EINVAL;
@@ -928,7 +920,7 @@ static int sdma_request_channel(struct sdma_channel *sdmac)
 	sdma->channel_control[channel].base_bd_ptr = sdmac->bd_phys;
 	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
 
-	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
+	sdma_set_channel_priority(sdma, channel, MXC_SDMA_DEFAULT_PRIORITY);
 	return 0;
 out:
 
@@ -958,6 +950,7 @@ static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor *tx)
 static int sdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
 	struct imx_dma_data *data = chan->private;
 	int prio, ret;
 
@@ -980,14 +973,14 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	sdmac->peripheral_type = data->peripheral_type;
 	sdmac->event_id0 = data->dma_request;
 
-	clk_enable(sdmac->sdma->clk_ipg);
-	clk_enable(sdmac->sdma->clk_ahb);
+	clk_enable(sdma->clk_ipg);
+	clk_enable(sdma->clk_ahb);
 
 	ret = sdma_request_channel(sdmac);
 	if (ret)
 		return ret;
 
-	ret = sdma_set_channel_priority(sdmac, prio);
+	ret = sdma_set_channel_priority(sdma, sdmac->channel, prio);
 	if (ret)
 		return ret;
 
@@ -1003,18 +996,19 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
+	int channel = sdmac->channel;
 
-	sdma_disable_channel(sdmac);
+	sdma_disable_channel(sdma, channel);
 
 	if (sdmac->event_id0)
-		sdma_event_disable(sdmac, sdmac->event_id0);
+		sdma_event_disable(sdma, channel, sdmac->event_id0);
 	if (sdmac->event_id1)
-		sdma_event_disable(sdmac, sdmac->event_id1);
+		sdma_event_disable(sdma, channel, sdmac->event_id1);
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
 
-	sdma_set_channel_priority(sdmac, 0);
+	sdma_set_channel_priority(sdma, channel, 0);
 
 	dma_free_coherent(NULL, PAGE_SIZE, sdmac->bd, sdmac->bd_phys);
 
@@ -1207,11 +1201,12 @@ static int sdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		unsigned long arg)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
 	struct dma_slave_config *dmaengine_cfg = (void *)arg;
 
 	switch (cmd) {
 	case DMA_TERMINATE_ALL:
-		sdma_disable_channel(sdmac);
+		sdma_disable_channel(sdma, sdmac->channel);
 		return 0;
 	case DMA_SLAVE_CONFIG:
 		if (dmaengine_cfg->direction == DMA_DEV_TO_MEM) {
@@ -1390,7 +1385,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	if (ret)
 		goto err_dma_alloc;
 
-	sdma_config_ownership(&sdma->channel[0], false, true, false);
+	sdma_config_ownership(sdma, 0, false, true, false);
 
 	/* Set Command Channel (Channel Zero) */
 	writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
@@ -1405,7 +1400,7 @@ static int sdma_init(struct sdma_engine *sdma)
 	writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
 
 	/* Initializes channel's priorities */
-	sdma_set_channel_priority(&sdma->channel[0], 7);
+	sdma_set_channel_priority(sdma, 0, 7);
 
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
-- 
2.1.4
