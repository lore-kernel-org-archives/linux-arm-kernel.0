From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 29 Aug 2017 02:59:49 +0200
Subject: [PATCH 3/3] PM: i2c-designware-platdrv: System sleep handling rework
In-Reply-To: <4245176.X6JjkhnUAM@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <4245176.X6JjkhnUAM@aspire.rjw.lan>
Message-ID: <6543072.R9SdZCE16v@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework the power management part of the i2c-designware-platdrv driver
so that its ->suspend and ->resume callbacks do not point to the
callback routines used by it for runtime PM.  Instead, point its late
suspend and early resume callbacks to pm_runtime_force_suspend() and
pm_runtime_force_resume(), respectively, and make it set the
SAFE_SUSPEND driver flag (introduced earlier) to instruct the generic
ACPI PM domain code that the driver can cope with runtime suspended
devices in its system sleep callbacks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-designware-platdrv.c
+++ linux-pm/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -358,6 +358,7 @@ static int dw_i2c_plat_probe(struct plat
 	if (dev->pm_disabled) {
 		pm_runtime_forbid(&pdev->dev);
 	} else {
+		dev->power.driver_flags = DPM_FLAG_SAFE_SUSPEND;
 		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
 		pm_runtime_use_autosuspend(&pdev->dev);
 		pm_runtime_set_active(&pdev->dev);
@@ -455,7 +456,8 @@ static int dw_i2c_plat_resume(struct dev
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 	.prepare = dw_i2c_plat_prepare,
 	.complete = dw_i2c_plat_complete,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
 };
 
