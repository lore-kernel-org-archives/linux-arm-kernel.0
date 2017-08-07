From: broonie@kernel.org (Mark Brown)
Date: Mon, 07 Aug 2017 16:53:37 +0100
Subject: Applied "spi: rockchip: Slightly rework return value handling" to the
 spi tree
In-Reply-To: <1502109620-26813-2-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <E1dekLZ-0005dc-Ed@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: Slightly rework return value handling

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

>From 43de979ddc099c57858b243619c66e2f663a2f97 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Mon, 7 Aug 2017 20:40:18 +0800
Subject: [PATCH] spi: rockchip: Slightly rework return value handling

Slightly rework return value handling, no functional changes.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0b4a52b3e1dc..5497650992c7 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -666,7 +666,7 @@ static bool rockchip_spi_can_dma(struct spi_master *master,
 
 static int rockchip_spi_probe(struct platform_device *pdev)
 {
-	int ret = 0;
+	int ret;
 	struct rockchip_spi *rs;
 	struct spi_master *master;
 	struct resource *mem;
@@ -703,13 +703,13 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = clk_prepare_enable(rs->apb_pclk);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to enable apb_pclk\n");
 		goto err_put_master;
 	}
 
 	ret = clk_prepare_enable(rs->spiclk);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to enable spi_clk\n");
 		goto err_disable_apbclk;
 	}
@@ -786,7 +786,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register master\n");
 		goto err_free_dma_rx;
 	}
@@ -834,12 +834,12 @@ static int rockchip_spi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int rockchip_spi_suspend(struct device *dev)
 {
-	int ret = 0;
+	int ret;
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	ret = spi_master_suspend(rs->master);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	if (!pm_runtime_suspended(dev)) {
@@ -849,12 +849,12 @@ static int rockchip_spi_suspend(struct device *dev)
 
 	pinctrl_pm_select_sleep_state(dev);
 
-	return ret;
+	return 0;
 }
 
 static int rockchip_spi_resume(struct device *dev)
 {
-	int ret = 0;
+	int ret;
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
@@ -878,7 +878,7 @@ static int rockchip_spi_resume(struct device *dev)
 		clk_disable_unprepare(rs->apb_pclk);
 	}
 
-	return ret;
+	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */
 
@@ -901,14 +901,14 @@ static int rockchip_spi_runtime_resume(struct device *dev)
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	ret = clk_prepare_enable(rs->apb_pclk);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = clk_prepare_enable(rs->spiclk);
-	if (ret)
+	if (ret < 0)
 		clk_disable_unprepare(rs->apb_pclk);
 
-	return ret;
+	return 0;
 }
 #endif /* CONFIG_PM */
 
-- 
2.13.3
