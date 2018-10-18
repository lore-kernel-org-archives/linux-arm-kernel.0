From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 18 Oct 2018 08:49:06 +0200
Subject: [PATCH v4 2/3] driver core: add deferring probe reason to
 devices_deferred property
In-Reply-To: <CAHp75VdwnHLuXazD926CU+HWWv+sgp8BFCdW=vHqzMqsE87Ekg@mail.gmail.com>
References: <CAHp75VdwnHLuXazD926CU+HWWv+sgp8BFCdW=vHqzMqsE87Ekg@mail.gmail.com>
 <CGME20181018064916eucas1p22f03a19eb09cecdb0061dc5a4bf99ce6@eucas1p2.samsung.com>
Message-ID: <20181018064906.23116-1-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/sys/kernel/debug/devices_deferred property contains list of deferred devices.
This list does not contain reason why the driver deferred probe, the patch
improves it.
The natural place to set the reason is probe_err function introduced recently,
ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
will be attached to deferred device and printed when user read devices_deferred
property.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v4:
  - removed NULL check before kfree,
  - coding style tweaking.
v3:
  - adjusted deferred_devs_show, to accept newline ended messages,
  - changed conditonal check to positive,
  - added R-b by Andy.
v2:
  - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
  - use kasprintf instead of bunch of code,
  - keep consistent format of devices_deferred lines,
  - added R-Bs (again I hope changes above are not against it).
---
---
 drivers/base/base.h |  3 +++
 drivers/base/core.c |  9 +++++----
 drivers/base/dd.c   | 21 ++++++++++++++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a419a7a6235..effbd5e7f9f1 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -75,6 +75,7 @@ struct device_private {
 	struct klist_node knode_driver;
 	struct klist_node knode_bus;
 	struct list_head deferred_probe;
+	char *deferred_probe_msg;
 	struct device *device;
 };
 #define to_device_private_parent(obj)	\
@@ -113,6 +114,8 @@ extern void device_release_driver_internal(struct device *dev,
 extern void driver_detach(struct device_driver *drv);
 extern int driver_probe_device(struct device_driver *drv, struct device *dev);
 extern void driver_deferred_probe_del(struct device *dev);
+extern void __deferred_probe_set_msg(const struct device *dev,
+				     struct va_format *vaf);
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
 {
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1f3e99c2ef03..27990110fb24 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3076,6 +3076,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * This helper implements common pattern present in probe functions for error
  * checking: print message if the error is not -EPROBE_DEFER and propagate it.
+ * In case of -EPROBE_DEFER it sets defer probe reason.
  * It replaces code sequence:
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
@@ -3091,14 +3092,14 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
 	struct va_format vaf;
 	va_list args;
 
-	if (err == -EPROBE_DEFER)
-		return err;
-
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	dev_err(dev, "error %d: %pV", err, &vaf);
+	if (err == -EPROBE_DEFER)
+		__deferred_probe_set_msg(dev, &vaf);
+	else
+		dev_err(dev, "error %d: %pV", err, &vaf);
 
 	va_end(args);
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 169412ee4ae8..e7986a307420 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -27,6 +27,7 @@
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
+#include <linux/slab.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -132,6 +133,8 @@ void driver_deferred_probe_del(struct device *dev)
 	if (!list_empty(&dev->p->deferred_probe)) {
 		dev_dbg(dev, "Removed from deferred list\n");
 		list_del_init(&dev->p->deferred_probe);
+		kfree(dev->p->deferred_probe_msg);
+		dev->p->deferred_probe_msg = NULL;
 	}
 	mutex_unlock(&deferred_probe_mutex);
 }
@@ -202,6 +205,21 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+/*
+ * __deferred_probe_set_msg() - Set defer probe reason message for device
+ */
+void __deferred_probe_set_msg(const struct device *dev, struct va_format *vaf)
+{
+	const char *drv = dev_driver_string(dev);
+
+	mutex_lock(&deferred_probe_mutex);
+
+	kfree(dev->p->deferred_probe_msg);
+	dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
+
+	mutex_unlock(&deferred_probe_mutex);
+}
+
 /*
  * deferred_devs_show() - Show the devices in the deferred probe pending list.
  */
@@ -212,7 +230,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 	mutex_lock(&deferred_probe_mutex);
 
 	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
-		seq_printf(s, "%s\n", dev_name(curr->device));
+		seq_printf(s, "%s\t%s", dev_name(curr->device),
+			   curr->device->p->deferred_probe_msg ?: "\n");
 
 	mutex_unlock(&deferred_probe_mutex);
 
-- 
2.18.0
