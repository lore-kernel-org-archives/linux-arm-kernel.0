From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 18 Oct 2018 13:26:15 +0200
Subject: [PATCH v1 3/3] i2c: imx: don't print error if DMA is not configured
In-Reply-To: <20181018112615.29362-1-o.rempel@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
Message-ID: <20181018112615.29362-4-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least on i.MX5x variants is DMA event for I2C muxed with SDHC. So
it is project specific configuration and not an error.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c | 38 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index df013b1b6fa4..bd362fe07257 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -319,7 +319,7 @@ static inline unsigned char imx_i2c_read_reg(struct imx_i2c_struct *i2c_imx,
 }
 
 /* Functions for DMA support */
-static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
+static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 						dma_addr_t phy_addr)
 {
 	struct imx_i2c_dma *dma;
@@ -328,15 +328,17 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	int ret;
 
 	if (!i2c_imx->hwdata->has_dmamode)
-		return;
+		return 0;
 
 	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
 	if (!dma)
-		return;
+		return -ENOMEM;
 
-	dma->chan_tx = dma_request_slave_channel(dev, "tx");
-	if (!dma->chan_tx) {
-		dev_dbg(dev, "can't request DMA tx channel\n");
+	dma->chan_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(dma->chan_tx)) {
+		ret = PTR_ERR(dma->chan_rx);
+		if (ret != -ENODEV && ret != -EPROBE_DEFER)
+			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
 		goto fail_al;
 	}
 
@@ -347,13 +349,15 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	dma_sconfig.direction = DMA_MEM_TO_DEV;
 	ret = dmaengine_slave_config(dma->chan_tx, &dma_sconfig);
 	if (ret < 0) {
-		dev_dbg(dev, "can't configure tx channel\n");
+		dev_err(dev, "can't configure tx channel (%d)\n", ret);
 		goto fail_tx;
 	}
 
-	dma->chan_rx = dma_request_slave_channel(dev, "rx");
-	if (!dma->chan_rx) {
-		dev_dbg(dev, "can't request DMA rx channel\n");
+	dma->chan_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->chan_rx)) {
+		ret = PTR_ERR(dma->chan_rx);
+		if (ret != -ENODEV && ret != -EPROBE_DEFER)
+			dev_err(dev, "can't request DMA rx channel (%d)\n", ret);
 		goto fail_tx;
 	}
 
@@ -364,7 +368,7 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	dma_sconfig.direction = DMA_DEV_TO_MEM;
 	ret = dmaengine_slave_config(dma->chan_rx, &dma_sconfig);
 	if (ret < 0) {
-		dev_dbg(dev, "can't configure rx channel\n");
+		dev_err(dev, "can't configure rx channel (%d)\n", ret);
 		goto fail_rx;
 	}
 
@@ -373,15 +377,15 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	dev_info(dev, "using %s (tx) and %s (rx) for DMA transfers\n",
 		dma_chan_name(dma->chan_tx), dma_chan_name(dma->chan_rx));
 
-	return;
+	return 0;
 
 fail_rx:
 	dma_release_channel(dma->chan_rx);
 fail_tx:
 	dma_release_channel(dma->chan_tx);
 fail_al:
-	devm_kfree(dev, dma);
-	dev_info(dev, "can't use DMA, using PIO instead.\n");
+	/* return successfully if there is no dma support */
+	return ret == -ENODEV ? 0 : ret;
 }
 
 static void i2c_imx_dma_callback(void *arg)
@@ -1208,11 +1212,13 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
 	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
 		i2c_imx->adapter.name);
-	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 
 	/* Init DMA config if supported */
-	i2c_imx_dma_request(i2c_imx, phy_addr);
+	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
+	if (ret < 0)
+		goto clk_notifier_unregister;
 
+	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 	return 0;   /* Return OK */
 
 clk_notifier_unregister:
-- 
2.19.0
