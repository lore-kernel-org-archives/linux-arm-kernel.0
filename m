From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Jul 2012 12:28:40 +0100
Subject: [PATCH 3/4] spi/s3c64xx: Convert to devm_request_and_ioremap()
In-Reply-To: <1342610921-31986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1342610921-31986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1342610921-31986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Saves some error handling and a small amount of code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-s3c64xx.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6ed3ba8..1781365 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1278,14 +1278,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
-	if (request_mem_region(mem_res->start,
-			resource_size(mem_res), pdev->name) == NULL) {
-		dev_err(&pdev->dev, "Req mem region failed\n");
-		ret = -ENXIO;
-		goto err0;
-	}
-
-	sdd->regs = ioremap(mem_res->start, resource_size(mem_res));
+	sdd->regs = devm_request_and_ioremap(&pdev->dev, mem_res);
 	if (sdd->regs == NULL) {
 		dev_err(&pdev->dev, "Unable to remap IO\n");
 		ret = -ENXIO;
@@ -1379,9 +1372,7 @@ err3:
 	if (!sdd->cntrlr_info->cfg_gpio && pdev->dev.of_node)
 		s3c64xx_spi_dt_gpio_free(sdd);
 err2:
-	iounmap((void *) sdd->regs);
 err1:
-	release_mem_region(mem_res->start, resource_size(mem_res));
 err0:
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
@@ -1393,7 +1384,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	struct resource	*mem_res;
 
 	pm_runtime_disable(&pdev->dev);
 
@@ -1412,12 +1402,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 	if (!sdd->cntrlr_info->cfg_gpio && pdev->dev.of_node)
 		s3c64xx_spi_dt_gpio_free(sdd);
 
-	iounmap((void *) sdd->regs);
-
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (mem_res != NULL)
-		release_mem_region(mem_res->start, resource_size(mem_res));
-
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
 
-- 
1.7.10.4
