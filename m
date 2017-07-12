From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Jul 2017 12:04:34 +0530
Subject: [RFC v2 4/6] drivers: boot_constraint: Add debugfs support
In-Reply-To: <cover.1499770771.git.viresh.kumar@linaro.org>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
Message-ID: <c52f57d42ec875da97acde84e5dbe86be5390f6c.1499770771.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds debugfs support for boot constraints. This is how it
looks for a "vmmc-supply" constraint for the MMC device.

$ ls -R /sys/kernel/debug/boot_constraints/
/sys/kernel/debug/boot_constraints/:
f723d000.dwmmc0

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0:
supply-vmmc

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmc:
u_volt_max  u_volt_min

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/boot_constraint.c | 80 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/base/boot_constraint.c b/drivers/base/boot_constraint.c
index d372ddfe1264..4e3b5e1aec7c 100644
--- a/drivers/base/boot_constraint.c
+++ b/drivers/base/boot_constraint.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "Boot Constraints: " fmt
 
 #include <linux/boot_constraint.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -24,6 +25,7 @@ struct constraint {
 	enum boot_constraint_type type;
 	void (*free_resources)(void *data);
 	void *free_resources_data;
+	struct dentry *dentry;
 
 	int (*add)(struct constraint *constraint, void *data);
 	void (*remove)(struct constraint *constraint);
@@ -34,6 +36,7 @@ struct constraint_dev {
 	struct device *dev;
 	struct list_head node;
 	struct list_head constraints;
+	struct dentry *dentry;
 };
 
 #define for_each_constraint(_constraint, _temp, _cdev)		\
@@ -59,6 +62,71 @@ static int __init constraints_disable(char *str)
 early_param("boot_constraints_disable", constraints_disable);
 
 
+/* Debugfs */
+
+static struct dentry *rootdir;
+
+static void constraint_device_add_debugfs(struct constraint_dev *cdev)
+{
+	struct device *dev = cdev->dev;
+
+	cdev->dentry = debugfs_create_dir(dev_name(dev), rootdir);
+	if (!cdev->dentry)
+		dev_err(dev, "Failed to create constraint dev debugfs dir\n");
+}
+
+static void constraint_device_remove_debugfs(struct constraint_dev *cdev)
+{
+	debugfs_remove_recursive(cdev->dentry);
+}
+
+static void constraint_add_debugfs(struct constraint *constraint,
+				   const char *suffix)
+{
+	struct device *dev = constraint->cdev->dev;
+	const char *prefix;
+	char name[NAME_MAX];
+
+	switch (constraint->type) {
+	case BOOT_CONSTRAINT_SUPPLY:
+		prefix = "supply";
+		break;
+	default:
+		dev_err(dev, "%s: Constraint type (%d) not supported\n",
+			__func__, constraint->type);
+		return;
+	}
+
+	snprintf(name, NAME_MAX, "%s-%s", prefix, suffix);
+
+	constraint->dentry = debugfs_create_dir(name, constraint->cdev->dentry);
+	if (!constraint->dentry)
+		dev_err(dev, "Failed to create constraint (%s) debugfs dir\n",
+			name);
+}
+
+static void constraint_remove_debugfs(struct constraint *constraint)
+{
+	debugfs_remove_recursive(constraint->dentry);
+}
+
+static int __init constraint_debugfs_init(void)
+{
+	if (boot_constraints_disabled)
+		return -ENODEV;
+
+	/* Create /sys/kernel/debug/opp directory */
+	rootdir = debugfs_create_dir("boot_constraints", NULL);
+	if (!rootdir) {
+		pr_err("Failed to create root directory\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+core_initcall(constraint_debugfs_init);
+
+
 /* Boot constraints core */
 
 static struct constraint_dev *constraint_device_find(struct device *dev)
@@ -86,12 +154,14 @@ static struct constraint_dev *constraint_device_allocate(struct device *dev)
 	INIT_LIST_HEAD(&cdev->constraints);
 
 	list_add(&cdev->node, &constraint_devices);
+	constraint_device_add_debugfs(cdev);
 
 	return cdev;
 }
 
 static void constraint_device_free(struct constraint_dev *cdev)
 {
+	constraint_device_remove_debugfs(cdev);
 	list_del(&cdev->node);
 	kfree(cdev);
 }
@@ -292,6 +362,15 @@ static int constraint_supply_add(struct constraint *constraint, void *data)
 	csupply->supply.name = kstrdup_const(supply->name, GFP_KERNEL);
 	constraint->private = csupply;
 
+	/* Debugfs */
+	constraint_add_debugfs(constraint, supply->name);
+
+	debugfs_create_u32("u_volt_min", 0444, constraint->dentry,
+			   &csupply->supply.u_volt_min);
+
+	debugfs_create_u32("u_volt_max", 0444, constraint->dentry,
+			   &csupply->supply.u_volt_max);
+
 	return 0;
 
 remove_voltage:
@@ -319,6 +398,7 @@ static void constraint_supply_remove(struct constraint *constraint)
 		dev_err(dev, "regulator_set_voltage failed (%d)\n", ret);
 
 	regulator_put(csupply->reg);
+	constraint_remove_debugfs(constraint);
 	kfree_const(csupply->supply.name);
 	kfree(csupply);
 }
-- 
2.13.0.71.gd7076ec9c9cb
