From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Jul 2017 12:04:36 +0530
Subject: [RFC v2 6/6] drivers: boot_constraint: Add constraints for OF devices
In-Reply-To: <cover.1499770771.git.viresh.kumar@linaro.org>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
Message-ID: <2d53af367f7d912338d5d00e8fb7065b8ce45548.1499770771.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements the device tree dependent part of the boot constraints.

The supply constraints are added automatically for the platform and AMBA
devices created from DT and will be removed after the driver is
registered for the devices.

It is possible that some of the resources aren't available at the time
when the devices are added and so the boot constraints core will return
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/Makefile             |   3 +
 drivers/base/base.h               |   1 +
 drivers/base/boot_constraint.c    |   2 +-
 drivers/base/boot_constraint_of.c | 122 ++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c                 |  12 ++++
 drivers/of/platform.c             |   4 ++
 include/linux/boot_constraint.h   |   2 +
 7 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/boot_constraint_of.c

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 6094b3b75184..0f47a5de585a 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -6,6 +6,9 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o
 obj-$(CONFIG_BOOT_CONSTRAINTS) += boot_constraint.o
+ifeq ($(CONFIG_OF),y)
+obj-$(CONFIG_BOOT_CONSTRAINTS) += boot_constraint_of.o
+endif
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
 obj-y			+= power/
diff --git a/drivers/base/base.h b/drivers/base/base.h
index e19b1008e5fb..9d6910cdbc8e 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -136,6 +136,7 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
+extern void driver_enable_deferred_probe(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/boot_constraint.c b/drivers/base/boot_constraint.c
index 4e3b5e1aec7c..80ac3f9aaa72 100644
--- a/drivers/base/boot_constraint.c
+++ b/drivers/base/boot_constraint.c
@@ -50,7 +50,7 @@ static DEFINE_MUTEX(constraint_devices_mutex);
 static int constraint_supply_add(struct constraint *constraint, void *data);
 static void constraint_supply_remove(struct constraint *constraint);
 
-static bool boot_constraints_disabled;
+bool boot_constraints_disabled;
 
 static int __init constraints_disable(char *str)
 {
diff --git a/drivers/base/boot_constraint_of.c b/drivers/base/boot_constraint_of.c
new file mode 100644
index 000000000000..671241b3d3a3
--- /dev/null
+++ b/drivers/base/boot_constraint_of.c
@@ -0,0 +1,122 @@
+/*
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#define pr_fmt(fmt) "Boot Constraints: " fmt
+
+#include <linux/boot_constraint.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "base.h"
+
+extern bool boot_constraints_disabled;
+
+struct boot_constraint_of_pdata {
+	struct device *dev;
+	enum boot_constraint_type type;
+	struct boot_constraint_supply_info info;
+};
+
+static void boot_constraint_add_supply(struct device *dev, int index)
+{
+	struct boot_constraint_of_pdata pdata = {
+		.dev = dev,
+		.type = BOOT_CONSTRAINT_SUPPLY,
+	};
+	struct boot_constraint_supply_info *info;
+	struct device_node *np = dev->of_node;
+	struct platform_device *pdev;
+	int ret;
+
+	info = &pdata.info;
+
+	ret = of_property_read_string_index(np, "boot-constraint-supplies",
+					    index, &info->name);
+	if (ret < 0) {
+		dev_err(dev, "%s: Failed to read supply@index %d (%d)\n",
+			__func__, index, ret);
+		return;
+	}
+
+	of_property_read_u32_index(np, "boot-constraint-uV", 2 * index,
+				   &info->u_volt_min);
+
+	of_property_read_u32_index(np, "boot-constraint-uV", 2 * index + 1,
+				   &info->u_volt_max);
+
+	pdev = platform_device_register_data(NULL, "boot-constraints-of", index,
+					     &pdata, sizeof(pdata));
+	if (IS_ERR(pdev)) {
+		dev_err(dev, "%s: Failed to create pdev for index %d (%d)\n",
+			__func__, index, ret);
+	}
+}
+
+static void boot_constraint_add_supplies(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	int i, count;
+
+	count = of_property_count_strings(np, "boot-constraint-supplies");
+	if (count <= 0)
+		return;
+
+	for (i = 0; i < count; i++)
+		boot_constraint_add_supply(dev, i);
+}
+
+void of_boot_constraint_init(struct device *dev)
+{
+	if (boot_constraints_disabled)
+		return;
+
+	BUG_ON(!dev->of_node);
+
+	boot_constraint_add_supplies(dev);
+}
+
+static void boot_constraint_remove_of(void *data)
+{
+	platform_device_unregister(data);
+}
+
+/*
+ * A platform device is added for each and every constraint, to handle
+ * -EPROBE_DEFER properly.
+ */
+static int boot_constraint_of_probe(struct platform_device *pdev)
+{
+	struct boot_constraint_of_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct boot_constraint_info info;
+	int ret;
+
+	BUG_ON(!pdata);
+
+	info.free_resources = boot_constraint_remove_of;
+	info.free_resources_data = pdev;
+	info.constraint_info = &pdata->info;
+
+	ret = boot_constraint_add(pdata->dev, pdata->type, &info);
+	if (ret == -EPROBE_DEFER)
+		driver_enable_deferred_probe();
+
+	return ret;
+}
+
+static struct platform_driver boot_constraint_of_driver = {
+	.driver = {
+		.name = "boot-constraints-of",
+	},
+	.probe = boot_constraint_of_probe,
+};
+
+static int __init boot_constraint_of_init(void)
+{
+	return platform_driver_register(&boot_constraint_of_driver);
+}
+core_initcall(boot_constraint_of_init);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 4eb9d183d647..aa761e13d8a7 100644
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
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 703a42118ffc..b88a1bf3e7fb 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/amba/bus.h>
+#include <linux/boot_constraint.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
@@ -194,6 +195,8 @@ static struct platform_device *of_platform_device_create_pdata(
 		goto err_clear_flag;
 	}
 
+	of_boot_constraint_init(&dev->dev);
+
 	return dev;
 
 err_clear_flag:
@@ -271,6 +274,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		goto err_free;
 	}
 
+	of_boot_constraint_init(&dev->dev);
 	return dev;
 
 err_free:
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index 110e5eca36c6..17bec71df228 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -33,10 +33,12 @@ struct boot_constraint_info {
 int boot_constraint_add(struct device *dev, enum boot_constraint_type type,
 			struct boot_constraint_info *info);
 void boot_constraints_remove(struct device *dev);
+void of_boot_constraint_init(struct device *dev);
 #else
 static inline int boot_constraint_add(struct device *dev,
 				      enum boot_constraint_type type,
 				      struct boot_constraint_info *info)
 { return -EINVAL; }
 static inline void boot_constraints_remove(struct device *dev) {}
+static inline void of_boot_constraint_init(struct device *dev) {}
 #endif
-- 
2.13.0.71.gd7076ec9c9cb
