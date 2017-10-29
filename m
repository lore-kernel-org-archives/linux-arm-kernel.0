From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:18:56 +0530
Subject: [PATCH V4 08/12] boot_constraint: Manage deferrable constraints
In-Reply-To: <cover.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <88c7a0a6421d267c118f501ea1e920b04649002d.1509284255.git.viresh.kumar@linaro.org>
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
 drivers/base/dd.c                         |  12 ++
 drivers/boot_constraints/Makefile         |   2 +-
 drivers/boot_constraints/deferrable_dev.c | 235 ++++++++++++++++++++++++++++++
 include/linux/boot_constraint.h           |  14 ++
 4 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 drivers/boot_constraints/deferrable_dev.c

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 4eec27fe2b2b..19eff5d08b9a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -228,6 +228,18 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+/**
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
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
index b7ade1a7afb5..a765094623a3 100644
--- a/drivers/boot_constraints/Makefile
+++ b/drivers/boot_constraints/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := clk.o core.o pm.o supply.o
+obj-y := clk.o deferrable_dev.o core.o pm.o supply.o
diff --git a/drivers/boot_constraints/deferrable_dev.c b/drivers/boot_constraints/deferrable_dev.c
new file mode 100644
index 000000000000..04056f317aff
--- /dev/null
+++ b/drivers/boot_constraints/deferrable_dev.c
@@ -0,0 +1,235 @@
+/*
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#define pr_fmt(fmt) "Boot Constraints: " fmt
+
+#include <linux/amba/bus.h>
+#include <linux/err.h>
+#include <linux/idr.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "core.h"
+
+static DEFINE_IDA(pdev_index);
+
+void driver_enable_deferred_probe(void);
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
+static int boot_constraint_add_dev(struct device *dev,
+				   struct dev_boot_constraint *constraint)
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
+static int dev_boot_constraint_add_deferrable(struct device *dev,
+			struct dev_boot_constraint *constraints, int count)
+{
+	int ret, i;
+
+	for (i = 0; i < count; i++) {
+		ret = boot_constraint_add_dev(dev, &constraints[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* This only creates platform devices for now */
+static void add_deferrable_of_single(struct device_node *np,
+				     struct dev_boot_constraint *constraints,
+				     int count)
+{
+	struct device *dev;
+	int ret;
+
+	if (!of_device_is_available(np))
+		return;
+
+	ret = of_platform_bus_create(np, NULL, NULL, NULL, false);
+	if (ret)
+		return;
+
+	if (of_device_is_compatible(np, "arm,primecell")) {
+		struct amba_device *adev = of_find_amba_device_by_node(np);
+
+		if (!adev) {
+			pr_err("Failed to find amba dev: %s\n", np->full_name);
+			return;
+		}
+		dev = &adev->dev;
+	} else {
+		struct platform_device *pdev = of_find_device_by_node(np);
+
+		if (!pdev) {
+			pr_err("Failed to find pdev: %s\n", np->full_name);
+			return;
+		}
+		dev = &pdev->dev;
+	}
+
+	ret = dev_boot_constraint_add_deferrable(dev, constraints, count);
+	if (ret)
+		dev_err(dev, "Failed to add boot constraint (%d)\n", ret);
+}
+
+/* Not all compatible device nodes may have boot constraints */
+static bool node_has_boot_constraints(struct device_node *np,
+				      struct dev_boot_constraint_of *oconst)
+{
+	int i;
+
+	if (!oconst->dev_names)
+		return true;
+
+	for (i = 0; i < oconst->dev_names_count; i++) {
+		if (!strcmp(oconst->dev_names[i], kbasename(np->full_name)))
+			return true;
+	}
+
+	return false;
+}
+
+void dev_boot_constraint_add_deferrable_of(struct dev_boot_constraint_of *oconst,
+					   int count)
+{
+	struct device_node *np;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		for_each_compatible_node(np, NULL, oconst[i].compat) {
+			if (!node_has_boot_constraints(np, &oconst[i]))
+				continue;
+
+			add_deferrable_of_single(np, oconst[i].constraints,
+						 oconst[i].count);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(dev_boot_constraint_add_deferrable_of);
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index 637fe9d65536..c110b36e490f 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -35,6 +35,15 @@ struct dev_boot_constraint {
 	void *data;
 };
 
+struct dev_boot_constraint_of {
+	const char *compat;
+	struct dev_boot_constraint *constraints;
+	unsigned int count;
+
+	const char **dev_names;
+	unsigned int dev_names_count;
+};
+
 struct dev_boot_constraint_info {
 	struct dev_boot_constraint constraint;
 
@@ -47,12 +56,17 @@ struct dev_boot_constraint_info {
 int dev_boot_constraint_add(struct device *dev,
 			    struct dev_boot_constraint_info *info);
 void dev_boot_constraints_remove(struct device *dev);
+void dev_boot_constraint_add_deferrable_of(struct dev_boot_constraint_of *oconst,
+					   int count);
 #else
 static inline
 int dev_boot_constraint_add(struct device *dev,
 			    struct dev_boot_constraint_info *info)
 { return -EINVAL; }
 static inline void dev_boot_constraints_remove(struct device *dev) {}
+void dev_boot_constraint_add_deferrable_of(struct dev_boot_constraint_of *oconst,
+					   int count)
+{ }
 #endif /* CONFIG_DEV_BOOT_CONSTRAINTS */
 
 #endif /* _LINUX_BOOT_CONSTRAINT_H */
-- 
2.15.0.rc1.236.g92ea95045093
