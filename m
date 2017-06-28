From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:25:17 +0100
Subject: Applied "spi: stm32: add runtime PM support" to the spi tree
In-Reply-To: <1498222550-19092-7-git-send-email-amelie.delaunay@st.com>
Message-ID: <E1dQIaT-0004cD-Qg@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: add runtime PM support

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

>From 038ac869c9d27fceb6197e775d780ad6aeb45b1f Mon Sep 17 00:00:00 2001
From: Amelie Delaunay <amelie.delaunay@st.com>
Date: Tue, 27 Jun 2017 17:45:18 +0200
Subject: [PATCH] spi: stm32: add runtime PM support

This patch reworks suspend and resume callbacks and add runtime_suspend
and runtime_resume callbacks.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 123529a1b40d..392c9453c2e6 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -27,6 +27,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 
@@ -1164,6 +1165,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (spi->dma_tx || spi->dma_rx)
 		master->can_dma = stm32_spi_can_dma;
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi master registration failed: %d\n",
@@ -1203,6 +1207,8 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		dma_release_channel(spi->dma_tx);
 	if (spi->dma_rx)
 		dma_release_channel(spi->dma_rx);
+
+	pm_runtime_disable(&pdev->dev);
 err_clk_disable:
 	clk_disable_unprepare(spi->clk);
 err_master_put:
@@ -1225,23 +1231,42 @@ static int stm32_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(spi->clk);
 
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int stm32_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct stm32_spi *spi = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(spi->clk);
+
+	return 0;
+}
+
+static int stm32_spi_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct stm32_spi *spi = spi_master_get_devdata(master);
+
+	return clk_prepare_enable(spi->clk);
+}
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 static int stm32_spi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct stm32_spi *spi = spi_master_get_devdata(master);
 	int ret;
 
 	ret = spi_master_suspend(master);
 	if (ret)
 		return ret;
 
-	clk_disable_unprepare(spi->clk);
-
-	return ret;
+	return pm_runtime_force_suspend(dev);
 }
 
 static int stm32_spi_resume(struct device *dev)
@@ -1250,9 +1275,10 @@ static int stm32_spi_resume(struct device *dev)
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 	int ret;
 
-	ret = clk_prepare_enable(spi->clk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
+
 	ret = spi_master_resume(master);
 	if (ret)
 		clk_disable_unprepare(spi->clk);
@@ -1261,8 +1287,11 @@ static int stm32_spi_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(stm32_spi_pm_ops,
-			 stm32_spi_suspend, stm32_spi_resume);
+static const struct dev_pm_ops stm32_spi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_spi_suspend, stm32_spi_resume)
+	SET_RUNTIME_PM_OPS(stm32_spi_runtime_suspend,
+			   stm32_spi_runtime_resume, NULL)
+};
 
 static struct platform_driver stm32_spi_driver = {
 	.probe = stm32_spi_probe,
-- 
2.13.2
