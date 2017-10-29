From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:18:52 +0530
Subject: [PATCH V4 04/12] boot_constraint: Add support for supply constraints
In-Reply-To: <cover.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <4e171b6a496a6f5645804d9ed9cb53b4bcbe75a0.1509284255.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the first constraint type: power-supply.

The constraint is set by enabling the regulator and setting a voltage
range (if required) for the respective regulator device, which will be
honored by the regulator core even if more users turn up. Once the
device is probed, the regulator is released and the constraint is
removed.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/boot_constraints/Makefile |  2 +-
 drivers/boot_constraints/core.c   |  4 ++
 drivers/boot_constraints/core.h   |  3 ++
 drivers/boot_constraints/supply.c | 98 +++++++++++++++++++++++++++++++++++++++
 include/linux/boot_constraint.h   |  8 +++-
 5 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 drivers/boot_constraints/supply.c

diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
index 0f2680177974..a45616f0c3b0 100644
--- a/drivers/boot_constraints/Makefile
+++ b/drivers/boot_constraints/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := core.o
+obj-y := core.o supply.o
diff --git a/drivers/boot_constraints/core.c b/drivers/boot_constraints/core.c
index 366a05d6d9ba..b9c024a3bdf5 100644
--- a/drivers/boot_constraints/core.c
+++ b/drivers/boot_constraints/core.c
@@ -94,6 +94,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
 	void (*remove)(struct constraint *constraint);
 
 	switch (type) {
+	case DEV_BOOT_CONSTRAINT_SUPPLY:
+		add = constraint_supply_add;
+		remove = constraint_supply_remove;
+		break;
 	default:
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/boot_constraints/core.h b/drivers/boot_constraints/core.h
index 7ba4ac172c09..73b9d2d22a12 100644
--- a/drivers/boot_constraints/core.h
+++ b/drivers/boot_constraints/core.h
@@ -30,4 +30,7 @@ struct constraint {
 };
 
 /* Forward declarations of constraint specific callbacks */
+int constraint_supply_add(struct constraint *constraint, void *data);
+void constraint_supply_remove(struct constraint *constraint);
+
 #endif /* _CORE_H */
diff --git a/drivers/boot_constraints/supply.c b/drivers/boot_constraints/supply.c
new file mode 100644
index 000000000000..30f816dbf12c
--- /dev/null
+++ b/drivers/boot_constraints/supply.c
@@ -0,0 +1,98 @@
+/*
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#define pr_fmt(fmt) "Supply Boot Constraints: " fmt
+
+#include <linux/err.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include "core.h"
+
+struct constraint_supply {
+	struct dev_boot_constraint_supply_info supply;
+	struct regulator *reg;
+};
+
+int constraint_supply_add(struct constraint *constraint, void *data)
+{
+	struct dev_boot_constraint_supply_info *supply = data;
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
+	if (supply->u_volt_min != 0 && supply->u_volt_max != 0) {
+		ret = regulator_set_voltage(csupply->reg, supply->u_volt_min,
+					    supply->u_volt_max);
+		if (ret) {
+			dev_err(dev, "regulator_set_voltage %s failed (%d)\n",
+				supply->name, ret);
+			goto free_regulator;
+		}
+	}
+
+	ret = regulator_enable(csupply->reg);
+	if (ret) {
+		dev_err(dev, "regulator_enable %s failed (%d)\n",
+			supply->name, ret);
+		goto remove_voltage;
+	}
+
+	memcpy(&csupply->supply, supply, sizeof(*supply));
+	csupply->supply.name = kstrdup_const(supply->name, GFP_KERNEL);
+	constraint->private = csupply;
+
+	return 0;
+
+remove_voltage:
+	if (supply->u_volt_min != 0 && supply->u_volt_max != 0)
+		regulator_set_voltage(csupply->reg, 0, INT_MAX);
+free_regulator:
+	regulator_put(csupply->reg);
+free:
+	kfree(csupply);
+
+	return ret;
+}
+
+void constraint_supply_remove(struct constraint *constraint)
+{
+	struct constraint_supply *csupply = constraint->private;
+	struct dev_boot_constraint_supply_info *supply = &csupply->supply;
+	struct device *dev = constraint->cdev->dev;
+	int ret;
+
+	kfree_const(supply->name);
+
+	ret = regulator_disable(csupply->reg);
+	if (ret)
+		dev_err(dev, "regulator_disable failed (%d)\n", ret);
+
+	if (supply->u_volt_min != 0 && supply->u_volt_max != 0) {
+		ret = regulator_set_voltage(csupply->reg, 0, INT_MAX);
+		if (ret)
+			dev_err(dev, "regulator_set_voltage failed (%d)\n",
+				ret);
+	}
+
+	regulator_put(csupply->reg);
+	kfree(csupply);
+}
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index 2b816bf74144..fc8ec0ee82f3 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -15,7 +15,13 @@
 struct device;
 
 enum dev_boot_constraint_type {
-	DEV_BOOT_CONSTRAINT_NONE,
+	DEV_BOOT_CONSTRAINT_SUPPLY,
+};
+
+struct dev_boot_constraint_supply_info {
+	const char *name;
+	unsigned int u_volt_min;
+	unsigned int u_volt_max;
 };
 
 struct dev_boot_constraint {
-- 
2.15.0.rc1.236.g92ea95045093
