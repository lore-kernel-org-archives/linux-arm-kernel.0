From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue,  1 Aug 2017 14:53:45 +0530
Subject: [PATCH V3 4/8] drivers: boot_constraint: Add support for clk
 constraints
In-Reply-To: <cover.1501578037.git.viresh.kumar@linaro.org>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
Message-ID: <fd860b30ea36958c1faea938e2182f4ed1bbde91.1501578037.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the clk constraint type.

The constraint is set by enabling the clk for the device. Once the
device is probed, the clk is disabled and the constraint is removed.

We may want to do clk_set_rate() from here, but lets wait for some real
users that really want it.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/boot_constraints/Makefile |  2 +-
 drivers/base/boot_constraints/clk.c    | 70 ++++++++++++++++++++++++++++++++++
 drivers/base/boot_constraints/core.c   |  4 ++
 drivers/base/boot_constraints/core.h   |  3 ++
 include/linux/boot_constraint.h        |  5 +++
 5 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/boot_constraints/clk.c

diff --git a/drivers/base/boot_constraints/Makefile b/drivers/base/boot_constraints/Makefile
index a45616f0c3b0..3424379fd1e4 100644
--- a/drivers/base/boot_constraints/Makefile
+++ b/drivers/base/boot_constraints/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := core.o supply.o
+obj-y := clk.o core.o supply.o
diff --git a/drivers/base/boot_constraints/clk.c b/drivers/base/boot_constraints/clk.c
new file mode 100644
index 000000000000..b5b1d63c3e76
--- /dev/null
+++ b/drivers/base/boot_constraints/clk.c
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#define pr_fmt(fmt) "Clock Boot Constraints: " fmt
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include "core.h"
+
+struct constraint_clk {
+	struct dev_boot_constraint_clk_info clk_info;
+	struct clk *clk;
+};
+
+int constraint_clk_add(struct constraint *constraint, void *data)
+{
+	struct dev_boot_constraint_clk_info *clk_info = data;
+	struct constraint_clk *cclk;
+	struct device *dev = constraint->cdev->dev;
+	int ret;
+
+	cclk = kzalloc(sizeof(*cclk), GFP_KERNEL);
+	if (!cclk)
+		return -ENOMEM;
+
+	cclk->clk = clk_get(dev, clk_info->name);
+	if (IS_ERR(cclk->clk)) {
+		ret = PTR_ERR(cclk->clk);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "clk_get() failed for %s (%d)\n",
+				clk_info->name, ret);
+		}
+		goto free;
+	}
+
+	ret = clk_prepare_enable(cclk->clk);
+	if (ret) {
+		dev_err(dev, "clk_prepare_enable() %s failed (%d)\n",
+			clk_info->name, ret);
+		goto put_clk;
+	}
+
+	cclk->clk_info.name = kstrdup_const(clk_info->name, GFP_KERNEL);
+	constraint->private = cclk;
+
+	return 0;
+
+put_clk:
+	clk_put(cclk->clk);
+free:
+	kfree(cclk);
+
+	return ret;
+}
+
+void constraint_clk_remove(struct constraint *constraint)
+{
+	struct constraint_clk *cclk = constraint->private;
+
+	kfree_const(cclk->clk_info.name);
+	clk_disable_unprepare(cclk->clk);
+	clk_put(cclk->clk);
+	kfree(cclk);
+}
diff --git a/drivers/base/boot_constraints/core.c b/drivers/base/boot_constraints/core.c
index 06b618a85c0a..88568ed1bfad 100644
--- a/drivers/base/boot_constraints/core.c
+++ b/drivers/base/boot_constraints/core.c
@@ -105,6 +105,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
 	void (*remove)(struct constraint *constraint);
 
 	switch (type) {
+	case DEV_BOOT_CONSTRAINT_CLK:
+		add = constraint_clk_add;
+		remove = constraint_clk_remove;
+		break;
 	case DEV_BOOT_CONSTRAINT_SUPPLY:
 		add = constraint_supply_add;
 		remove = constraint_supply_remove;
diff --git a/drivers/base/boot_constraints/core.h b/drivers/base/boot_constraints/core.h
index 73b9d2d22a12..4f28ac2ef691 100644
--- a/drivers/base/boot_constraints/core.h
+++ b/drivers/base/boot_constraints/core.h
@@ -30,6 +30,9 @@ struct constraint {
 };
 
 /* Forward declarations of constraint specific callbacks */
+int constraint_clk_add(struct constraint *constraint, void *data);
+void constraint_clk_remove(struct constraint *constraint);
+
 int constraint_supply_add(struct constraint *constraint, void *data);
 void constraint_supply_remove(struct constraint *constraint);
 
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index d19b8ec2f10d..a2696002e6e1 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -15,9 +15,14 @@
 struct device;
 
 enum dev_boot_constraint_type {
+	DEV_BOOT_CONSTRAINT_CLK,
 	DEV_BOOT_CONSTRAINT_SUPPLY,
 };
 
+struct dev_boot_constraint_clk_info {
+	const char *name;
+};
+
 struct dev_boot_constraint_supply_info {
 	const char *name;
 	unsigned int u_volt_min;
-- 
2.13.0.71.gd7076ec9c9cb
