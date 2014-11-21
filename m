From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 21 Nov 2014 14:44:31 +0100
Subject: [PATCH 1/2] i2c: at91: remove legacy DMA support
Message-ID: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Since at91sam9g45 is now DT-only, all DMA capable users of this driver
are using the DT case, and the legacy support can be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi,

I have split the legacy dma support removing and probe deferring. I have also
fixed the compilation issue.

 drivers/i2c/busses/i2c-at91.c | 37 +++----------------------------------
 1 file changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 917d545..b69ea9b 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -72,7 +72,6 @@ struct at91_twi_pdata {
 	unsigned clk_max_div;
 	unsigned clk_offset;
 	bool has_unre_flag;
-	bool has_dma_support;
 	struct at_dma_slave dma_slave;
 };
 
@@ -541,35 +540,30 @@ static struct at91_twi_pdata at91rm9200_config = {
 	.clk_max_div = 5,
 	.clk_offset = 3,
 	.has_unre_flag = true,
-	.has_dma_support = false,
 };
 
 static struct at91_twi_pdata at91sam9261_config = {
 	.clk_max_div = 5,
 	.clk_offset = 4,
 	.has_unre_flag = false,
-	.has_dma_support = false,
 };
 
 static struct at91_twi_pdata at91sam9260_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
 	.has_unre_flag = false,
-	.has_dma_support = false,
 };
 
 static struct at91_twi_pdata at91sam9g20_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
 	.has_unre_flag = false,
-	.has_dma_support = false,
 };
 
 static struct at91_twi_pdata at91sam9g10_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
 	.has_unre_flag = false,
-	.has_dma_support = false,
 };
 
 static const struct platform_device_id at91_twi_devtypes[] = {
@@ -598,7 +592,6 @@ static struct at91_twi_pdata at91sam9x5_config = {
 	.clk_max_div = 7,
 	.clk_offset = 4,
 	.has_unre_flag = false,
-	.has_dma_support = true,
 };
 
 static const struct of_device_id atmel_twi_dt_ids[] = {
@@ -627,30 +620,11 @@ static const struct of_device_id atmel_twi_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, atmel_twi_dt_ids);
 #endif
 
-static bool filter(struct dma_chan *chan, void *pdata)
-{
-	struct at91_twi_pdata *sl_pdata = pdata;
-	struct at_dma_slave *sl;
-
-	if (!sl_pdata)
-		return false;
-
-	sl = &sl_pdata->dma_slave;
-	if (sl && (sl->dma_dev == chan->device->dev)) {
-		chan->private = sl;
-		return true;
-	} else {
-		return false;
-	}
-}
-
 static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 {
 	int ret = 0;
-	struct at91_twi_pdata *pdata = dev->pdata;
 	struct dma_slave_config slave_config;
 	struct at91_twi_dma *dma = &dev->dma;
-	dma_cap_mask_t mask;
 
 	memset(&slave_config, 0, sizeof(slave_config));
 	slave_config.src_addr = (dma_addr_t)phy_addr + AT91_TWI_RHR;
@@ -661,19 +635,14 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 	slave_config.dst_maxburst = 1;
 	slave_config.device_fc = false;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	dma->chan_tx = dma_request_slave_channel_compat(mask, filter, pdata,
-							dev->dev, "tx");
+	dma->chan_tx = dma_request_slave_channel(dev->dev, "tx");
 	if (!dma->chan_tx) {
 		dev_err(dev->dev, "can't get a DMA channel for tx\n");
 		ret = -EBUSY;
 		goto error;
 	}
 
-	dma->chan_rx = dma_request_slave_channel_compat(mask, filter, pdata,
-							dev->dev, "rx");
+	dma->chan_rx = dma_request_slave_channel(dev->dev, "rx");
 	if (!dma->chan_rx) {
 		dev_err(dev->dev, "can't get a DMA channel for rx\n");
 		ret = -EBUSY;
@@ -772,7 +741,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(dev->clk);
 
-	if (dev->pdata->has_dma_support) {
+	if (dev->dev->of_node) {
 		if (at91_twi_configure_dma(dev, phy_addr) == 0)
 			dev->use_dma = true;
 	}
-- 
2.0.3
