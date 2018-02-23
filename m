From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Feb 2018 15:53:45 +0530
Subject: [PATCH V7 06/13] boot_constraint: Add support for PM constraints
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Message-ID: <9802d5501b0f22cc14e2043797ab995f7640b3c0.1519380923.git.viresh.kumar@linaro.org>
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
 drivers/bootconstraint/Makefile |  2 +-
 drivers/bootconstraint/core.c   |  4 ++++
 drivers/bootconstraint/core.h   |  3 +++
 drivers/bootconstraint/pm.c     | 21 +++++++++++++++++++++
 include/linux/boot_constraint.h |  2 ++
 5 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bootconstraint/pm.c

diff --git a/drivers/bootconstraint/Makefile b/drivers/bootconstraint/Makefile
index 3424379fd1e4..b7ade1a7afb5 100644
--- a/drivers/bootconstraint/Makefile
+++ b/drivers/bootconstraint/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := clk.o core.o supply.o
+obj-y := clk.o core.o pm.o supply.o
diff --git a/drivers/bootconstraint/core.c b/drivers/bootconstraint/core.c
index a73744c5d599..a6148b625b48 100644
--- a/drivers/bootconstraint/core.c
+++ b/drivers/bootconstraint/core.c
@@ -95,6 +95,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
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
diff --git a/drivers/bootconstraint/core.h b/drivers/bootconstraint/core.h
index 09a6176541d7..35ea984d74f0 100644
--- a/drivers/bootconstraint/core.h
+++ b/drivers/bootconstraint/core.h
@@ -32,6 +32,9 @@ struct constraint {
 int constraint_clk_add(struct constraint *constraint, void *data);
 void constraint_clk_remove(struct constraint *constraint);
 
+int constraint_pm_add(struct constraint *constraint, void *data);
+void constraint_pm_remove(struct constraint *constraint);
+
 int constraint_supply_add(struct constraint *constraint, void *data);
 void constraint_supply_remove(struct constraint *constraint);
 
diff --git a/drivers/bootconstraint/pm.c b/drivers/bootconstraint/pm.c
new file mode 100644
index 000000000000..f52bff240dd5
--- /dev/null
+++ b/drivers/bootconstraint/pm.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
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
index 4685ff55fff8..fbccb62f423d 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -17,10 +17,12 @@ struct device;
  * enum dev_boot_constraint_type - This defines different boot constraint types.
  *
  * @DEV_BOOT_CONSTRAINT_CLK: This represents a clock boot constraint.
+ * @DEV_BOOT_CONSTRAINT_PM: This represents a power domain boot constraint.
  * @DEV_BOOT_CONSTRAINT_SUPPLY: This represents a power supply boot constraint.
  */
 enum dev_boot_constraint_type {
 	DEV_BOOT_CONSTRAINT_CLK,
+	DEV_BOOT_CONSTRAINT_PM,
 	DEV_BOOT_CONSTRAINT_SUPPLY,
 };
 
-- 
2.15.0.194.g9af6a3dea062
