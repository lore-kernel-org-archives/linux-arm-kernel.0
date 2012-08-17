From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 16 Aug 2012 20:14:25 -0700
Subject: [PATCH] spi/s3c64xx: Drop extra calls to spi_master_get in
 suspend/remove functions
Message-ID: <1345173265-1721-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend and resume functions call spi_master_get() without matching
spi_master_put(). The extra references are unnecessary and cause subsequent
module unload attempts to fail. Drop the calls.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/spi/spi-s3c64xx.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 646a765..d7a87df 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1409,7 +1409,7 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int s3c64xx_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
 	spi_master_suspend(master);
@@ -1428,7 +1428,7 @@ static int s3c64xx_spi_suspend(struct device *dev)
 
 static int s3c64xx_spi_resume(struct device *dev)
 {
-	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 
@@ -1452,7 +1452,7 @@ static int s3c64xx_spi_resume(struct device *dev)
 #ifdef CONFIG_PM_RUNTIME
 static int s3c64xx_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
 	clk_disable(sdd->clk);
@@ -1463,7 +1463,7 @@ static int s3c64xx_spi_runtime_suspend(struct device *dev)
 
 static int s3c64xx_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
 	clk_enable(sdd->src_clk);
-- 
1.7.9.7
