From: broonie@kernel.org (Mark Brown)
Date: Wed,  5 Sep 2018 12:46:16 +0100 (BST)
Subject: Applied "spi: Do not print a message if spi_controller_{suspend,
 resume}() fails" to the spi tree
In-Reply-To: <20180905085157.7807-1-geert+renesas@glider.be>
Message-ID: <20180905114616.63A8111229D0@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: Do not print a message if spi_controller_{suspend,resume}() fails

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 7c5d8a249acadc3e9d5af643c0fe24b608a98269 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 5 Sep 2018 10:51:57 +0200
Subject: [PATCH] spi: Do not print a message if
 spi_controller_{suspend,resume}() fails

spi_controller_{suspend,resume}() already prints an error message on
failure, so there is no need to repeat this in individual drivers.

Note: spi_master_{suspend,resume}() is an alias for
      spi_controller_{suspend,resume}().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Daniel Mack <daniel@zonque.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c    | 10 ++--------
 drivers/spi/spi-dw.c       |  7 +------
 drivers/spi/spi-fsl-espi.c |  4 +---
 drivers/spi/spi-pl022.c    |  8 ++------
 drivers/spi/spi-pxa2xx.c   |  8 +-------
 5 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 3f890d162934..74fddcd3282b 100644
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
index ac2eb89ef7a5..1736612ee86b 100644
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
index 1e8ff6256079..cf2118dc91f4 100644
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
index 1af8c96b940e..5f5f197b153c 100644
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
index 14f4ea59caff..e3cbc66a7061 100644
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
2.19.0.rc1
