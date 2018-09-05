From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  5 Sep 2018 10:51:57 +0200
Subject: [PATCH] spi: Do not print a message if spi_controller_{suspend,
 resume}() fails
Message-ID: <20180905085157.7807-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spi_controller_{suspend,resume}() already prints an error message on
failure, so there is no need to repeat this in individual drivers.

Note: spi_master_{suspend,resume}() is an alias for
      spi_controller_{suspend,resume}().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-atmel.c    | 10 ++--------
 drivers/spi/spi-dw.c       |  7 +------
 drivers/spi/spi-fsl-espi.c |  4 +---
 drivers/spi/spi-pl022.c    |  8 ++------
 drivers/spi/spi-pxa2xx.c   |  8 +-------
 5 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 3f890d16293411ba..74fddcd3282b4bea 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1767,10 +1767,8 @@ static int atmel_spi_suspend(struct device *dev)
 
 	/* Stop the queue running */
 	ret = spi_master_suspend(master);
-	if (ret) {
-		dev_warn(dev, "cannot suspend master\n");
+	if (ret)
 		return ret;
-	}
 
 	if (!pm_runtime_suspended(dev))
 		atmel_spi_runtime_suspend(dev);
@@ -1799,11 +1797,7 @@ static int atmel_spi_resume(struct device *dev)
 	}
 
 	/* Start the queue running */
-	ret = spi_master_resume(master);
-	if (ret)
-		dev_err(dev, "problem starting queue (%d)\n", ret);
-
-	return ret;
+	return spi_master_resume(master);
 }
 #endif
 
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index ac2eb89ef7a5a061..1736612ee86be7dd 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -572,13 +572,8 @@ EXPORT_SYMBOL_GPL(dw_spi_suspend_host);
 
 int dw_spi_resume_host(struct dw_spi *dws)
 {
-	int ret;
-
 	spi_hw_init(&dws->master->dev, dws);
-	ret = spi_controller_resume(dws->master);
-	if (ret)
-		dev_err(&dws->master->dev, "fail to start queue (%d)\n", ret);
-	return ret;
+	return spi_controller_resume(dws->master);
 }
 EXPORT_SYMBOL_GPL(dw_spi_resume_host);
 
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1e8ff6256079f134..cf2118dc91f44548 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -798,10 +798,8 @@ static int of_fsl_espi_suspend(struct device *dev)
 	int ret;
 
 	ret = spi_master_suspend(master);
-	if (ret) {
-		dev_warn(dev, "cannot suspend master\n");
+	if (ret)
 		return ret;
-	}
 
 	return pm_runtime_force_suspend(dev);
 }
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 1af8c96b940e203d..5f5f197b153c3ec4 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2325,10 +2325,8 @@ static int pl022_suspend(struct device *dev)
 	int ret;
 
 	ret = spi_master_suspend(pl022->master);
-	if (ret) {
-		dev_warn(dev, "cannot suspend master\n");
+	if (ret)
 		return ret;
-	}
 
 	ret = pm_runtime_force_suspend(dev);
 	if (ret) {
@@ -2353,9 +2351,7 @@ static int pl022_resume(struct device *dev)
 
 	/* Start the queue running */
 	ret = spi_master_resume(pl022->master);
-	if (ret)
-		dev_err(dev, "problem starting queue (%d)\n", ret);
-	else
+	if (!ret)
 		dev_dbg(dev, "resumed\n");
 
 	return ret;
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 14f4ea59caff7a23..e3cbc66a7061b42f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1808,13 +1808,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 		lpss_ssp_setup(drv_data);
 
 	/* Start the queue running */
-	status = spi_controller_resume(drv_data->master);
-	if (status != 0) {
-		dev_err(dev, "problem starting queue (%d)\n", status);
-		return status;
-	}
-
-	return 0;
+	return spi_controller_resume(drv_data->master);
 }
 #endif
 
-- 
2.17.1
