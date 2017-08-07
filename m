From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon,  7 Aug 2017 20:40:18 +0800
Subject: [PATCH 1/3] spi: rockchip: Slightly rework return value handling
In-Reply-To: <1502109620-26813-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1502109620-26813-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1502109620-26813-2-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Slightly rework return value handling, no functional changes.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

 drivers/spi/spi-rockchip.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0b4a52b..5497650 100644
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
2.1.4
