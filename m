From: yibin.gong@nxp.com (Robin Gong)
Date: Wed, 11 Jul 2018 00:23:12 +0800
Subject: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
In-Reply-To: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dmatest(memcpy) will never call dmaengine_slave_config before prep,
so jobs in dmaengine_slave_config need to be moved into somewhere
before device_prep_dma_memcpy. Besides, dmatest never setup chan
->private as other common case like uart/audio/spi will always setup
chan->private. Here check it to judge if it's dmatest case and do
jobs in slave_config.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ed2267d..48f3749 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1222,10 +1222,36 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct imx_dma_data *data = chan->private;
+	struct imx_dma_data default_data;
 	int prio, ret;
 
-	if (!data)
-		return -EINVAL;
+	ret = clk_enable(sdmac->sdma->clk_ipg);
+	if (ret)
+		return ret;
+	ret = clk_enable(sdmac->sdma->clk_ahb);
+	if (ret)
+		goto disable_clk_ipg;
+	/*
+	 * dmatest(memcpy) will never call dmaengine_slave_config before prep,
+	 * so jobs in dmaengine_slave_config need to be moved into somewhere
+	 * before device_prep_dma_memcpy. Besides, dmatest never setup chan
+	 * ->private as other common cases like uart/audio/spi will setup
+	 * chan->private always. Here check it to judge if it's dmatest case
+	 * and do jobs in slave_config.
+	 */
+	if (!data) {
+		dev_warn(sdmac->sdma->dev, "dmatest is running?\n");
+		sdmac->word_size  =  sdmac->sdma->dma_device.copy_align;
+		default_data.priority = 2;
+		default_data.peripheral_type = IMX_DMATYPE_MEMORY;
+		default_data.dma_request = 0;
+		default_data.dma_request2 = 0;
+		data = &default_data;
+
+		sdma_config_ownership(sdmac, false, true, false);
+		sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
+		sdma_load_context(sdmac);
+	}
 
 	switch (data->priority) {
 	case DMA_PRIO_HIGH:
@@ -1244,13 +1270,6 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	sdmac->event_id0 = data->dma_request;
 	sdmac->event_id1 = data->dma_request2;
 
-	ret = clk_enable(sdmac->sdma->clk_ipg);
-	if (ret)
-		return ret;
-	ret = clk_enable(sdmac->sdma->clk_ahb);
-	if (ret)
-		goto disable_clk_ipg;
-
 	ret = sdma_set_channel_priority(sdmac, prio);
 	if (ret)
 		goto disable_clk_ahb;
-- 
2.7.4
