From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue,  6 Jun 2017 15:14:15 +0530
Subject: [PATCH] spi: pxa2xx: Handle return value of clk_prepare_enable
Message-ID: <4e16c0aba047b068aaa41c1d180d98ccb441afd0.1496668108.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/spi/spi-pxa2xx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 47b65d7..e9c0fe5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1676,7 +1676,11 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Enable SOC clock */
-	clk_prepare_enable(ssp->clk);
+	status = clk_prepare_enable(ssp->clk);
+	if (status) {
+		dev_err(&pdev->dev, "Failed to prepare clock\n");
+		goto out_error_master_alloc;
+	}
 
 	master->max_speed_hz = clk_get_rate(ssp->clk);
 
@@ -1855,8 +1859,13 @@ static int pxa2xx_spi_resume(struct device *dev)
 	int status;
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev))
-		clk_prepare_enable(ssp->clk);
+	if (!pm_runtime_suspended(dev)) {
+		status = clk_prepare_enable(ssp->clk);
+		if (status) {
+			dev_err(dev, "Failed to prepare clock\n");
+			return status;
+		}
+	}
 
 	/* Restore LPSS private register bits */
 	if (is_lpss_ssp(drv_data))
@@ -1886,8 +1895,7 @@ static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
-	clk_prepare_enable(drv_data->ssp->clk);
-	return 0;
+	return clk_prepare_enable(drv_data->ssp->clk);
 }
 #endif
 
-- 
1.9.1
