From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Jul 2017 12:04:31 +0530
Subject: [RFC v2 1/6] drivers: Add boot constraints core
In-Reply-To: <cover.1499770771.git.viresh.kumar@linaro.org>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
Message-ID: <f2007035f03e08270ae19a341560cabfcb6a57c0.1499770771.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some devices are powered ON by the bootloader before the bootloader
handovers control to Linux. It maybe important for those devices to keep
working until the time a Linux device driver probes the device and
reconfigure its resources.

A typical example of that can be the LCD controller, which is used by
the bootloaders to show image(s) while the platform is booting into
Linux.  The LCD controller can be using some resources, like clk,
regulators, etc, that are shared between several devices. These shared
resources should be configured to satisfy need of all the users.  If
another device's (X) driver gets probed before the LCD controller driver
in this case, then it may end up reconfiguring these resources to ranges
satisfying the current users (only device X) and that can make the LCD
screen unstable.

This patch introduces the concept of boot-constraints, which will be set
by the bootloaders and the kernel will satisfy them until the time
driver for such a device is probed (successfully or unsuccessfully).

The list of boot constraint types is empty for now, and will be added by
a later patch.

Only two routines are exposed by the boot constraints core for now:

- boot_constraint_add(): This will be called by parts of the kernel
  (before the device is probed) to set the constraints.

- boot_constraints_remove(): This is called only by the driver core
  after a device is probed successfully or unsuccessfully. Special
  handling is done here for deffered probing.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/Kconfig            |  10 ++
 drivers/base/Makefile           |   1 +
 drivers/base/boot_constraint.c  | 219 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c               |  20 ++--
 include/linux/boot_constraint.h |  36 +++++++
 5 files changed, 279 insertions(+), 7 deletions(-)
 create mode 100644 drivers/base/boot_constraint.c
 create mode 100644 include/linux/boot_constraint.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index d718ae4b907a..0cf7cdd3081e 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -339,4 +339,14 @@ config CMA_ALIGNMENT
 
 endif
 
+config BOOT_CONSTRAINTS
+	bool "Boot constraints for devices"
+	help
+	  This enables boot constraints detection for devices. These constraints
+	  are (normally) set by the Bootloader and must be satisfied by the
+	  kernel until the relevant device driver is probed. Once the driver is
+	  probed, the constraint is dropped.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index f2816f6ff76a..6094b3b75184 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -5,6 +5,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o
+obj-$(CONFIG_BOOT_CONSTRAINTS) += boot_constraint.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
 obj-y			+= power/
diff --git a/drivers/base/boot_constraint.c b/drivers/base/boot_constraint.c
new file mode 100644
index 000000000000..7dc7b6132765
--- /dev/null
+++ b/drivers/base/boot_constraint.c
@@ -0,0 +1,219 @@
+/*
+ * This takes care of boot time constraints, normally set by the Bootloader.
+ *
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#define pr_fmt(fmt) "Boot Constraints: " fmt
+
+#include <linux/boot_constraint.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+struct constraint {
+	struct constraint_dev *cdev;
+	struct list_head node;
+	enum boot_constraint_type type;
+	void (*free_resources)(void *data);
+	void *free_resources_data;
+
+	int (*add)(struct constraint *constraint, void *data);
+	void (*remove)(struct constraint *constraint);
+	void *private;
+};
+
+struct constraint_dev {
+	struct device *dev;
+	struct list_head node;
+	struct list_head constraints;
+};
+
+#define for_each_constraint(_constraint, _temp, _cdev)		\
+	list_for_each_entry_safe(_constraint, _temp, &_cdev->constraints, node)
+
+/* Global list of all constraint devices currently registered */
+static LIST_HEAD(constraint_devices);
+static DEFINE_MUTEX(constraint_devices_mutex);
+
+/* Forward declarations of constraints */
+
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
+					      enum boot_constraint_type type)
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
+int boot_constraint_add(struct device *dev, enum boot_constraint_type type,
+			struct boot_constraint_info *info)
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
+	constraint = constraint_allocate(cdev, type);
+	if (IS_ERR(constraint)) {
+		dev_err(dev, "Failed to add constraint type: %d (%ld)\n", type,
+			PTR_ERR(constraint));
+		ret = PTR_ERR(constraint);
+		goto put_cdev;
+	}
+
+	constraint->free_resources = info->free_resources;
+	constraint->free_resources_data = info->free_resources_data;
+
+	/* Set constraint */
+	ret = constraint->add(constraint, info->constraint_info);
+	if (ret)
+		goto free_constraint;
+
+	dev_dbg(dev, "Added boot constraint-type (%d)\n", type);
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
+EXPORT_SYMBOL_GPL(boot_constraint_add);
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
+void boot_constraints_remove(struct device *dev)
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
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 4882f06d12df..4eb9d183d647 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -17,6 +17,7 @@
  * This file is released under the GPLv2
  */
 
+#include <linux/boot_constraint.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -381,15 +382,20 @@ static int really_probe(struct device *dev, struct device_driver *drv)
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
+		boot_constraints_remove(dev);
+
+	if (ret)
+		goto probe_failed;
 
 	if (test_remove) {
 		test_remove = false;
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
new file mode 100644
index 000000000000..99f268447f72
--- /dev/null
+++ b/include/linux/boot_constraint.h
@@ -0,0 +1,36 @@
+/*
+ * Boot constraints header.
+ *
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2
+ */
+
+#include <linux/err.h>
+#include <linux/types.h>
+
+struct device;
+
+enum boot_constraint_type {
+	BOOT_CONSTRAINT_NONE,
+};
+
+struct boot_constraint_info {
+	/* This will be called just before the constraint is removed */
+	void (*free_resources)(void *data);
+	void *free_resources_data;
+	void *constraint_info;
+};
+
+#ifdef CONFIG_BOOT_CONSTRAINTS
+int boot_constraint_add(struct device *dev, enum boot_constraint_type type,
+			struct boot_constraint_info *info);
+void boot_constraints_remove(struct device *dev);
+#else
+static inline int boot_constraint_add(struct device *dev,
+				      enum boot_constraint_type type,
+				      struct boot_constraint_info *info)
+{ return -EINVAL; }
+static inline void boot_constraints_remove(struct device *dev) {}
+#endif
-- 
2.13.0.71.gd7076ec9c9cb
