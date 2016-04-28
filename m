From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 28 Apr 2016 13:03:31 +0200
Subject: [PATCH] spi: imx: Add pm-runtime autosuspend
Message-ID: <1461841411-26529-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently for each transfer the two clocks are enabled and disabled. For
heavy SPI usage this can lead to a significant overhead.

This patch replaces the clock enable/disable for each transfer by
runtime pm autosuspend. The spi core offers the possibility to control
resume/suspend and autosuspension marks by setting "auto_runtime_pm".

To support systems without CONFIG_PM set, the functions
spi_imx_runtime_resume()/suspend() are called manually if the
pm_runtime_* functions fail.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/spi/spi-imx.c | 76 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 50769078e72e..79038533bc4f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -38,6 +38,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/spi-imx.h>
@@ -1098,32 +1099,33 @@ static void spi_imx_cleanup(struct spi_device *spi)
 {
 }
 
-static int
-spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
+static int spi_imx_runtime_resume(struct device *dev)
 {
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 	int ret;
 
-	ret = clk_enable(spi_imx->clk_per);
+	ret = clk_prepare_enable(spi_imx->clk_per);
 	if (ret)
 		return ret;
 
-	ret = clk_enable(spi_imx->clk_ipg);
+	ret = clk_prepare_enable(spi_imx->clk_ipg);
 	if (ret) {
-		clk_disable(spi_imx->clk_per);
+		clk_disable_unprepare(spi_imx->clk_per);
 		return ret;
 	}
 
 	return 0;
 }
 
-static int
-spi_imx_unprepare_message(struct spi_master *master, struct spi_message *msg)
+static int spi_imx_runtime_suspend(struct device *dev)
 {
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	clk_disable(spi_imx->clk_ipg);
-	clk_disable(spi_imx->clk_per);
+	clk_disable_unprepare(spi_imx->clk_per);
+	clk_disable_unprepare(spi_imx->clk_ipg);
+
 	return 0;
 }
 
@@ -1137,7 +1139,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret, num_cs, irq;
+	int i, ret, num_cs, irq, err;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
@@ -1192,8 +1194,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
 	spi_imx->bitbang.master->setup = spi_imx_setup;
 	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
-	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
-	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	if (is_imx51_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
@@ -1233,13 +1233,17 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	ret = clk_prepare_enable(spi_imx->clk_per);
-	if (ret)
-		goto out_master_put;
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	spi_imx->bitbang.master->auto_runtime_pm = true;
 
-	ret = clk_prepare_enable(spi_imx->clk_ipg);
-	if (ret)
-		goto out_put_per;
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret) {
+		ret = spi_imx_runtime_resume(&pdev->dev);
+		if (ret)
+			goto out_master_put;
+	}
 
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
 	/*
@@ -1249,7 +1253,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	if (is_imx51_ecspi(spi_imx)) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
 		if (ret == -EPROBE_DEFER)
-			goto out_clk_put;
+			goto out_pm_runtime_put;
 
 		if (ret < 0)
 			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
@@ -1264,19 +1268,18 @@ static int spi_imx_probe(struct platform_device *pdev)
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
 		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_clk_put;
+		goto out_pm_runtime_put;
 	}
 
-	dev_info(&pdev->dev, "probed\n");
+	pm_runtime_put_autosuspend(&pdev->dev);
 
-	clk_disable(spi_imx->clk_ipg);
-	clk_disable(spi_imx->clk_per);
+	dev_info(&pdev->dev, "probed\n");
 	return ret;
 
-out_clk_put:
-	clk_disable_unprepare(spi_imx->clk_ipg);
-out_put_per:
-	clk_disable_unprepare(spi_imx->clk_per);
+out_pm_runtime_put:
+	err = pm_runtime_put_sync_suspend(&pdev->dev);
+	if (err == -ENOSYS)
+		spi_imx_runtime_suspend(&pdev->dev);
 out_master_put:
 	spi_master_put(master);
 
@@ -1287,21 +1290,36 @@ static int spi_imx_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	int ret;
+
+	ret = pm_runtime_get_sync(&pdev->dev);
 
 	spi_bitbang_stop(&spi_imx->bitbang);
 
 	writel(0, spi_imx->base + MXC_CSPICTRL);
-	clk_unprepare(spi_imx->clk_ipg);
-	clk_unprepare(spi_imx->clk_per);
+
+	if (ret) {
+		spi_imx_runtime_suspend(&pdev->dev);
+	} else {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+
 	spi_imx_sdma_exit(spi_imx);
 	spi_master_put(master);
 
 	return 0;
 }
 
+static const struct dev_pm_ops spi_imx_pm_ops = {
+	SET_RUNTIME_PM_OPS(spi_imx_runtime_suspend, spi_imx_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver spi_imx_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
+		   .pm = &spi_imx_pm_ops,
 		   .of_match_table = spi_imx_dt_ids,
 		   },
 	.id_table = spi_imx_devtype,
-- 
2.8.0.rc3
