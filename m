From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:18:51 +0530
Subject: [PATCH V4 03/12] drivers: Add boot constraints core
In-Reply-To: <cover.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <2868a37e561cab91ba5495a1e14b9548c8e93c3e.1509284255.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices are powered ON by the bootloader before the bootloader
handovers control to Linux. It maybe important for those devices to keep
working until the time a Linux device driver probes the device and
reconfigure its resources.

A typical example of that can be the LCD controller, which is used by
the bootloaders to show image(s) while the platform is booting into
Linux. The LCD controller can be using some resources, like clk,
regulators, PM domain, etc, that are shared between several devices.
These shared resources should be configured to satisfy need of all the
users. If another device's (X) driver gets probed before the LCD
controller driver in this case, then it may end up reconfiguring these
resources to ranges satisfying the current users (only device X) and
that can make the LCD screen unstable.

This patch introduces the concept of boot-constraints, which will be set
by the bootloaders and the kernel will satisfy them until the time
driver for such a device is probed (successfully or unsuccessfully).

The list of boot constraint types is empty for now, and will be
incrementally updated by later patches.

Only two routines are exposed by the boot constraints core for now:

- dev_boot_constraint_add(): This shall be called by parts of the kernel
  (before the device is probed) to set the constraints.

- dev_boot_constraints_remove(): This is called only by the driver core
  after a device is probed successfully or unsuccessfully. Special
  handling is done here for deferred probing.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/Kconfig                   |   2 +
 drivers/Makefile                  |   1 +
 drivers/base/dd.c                 |  20 ++--
 drivers/boot_constraints/Kconfig  |   9 ++
 drivers/boot_constraints/Makefile |   3 +
 drivers/boot_constraints/core.c   | 199 ++++++++++++++++++++++++++++++++++++++
 drivers/boot_constraints/core.h   |  33 +++++++
 include/linux/boot_constraint.h   |  46 +++++++++
 8 files changed, 306 insertions(+), 7 deletions(-)
 create mode 100644 drivers/boot_constraints/Kconfig
 create mode 100644 drivers/boot_constraints/Makefile
 create mode 100644 drivers/boot_constraints/core.c
 create mode 100644 drivers/boot_constraints/core.h
 create mode 100644 include/linux/boot_constraint.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 505c676fa9c7..e595ffad2214 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -4,6 +4,8 @@ source "drivers/amba/Kconfig"
 
 source "drivers/base/Kconfig"
 
+source "drivers/boot_constraints/Kconfig"
+
 source "drivers/bus/Kconfig"
 
 source "drivers/connector/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index d90fdc413648..29d03466cb2a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
 obj-$(CONFIG_PARPORT)		+= parport/
 obj-$(CONFIG_NVM)		+= lightnvm/
 obj-y				+= base/ block/ misc/ mfd/ nfc/
+obj-$(CONFIG_DEV_BOOT_CONSTRAINTS) += boot_constraints/
 obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
 obj-$(CONFIG_DAX)		+= dax/
 obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index ad44b40fe284..4eec27fe2b2b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -17,6 +17,7 @@
  * This file is released under the GPLv2
  */
 
+#include <linux/boot_constraint.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -409,15 +410,20 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	 */
 	devices_kset_move_last(dev);
 
