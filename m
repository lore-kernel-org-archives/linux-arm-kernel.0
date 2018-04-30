From: Tobias.Jordan@elektrobit.com (Tobias Jordan)
Date: Mon, 30 Apr 2018 16:30:06 +0200
Subject: [PATCH] spi: pxa2xx: check clk_prepare_enable() return value
Message-ID: <20180430143006.ckcbicijw2to2ghl@agrajag.zerfleddert.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail, so its return value should be checked and
acted upon.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 3343b7a6d2cd ("spi/pxa2xx: convert to the common clk framework")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
 drivers/spi/spi-pxa2xx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 40f1346b8188..0b2d60d30f69 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1612,7 +1612,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Enable SOC clock */
-	clk_prepare_enable(ssp->clk);
+	status = clk_prepare_enable(ssp->clk);
+	if (status)
+		goto out_error_dma_irq_alloc;
 
 	master->max_speed_hz = clk_get_rate(ssp->clk);
 
@@ -1716,6 +1718,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(ssp->clk);
+
+out_error_dma_irq_alloc:
 	pxa2xx_spi_dma_release(drv_data);
 	free_irq(ssp->irq, drv_data);
 
@@ -1789,8 +1793,11 @@ static int pxa2xx_spi_resume(struct device *dev)
 	int status;
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev))
-		clk_prepare_enable(ssp->clk);
+	if (!pm_runtime_suspended(dev)) {
+		status = clk_prepare_enable(ssp->clk);
+		if (status)
+			return status;
+	}
 
 	/* Restore LPSS private register bits */
 	if (is_lpss_ssp(drv_data))
@@ -1819,9 +1826,10 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
+	int status;
 
-	clk_prepare_enable(drv_data->ssp->clk);
-	return 0;
+	status = clk_prepare_enable(drv_data->ssp->clk);
+	return status;
 }
 #endif
 
-- 
2.11.0
