From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue,  1 Aug 2017 14:53:48 +0530
Subject: [PATCH V3 7/8] drivers: boot_constraint: Manage deferrable constraints
In-Reply-To: <cover.1501578037.git.viresh.kumar@linaro.org>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
Message-ID: <79e1a28ab90d0bb88c47c6179f57542e9d197443.1501578037.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible that some of the resources aren't available at the time
constraints are getting set and the boot constraints core will return
-EPROBE_DEFER for them. In order to retry adding the constraints at a
later point of time (after the resource is added and before any of its
users come up), this patch proposes two things:

- Each constraint is represented by a virtual platform device, so that
  it is re-probed again until the time all the dependencies aren't met.
  The platform device is removed along with the constraint, with help of
  the free_resources() callback.

- Enable early defer probing support by calling
  driver_enable_deferred_probe(), so that the core retries probing
  deferred devices every time any device is bound to a driver. This
  makes sure that the constraint is set before any of the users of the
  resources come up.

This is tested on ARM64 Hikey board where probe was deferred for a
device.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/base.h                            |   1 +
 drivers/base/boot_constraints/Makefile         |   2 +-
 drivers/base/boot_constraints/core.c           |   2 +-
 drivers/base/boot_constraints/core.h           |   2 +
 drivers/base/boot_constraints/deferrable_dev.c | 192 +++++++++++++++++++++++++
 drivers/base/dd.c                              |  12 ++
 include/linux/boot_constraint.h                |  10 ++
 7 files changed, 219 insertions(+), 2 deletions(-)
 create mode 100644 drivers/base/boot_constraints/deferrable_dev.c

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 539432a14b5c..9c117f0dc44c 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -131,6 +131,7 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
+extern void driver_enable_deferred_probe(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/boot_constraints/Makefile b/drivers/base/boot_constraints/Makefile
index b7ade1a7afb5..a765094623a3 100644
--- a/drivers/base/boot_constraints/Makefile
+++ b/drivers/base/boot_constraints/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := clk.o core.o pm.o supply.o
+obj-y := clk.o deferrable_dev.o core.o pm.o supply.o
diff --git a/drivers/base/boot_constraints/core.c b/drivers/base/boot_constraints/core.c
index c0e3a85ff85a..8e2f9b8fe80f 100644
--- a/drivers/base/boot_constraints/core.c
+++ b/drivers/base/boot_constraints/core.c
@@ -24,7 +24,7 @@
 static LIST_HEAD(constraint_devices);
 static DEFINE_MUTEX(constraint_devices_mutex);
 
-static bool boot_constraints_disabled;
+bool boot_constraints_disabled;
 
 static int __init constraints_disable(char *str)
 {
diff --git a/drivers/base/boot_constraints/core.h b/drivers/base/boot_constraints/core.h
index ee84e237c66a..41354f7206bf 100644
--- a/drivers/base/boot_constraints/core.h
+++ b/drivers/base/boot_constraints/core.h
@@ -32,6 +32,8 @@ struct constraint {
 	void *private;
 };
 
+extern bool boot_constraints_disabled;
+
 void constraint_add_debugfs(struct constraint *constraint, const char *suffix);
 void constraint_remove_debugfs(struct constraint *constraint);
 
diff --git a/drivers/base/boot_constraints/deferrable_dev.c b/drivers/base/boot_constraints/deferrable_dev.c
new file mode 100644
index 000000000000..5169882f2af1
--- /dev/null
+++ b/drivers/base/boot_constraints/deferrable_dev.c
@@ -0,0 +1,192 @@
+/*
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#define pr_fmt(fmt) "Boot Constraints: " fmt
+
+#include <linux/err.h>
+#include <linux/idr.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "../base.h"
+#include "core.h"
+
+static DEFINE_IDA(pdev_index);
+
+struct boot_constraint_pdata {
+	struct device *dev;
+	struct dev_boot_constraint constraint;
+	int probe_failed;
+	int index;
+};
+
+static void boot_constraint_remove(void *data)
+{
+	struct platform_device *pdev = data;
+	struct boot_constraint_pdata *pdata = dev_get_platdata(&pdev->dev);
+
+	ida_simple_remove(&pdev_index, pdata->index);
+	kfree(pdata->constraint.data);
+	platform_device_unregister(pdev);
+}
+
+/*
+ * A platform device is added for each and every constraint, to handle
+ * -EPROBE_DEFER properly.
+ */
+static int boot_constraint_probe(struct platform_device *pdev)
+{
+	struct boot_constraint_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct dev_boot_constraint_info info;
+	int ret;
+
+	if (WARN_ON(!pdata))
+		return -EINVAL;
+
+	info.constraint = pdata->constraint;
+	info.free_resources = boot_constraint_remove;
+	info.free_resources_data = pdev;
+
+	ret = dev_boot_constraint_add(pdata->dev, &info);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			driver_enable_deferred_probe();
+		else
+			pdata->probe_failed = ret;
+	}
+
+	return ret;
+}
+
+static struct platform_driver boot_constraint_driver = {
+	.driver = {
+		.name = "boot-constraints-dev",
+	},
+	.probe = boot_constraint_probe,
+};
+
+static int __init boot_constraint_init(void)
+{
+	return platform_driver_register(&boot_constraint_driver);
+}
+core_initcall(boot_constraint_init);
+
+static int _boot_constraint_add_dev(struct device *dev,
+				    struct dev_boot_constraint *constraint)
+{
+	struct boot_constraint_pdata pdata = {
+		.dev = dev,
+		.constraint.type = constraint->type,
+	};
+	struct platform_device *pdev;
+	struct boot_constraint_pdata *pdev_pdata;
+	int size, ret;
+
+	switch (constraint->type) {
+	case DEV_BOOT_CONSTRAINT_CLK:
+		size = sizeof(struct dev_boot_constraint_clk_info);
+		break;
+	case DEV_BOOT_CONSTRAINT_PM:
+		size = 0;
+		break;
+	case DEV_BOOT_CONSTRAINT_SUPPLY:
+		size = sizeof(struct dev_boot_constraint_supply_info);
+		break;
+	default:
+		dev_err(dev, "%s: Constraint type (%d) not supported\n",
+			__func__, constraint->type);
+		return -EINVAL;
+	}
+
+	/* Will be freed from boot_constraint_remove() */
+	pdata.constraint.data = kmemdup(constraint->data, size, GFP_KERNEL);
+	if (!pdata.constraint.data)
+		return -ENOMEM;
+
+	ret = ida_simple_get(&pdev_index, 0, 256, GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(dev, "failed to allocate index (%d)\n", ret);
+		goto free;
+	}
+
+	pdata.index = ret;
+
+	pdev = platform_device_register_data(NULL, "boot-constraints-dev", ret,
+					     &pdata, sizeof(pdata));
+	if (IS_ERR(pdev)) {
+		dev_err(dev, "%s: Failed to create pdev (%ld)\n", __func__,
+			PTR_ERR(pdev));
+		ret = PTR_ERR(pdev);
+		goto ida_remove;
+	}
+
+	/* Release resources if probe has failed */
+	pdev_pdata = dev_get_platdata(&pdev->dev);
+	if (pdev_pdata->probe_failed) {
+		ret = pdev_pdata->probe_failed;
+		goto remove_pdev;
+	}
+
+	return 0;
+
+remove_pdev:
+	platform_device_unregister(pdev);
+ida_remove:
+	ida_simple_remove(&pdev_index, pdata.index);
+free:
+	kfree(pdata.constraint.data);
+
+	return ret;
+}
+
+int dev_boot_constraint_add_deferrable(struct device *dev,
+			struct dev_boot_constraint *constraints, int count)
+{
+	int ret, i;
+
+	if (boot_constraints_disabled)
+		return -ENODEV;
+
+	for (i = 0; i < count; i++) {
+		ret = _boot_constraint_add_dev(dev, &constraints[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_boot_constraint_add_deferrable);
+
+/* This only creates platform devices for now */
+int dev_boot_constraint_add_of_deferrable(const char *compatible,
+			struct dev_boot_constraint *constraints, int count)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	if (boot_constraints_disabled)
+		return -ENODEV;
+
+	np = of_find_compatible_node(NULL, NULL, compatible);
+	if (!np)
+		return -ENODEV;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		pdev = of_platform_device_create(np, NULL, NULL);
+
+	of_node_put(np);
+
+	if (!pdev)
+		return -ENODEV;
+
+	return dev_boot_constraint_add_deferrable(&pdev->dev, constraints,
+						  count);
+}
+EXPORT_SYMBOL_GPL(dev_boot_constraint_add_of_deferrable);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 2262a4a4c0e4..62a8a22f8b04 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -204,6 +204,18 @@ void device_unblock_probing(void)
 }
 
 /**
+ * driver_enable_deferred_probe() - Enable probing of deferred devices
+ *
+ * We don't want to get in the way when the bulk of drivers are getting probed
+ * and so deferred probe is disabled in the beginning. Enable it now because we
+ * need it.
+ */
+void driver_enable_deferred_probe(void)
+{
+	driver_deferred_probe_enable = true;
+}
+
+/**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
  * We don't want to get in the way when the bulk of drivers are getting probed.
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index edc9abe7913a..f66c2f6d14dc 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -47,12 +47,22 @@ struct dev_boot_constraint_info {
 int dev_boot_constraint_add(struct device *dev,
 			    struct dev_boot_constraint_info *info);
 void dev_boot_constraints_remove(struct device *dev);
+int dev_boot_constraint_add_deferrable(struct device *dev,
+			struct dev_boot_constraint *constraints, int count);
+int dev_boot_constraint_add_of_deferrable(const char *compatible,
+			struct dev_boot_constraint *constraints, int count);
 #else
 static inline
 int dev_boot_constraint_add(struct device *dev,
 			    struct dev_boot_constraint_info *info);
 { return -EINVAL; }
 static inline void dev_boot_constraints_remove(struct device *dev) {}
+static inline int dev_boot_constraint_add_deferrable(struct device *dev,
+			struct dev_boot_constraint *constraints, int count)
+{ return -EINVAL; }
+static inline int dev_boot_constraint_add_of_deferrable(const char *compatible,
+			struct dev_boot_constraint *constraints, int count)
+{ return -EINVAL; }
 #endif /* CONFIG_DEV_BOOT_CONSTRAINTS */
 
 #endif /* _LINUX_BOOT_CONSTRAINT_H */
-- 
2.13.0.71.gd7076ec9c9cb
