From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  7 Oct 2012 09:27:16 +0200
Subject: [PATCH 2/6] platform: pm: add suspend_mem and suspend_standby support
In-Reply-To: <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121006161429.GD12462@game.jcrosoft.org>
 <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1349594840-11374-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a drivers does not need to care about this distinction we fallback to
suspend. This will allow to do not update the current drivers.

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-pm at vger.kernel.org
---
 drivers/base/platform.c         |   40 +++++++++++++++++++++++++++++++++++++++
 include/linux/platform_device.h |    6 ++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8727e9c..f4822e2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -740,6 +740,46 @@ static int platform_legacy_resume(struct device *dev)
 
 #ifdef CONFIG_SUSPEND
 
+int platform_pm_suspend_mem(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->suspend_mem)
+			ret = drv->pm->suspend_mem(dev);
+		else if (drv->pm->suspend)
+			ret = drv->pm->suspend(dev);
+	} else {
+		ret = platform_legacy_suspend(dev, PMSG_SUSPEND);
+	}
+
+	return ret;
+}
+
+int platform_pm_suspend_standby(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret = 0;
+
+	if (!drv)
+		return 0;
+
+	if (drv->pm) {
+		if (drv->pm->suspend_standby)
+			ret = drv->pm->suspend_standby(dev);
+		else if (drv->pm->suspend)
+			ret = drv->pm->suspend(dev);
+	} else {
+		ret = platform_legacy_suspend(dev, PMSG_SUSPEND);
+	}
+
+	return ret;
+}
+
 int platform_pm_suspend(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 5711e95..a7c2275 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -262,9 +262,13 @@ static inline char *early_platform_driver_setup_func(void)		\
 
 #ifdef CONFIG_SUSPEND
 extern int platform_pm_suspend(struct device *dev);
+extern int platform_pm_suspend_mem(struct device *dev);
+extern int platform_pm_suspend_standby(struct device *dev);
 extern int platform_pm_resume(struct device *dev);
 #else
 #define platform_pm_suspend		NULL
+#define platform_pm_suspend_mem		NULL
+#define platform_pm_suspend_standby	NULL
 #define platform_pm_resume		NULL
 #endif
 
@@ -283,6 +287,8 @@ extern int platform_pm_restore(struct device *dev);
 #ifdef CONFIG_PM_SLEEP
 #define USE_PLATFORM_PM_SLEEP_OPS \
 	.suspend = platform_pm_suspend, \
+	.suspend_standby = platform_pm_suspend_standby, \
+	.suspend_mem = platform_pm_suspend_mem, \
 	.resume = platform_pm_resume, \
 	.freeze = platform_pm_freeze, \
 	.thaw = platform_pm_thaw, \
-- 
1.7.10.4
