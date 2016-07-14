From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jul 2016 17:32:55 +0100
Subject: Applied "spi: s3c64xx: rename goto labels to meaningful names" to the
 spi tree
In-Reply-To: <1467989201-14661-4-git-send-email-andi.shyti@samsung.com>
Message-ID: <E1bNjZH-0001ni-TY@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: rename goto labels to meaningful names

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

>From 60a9a964420912a4c4b66efd210d98006177695a Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Tue, 12 Jul 2016 19:02:12 +0900
Subject: [PATCH] spi: s3c64xx: rename goto labels to meaningful names

The goto labels of the style of

  err4:
  err3:
  err2:
  err1:

are complex to insert in between new errors without renaming all
the goto statements. Replace the errX naming style to meaningful
names in order to make it easier to insert new goto exit points.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 001c9ebf884d..0a93eb98c2b6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1078,7 +1078,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
 				ret);
-			goto err0;
+			goto err_deref_master;
 		}
 		sdd->port_id = ret;
 	} else {
@@ -1116,13 +1116,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(sdd->regs)) {
 		ret = PTR_ERR(sdd->regs);
-		goto err0;
+		goto err_deref_master;
 	}
 
 	if (sci->cfg_gpio && sci->cfg_gpio()) {
 		dev_err(&pdev->dev, "Unable to config gpio\n");
 		ret = -EBUSY;
-		goto err0;
+		goto err_deref_master;
 	}
 
 	/* Setup clocks */
@@ -1130,13 +1130,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(sdd->clk)) {
 		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
 		ret = PTR_ERR(sdd->clk);
-		goto err0;
+		goto err_deref_master;
 	}
 
 	if (clk_prepare_enable(sdd->clk)) {
 		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
 		ret = -EBUSY;
-		goto err0;
+		goto err_deref_master;
 	}
 
 	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
@@ -1145,13 +1145,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Unable to acquire clock '%s'\n", clk_name);
 		ret = PTR_ERR(sdd->src_clk);
-		goto err2;
+		goto err_disable_clk;
 	}
 
 	if (clk_prepare_enable(sdd->src_clk)) {
 		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
 		ret = -EBUSY;
-		goto err2;
+		goto err_disable_clk;
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
@@ -1171,7 +1171,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request IRQ %d: %d\n",
 			irq, ret);
-		goto err3;
+		goto err_pm_put;
 	}
 
 	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
@@ -1181,7 +1181,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot register SPI master: %d\n", ret);
-		goto err3;
+		goto err_pm_put;
 	}
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
@@ -1195,15 +1195,15 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-err3:
+err_pm_put:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	clk_disable_unprepare(sdd->src_clk);
-err2:
+err_disable_clk:
 	clk_disable_unprepare(sdd->clk);
-err0:
+err_deref_master:
 	spi_master_put(master);
 
 	return ret;
-- 
2.8.1
