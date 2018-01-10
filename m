From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 10 Jan 2018 09:17:34 +0530
Subject: [PATCH V6 05/13] boot_constraint: Add support for clk constraints
In-Reply-To: <cover.1515554879.git.viresh.kumar@linaro.org>
References: <cover.1515554879.git.viresh.kumar@linaro.org>
Message-ID: <282c37b14c0f6102b6748e26314455c64d5fe46b.1515554879.git.viresh.kumar@linaro.org>
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
 drivers/boot_constraint/Makefile |  2 +-
 drivers/boot_constraint/clk.c    | 67 ++++++++++++++++++++++++++++++++++++++++
 drivers/boot_constraint/core.c   |  4 +++
 drivers/boot_constraint/core.h   |  3 ++
 include/linux/boot_constraint.h  | 11 +++++++
 5 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/boot_constraint/clk.c

diff --git a/drivers/boot_constraint/Makefile b/drivers/boot_constraint/Makefile
index a45616f0c3b0..3424379fd1e4 100644
--- a/drivers/boot_constraint/Makefile
+++ b/drivers/boot_constraint/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := core.o supply.o
+obj-y := clk.o core.o supply.o
diff --git a/drivers/boot_constraint/clk.c b/drivers/boot_constraint/clk.c
new file mode 100644
index 000000000000..db22acff43e6
--- /dev/null
+++ b/drivers/boot_constraint/clk.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
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
diff --git a/drivers/boot_constraint/core.c b/drivers/boot_constraint/core.c
index 63a4b1a2fa2c..df9e0bddbfbe 100644
--- a/drivers/boot_constraint/core.c
+++ b/drivers/boot_constraint/core.c
@@ -91,6 +91,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
 	void (*remove)(struct constraint *constraint);
 
 	switch (type) {
+	case DEV_BOOT_CONSTRAINT_CLK:
+		add = constraint_clk_add;
+		remove = constraint_clk_remove;
+		break;
 	case DEV_BOOT_CONSTRAINT_SUPPLY:
 		add = constraint_supply_add;
 		remove = constraint_supply_remove;
diff --git a/drivers/boot_constraint/core.h b/drivers/boot_constraint/core.h
index d0d3e7bf7d57..720bda0a0f44 100644
--- a/drivers/boot_constraint/core.h
+++ b/drivers/boot_constraint/core.h
@@ -29,6 +29,9 @@ struct constraint {
 };
 
 /* Forward declarations of constraint specific callbacks */
+int constraint_clk_add(struct constraint *constraint, void *data);
+void constraint_clk_remove(struct constraint *constraint);
+
 int constraint_supply_add(struct constraint *constraint, void *data);
 void constraint_supply_remove(struct constraint *constraint);
 
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index 1db24d53b622..d798355fd93f 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -16,12 +16,23 @@ struct device;
 /**
  * enum dev_boot_constraint_type - This defines different boot constraint types.
  *
+ * @DEV_BOOT_CONSTRAINT_CLK: This represents a clock boot constraint.
  * @DEV_BOOT_CONSTRAINT_SUPPLY: This represents a power supply boot constraint.
  */
 enum dev_boot_constraint_type {
+	DEV_BOOT_CONSTRAINT_CLK,
 	DEV_BOOT_CONSTRAINT_SUPPLY,
 };
 
+/**
+ * struct dev_boot_constraint_clk_info - Clock boot constraint information.
+ *
+ * @name: This must match the connection-id of the clock for the device.
+ */
+struct dev_boot_constraint_clk_info {
+	const char *name;
+};
+
 /**
  * struct dev_boot_constraint_supply_info - Power supply boot constraint
  * information.
-- 
2.15.0.194.g9af6a3dea062
