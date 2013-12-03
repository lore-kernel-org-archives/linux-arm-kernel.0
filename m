From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Dec 2013 11:04:29 +0100
Subject: [PATCH 4/6] amba: Drop legacy PM support and use the pm_generic
 functions
In-Reply-To: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
References: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1386065071-9529-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All AMBA drivers have converted to use the modern PM ops thus we can
safely drop the legacy PM support from the bus.

While using the modern PM ops it also makes sense to convert to use the
pm_generic callback functions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c |  180 ++--------------------------------------------------
 1 file changed, 7 insertions(+), 173 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index c4876ac..b90dc1e 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -83,162 +83,6 @@ static struct device_attribute amba_dev_attrs[] = {
 	__ATTR_NULL,
 };
 
-#ifdef CONFIG_PM_SLEEP
-
-static int amba_legacy_suspend(struct device *dev, pm_message_t mesg)
-{
-	struct amba_driver *adrv = to_amba_driver(dev->driver);
-	struct amba_device *adev = to_amba_device(dev);
-	int ret = 0;
-
-	if (dev->driver && adrv->suspend)
-		ret = adrv->suspend(adev, mesg);
-
-	return ret;
-}
-
-static int amba_legacy_resume(struct device *dev)
-{
-	struct amba_driver *adrv = to_amba_driver(dev->driver);
-	struct amba_device *adev = to_amba_device(dev);
-	int ret = 0;
-
-	if (dev->driver && adrv->resume)
-		ret = adrv->resume(adev);
-
-	return ret;
-}
-
-#endif /* CONFIG_PM_SLEEP */
-
-#ifdef CONFIG_SUSPEND
-
-static int amba_pm_suspend(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->suspend)
-			ret = drv->pm->suspend(dev);
-	} else {
-		ret = amba_legacy_suspend(dev, PMSG_SUSPEND);
-	}
-
-	return ret;
-}
-
-static int amba_pm_resume(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->resume)
-			ret = drv->pm->resume(dev);
-	} else {
-		ret = amba_legacy_resume(dev);
-	}
-
-	return ret;
-}
-
-#else /* !CONFIG_SUSPEND */
-
-#define amba_pm_suspend		NULL
-#define amba_pm_resume		NULL
-
-#endif /* !CONFIG_SUSPEND */
-
-#ifdef CONFIG_HIBERNATE_CALLBACKS
-
-static int amba_pm_freeze(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->freeze)
-			ret = drv->pm->freeze(dev);
-	} else {
-		ret = amba_legacy_suspend(dev, PMSG_FREEZE);
-	}
-
-	return ret;
-}
-
-static int amba_pm_thaw(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->thaw)
-			ret = drv->pm->thaw(dev);
-	} else {
-		ret = amba_legacy_resume(dev);
-	}
-
-	return ret;
-}
-
-static int amba_pm_poweroff(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->poweroff)
-			ret = drv->pm->poweroff(dev);
-	} else {
-		ret = amba_legacy_suspend(dev, PMSG_HIBERNATE);
-	}
-
-	return ret;
-}
-
-static int amba_pm_restore(struct device *dev)
-{
-	struct device_driver *drv = dev->driver;
-	int ret = 0;
-
-	if (!drv)
-		return 0;
-
-	if (drv->pm) {
-		if (drv->pm->restore)
-			ret = drv->pm->restore(dev);
-	} else {
-		ret = amba_legacy_resume(dev);
-	}
-
-	return ret;
-}
-
-#else /* !CONFIG_HIBERNATE_CALLBACKS */
-
-#define amba_pm_freeze		NULL
-#define amba_pm_thaw		NULL
-#define amba_pm_poweroff		NULL
-#define amba_pm_restore		NULL
-
-#endif /* !CONFIG_HIBERNATE_CALLBACKS */
-
 #ifdef CONFIG_PM_RUNTIME
 /*
  * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
@@ -272,15 +116,13 @@ static int amba_pm_runtime_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM
-
 static const struct dev_pm_ops amba_pm = {
-	.suspend	= amba_pm_suspend,
-	.resume		= amba_pm_resume,
-	.freeze		= amba_pm_freeze,
-	.thaw		= amba_pm_thaw,
-	.poweroff	= amba_pm_poweroff,
-	.restore	= amba_pm_restore,
+	.suspend	= pm_generic_suspend,
+	.resume		= pm_generic_resume,
+	.freeze		= pm_generic_freeze,
+	.thaw		= pm_generic_thaw,
+	.poweroff	= pm_generic_poweroff,
+	.restore	= pm_generic_restore,
 	SET_RUNTIME_PM_OPS(
 		amba_pm_runtime_suspend,
 		amba_pm_runtime_resume,
@@ -288,14 +130,6 @@ static const struct dev_pm_ops amba_pm = {
 	)
 };
 
-#define AMBA_PM (&amba_pm)
-
-#else /* !CONFIG_PM */
-
-#define AMBA_PM	NULL
-
-#endif /* !CONFIG_PM */
-
 /*
  * Primecells are part of the Advanced Microcontroller Bus Architecture,
  * so we call the bus "amba".
@@ -305,7 +139,7 @@ struct bus_type amba_bustype = {
 	.dev_attrs	= amba_dev_attrs,
 	.match		= amba_match,
 	.uevent		= amba_uevent,
-	.pm		= AMBA_PM,
+	.pm		= &amba_pm,
 };
 
 static int __init amba_init(void)
-- 
1.7.9.5
