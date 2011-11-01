From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 1 Nov 2011 11:14:57 +0100
Subject: [PATCH V3] AMBA: Put devices into low-power state in suspend_noirq
Message-ID: <1320142497-16750-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously it was possible for device drivers doing
pm_runtime_suspend and pm_runtime_put_sync from their suspend
callbacks. From the following commit, which solved a race issue,
this is not possible anymore.

PM: Limit race conditions between runtime PM and system sleep (v2)

Therefore some devices might not be in full low-power state after
device's suspend callbacks has been executed. To make sure this is
done the suspend_noirq callback is used.

In the resume_noirq the power is restored to the device if it were
previously cut in suspend_noirq. This to make sure the device is
put back into the same state as the device driver left it in from
it's suspend callback.

If a device is configured as wakeup device this will prevent the
bus from putting it into low-power state during suspend_noirq.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---

Changes in v3:
	- Fixup comments and commit message (including the header).

Changes in v2:
	- Integrated code directly into suspend|resume_noirq and get rid
	of not needed ifdefs.
	- Prevent runtime suspend if device is configured as wakeup.

---
 drivers/amba/bus.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index bd230e8..e3ecf66 100644
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
@@ -168,6 +170,15 @@ static int amba_pm_suspend_noirq(struct device *dev)
 			ret = drv->pm->suspend_noirq(dev);
 	}
 
+	/*
+	 * If the device's power hasn't already been cut and the
+	 * device doesn't need to generate wakeup requests, cut
+	 * the power now.
+	 */
+	if (!ret && !is_suspended && !device_may_wakeup(dev))
+		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
+			ret = dev->bus->pm->runtime_suspend(dev);
+
 	return ret;
 }
 
@@ -192,6 +203,7 @@ static int amba_pm_resume(struct device *dev)
 static int amba_pm_resume_noirq(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
+	bool is_suspended = pm_runtime_status_suspended(dev);
 	int ret = 0;
 
 	if (!drv)
@@ -202,6 +214,14 @@ static int amba_pm_resume_noirq(struct device *dev)
 			ret = drv->pm->resume_noirq(dev);
 	}
 
+	/*
+	 * If the device's power were cut during suspend_noirq
+	 * restore the power to the device now.
+	 */
+	if (!ret && !is_suspended && !device_may_wakeup(dev))
+		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
+			ret = dev->bus->pm->runtime_resume(dev);
+
 	return ret;
 }
 
-- 
1.7.5.4
