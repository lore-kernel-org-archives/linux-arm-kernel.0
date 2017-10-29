From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:18:55 +0530
Subject: [PATCH V4 07/12] boot_constraint: Add debugfs support
In-Reply-To: <cover.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <a796de9a338d7d0876faa3ec99f5cb49315c893c.1509284255.git.viresh.kumar@linaro.org>
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
 drivers/boot_constraints/clk.c    |  3 ++
 drivers/boot_constraints/core.c   | 60 +++++++++++++++++++++++++++++++++++++++
 drivers/boot_constraints/core.h   |  6 ++++
 drivers/boot_constraints/pm.c     | 11 +++++--
 drivers/boot_constraints/supply.c |  9 ++++++
 5 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/boot_constraints/clk.c b/drivers/boot_constraints/clk.c
index b5b1d63c3e76..91b7b538ef32 100644
--- a/drivers/boot_constraints/clk.c
+++ b/drivers/boot_constraints/clk.c
@@ -49,6 +49,8 @@ int constraint_clk_add(struct constraint *constraint, void *data)
 	cclk->clk_info.name = kstrdup_const(clk_info->name, GFP_KERNEL);
 	constraint->private = cclk;
 
+	constraint_add_debugfs(constraint, clk_info->name);
+
 	return 0;
 
 put_clk:
@@ -63,6 +65,7 @@ void constraint_clk_remove(struct constraint *constraint)
 {
 	struct constraint_clk *cclk = constraint->private;
 
+	constraint_remove_debugfs(constraint);
 	kfree_const(cclk->clk_info.name);
 	clk_disable_unprepare(cclk->clk);
 	clk_put(cclk->clk);
diff --git a/drivers/boot_constraints/core.c b/drivers/boot_constraints/core.c
index f4d3520ddb04..707ffac690fc 100644
--- a/drivers/boot_constraints/core.c
+++ b/drivers/boot_constraints/core.c
@@ -24,6 +24,64 @@
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
+	/* Create /sys/kernel/debug/opp directory */
+	rootdir = debugfs_create_dir("boot_constraints", NULL);
+
+	return 0;
+}
+core_initcall(constraint_debugfs_init);
+
+
 /* Boot constraints core */
 
 static struct constraint_dev *constraint_device_find(struct device *dev)
@@ -51,12 +109,14 @@ static struct constraint_dev *constraint_device_allocate(struct device *dev)
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
diff --git a/drivers/boot_constraints/core.h b/drivers/boot_constraints/core.h
index a051c3d7c8ab..ee84e237c66a 100644
--- a/drivers/boot_constraints/core.h
+++ b/drivers/boot_constraints/core.h
@@ -8,6 +8,7 @@
 #define _CORE_H
 
 #include <linux/boot_constraint.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/list.h>
 
@@ -15,6 +16,7 @@ struct constraint_dev {
 	struct device *dev;
 	struct list_head node;
 	struct list_head constraints;
+	struct dentry *dentry;
 };
 
 struct constraint {
@@ -23,12 +25,16 @@ struct constraint {
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
diff --git a/drivers/boot_constraints/pm.c b/drivers/boot_constraints/pm.c
index edba5eca5093..d74b776cdced 100644
--- a/drivers/boot_constraints/pm.c
+++ b/drivers/boot_constraints/pm.c
@@ -14,11 +14,18 @@
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
diff --git a/drivers/boot_constraints/supply.c b/drivers/boot_constraints/supply.c
index 30f816dbf12c..3d658410a082 100644
--- a/drivers/boot_constraints/supply.c
+++ b/drivers/boot_constraints/supply.c
@@ -60,6 +60,14 @@ int constraint_supply_add(struct constraint *constraint, void *data)
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
@@ -80,6 +88,7 @@ void constraint_supply_remove(struct constraint *constraint)
 	struct device *dev = constraint->cdev->dev;
 	int ret;
 
+	constraint_remove_debugfs(constraint);
 	kfree_const(supply->name);
 
 	ret = regulator_disable(csupply->reg);
-- 
2.15.0.rc1.236.g92ea95045093
