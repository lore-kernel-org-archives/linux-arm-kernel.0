From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 19 Mar 2015 17:58 +0100
Subject: [PATCH] driver core / PM: Add PM domain callbacks for device
 setup/cleanup
In-Reply-To: <3998390.WErrfO4Yno@vostro.rjw.lan>
References: <3533423.QQDErEmeTO@vostro.rjw.lan>
 <CAPDyKFo8YNpnriaAcLnEJ8tLZ+G68N_fyfOAYoEjBPHP=wyWbQ@mail.gmail.com>
 <3998390.WErrfO4Yno@vostro.rjw.lan>
Message-ID: <5975784.LhOHuiUKGO@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If PM domains are in use, it may be necessary to prepare the code
handling a PM domain for driver probing.  For example, in some
cases device drivers rely on the ability to power on the devices
with the help of the IO runtime PM framework and the PM domain
code needs to be ready for that.  Also, if that code has not been
fully initialized yet, the driver probing should be deferred.

Moreover, after the probing is complete, it may be necessary to
put the PM domain in question into the state reflecting the current
needs of the devices in it, for example, so that power is not drawn
in vain.  The same should be done after removing a driver from
a device, as the PM domain state may need to be changed to reflect
the new situation.

For these reasons, introduce new PM domain callbacks, ->activate
and ->sync, called, respectively, before probing for a device
driver and after the probing has been completed or the driver
has been removed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is an update without the additional bus type callbacks.  This should
be suffucient at this point for the use cases we have.

I've decided to also call ->sync on driver removal as that is consistent
with what happens for failing probe.

---
 drivers/base/dd.c  |   24 ++++++++++++++++++------
 include/linux/pm.h |    6 ++++++
 2 files changed, 24 insertions(+), 6 deletions(-)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -603,10 +603,16 @@ extern void dev_pm_put_subsys_data(struc
  * Power domains provide callbacks that are executed during system suspend,
  * hibernation, system resume and during runtime PM transitions along with
  * subsystem-level and driver-level callbacks.
+ *
+ * @detach: Called when removing a device from the domain.
+ * @activate: Called before executing probe routines for bus types and drivers.
+ * @sync: Called after driver probe and removal.
  */
 struct dev_pm_domain {
 	struct dev_pm_ops	ops;
 	void (*detach)(struct device *dev, bool power_off);
+	int (*activate)(struct device *dev);
+	void (*sync)(struct device *dev);
 };
 
 /*
Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -279,6 +279,7 @@ static int really_probe(struct device *d
 {
 	int ret = 0;
 	int local_trigger_count = atomic_read(&deferred_trigger_count);
+	struct dev_pm_domain *pm_domain = dev->pm_domain;
 
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
@@ -298,16 +299,23 @@ static int really_probe(struct device *d
 		goto probe_failed;
 	}
 
-	if (dev->bus->probe) {
-		ret = dev->bus->probe(dev);
-		if (ret)
-			goto probe_failed;
-	} else if (drv->probe) {
-		ret = drv->probe(dev);
+	if (pm_domain && pm_domain->activate) {
+		ret = pm_domain->activate(dev);
 		if (ret)
 			goto probe_failed;
 	}
 
+	if (dev->bus->probe)
+		ret = dev->bus->probe(dev);
+	else if (drv->probe)
+		ret = drv->probe(dev);
+
+	if (pm_domain && pm_domain->sync)
+		pm_domain->sync(dev);
+
+	if (ret)
+		goto probe_failed;
+
 	driver_bound(dev);
 	ret = 1;
 	pr_debug("bus: '%s': %s: bound device %s to driver %s\n",
@@ -522,6 +530,10 @@ static void __device_release_driver(stru
 			dev->bus->remove(dev);
 		else if (drv->remove)
 			drv->remove(dev);
+
+		if (dev->pm_domain && dev->pm_domain->sync)
+			dev->pm_domain->sync(dev);
+
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
