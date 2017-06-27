From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 27 Jun 2017 17:45:18 +0200
Subject: [PATCHv2 6/9] spi: stm32: add runtime PM support
In-Reply-To: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498578321-13980-7-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch reworks suspend and resume callbacks and add runtime_suspend
and runtime_resume callbacks.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/spi/spi-stm32.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 72efc63..209afda 100644
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
1.9.1
