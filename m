From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 08 Jul 2016 23:46:39 +0900
Subject: [PATCH v2 5/7] spi: s3c64xx: add exynos5433 compatible for ioclk
 handling
In-Reply-To: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new compatible is related to the Samsung Exynos5433 SoC. The
difference between the previous is that in the exynos5433 the SPI
controller is driven by three clocks instead of only one.

The new clock (ioclk) is controlling the input/output clock
whenever the controller is slave or master.

The presence of the clock line is detected from the compatibility
structure (exynos5433_spi_port_config) as a boolean value.

The probe function checks whether the ioclk is present and if so,
it acquires.

The runtime suspend and resume functions will handle the clock
enabling and disabling as well.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3a65adf..6da663f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -156,12 +156,14 @@ struct s3c64xx_spi_port_config {
 	int	quirks;
 	bool	high_speed;
 	bool	clk_from_cmu;
+	bool	clk_ioclk;
 };
 
 /**
  * struct s3c64xx_spi_driver_data - Runtime info holder for SPI driver.
  * @clk: Pointer to the spi clock.
  * @src_clk: Pointer to the clock used to generate SPI signals.
+ * @ioclk: Pointer to the i/o clock between master and slave
  * @master: Pointer to the SPI Protocol master.
  * @cntrlr_info: Platform specific data for the controller this driver manages.
  * @tgl_spi: Pointer to the last CS left untoggled by the cs_change hint.
@@ -181,6 +183,7 @@ struct s3c64xx_spi_driver_data {
 	void __iomem                    *regs;
 	struct clk                      *clk;
 	struct clk                      *src_clk;
+	struct clk                      *ioclk;
 	struct platform_device          *pdev;
 	struct spi_master               *master;
 	struct s3c64xx_spi_info  *cntrlr_info;
@@ -1147,6 +1150,21 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
+	if (sdd->port_conf->clk_ioclk) {
+		sdd->ioclk = devm_clk_get(&pdev->dev, "spi_ioclk");
+		if (IS_ERR(sdd->ioclk)) {
+			dev_err(&pdev->dev, "Unable to acquire 'ioclk'\n");
+			ret = PTR_ERR(sdd->ioclk);
+			goto err_disable_src_clk;
+		}
+
+		ret = clk_prepare_enable(sdd->ioclk);
+		if (ret) {
+			dev_err(&pdev->dev, "Couldn't enable clock 'ioclk'\n");
+			goto err_disable_src_clk;
+		}
+	}
+
 	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
@@ -1193,6 +1211,8 @@ err_pm_put:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
+	clk_disable_unprepare(sdd->ioclk);
+err_disable_src_clk:
 	clk_disable_unprepare(sdd->src_clk);
 err_disable_clk:
 	clk_disable_unprepare(sdd->clk);
@@ -1211,6 +1231,8 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
+	clk_disable_unprepare(sdd->ioclk);
+
 	clk_disable_unprepare(sdd->src_clk);
 
 	clk_disable_unprepare(sdd->clk);
@@ -1269,6 +1291,7 @@ static int s3c64xx_spi_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(sdd->clk);
 	clk_disable_unprepare(sdd->src_clk);
+	clk_disable_unprepare(sdd->ioclk);
 
 	return 0;
 }
@@ -1279,17 +1302,28 @@ static int s3c64xx_spi_runtime_resume(struct device *dev)
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	int ret;
 
+	if (sdd->port_conf->clk_ioclk) {
+		ret = clk_prepare_enable(sdd->ioclk);
+		if (ret != 0)
+			return ret;
+	}
+
 	ret = clk_prepare_enable(sdd->src_clk);
 	if (ret != 0)
-		return ret;
+		goto err_disable_ioclk;
 
 	ret = clk_prepare_enable(sdd->clk);
-	if (ret != 0) {
-		clk_disable_unprepare(sdd->src_clk);
-		return ret;
-	}
+	if (ret != 0)
+		goto err_disable_src_clk;
 
 	return 0;
+
+err_disable_src_clk:
+	clk_disable_unprepare(sdd->src_clk);
+err_disable_ioclk:
+	clk_disable_unprepare(sdd->ioclk);
+
+	return ret;
 }
 #endif /* CONFIG_PM */
 
@@ -1345,6 +1379,16 @@ static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
+	.fifo_lvl_mask	= { 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff},
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.high_speed	= true,
+	.clk_from_cmu	= true,
+	.clk_ioclk	= true,
+	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	{
 		.name		= "s3c2443-spi",
@@ -1375,6 +1419,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos7-spi",
 			.data = (void *)&exynos7_spi_port_config,
 	},
+	{ .compatible = "samsung,exynos5433-spi",
+			.data = (void *)&exynos5433_spi_port_config,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, s3c64xx_spi_dt_match);
-- 
2.8.1
