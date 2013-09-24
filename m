From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Sep 2013 20:59:47 +0200
Subject: [PATCH v2] [media] marvell-ccic: simplify and fix clk handling (a bit)
In-Reply-To: <1380048167-13729-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380048167-13729-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1380049187-16036-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The marvell-ccic does several things wrong or ineffectively in the clock
handling and it's usage of the devm_* stuff

 - it assumes clk_get doesn't return NULL
 - it explicitly calls devm_clk_put instead just keeping the reference
   during it's lifetime and let the driver core call it
 - it calls kfree, gpio_free and free_irq for resources it requested
   using devm_kzalloc, devm_gpio_request and devm_request_irq
   respectively.
 - it mixes devm_ and unmanaged resources which probably results in a
   race condition during remove

This patch fixes all but the last issue in this list. This patch doesn't
introduce new reasons for not building, but there are already several
bulid problems.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Libin Yang <lbyang@marvell.com>

Changes since (implicit) v1:
 - really fix the third issue in the list.
 - drop whitespace noise hunk

---
 drivers/media/platform/marvell-ccic/mmp-driver.c | 29 ++----------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/media/platform/marvell-ccic/mmp-driver.c
index b5a19af..ed16f81e 100644
--- a/drivers/media/platform/marvell-ccic/mmp-driver.c
+++ b/drivers/media/platform/marvell-ccic/mmp-driver.c
@@ -143,7 +143,6 @@ static int mmpcam_power_up(struct mcam_camera *mcam)
 	struct mmp_camera_platform_data *pdata;
 
 	if (mcam->bus_type == V4L2_MBUS_CSI2) {
-		cam->mipi_clk = devm_clk_get(mcam->dev, "mipi");
 		if ((IS_ERR(cam->mipi_clk) && mcam->dphy[2] == 0))
 			return PTR_ERR(cam->mipi_clk);
 	}
@@ -186,12 +185,6 @@ static void mmpcam_power_down(struct mcam_camera *mcam)
 	gpio_set_value(pdata->sensor_power_gpio, 0);
 	gpio_set_value(pdata->sensor_reset_gpio, 0);
 
-	if (mcam->bus_type == V4L2_MBUS_CSI2 && !IS_ERR(cam->mipi_clk)) {
-		if (cam->mipi_clk)
-			devm_clk_put(mcam->dev, cam->mipi_clk);
-		cam->mipi_clk = NULL;
-	}
-
 	mcam_clk_disable(mcam);
 }
 
@@ -325,19 +318,6 @@ static irqreturn_t mmpcam_irq(int irq, void *data)
 	return IRQ_RETVAL(handled);
 }
 
-static void mcam_deinit_clk(struct mcam_camera *mcam)
-{
-	unsigned int i;
-
-	for (i = 0; i < NR_MCAM_CLK; i++) {
-		if (!IS_ERR(mcam->clk[i])) {
-			if (mcam->clk[i])
-				devm_clk_put(mcam->dev, mcam->clk[i]);
-		}
-		mcam->clk[i] = NULL;
-	}
-}
-
 static void mcam_init_clk(struct mcam_camera *mcam)
 {
 	unsigned int i;
@@ -371,7 +351,7 @@ static int mmpcam_probe(struct platform_device *pdev)
 	if (cam == NULL)
 		return -ENOMEM;
 	cam->pdev = pdev;
-	cam->mipi_clk = NULL;
+	cam->mipi_clk = devm_clk_get(&pdev->dev, "mipi");
 	INIT_LIST_HEAD(&cam->devlist);
 
 	mcam = &cam->mcam;
@@ -442,6 +422,7 @@ static int mmpcam_probe(struct platform_device *pdev)
 	/*
 	 * Power the device up and hand it off to the core.
 	 */
+
 	ret = mmpcam_power_up(mcam);
 	if (ret)
 		goto out_deinit_clk;
@@ -470,7 +451,6 @@ out_unregister:
 out_power_down:
 	mmpcam_power_down(mcam);
 out_deinit_clk:
-	mcam_deinit_clk(mcam);
 	return ret;
 }
 
@@ -481,16 +461,11 @@ static int mmpcam_remove(struct mmp_camera *cam)
 	struct mmp_camera_platform_data *pdata;
 
 	mmpcam_remove_device(cam);
-	free_irq(cam->irq, mcam);
 	mccic_shutdown(mcam);
 	mmpcam_power_down(mcam);
 	pdata = cam->pdev->dev.platform_data;
-	gpio_free(pdata->sensor_reset_gpio);
-	gpio_free(pdata->sensor_power_gpio);
-	mcam_deinit_clk(mcam);
 	iounmap(cam->power_regs);
 	iounmap(mcam->regs);
-	kfree(cam);
 	return 0;
 }
 
-- 
1.8.4.rc3
