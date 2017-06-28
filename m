From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 28 Jun 2017 15:56:35 +0530
Subject: [RFC 2/5] drivers: boot_constraint: Add support for supply constraints
In-Reply-To: <cover.1498642745.git.viresh.kumar@linaro.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
Message-ID: <ed2625f0dcfa55d645732140d92a934a4d57a5ec.1498642745.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the first constraint type: power-supply.

The constraint is set by setting a voltage range for the respective
regulator device, which will be honored by the regulator core even if
more users turn up. Once the device is probed, the regulator is
released and the constraint is removed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/boot_constraint.c  | 92 +++++++++++++++++++++++++++++++++++++++++
 include/linux/boot_constraint.h |  9 +++-
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/base/boot_constraint.c b/drivers/base/boot_constraint.c
index 38740b8499ba..495344e6405b 100644
--- a/drivers/base/boot_constraint.c
+++ b/drivers/base/boot_constraint.c
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 struct constraint {
@@ -41,6 +42,8 @@ static LIST_HEAD(constraint_devices);
 static DEFINE_MUTEX(constraint_devices_mutex);
 
 /* Forward declarations of constraints */
+static int constraint_supply_add(struct constraint *constraint, void *data);
+static void constraint_supply_remove(struct constraint *constraint);
 
 
 /* Boot constraints core */
@@ -113,6 +116,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
 	void (*remove)(struct constraint *constraint);
 
 	switch (type) {
+	case BOOT_CONSTRAINT_SUPPLY:
+		add = constraint_supply_add;
+		remove = constraint_supply_remove;
+		break;
 	default:
 		return ERR_PTR(-EINVAL);
 	}
@@ -208,3 +215,88 @@ void boot_constraints_remove(struct device *dev)
 unlock:
 	mutex_unlock(&constraint_devices_mutex);
 }
+
+
+/* Boot constraints */
+
+/* Boot constraint - Supply */
+
+struct constraint_supply {
+	struct boot_constraint_supply_info supply;
+	struct regulator *reg;
+};
+
+static int constraint_supply_add(struct constraint *constraint, void *data)
+{
+	struct boot_constraint_supply_info *supply = data;
+	struct constraint_supply *csupply;
+	struct device *dev = constraint->cdev->dev;
+	int ret;
+
+	csupply = kzalloc(sizeof(*csupply), GFP_KERNEL);
+	if (!csupply)
+		return -ENOMEM;
+
+	csupply->reg = regulator_get(dev, supply->name);
+	if (IS_ERR(csupply->reg)) {
+		ret = PTR_ERR(csupply->reg);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "regulator_get() failed for %s (%d)\n",
+				supply->name, ret);
+		}
+		goto free;
+	}
+
+	ret = regulator_set_voltage(csupply->reg, supply->u_volt_min,
+				    supply->u_volt_max);
+	if (ret) {
+		dev_err(dev, "regulator_set_voltage %s failed (%d)\n",
+			supply->name, ret);
+		goto free_regulator;
+	}
+
+	if (supply->enable) {
+		ret = regulator_enable(csupply->reg);
+		if (ret) {
+			dev_err(dev, "regulator_enable %s failed (%d)\n",
+				supply->name, ret);
+			goto remove_voltage;
+		}
+	}
+
+	memcpy(&csupply->supply, supply, sizeof(*supply));
+	csupply->supply.name = kstrdup_const(supply->name, GFP_KERNEL);
+	constraint->private = csupply;
+
+	return 0;
+
+remove_voltage:
+	regulator_set_voltage(csupply->reg, 0, INT_MAX);
+free_regulator:
+	regulator_put(csupply->reg);
+free:
+	kfree(csupply);
+
+	return ret;
+}
+
+static void constraint_supply_remove(struct constraint *constraint)
+{
+	struct constraint_supply *csupply = constraint->private;
+	struct device *dev = constraint->cdev->dev;
+	int ret;
+
+	if (csupply->supply.enable) {
+		ret = regulator_disable(csupply->reg);
+		if (ret)
+			dev_err(dev, "regulator_disable failed (%d)\n", ret);
+	}
+
+	ret = regulator_set_voltage(csupply->reg, 0, INT_MAX);
+	if (ret)
+		dev_err(dev, "regulator_set_voltage failed (%d)\n", ret);
+
+	regulator_put(csupply->reg);
+	kfree_const(csupply->supply.name);
+	kfree(csupply);
+}
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index 41b5a62d2dbb..a98fdb403e8d 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -13,7 +13,14 @@
 struct device;
 
 enum boot_constraint_type {
-	BOOT_CONSTRAINT_NONE,
+	BOOT_CONSTRAINT_SUPPLY,
+};
+
+struct boot_constraint_supply_info {
+	bool enable;
+	const char *name;
+	unsigned long u_volt_min;
+	unsigned long u_volt_max;
 };
 
 #ifdef CONFIG_BOOT_CONSTRAINTS
-- 
2.13.0.71.gd7076ec9c9cb
