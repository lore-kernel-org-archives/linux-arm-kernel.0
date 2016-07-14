From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jul 2016 17:32:50 +0100
Subject: Applied "spi: s3c64xx: add Exynos5433 compatible for ioclk handling"
 to the spi tree
In-Reply-To: <1467989201-14661-6-git-send-email-andi.shyti@samsung.com>
Message-ID: <E1bNjZC-0001lA-35@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: add Exynos5433 compatible for ioclk handling

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7990b00819e765ca180d36b38969c2bde2734e53 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Tue, 12 Jul 2016 19:02:14 +0900
Subject: [PATCH] spi: s3c64xx: add Exynos5433 compatible for ioclk handling

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
Reviewed-by: Michael Turquette <mturquette@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 57 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3d21f8a35837..a1e84686c70c 100644
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
@@ -1154,6 +1157,21 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
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
@@ -1200,6 +1218,8 @@ err_pm_put:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
+	clk_disable_unprepare(sdd->ioclk);
+err_disable_src_clk:
 	clk_disable_unprepare(sdd->src_clk);
 err_disable_clk:
 	clk_disable_unprepare(sdd->clk);
@@ -1218,6 +1238,8 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
+	clk_disable_unprepare(sdd->ioclk);
+
 	clk_disable_unprepare(sdd->src_clk);
 
 	clk_disable_unprepare(sdd->clk);
@@ -1276,6 +1298,7 @@ static int s3c64xx_spi_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(sdd->clk);
 	clk_disable_unprepare(sdd->src_clk);
+	clk_disable_unprepare(sdd->ioclk);
 
 	return 0;
 }
@@ -1286,17 +1309,28 @@ static int s3c64xx_spi_runtime_resume(struct device *dev)
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
 
@@ -1352,6 +1386,16 @@ static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
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
@@ -1382,6 +1426,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
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
