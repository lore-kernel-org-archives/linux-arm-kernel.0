From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Apr 2016 11:36:00 +0200
Subject: [PATCH v7 2/2] drivers: amba: properly handle devices with power
 domains
In-Reply-To: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
References: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1460540160-18762-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To read pid/cid registers, the probed device need to be properly turned on.
When it is inside a power domain, the bus code should ensure that the
given power domain is enabled before trying to access device's registers.
However in some cases power domain (or clocks) might not be yet available.
Returning EPROBE_DEFER is not a solution in such case, because callers
don't handle this special error code. Instead such devices are added to the
special list and their registration is retried in late_initcall, when
hopefully all resources are available.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/amba/bus.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 10 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f0099360039e..3329262007f9 100644
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
@@ -421,6 +419,94 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
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
+ * deferred probe notifier, when hopefully all resources are available.
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
+static int amba_deferred_probe_notifier(struct notifier_block *nb,
+			      unsigned long action, void *data);
+static struct notifier_block amba_deferred_probe_nb = {
+	.notifier_call = amba_deferred_probe_notifier,
+};
+
+static int amba_deferred_probe_notifier(struct notifier_block *nb,
+			      unsigned long action, void *data)
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
+	if (list_empty(&deferred_devices))
+		deferred_probe_unregister_notifier(&amba_deferred_probe_nb);
+
+	mutex_unlock(&deferred_devices_lock);
+
+	return NOTIFY_DONE;
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
+			ret = deferred_probe_register_notifier(
+						&amba_deferred_probe_nb);
+		if (ret == 0)
+			list_add_tail(&ddev->node, &deferred_devices);
+		else
+			kfree(ddev);
+
+		mutex_unlock(&deferred_devices_lock);
+	}
+	return ret;
+}
 EXPORT_SYMBOL_GPL(amba_device_add);
 
 static struct amba_device *
-- 
1.9.2
