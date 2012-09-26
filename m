From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 26 Sep 2012 17:33:00 +0200
Subject: [PATCH] spi/pl022: Simplify use of runtime pm
Message-ID: <1348673580-17265-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi-pl022.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f8568b4..e51a026 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2188,8 +2188,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
 	       adev->res.start, pl022->virtbase);
 
-	pm_runtime_resume(dev);
-
 	pl022->clk = clk_get(&adev->dev, NULL);
 	if (IS_ERR(pl022->clk)) {
 		status = PTR_ERR(pl022->clk);
@@ -2250,10 +2248,9 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		pm_runtime_set_autosuspend_delay(dev,
 			platform_info->autosuspend_delay);
 		pm_runtime_use_autosuspend(dev);
-		pm_runtime_put_autosuspend(dev);
-	} else {
-		pm_runtime_put(dev);
 	}
+	pm_runtime_put(dev);
+
 	return 0;
 
  err_spi_register:
@@ -2302,7 +2299,6 @@ pl022_remove(struct amba_device *adev)
 	clk_disable(pl022->clk);
 	clk_unprepare(pl022->clk);
 	clk_put(pl022->clk);
-	pm_runtime_disable(&adev->dev);
 	iounmap(pl022->virtbase);
 	amba_release_regions(adev);
 	tasklet_disable(&pl022->pump_transfers);
-- 
1.7.10
