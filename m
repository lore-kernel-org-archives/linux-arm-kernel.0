From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:23 +0200
Subject: [PATCH 13/13] driver-core: probe dependencies before probing
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-14-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before actually probing a device, find out what dependencies it has and
do our best to ensure that they are available at this point.

This is accomplished by finding out what platform devices need to be
probed so the dependencies are available.

If any dependencies are still unavailable after that (most probably a
missing driver or an error in the HW description from the firmware), we
print a nice error message so that people don't have to add a zillion of
printks to find out why a device asked for its probe to be deferred.

Dependencies are discovered with the help of the subsystems that already
implement the firmware bindings that specify the naming scheme of
properties that point to other nodes, via class.get_deps().

Currently the dependencies list is discarded but it could be stored for
later usage.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/base/dd.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 18438aa..8a64a29 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,9 @@
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -54,6 +57,121 @@ static LIST_HEAD(deferred_probe_active_list);
 static struct workqueue_struct *deferred_wq;
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
 
+static bool device_is_bound(struct device *dev)
+{
+	return klist_node_attached(&dev->p->knode_driver);
+}
+
+static int fwnode_match(struct device *dev, void *data)
+{
+	return dev->fwnode == data;
+}
+
+static bool fwnode_is_bound(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&platform_bus_type, NULL, fwnode, fwnode_match);
+
+	/* Check whether device is bound or is being probed right now */
+	return dev ? dev->driver : false;
+}
+
+static struct fwnode_handle *get_enclosing_platform_dev(
+						struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *iter, *node = NULL;
+
+	for (iter = fwnode;
+	     iter && fwnode_get_parent(iter);
+	     iter = fwnode_get_parent(iter)) {
+		struct fwnode_handle *parent = fwnode_get_parent(iter);
+
+		/* Only nodes with the compatible property can be probed */
+		if (fwnode_property_present(iter, "compatible"))
+			node = iter;
+
+		/* Stop just below root or if the parent is bound already */
+		if (!fwnode_get_parent(parent) ||
+		    fwnode_is_bound(parent))
+			break;
+	}
+
+	return node;
+}
+
+static bool check_dependency(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *target;
+	struct device *dev;
+
+	if (!fwnode)
+		return true;
+
+	target = get_enclosing_platform_dev(fwnode);
+	if (!target)
+		return true;
+
+	dev = bus_find_device(&platform_bus_type, NULL, target, fwnode_match);
+	if (!dev) {
+		pr_debug("Couldn't find device for %s\n",
+			 fwnode_get_name(fwnode));
+		return false;
+	}
+
+	/*
+	 * Device is bound or is being probed right now. If we have bad luck
+	 * and the dependency isn't ready when it's needed, deferred probe
+	 * will save us.
+	 */
+	if (dev->driver)
+		return true;
+
+	bus_probe_device(dev);
+
+	/* If the dependency hasn't finished probing, we'll want a warning */
+	return device_is_bound(dev);
+}
+
+static void check_dependencies_per_class(struct class *class, void *data)
+{
+	struct fwnode_handle *fwnode = data;
+	struct list_head *deps;
+	struct fwnode_dependency *dep, *tmp;
+
+	if (!class->get_dependencies)
+		return;
+
+	deps = class->get_dependencies(fwnode);
+	if (!deps)
+		return;
+
+	list_for_each_entry_safe(dep, tmp, deps, dependency) {
+		if (!check_dependency(dep->fwnode))
+			pr_debug("Dependency '%s' not available\n",
+				 fwnode_get_name(dep->fwnode));
+
+		list_del(&dep->dependency);
+		kfree(dep);
+	}
+
+	kfree(deps);
+}
+
+static void check_dependencies(struct device *dev)
+{
+	if (dev->parent && !check_dependency(dev->parent->fwnode))
+		pr_debug("Parent '%s' of device '%s' not available\n",
+			 dev_name(dev->parent), dev_name(dev));
+
+	if (!dev->fwnode) {
+		pr_debug("Device '%s' doesn't have a fwnode\n", dev_name(dev));
+		return;
+	}
+
+	for_each_class(check_dependencies_per_class, dev->fwnode);
+}
+
 /*
  * deferred_probe_work_func() - Retry probing devices in the active list.
  */
@@ -413,6 +531,8 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 		return 0;
 	}
 
+	check_dependencies(dev);
+
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
-- 
2.4.1
