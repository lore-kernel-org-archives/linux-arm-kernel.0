From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Jun 2013 14:22:07 +0400
Subject: [RFC v2 1/5] SPI: imx: Convert to devm_* API
Message-ID: <1370168531-22718-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_* functions for the driver.
This ensures more consistent error values and simplifies error paths.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/spi/spi-imx.c | 81 +++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7db4f43..1a53e7d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -84,7 +84,6 @@ struct spi_imx_data {
 
 	struct completion xfer_done;
 	void __iomem *base;
-	int irq;
 	struct clk *clk_per;
 	struct clk *clk_ipg;
 	unsigned long spi_clk;
@@ -758,7 +757,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret, num_cs;
+	int i, irq, ret, num_cs;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
@@ -796,10 +795,11 @@ static int spi_imx_probe(struct platform_device *pdev)
 		if (!gpio_is_valid(cs_gpio))
 			continue;
 
-		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
+		ret = devm_gpio_request(&pdev->dev, spi_imx->chipselect[i],
+					DRIVER_NAME);
 		if (ret) {
 			dev_err(&pdev->dev, "can't get cs gpios\n");
-			goto out_gpio_free;
+			goto out_master_put;
 		}
 	}
 
@@ -816,46 +816,35 @@ static int spi_imx_probe(struct platform_device *pdev)
 		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "can't get platform resource\n");
-		ret = -ENOMEM;
-		goto out_gpio_free;
+	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spi_imx->base)) {
+		ret = PTR_ERR(spi_imx->base);
+		goto out_master_put;
 	}
 
-	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
-		dev_err(&pdev->dev, "request_mem_region failed\n");
-		ret = -EBUSY;
-		goto out_gpio_free;
-	}
-
-	spi_imx->base = ioremap(res->start, resource_size(res));
-	if (!spi_imx->base) {
-		ret = -EINVAL;
-		goto out_release_mem;
-	}
-
-	spi_imx->irq = platform_get_irq(pdev, 0);
-	if (spi_imx->irq < 0) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		ret = -EINVAL;
-		goto out_iounmap;
+		goto out_master_put;
 	}
 
-	ret = request_irq(spi_imx->irq, spi_imx_isr, 0, DRIVER_NAME, spi_imx);
+	ret = devm_request_irq(&pdev->dev, irq, spi_imx_isr, 0, DRIVER_NAME,
+			       spi_imx);
 	if (ret) {
-		dev_err(&pdev->dev, "can't get irq%d: %d\n", spi_imx->irq, ret);
-		goto out_iounmap;
+		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
+		goto out_master_put;
 	}
 
 	spi_imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(spi_imx->clk_ipg)) {
 		ret = PTR_ERR(spi_imx->clk_ipg);
-		goto out_free_irq;
+		goto out_master_put;
 	}
 
 	spi_imx->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(spi_imx->clk_per)) {
 		ret = PTR_ERR(spi_imx->clk_per);
-		goto out_free_irq;
+		goto out_master_put;
 	}
 
 	clk_prepare_enable(spi_imx->clk_per);
@@ -869,56 +858,34 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	master->dev.of_node = pdev->dev.of_node;
 	ret = spi_bitbang_start(&spi_imx->bitbang);
-	if (ret) {
-		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_clk_put;
-	}
+	if (!ret)
+		return 0;
 
-	dev_info(&pdev->dev, "probed\n");
+	dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
 
-	return ret;
-
-out_clk_put:
 	clk_disable_unprepare(spi_imx->clk_per);
 	clk_disable_unprepare(spi_imx->clk_ipg);
-out_free_irq:
-	free_irq(spi_imx->irq, spi_imx);
-out_iounmap:
-	iounmap(spi_imx->base);
-out_release_mem:
-	release_mem_region(res->start, resource_size(res));
-out_gpio_free:
-	while (--i >= 0) {
-		if (gpio_is_valid(spi_imx->chipselect[i]))
-			gpio_free(spi_imx->chipselect[i]);
-	}
+
+out_master_put:
 	spi_master_put(master);
 	kfree(master);
+
 	return ret;
 }
 
 static int spi_imx_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
-	int i;
 
 	spi_bitbang_stop(&spi_imx->bitbang);
 
 	writel(0, spi_imx->base + MXC_CSPICTRL);
 	clk_disable_unprepare(spi_imx->clk_per);
 	clk_disable_unprepare(spi_imx->clk_ipg);
-	free_irq(spi_imx->irq, spi_imx);
-	iounmap(spi_imx->base);
-
-	for (i = 0; i < master->num_chipselect; i++)
-		if (gpio_is_valid(spi_imx->chipselect[i]))
-			gpio_free(spi_imx->chipselect[i]);
 
 	spi_master_put(master);
-
-	release_mem_region(res->start, resource_size(res));
+	kfree(master);
 
 	return 0;
 }
-- 
1.8.1.5
