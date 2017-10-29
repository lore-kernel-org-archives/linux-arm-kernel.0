From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:18:54 +0530
Subject: [PATCH V4 06/12] boot_constraint: Add support for PM constraints
In-Reply-To: <cover.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <000268f9c5b06354333a18dbe26fc8b052231ed8.1509284255.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PM constraint type.

The constraint is set by attaching the power domain for the device,
which will also enable the power domain. This guarantees that the power
domain doesn't get shut down while being used.

We don't need to detach the power domain to remove the constraint as the
domain is attached only once, from here or before driver probe.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/boot_constraints/Makefile |  2 +-
 drivers/boot_constraints/core.c   |  4 ++++
 drivers/boot_constraints/core.h   |  3 +++
 drivers/boot_constraints/pm.c     | 24 ++++++++++++++++++++++++
 include/linux/boot_constraint.h   |  1 +
 5 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/boot_constraints/pm.c

diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
index 3424379fd1e4..b7ade1a7afb5 100644
--- a/drivers/boot_constraints/Makefile
+++ b/drivers/boot_constraints/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := clk.o core.o supply.o
+obj-y := clk.o core.o pm.o supply.o
diff --git a/drivers/boot_constraints/core.c b/drivers/boot_constraints/core.c
index 9213e56e8078..f4d3520ddb04 100644
--- a/drivers/boot_constraints/core.c
+++ b/drivers/boot_constraints/core.c
@@ -98,6 +98,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
 		add = constraint_clk_add;
 		remove = constraint_clk_remove;
 		break;
+	case DEV_BOOT_CONSTRAINT_PM:
+		add = constraint_pm_add;
+		remove = constraint_pm_remove;
+		break;
 	case DEV_BOOT_CONSTRAINT_SUPPLY:
 		add = constraint_supply_add;
 		remove = constraint_supply_remove;
diff --git a/drivers/boot_constraints/core.h b/drivers/boot_constraints/core.h
index 4f28ac2ef691..a051c3d7c8ab 100644
--- a/drivers/boot_constraints/core.h
+++ b/drivers/boot_constraints/core.h
@@ -33,6 +33,9 @@ struct constraint {
 int constraint_clk_add(struct constraint *constraint, void *data);
 void constraint_clk_remove(struct constraint *constraint);
 
+int constraint_pm_add(struct constraint *constraint, void *data);
+void constraint_pm_remove(struct constraint *constraint);
+
 int constraint_supply_add(struct constraint *constraint, void *data);
 void constraint_supply_remove(struct constraint *constraint);
 
diff --git a/drivers/boot_constraints/pm.c b/drivers/boot_constraints/pm.c
new file mode 100644
index 000000000000..edba5eca5093
--- /dev/null
+++ b/drivers/boot_constraints/pm.c
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#define pr_fmt(fmt) "PM Boot Constraints: " fmt
+
+#include <linux/pm_domain.h>
+
+#include "core.h"
+
+int constraint_pm_add(struct constraint *constraint, void *data)
+{
+	struct device *dev = constraint->cdev->dev;
+
+	return dev_pm_domain_attach(dev, true);
+}
+
+void constraint_pm_remove(struct constraint *constraint)
+{
+	/* Nothing to do for now */
+}
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index a74b261a4ee4..637fe9d65536 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -16,6 +16,7 @@ struct device;
 
 enum dev_boot_constraint_type {
 	DEV_BOOT_CONSTRAINT_CLK,
+	DEV_BOOT_CONSTRAINT_PM,
 	DEV_BOOT_CONSTRAINT_SUPPLY,
 };
 
-- 
2.15.0.rc1.236.g92ea95045093
