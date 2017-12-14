From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 Dec 2017 21:03:14 +0530
Subject: [PATCH V5 07/13] boot_constraint: Add debugfs support
In-Reply-To: <cover.1513264961.git.viresh.kumar@linaro.org>
References: <cover.1513264961.git.viresh.kumar@linaro.org>
Message-ID: <b3b65dd0603c33fddc78fac7862b8eb7abf0fcf8.1513264961.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds debugfs support for boot constraints. This is how it
looks for a "vmmc-supply" constraint for the MMC device.

$ ls -R /sys/kernel/debug/boot_constraints/
/sys/kernel/debug/boot_constraints/:
f723d000.dwmmc0

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0:
clk-ciu  pm-domain  supply-vmmc  supply-vmmcaux

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0/clk-ciu:

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0/pm-domain:

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmc:
u_volt_max  u_volt_min

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmcaux:
u_volt_max  u_volt_min

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/boot_constraint/clk.c    |  3 ++
 drivers/boot_constraint/core.c   | 59 ++++++++++++++++++++++++++++++++++++++++
 drivers/boot_constraint/core.h   |  6 ++++
 drivers/boot_constraint/pm.c     | 11 ++++++--
 drivers/boot_constraint/supply.c |  9 ++++++
 5 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/boot_constraint/clk.c b/drivers/boot_constraint/clk.c
index db22acff43e6..ebc871c29a83 100644
--- a/drivers/boot_constraint/clk.c
+++ b/drivers/boot_constraint/clk.c
@@ -46,6 +46,8 @@ int constraint_clk_add(struct constraint *constraint, void *data)
 	cclk->clk_info.name = kstrdup_const(clk_info->name, GFP_KERNEL);
 	constraint->private = cclk;
 
+	constraint_add_debugfs(constraint, clk_info->name);
+
 	return 0;
 
 put_clk:
@@ -60,6 +62,7 @@ void constraint_clk_remove(struct constraint *constraint)
 {
 	struct constraint_clk *cclk = constraint->private;
 
+	constraint_remove_debugfs(constraint);
 	kfree_const(cclk->clk_info.name);
 	clk_disable_unprepare(cclk->clk);
 	clk_put(cclk->clk);
diff --git a/drivers/boot_constraint/core.c b/drivers/boot_constraint/core.c
index b36c02aa50c5..0350c5057ee5 100644
--- a/drivers/boot_constraint/core.c
+++ b/drivers/boot_constraint/core.c
@@ -21,6 +21,63 @@
 static LIST_HEAD(constraint_devices);
 static DEFINE_MUTEX(constraint_devices_mutex);
 
+/* Debugfs */
+
+static struct dentry *rootdir;
+
+static void constraint_device_add_debugfs(struct constraint_dev *cdev)
+{
+	struct device *dev = cdev->dev;
+
+	cdev->dentry = debugfs_create_dir(dev_name(dev), rootdir);
+}
+
+static void constraint_device_remove_debugfs(struct constraint_dev *cdev)
+{
+	debugfs_remove_recursive(cdev->dentry);
+}
+
+void constraint_add_debugfs(struct constraint *constraint, const char *suffix)
+{
+	struct device *dev = constraint->cdev->dev;
+	const char *prefix;
+	char name[NAME_MAX];
+
+	switch (constraint->type) {
+	case DEV_BOOT_CONSTRAINT_CLK:
+		prefix = "clk";
+		break;
+	case DEV_BOOT_CONSTRAINT_PM:
+		prefix = "pm";
+		break;
+	case DEV_BOOT_CONSTRAINT_SUPPLY:
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
+}
+
+void constraint_remove_debugfs(struct constraint *constraint)
+{
+	debugfs_remove_recursive(constraint->dentry);
+}
+
+static int __init constraint_debugfs_init(void)
+{
+	rootdir = debugfs_create_dir("boot_constraints", NULL);
+
+	return 0;
+}
+core_initcall(constraint_debugfs_init);
+
+
 /* Boot constraints core */
 
 static struct constraint_dev *constraint_device_find(struct device *dev)
@@ -48,12 +105,14 @@ static struct constraint_dev *constraint_device_allocate(struct device *dev)
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
diff --git a/drivers/boot_constraint/core.h b/drivers/boot_constraint/core.h
index c5b27617b4ae..9dd481d38b99 100644
--- a/drivers/boot_constraint/core.h
+++ b/drivers/boot_constraint/core.h
@@ -7,6 +7,7 @@
 #define _CORE_H
 
 #include <linux/boot_constraint.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/list.h>
 
@@ -14,6 +15,7 @@ struct constraint_dev {
 	struct device *dev;
 	struct list_head node;
 	struct list_head constraints;
+	struct dentry *dentry;
 };
 
 struct constraint {
@@ -22,12 +24,16 @@ struct constraint {
 	enum dev_boot_constraint_type type;
 	void (*free_resources)(void *data);
 	void *free_resources_data;
+	struct dentry *dentry;
 
 	int (*add)(struct constraint *constraint, void *data);
 	void (*remove)(struct constraint *constraint);
 	void *private;
 };
 
+void constraint_add_debugfs(struct constraint *constraint, const char *suffix);
+void constraint_remove_debugfs(struct constraint *constraint);
+
 /* Forward declarations of constraint specific callbacks */
 int constraint_clk_add(struct constraint *constraint, void *data);
 void constraint_clk_remove(struct constraint *constraint);
diff --git a/drivers/boot_constraint/pm.c b/drivers/boot_constraint/pm.c
index 4950ec6b248b..584d3d46ef65 100644
--- a/drivers/boot_constraint/pm.c
+++ b/drivers/boot_constraint/pm.c
@@ -11,11 +11,18 @@
 int constraint_pm_add(struct constraint *constraint, void *data)
 {
 	struct device *dev = constraint->cdev->dev;
+	int ret;
 
-	return dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, true);
+	if (ret)
+		return ret;
+
+	constraint_add_debugfs(constraint, "domain");
+
+	return 0;
 }
 
 void constraint_pm_remove(struct constraint *constraint)
 {
-	/* Nothing to do for now */
+	constraint_remove_debugfs(constraint);
 }
diff --git a/drivers/boot_constraint/supply.c b/drivers/boot_constraint/supply.c
index 916e5d6848d5..28fda60a0711 100644
--- a/drivers/boot_constraint/supply.c
+++ b/drivers/boot_constraint/supply.c
@@ -57,6 +57,14 @@ int constraint_supply_add(struct constraint *constraint, void *data)
 	csupply->supply.name = kstrdup_const(supply->name, GFP_KERNEL);
 	constraint->private = csupply;
 
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
@@ -77,6 +85,7 @@ void constraint_supply_remove(struct constraint *constraint)
 	struct device *dev = constraint->cdev->dev;
 	int ret;
 
+	constraint_remove_debugfs(constraint);
 	kfree_const(supply->name);
 
 	ret = regulator_disable(csupply->reg);
-- 
2.15.0.194.g9af6a3dea062
