From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Jun 2016 17:07:23 +0200
Subject: [PATCH 05/10] i2c: designware-platdrv: Fix clk gating in ->remove()
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1465916848-8207-6-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current approach to gate the clock in ->remove() relies on CONFIG_PM
to be set, as it's expected that the call to pm_runtime_put_sync()
triggers the ->runtime_suspend() callback to be invoked.

Even in the case when CONFIG_PM is set, userspace may prevent runtime PM
suspend via sysfs (pm_runtime_forbid()) for the device.

Fix the behaviour by converting from using pm_runtime_put_sync() into
directly using the clk API to manage clock gating. Let's also update the
runtime PM status for the device as to reflect the state of the HW.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 7f67d801..4083376 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -268,11 +268,16 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 
 	i2c_dw_disable(dev);
 
+	if (!IS_ERR(dev->clk))
+		clk_disable_unprepare(dev->clk);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	if (dev->pm_runtime_disabled)
 		pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 
 	return 0;
 }
-- 
1.9.1
