From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  8 Jul 2011 16:27:31 +0800
Subject: [PATCH 3/6] spi/imx: copy gpio number passed by platform data into
	driver private data
In-Reply-To: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310113654-25887-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It copies gpio number passed via platform data embedded pointer into
driver private data, so that we do not need to refer to this embedded
pointer passed by platform data after probe function exits.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/spi-imx.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 3d4efae..b9cd31f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -84,7 +84,6 @@ struct spi_imx_data {
 	int irq;
 	struct clk *clk;
 	unsigned long spi_clk;
-	int *chipselect;
 
 	unsigned int count;
 	void (*tx)(struct spi_imx_data *);
@@ -94,6 +93,7 @@ struct spi_imx_data {
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 
 	struct spi_imx_devtype_data *devtype_data;
+	int chipselect[0];
 };
 
 static inline int is_imx27_cspi(struct spi_imx_data *d)
@@ -743,7 +743,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret;
+	int i, ret, num_cs;
 
 	mxc_platform_info = dev_get_platdata(&pdev->dev);
 	if (!mxc_platform_info) {
@@ -751,20 +751,22 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
+	num_cs = mxc_platform_info->num_chipselect;
+	master = spi_alloc_master(&pdev->dev,
+			sizeof(struct spi_imx_data) + sizeof(int) * num_cs);
 	if (!master)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, master);
 
 	master->bus_num = pdev->id;
-	master->num_chipselect = mxc_platform_info->num_chipselect;
+	master->num_chipselect = num_cs;
 
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = spi_master_get(master);
-	spi_imx->chipselect = mxc_platform_info->chipselect;
 
 	for (i = 0; i < master->num_chipselect; i++) {
+		spi_imx->chipselect[i] = mxc_platform_info->chipselect[i];
 		if (spi_imx->chipselect[i] < 0)
 			continue;
 		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
-- 
1.7.4.1