-	if (dev->bus->probe) {
+	if (dev->bus->probe)
 		ret = dev->bus->probe(dev);
-		if (ret)
-			goto probe_failed;
-	} else if (drv->probe) {
+	else if (drv->probe)
 		ret = drv->probe(dev);
-		if (ret)
-			goto probe_failed;
-	}
+
+	/*
+	 * Remove boot constraints for both successful and unsuccessful probe(),
+	 * except for the case where EPROBE_DEFER is returned by probe().
+	 */
+	if (ret != -EPROBE_DEFER)
+		dev_boot_constraints_remove(dev);
+
+	if (ret)
+		goto probe_failed;
 
 	if (test_remove) {
 		test_remove = false;
diff --git a/drivers/boot_constraints/Kconfig b/drivers/boot_constraints/Kconfig
new file mode 100644
index 000000000000..77831af1c6fb
--- /dev/null
+++ b/drivers/boot_constraints/Kconfig
@@ -0,0 +1,9 @@
+config DEV_BOOT_CONSTRAINTS
+	bool "Boot constraints for devices"
+	help
+	  This enables boot constraints detection for devices. These constraints
+	  are (normally) set by the Bootloader and must be satisfied by the
+	  kernel until the relevant device driver is probed. Once the driver is
+	  probed, the constraint is dropped.
+
+	  If unsure, say N.
diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
new file mode 100644
index 000000000000..0f2680177974
--- /dev/null
+++ b/drivers/boot_constraints/Makefile
@@ -0,0 +1,3 @@
+# Makefile for device boot constraints
+
+obj-y := core.o
diff --git a/drivers/boot_constraints/core.c b/drivers/boot_constraints/core.c
new file mode 100644
index 000000000000..366a05d6d9ba
--- /dev/null
+++ b/drivers/boot_constraints/core.c
@@ -0,0 +1,199 @@
+/*
+ * This takes care of boot time device constraints, normally set by the
+ * Bootloader.
+ *
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#define pr_fmt(fmt) "Boot Constraints: " fmt
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#include "core.h"
+
+#define for_each_constraint(_constraint, _temp, _cdev)		\
+	list_for_each_entry_safe(_constraint, _temp, &_cdev->constraints, node)
+
+/* Global list of all constraint devices currently registered */
+static LIST_HEAD(constraint_devices);
+static DEFINE_MUTEX(constraint_devices_mutex);
+
+/* Boot constraints core */
+
+static struct constraint_dev *constraint_device_find(struct device *dev)
+{
+	struct constraint_dev *cdev;
+
+	list_for_each_entry(cdev, &constraint_devices, node) {
+		if (cdev->dev == dev)
+			return cdev;
+	}
+
+	return NULL;
+}
+
+static struct constraint_dev *constraint_device_allocate(struct device *dev)
+{
+	struct constraint_dev *cdev;
+
+	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
+	if (!cdev)
+		return ERR_PTR(-ENOMEM);
+
+	cdev->dev = dev;
+	INIT_LIST_HEAD(&cdev->node);
+	INIT_LIST_HEAD(&cdev->constraints);
+
+	list_add(&cdev->node, &constraint_devices);
+
+	return cdev;
+}
+
+static void constraint_device_free(struct constraint_dev *cdev)
+{
+	list_del(&cdev->node);
+	kfree(cdev);
+}
+
+static struct constraint_dev *constraint_device_get(struct device *dev)
+{
+	struct constraint_dev *cdev;
+
+	cdev = constraint_device_find(dev);
+	if (cdev)
+		return cdev;
+
+	cdev = constraint_device_allocate(dev);
+	if (IS_ERR(cdev)) {
+		dev_err(dev, "Failed to add constraint dev (%ld)\n",
+			PTR_ERR(cdev));
+	}
+
+	return cdev;
+}
+
+static void constraint_device_put(struct constraint_dev *cdev)
+{
+	if (!list_empty(&cdev->constraints))
+		return;
+
+	constraint_device_free(cdev);
+}
+
+static struct constraint *constraint_allocate(struct constraint_dev *cdev,
+					enum dev_boot_constraint_type type)
+{
+	struct constraint *constraint;
+	int (*add)(struct constraint *constraint, void *data);
+	void (*remove)(struct constraint *constraint);
+
+	switch (type) {
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	constraint = kzalloc(sizeof(*constraint), GFP_KERNEL);
+	if (!constraint)
+		return ERR_PTR(-ENOMEM);
+
+	constraint->cdev = cdev;
+	constraint->type = type;
+	constraint->add = add;
+	constraint->remove = remove;
+	INIT_LIST_HEAD(&constraint->node);
+
+	list_add(&constraint->node, &cdev->constraints);
+
+	return constraint;
+}
+
+static void constraint_free(struct constraint *constraint)
+{
+	list_del(&constraint->node);
+	kfree(constraint);
+}
+
+int dev_boot_constraint_add(struct device *dev,
+			    struct dev_boot_constraint_info *info)
+{
+	struct constraint_dev *cdev;
+	struct constraint *constraint;
+	int ret;
+
+	mutex_lock(&constraint_devices_mutex);
+
+	/* Find or add the cdev type first */
+	cdev = constraint_device_get(dev);
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
+		goto unlock;
+	}
+
+	constraint = constraint_allocate(cdev, info->constraint.type);
+	if (IS_ERR(constraint)) {
+		dev_err(dev, "Failed to add constraint type: %d (%ld)\n",
+			info->constraint.type, PTR_ERR(constraint));
+		ret = PTR_ERR(constraint);
+		goto put_cdev;
+	}
+
+	constraint->free_resources = info->free_resources;
+	constraint->free_resources_data = info->free_resources_data;
+
+	/* Set constraint */
+	ret = constraint->add(constraint, info->constraint.data);
+	if (ret)
+		goto free_constraint;
+
+	dev_dbg(dev, "Added boot constraint-type (%d)\n",
+		info->constraint.type);
+
+	mutex_unlock(&constraint_devices_mutex);
+
+	return 0;
+
+free_constraint:
+	constraint_free(constraint);
+put_cdev:
+	constraint_device_put(cdev);
+unlock:
+	mutex_unlock(&constraint_devices_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_boot_constraint_add);
+
+static void constraint_remove(struct constraint *constraint)
+{
+	constraint->remove(constraint);
+
+	if (constraint->free_resources)
+		constraint->free_resources(constraint->free_resources_data);
+
+	constraint_free(constraint);
+}
+
+void dev_boot_constraints_remove(struct device *dev)
+{
+	struct constraint_dev *cdev;
+	struct constraint *constraint, *temp;
+
+	mutex_lock(&constraint_devices_mutex);
+
+	cdev = constraint_device_find(dev);
+	if (!cdev)
+		goto unlock;
+
+	for_each_constraint(constraint, temp, cdev)
+		constraint_remove(constraint);
+
+	constraint_device_put(cdev);
+unlock:
+	mutex_unlock(&constraint_devices_mutex);
+}
diff --git a/drivers/boot_constraints/core.h b/drivers/boot_constraints/core.h
new file mode 100644
index 000000000000..7ba4ac172c09
--- /dev/null
+++ b/drivers/boot_constraints/core.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+#ifndef _CORE_H
+#define _CORE_H
+
+#include <linux/boot_constraint.h>
+#include <linux/device.h>
+#include <linux/list.h>
+
+struct constraint_dev {
+	struct device *dev;
+	struct list_head node;
+	struct list_head constraints;
+};
+
+struct constraint {
+	struct constraint_dev *cdev;
+	struct list_head node;
+	enum dev_boot_constraint_type type;
+	void (*free_resources)(void *data);
+	void *free_resources_data;
+
+	int (*add)(struct constraint *constraint, void *data);
+	void (*remove)(struct constraint *constraint);
+	void *private;
+};
+
+/* Forward declarations of constraint specific callbacks */
+#endif /* _CORE_H */
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
new file mode 100644
index 000000000000..2b816bf74144
--- /dev/null
+++ b/include/linux/boot_constraint.h
@@ -0,0 +1,46 @@
+/*
+ * Boot constraints header.
+ *
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef _LINUX_BOOT_CONSTRAINT_H
+#define _LINUX_BOOT_CONSTRAINT_H
+
+#include <linux/err.h>
+#include <linux/types.h>
+
+struct device;
+
+enum dev_boot_constraint_type {
+	DEV_BOOT_CONSTRAINT_NONE,
+};
+
+struct dev_boot_constraint {
+	enum dev_boot_constraint_type type;
+	void *data;
+};
+
+struct dev_boot_constraint_info {
+	struct dev_boot_constraint constraint;
+
+	/* This will be called just before the constraint is removed */
+	void (*free_resources)(void *data);
+	void *free_resources_data;
+};
+
+#ifdef CONFIG_DEV_BOOT_CONSTRAINTS
+int dev_boot_constraint_add(struct device *dev,
+			    struct dev_boot_constraint_info *info);
+void dev_boot_constraints_remove(struct device *dev);
+#else
+static inline
+int dev_boot_constraint_add(struct device *dev,
+			    struct dev_boot_constraint_info *info)
+{ return -EINVAL; }
+static inline void dev_boot_constraints_remove(struct device *dev) {}
+#endif /* CONFIG_DEV_BOOT_CONSTRAINTS */
+
+#endif /* _LINUX_BOOT_CONSTRAINT_H */
-- 
2.15.0.rc1.236.g92ea95045093
