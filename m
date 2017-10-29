From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:18:57 +0530
Subject: [PATCH V4 09/12] boot_constraint: Add earlycon helper
In-Reply-To: <cover.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <f32e9a84a985e36cbff76df73faf0e3966d90ada.1509284255.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Getting boot messages during initial kernel boot is a common problem,
which (almost) everyone wants to solve. Considering that this would be
required by multiple platforms, provide a helper to check if "earlycon"
or "earlyprintk" boot arguments are passed to kernel or not. The
platforms can use this helper to add serial constraints only if earlycon
if required.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/boot_constraints/Makefile |  2 +-
 drivers/boot_constraints/serial.c | 28 ++++++++++++++++++++++++++++
 include/linux/boot_constraint.h   |  2 ++
 3 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 drivers/boot_constraints/serial.c

diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
index a765094623a3..0d4f88bb767c 100644
--- a/drivers/boot_constraints/Makefile
+++ b/drivers/boot_constraints/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := clk.o deferrable_dev.o core.o pm.o supply.o
+obj-y := clk.o deferrable_dev.o core.o pm.o serial.o supply.o
diff --git a/drivers/boot_constraints/serial.c b/drivers/boot_constraints/serial.c
new file mode 100644
index 000000000000..d0d07d4aa6af
--- /dev/null
+++ b/drivers/boot_constraints/serial.c
@@ -0,0 +1,28 @@
+/*
+ * This contains helpers related to serial boot constraints.
+ *
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/init.h>
+
+static bool earlycon_boot_constraints_enabled __initdata;
+
+bool __init boot_constraint_earlycon_enabled(void)
+{
+	return earlycon_boot_constraints_enabled;
+}
+
+static int __init enable_earlycon_boot_constraints(char *str)
+{
+	earlycon_boot_constraints_enabled = true;
+
+	return 0;
+}
+__setup_param("earlycon", boot_constraint_earlycon,
+	      enable_earlycon_boot_constraints, 0);
+__setup_param("earlyprintk", boot_constraint_earlyprintk,
+	      enable_earlycon_boot_constraints, 0);
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index c110b36e490f..aeada69b87e6 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -10,6 +10,7 @@
 #define _LINUX_BOOT_CONSTRAINT_H
 
 #include <linux/err.h>
+#include <linux/init.h>
 #include <linux/types.h>
 
 struct device;
@@ -58,6 +59,7 @@ int dev_boot_constraint_add(struct device *dev,
 void dev_boot_constraints_remove(struct device *dev);
 void dev_boot_constraint_add_deferrable_of(struct dev_boot_constraint_of *oconst,
 					   int count);
+bool __init boot_constraint_earlycon_enabled(void);
 #else
 static inline
 int dev_boot_constraint_add(struct device *dev,
-- 
2.15.0.rc1.236.g92ea95045093
