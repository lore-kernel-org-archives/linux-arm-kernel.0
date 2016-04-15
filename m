From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 15 Apr 2016 11:13:32 +0200
Subject: [PATCH v8] drivers: amba: properly handle devices with power domains
Message-ID: <1460711612-5268-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To read pid/cid registers, the probed device need to be properly turned on.
When it is inside a power domain, the bus code should ensure that the
given power domain is enabled before trying to access device's registers.
However in some cases power domain (or clocks) might not be yet available.
Returning -EPROBE_DEFER is not a solution in such case, because callers
don't handle this special error code. Instead such devices are added to the
special list and their registration is retried from periodic worker until
all resources are available.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changelog:

v8:
- replaced notifier with periodic workqueue on Greg request

v7: https://lkml.org/lkml/2016/4/13/201
- replaced late_initcall approach with a notifier registered to device core

v6: https://lkml.org/lkml/2016/4/12/414
- got back to v1-style approach on Russell King request to avoid ABI break
- use list for storing deferred devices and retry their registration from
  late_initcall

v5: https://lkml.org/lkml/2016/2/10/179
- added 2 more patches to avoid regression with existing drivers (nvdimm and
  sa1111), for more information, see https://lkml.org/lkml/2015/12/17/390
- changed thread name to "AMBA: add complete support for power domains"

v4: https://lkml.org/lkml/2015/12/2/52
- fixed more issues pointed by Ulf Hansson and Russell King

v3: https://lkml.org/lkml/2015/12/1/334
- fixed issues pointed by Ulf Hansson
- dropped patch for exynos4210 dts, because it already got queued for merging

v2: https://lkml.org/lkml/2015/11/26/229
- added 2 patches from 'On-demand device probing' thread
  (https://lkml.org/lkml/2015/9/29/189), which move PID/CIR reading
  from amba_device_add() to amba_match()
- moved dev_pm_domain_attach() to amba_match(), which is allowed to
  return -EPROBE_DEFER

v1: http://www.spinics.net/lists/arm-kernel/msg463185.html
- initial version
---
 drivers/amba/bus.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f0099360039e..a5b5c87e2114 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -336,16 +336,7 @@ static void amba_device_release(struct device *dev)
 	kfree(d);
 }
 
-/**
- *	amba_device_add - add a previously allocated AMBA device structure
- *	@dev: AMBA device allocated by amba_device_alloc
- *	@parent: resource parent for this devices resources
- *
- *	Claim the resource, and read the device cell ID if not already
- *	initialized.  Register the AMBA device with the Linux device
- *	manager.
- */
-int amba_device_add(struct amba_device *dev, struct resource *parent)
+static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 {
 	u32 size;
 	void __iomem *tmp;
@@ -373,6 +364,12 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 		goto err_release;
 	}
 
+	ret = dev_pm_domain_attach(&dev->dev, true);
+	if (ret == -EPROBE_DEFER) {
+		iounmap(tmp);
+		goto err_release;
+	}
+
 	ret = amba_get_enable_pclk(dev);
 	if (ret == 0) {
 		u32 pid, cid;
@@ -398,6 +395,7 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 	}
 
 	iounmap(tmp);
+	dev_pm_domain_detach(&dev->dev, true);
 
 	if (ret)
 		goto err_release;
@@ -421,6 +419,88 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
  err_out:
 	return ret;
 }
+
+/*
+ * Registration of AMBA device require reading its pid and cid registers.
+ * To do this, the device must be turned on (if it is a part of power domain)
+ * and have clocks enabled. However in some cases those resources might not be
+ * yet available. Returning EPROBE_DEFER is not a solution in such case,
+ * because callers don't handle this special error code. Instead such devices
+ * are added to the special list and their registration is retried from
+ * periodic worker, until all resources are available and registration succeeds.
+ */
+struct deferred_device {
+	struct amba_device *dev;
+	struct resource *parent;
+	struct list_head node;
+};
+
+static LIST_HEAD(deferred_devices);
+static DEFINE_MUTEX(deferred_devices_lock);
+
+static void amba_deferred_retry_func(struct work_struct *dummy);
+static DECLARE_DELAYED_WORK(deferred_retry_work, amba_deferred_retry_func);
+
+#define DEFERRED_DEVICE_TIMEOUT (msecs_to_jiffies(5 * 1000))
+
+static void amba_deferred_retry_func(struct work_struct *dummy)
+{
+	struct deferred_device *ddev, *tmp;
+
+	mutex_lock(&deferred_devices_lock);
+
+	list_for_each_entry_safe(ddev, tmp, &deferred_devices, node) {
+		int ret = amba_device_try_add(ddev->dev, ddev->parent);
+
+		if (ret == -EPROBE_DEFER)
+			continue;
+
+		list_del_init(&ddev->node);
+		kfree(ddev);
+	}
+
+	if (!list_empty(&deferred_devices))
+		schedule_delayed_work(&deferred_retry_work,
+				      DEFERRED_DEVICE_TIMEOUT);
+
+	mutex_unlock(&deferred_devices_lock);
+}
+
+/**
+ *	amba_device_add - add a previously allocated AMBA device structure
+ *	@dev: AMBA device allocated by amba_device_alloc
+ *	@parent: resource parent for this devices resources
+ *
+ *	Claim the resource, and read the device cell ID if not already
+ *	initialized.  Register the AMBA device with the Linux device
+ *	manager.
+ */
+int amba_device_add(struct amba_device *dev, struct resource *parent)
+{
+	int ret = amba_device_try_add(dev, parent);
+
+	if (ret == -EPROBE_DEFER) {
+		struct deferred_device *ddev;
+
+		ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
+		if (!ddev)
+			return -ENOMEM;
+
+		ddev->dev = dev;
+		ddev->parent = parent;
+		ret = 0;
+
+		mutex_lock(&deferred_devices_lock);
+
+		if (list_empty(&deferred_devices))
+			schedule_delayed_work(&deferred_retry_work,
+					      DEFERRED_DEVICE_TIMEOUT);
+		list_add_tail(&ddev->node, &deferred_devices);
+
+		mutex_unlock(&deferred_devices_lock);
+	}
+	return ret;
+}
 EXPORT_SYMBOL_GPL(amba_device_add);
 
 static struct amba_device *
-- 
1.9.2
