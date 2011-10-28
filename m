From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 28 Oct 2011 14:37:18 +0200
Subject: [PATCH V2] AMBA: Use suspend_noriq to force devices into runtime
	suspend
Message-ID: <1319805438-25004-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to make sure devices are put into runtime suspend
after a suspend sequence, the suspend_noirq callback is used.

Previously it was was possible for drivers doing pm_runtime_suspend
and pm_runtime_put_sync directly from it's suspend callbacks.
This is now not possible due to the following commit, which solved a
race issue:

PM: Limit race conditions between runtime PM and system sleep (v2)

If an AMBA device is used as wakeup device, the driver shall
configure the device as such. This will prevent the AMBA bus
from forcing it into runtime suspend state when executing the
suspend_noirq callback.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---

Changes in v2:
	- Integrated code directly into suspend|resume_noirq and get rid
	of not needed ifdefs.
	- Prevent runtime suspend if device is configured as wakeup.

---
 drivers/amba/bus.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index bd230e8..97ca9a9 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/pm.h>
+#include <linux/pm_wakeup.h>
 #include <linux/pm_runtime.h>
 #include <linux/amba/bus.h>
 
@@ -158,6 +159,7 @@ static int amba_pm_suspend(struct device *dev)
 static int amba_pm_suspend_noirq(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	bool is_suspended = pm_runtime_status_suspended(dev);
 	int ret = 0;
 
 	if (!drv)
@@ -168,6 +170,14 @@ static int amba_pm_suspend_noirq(struct device *dev)
 			ret = drv->pm->suspend_noirq(dev);
 	}
 
+	/*
+	 * If the amba device is not already runtime suspended,
+	 * check if we can force it into this state to save power.
+	 */
+	if (!ret && !is_suspended && !device_may_wakeup(dev))
+		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
+			ret = dev->bus->pm->runtime_suspend(dev);
+
 	return ret;
 }
 
@@ -192,6 +202,7 @@ static int amba_pm_resume(struct device *dev)
 static int amba_pm_resume_noirq(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	bool is_suspended = pm_runtime_status_suspended(dev);
 	int ret = 0;
 
 	if (!drv)
@@ -202,6 +213,14 @@ static int amba_pm_resume_noirq(struct device *dev)
 			ret = drv->pm->resume_noirq(dev);
 	}
 
+	/*
+	 * If the amba device was forced into runtime suspend state
+	 * from suspend_noirq, make sure we restore the state.
+	 */
+	if (!ret && !is_suspended && !device_may_wakeup(dev))
+		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
+			ret = dev->bus->pm->runtime_resume(dev);
+
 	return ret;
 }
 
-- 
1.7.5.4
