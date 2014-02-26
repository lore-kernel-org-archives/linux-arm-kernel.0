From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 26 Feb 2014 08:30:07 -0800
Subject: [PATCH 0/8] PM / Sleep / Runtime: Fixup some driver's system
 suspend
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7htxblx2eo.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Patch 1 -> 2:
> These patches provides two new runtime PM helper functions which intend to be
> used from system suspend/resume callbacks, to make sure devices are put into low
> power state during system suspend and brought back to full power at system
> resume.
>
> The prerequisite is to have all levels of a device's runtime PM callbacks to be
> defined through the SET_PM_RUNTIME_PM_OPS macro, which means these are available
> for CONFIG_PM.
>
> By using the new runtime PM helper functions especially the two scenarios below
> will be addressed.
>
> 1) The PM core prevents .runtime_suspend callbacks from being invoked during
> system suspend. That means even for a runtime PM centric subsystem and driver,
> the device needs to be put into low power state from a system suspend callback.
> Otherwise it may very well be left in full power state (runtime resumed) while
> the system is suspended. By using the new helper functions, we make sure to walk
> the hierarchy of a device's power domain, subsystem and driver.

I thought it was the case that runtime PM was only disabled during the
'late' phase now.  Isn't that enough to allow runtime callbacks in the
normal suspend/resume hooks now?   /me looks.

oh, wait.  Ee still have the _get_noresume() in device_prepare().  hmm

Either way, I'm not not a big fan of new functions.  Personally, I think
subsystems/busses/pm_domains should be able to opt out of the PM core
behavior that blocks runtime PM transitions during system suspend.
Something like the (untested) hack below.  That way, we could avoid the
need for new helper functions.

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1b41fca3d65a..e0770009ba8e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -832,7 +832,8 @@ static void device_complete(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
-	pm_runtime_put(dev);
+	if (dev->power.block_rpm_during_suspend)
+		pm_runtime_put(dev);
 }
 
 /**
@@ -1318,7 +1319,8 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	 * block runtime suspend here, during the prepare phase, and allow
 	 * it again during the complete phase.
 	 */
-	pm_runtime_get_noresume(dev);
+	if (dev->power.block_rpm_during_suspend)
+		pm_runtime_get_noresume(dev);
 
 	device_lock(dev);
 
@@ -1350,7 +1352,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
-	if (error)
+	if (error && dev->power.block_rpm_during_suspend)
 		pm_runtime_put(dev);
 
 	return error;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 8c6583a53a06..692cd543b71d 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -551,6 +551,7 @@ struct dev_pm_info {
 	struct wakeup_source	*wakeup;
 	bool			wakeup_path:1;
 	bool			syscore:1;
+	unsigned int            block_rpm_during_suspend:1;
 #else
 	unsigned int		should_wakeup:1;
 #endif

Kevin
