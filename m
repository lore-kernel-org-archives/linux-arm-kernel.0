From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 27 Oct 2011 17:48:44 +0200
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime suspend
Message-ID: <1319730524-29483-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to make sure devices are put into runtime suspend
after a suspend sequence, the suspend_noirq callback is used.

Previously it was was possible for drivers doing pm_runtime_suspend
and pm_runtime_put_sync directly from it's suspend callbacks.
This is now not possible due to the following commit, which solve a
race issue:

PM: Limit race conditions between runtime PM and system sleep (v2)

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/amba/bus.c |  113 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 79 insertions(+), 34 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index bd230e8..7ba523a 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -135,6 +135,79 @@ static void amba_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
+#ifdef CONFIG_PM_RUNTIME
+/*
+ * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
+ * enable/disable the bus clock at runtime PM suspend/resume as this
+ * does not result in loss of context.  However, disabling vcore power
+ * would do, so we leave that to the driver.
+ */
+static int amba_pm_runtime_suspend(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	int ret = pm_generic_runtime_suspend(dev);
+
+	if (ret == 0 && dev->driver)
+		clk_disable(pcdev->pclk);
+
+	return ret;
+}
+
+static int amba_pm_runtime_suspend_noirq(struct device *dev)
+{
+	int ret = 0;
+
+	/*
+	 * If the amba device is not already runtime suspended
+	 * force it into this state to save power.
+	 */
+	if (!pm_runtime_status_suspended(dev))
+		ret = amba_pm_runtime_suspend(dev);
+
+	return ret;
+}
+
+static int amba_pm_runtime_resume(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	int ret;
+
+	if (dev->driver) {
+		ret = clk_enable(pcdev->pclk);
+		/* Failure is probably fatal to the system, but... */
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_runtime_resume(dev);
+}
+
+static int amba_pm_runtime_resume_noirq(struct device *dev)
+{
+	int ret = 0;
+
+	/*
+	 * If the amba device has been forced into runtime suspend state,
+	 * we must make sure to restore it back into runtime resumed state.
+	 */
+	if (!pm_runtime_status_suspended(dev))
+		ret = amba_pm_runtime_resume(dev);
+
+	return ret;
+}
+#else /* !CONFIG_PM_RUNTIME */
+
+static int amba_pm_runtime_suspend_noirq(struct device *dev)
+{
+	return 0;
+}
+static int amba_pm_runtime_resume_noirq(struct device *dev)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_PM_RUNTIME */
+
 #ifdef CONFIG_SUSPEND
 
 static int amba_pm_suspend(struct device *dev)
@@ -163,7 +236,9 @@ static int amba_pm_suspend_noirq(struct device *dev)
 	if (!drv)
 		return 0;
 
-	if (drv->pm) {
+	ret = amba_pm_runtime_suspend_noirq(dev);
+
+	if (!ret && drv->pm) {
 		if (drv->pm->suspend_noirq)
 			ret = drv->pm->suspend_noirq(dev);
 	}
@@ -202,6 +277,9 @@ static int amba_pm_resume_noirq(struct device *dev)
 			ret = drv->pm->resume_noirq(dev);
 	}
 
+	if (!ret)
+		ret = amba_pm_runtime_resume_noirq(dev);
+
 	return ret;
 }
 
@@ -365,39 +443,6 @@ static int amba_pm_restore_noirq(struct device *dev)
 
 #endif /* !CONFIG_HIBERNATE_CALLBACKS */
 
-#ifdef CONFIG_PM_RUNTIME
-/*
- * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
- * enable/disable the bus clock at runtime PM suspend/resume as this
- * does not result in loss of context.  However, disabling vcore power
- * would do, so we leave that to the driver.
- */
-static int amba_pm_runtime_suspend(struct device *dev)
-{
-	struct amba_device *pcdev = to_amba_device(dev);
-	int ret = pm_generic_runtime_suspend(dev);
-
-	if (ret == 0 && dev->driver)
-		clk_disable(pcdev->pclk);
-
-	return ret;
-}
-
-static int amba_pm_runtime_resume(struct device *dev)
-{
-	struct amba_device *pcdev = to_amba_device(dev);
-	int ret;
-
-	if (dev->driver) {
-		ret = clk_enable(pcdev->pclk);
-		/* Failure is probably fatal to the system, but... */
-		if (ret)
-			return ret;
-	}
-
-	return pm_generic_runtime_resume(dev);
-}
-#endif
 
 #ifdef CONFIG_PM
 
-- 
1.7.5.4
