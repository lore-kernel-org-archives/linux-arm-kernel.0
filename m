From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 21 Jun 2017 21:21:28 +0200
Subject: [PATCH 9/9] i2c: designware: Deploy the runtime PM centric approach
 for system sleep
In-Reply-To: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1498072888-14782-10-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we runtime resume the device in the ->prepare() callback to make
sure we manage system sleep properly.

The earlier attempt to avoid that, as it's surely a waste in many
situations, was based upon using the direct_complete path during system
sleep. However, that failed because we could end up having the ->suspend()
callback being invoked when the device was runtime suspended, causing calls
for clock enable/disable and clock prepare/unprepare to become unbalanced.

Deploying the runtime PM centric approach, via using the
pm_runtime_force_suspend|resume() helpers as the system sleep callbacks,
improves the behavior in the following regards:

*)
It avoids runtime resuming the device in the ->prepare() callback.

**)
The device remains runtime PM enabled during the device_suspend() phase,
which thus makes it possible for users to send i2c transfers this entire
phase.

***)
It doesn't unnecessary runtime resume the device during system suspend, but
allows the device to remain runtime suspended if that is possible.

****)
It avoids to bring the device back to full power during system resume,
unless really needed. Instead this task may get postponed to be managed by
runtime PM.

In case when the i2c device is attached to the ACPI PM domain, we need to
inform ACPI to adapt its behavior for the runtime PM centric path during
system sleep, which is done by calling acpi_dev_disable_direct_complete().

Worth to notice, comparing the earlier attempt of using the
direct_complete() approach is that **) couldn't be supported and ****)
relied on the device to be runtime suspended in the device_suspend() phase.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 2b7fa75..b6e05ba 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -331,6 +331,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (r)
 		goto exit_probe;
 
+	acpi_dev_disable_direct_complete(&pdev->dev);
+
 	return r;
 
 exit_probe:
@@ -346,6 +348,7 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 
+	acpi_dev_enable_direct_complete(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
 	i2c_del_adapter(&dev->adapter);
@@ -372,18 +375,8 @@ static const struct of_device_id dw_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
 #endif
 
-#ifdef CONFIG_PM_SLEEP
-static int dw_i2c_plat_prepare(struct device *dev)
-{
-	pm_runtime_resume(dev);
-	return 0;
-}
-#else
-#define dw_i2c_plat_prepare	NULL
-#endif
-
 #ifdef CONFIG_PM
-static int dw_i2c_plat_suspend(struct device *dev)
+static int dw_i2c_plat_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
@@ -394,7 +387,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
 	return 0;
 }
 
-static int dw_i2c_plat_resume(struct device *dev)
+static int dw_i2c_plat_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
@@ -406,9 +399,11 @@ static int dw_i2c_plat_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
-	.prepare = dw_i2c_plat_prepare,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
-	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
+			   dw_i2c_plat_runtime_resume,
+			   NULL)
 };
 
 #define DW_I2C_DEV_PMOPS (&dw_i2c_dev_pm_ops)
-- 
2.7.4
