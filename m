From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 23 Aug 2017 16:42:08 +0200
Subject: [PATCH v2 8/9] i2c: designware: Don't resume device in the
 ->complete() callback
In-Reply-To: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1503499329-28834-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the PM core is able to use the direct_complete path during system
sleep for the i2c device, the device is runtime resumed in the ->complete()
callback. For ACPI platforms this is needed to synchronize the power state
of the device, while for non-ACPI platforms this is a waste.

To better deal with this, let's drop the ->complete() callback from the
i2c-dw-plat driver altogether, thus avoiding the runtime resume of the
device.

This change still plays well for the ACPI case, because the ACPI PM
domain's ->complete() callback, assigned to acpi_subsys_complete(), already
deals with runtime resuming the device in case it's needed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch.

---
 drivers/i2c/busses/i2c-designware-platdrv.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 441afc7..fc6b99f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -418,15 +418,8 @@ static int dw_i2c_plat_prepare(struct device *dev)
 {
 	return pm_runtime_suspended(dev);
 }
-
-static void dw_i2c_plat_complete(struct device *dev)
-{
-	if (dev->power.direct_complete)
-		pm_request_resume(dev);
-}
 #else
 #define dw_i2c_plat_prepare	NULL
-#define dw_i2c_plat_complete	NULL
 #endif
 
 #ifdef CONFIG_PM
@@ -462,7 +455,6 @@ static int dw_i2c_plat_suspend(struct device *dev)
 
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 	.prepare = dw_i2c_plat_prepare,
-	.complete = dw_i2c_plat_complete,
 	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
 	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
 			   dw_i2c_plat_resume,
-- 
2.7.4
