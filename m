From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 20:12:52 +0100
Subject: [PATCH v2 07/12] ARM: SAMSUNG: Move common save/restore helpers to
 separate file
In-Reply-To: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391713977-22300-8-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To separate legacy PM code from generic helpers, this patch moves the
generic register save/restore helpers to a new file called pm-common.c
that is compiled always when CONFIG_PM_SLEEP is enabled, to allow
platforms that do not want to use the legacy PM code use the generic
helpers.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/Makefile                 |  1 +
 arch/arm/plat-samsung/include/plat/pm-common.h | 26 +++++++++
 arch/arm/plat-samsung/include/plat/pm.h        | 25 ---------
 arch/arm/plat-samsung/pm-common.c              | 75 ++++++++++++++++++++++++++
 arch/arm/plat-samsung/pm.c                     | 56 -------------------
 5 files changed, 102 insertions(+), 81 deletions(-)
 create mode 100644 arch/arm/plat-samsung/pm-common.c

diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index ba30a16..25c826e 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_SAMSUNG_DMADEV)	+= dma-ops.o
 
 # PM support
 
+obj-$(CONFIG_PM_SLEEP)		+= pm-common.o
 obj-$(CONFIG_SAMSUNG_PM)	+= pm.o
 obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
diff --git a/arch/arm/plat-samsung/include/plat/pm-common.h b/arch/arm/plat-samsung/include/plat/pm-common.h
index f72974a..741723e 100644
--- a/arch/arm/plat-samsung/include/plat/pm-common.h
+++ b/arch/arm/plat-samsung/include/plat/pm-common.h
@@ -13,6 +13,32 @@
 #ifndef __PLAT_SAMSUNG_PM_COMMON_H
 #define __PLAT_SAMSUNG_PM_COMMON_H __FILE__
 
+#include <linux/irq.h>
+
+/* sleep save info */
+
+/**
+ * struct sleep_save - save information for shared peripherals.
+ * @reg: Pointer to the register to save.
+ * @val: Holder for the value saved from reg.
+ *
+ * This describes a list of registers which is used by the pm core and
+ * other subsystem to save and restore register values over suspend.
+ */
+struct sleep_save {
+	void __iomem	*reg;
+	unsigned long	val;
+};
+
+#define SAVE_ITEM(x) \
+	{ .reg = (x) }
+
+/* helper functions to save/restore lists of registers. */
+
+extern void s3c_pm_do_save(struct sleep_save *ptr, int count);
+extern void s3c_pm_do_restore(const struct sleep_save *ptr, int count);
+extern void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count);
+
 /* PM debug functions */
 
 /**
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 2e04396..4099e8d 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -15,7 +15,6 @@
  * management
 */
 
-#include <linux/irq.h>
 #include <plat/pm-common.h>
 
 struct device;
@@ -59,30 +58,6 @@ extern unsigned long s3c_pm_flags;
 
 extern int s3c2410_cpu_suspend(unsigned long);
 
-/* sleep save info */
-
-/**
- * struct sleep_save - save information for shared peripherals.
- * @reg: Pointer to the register to save.
- * @val: Holder for the value saved from reg.
- *
- * This describes a list of registers which is used by the pm core and
- * other subsystem to save and restore register values over suspend.
- */
-struct sleep_save {
-	void __iomem	*reg;
-	unsigned long	val;
-};
-
-#define SAVE_ITEM(x) \
-	{ .reg = (x) }
-
-/* helper functions to save/restore lists of registers. */
-
-extern void s3c_pm_do_save(struct sleep_save *ptr, int count);
-extern void s3c_pm_do_restore(const struct sleep_save *ptr, int count);
-extern void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count);
-
 #ifdef CONFIG_SAMSUNG_PM
 extern int s3c_irq_wake(struct irq_data *data, unsigned int state);
 extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
diff --git a/arch/arm/plat-samsung/pm-common.c b/arch/arm/plat-samsung/pm-common.c
new file mode 100644
index 0000000..515cd53
--- /dev/null
+++ b/arch/arm/plat-samsung/pm-common.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *	Tomasz Figa <t.figa@samsung.com>
+ * Copyright (C) 2008 Openmoko, Inc.
+ * Copyright (C) 2004-2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * Samsung common power management helper functions.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+#include <plat/pm-common.h>
+
+/* helper functions to save and restore register state */
+
+/**
+ * s3c_pm_do_save() - save a set of registers for restoration on resume.
+ * @ptr: Pointer to an array of registers.
+ * @count: Size of the ptr array.
+ *
+ * Run through the list of registers given, saving their contents in the
+ * array for later restoration when we wakeup.
+ */
+void s3c_pm_do_save(struct sleep_save *ptr, int count)
+{
+	for (; count > 0; count--, ptr++) {
+		ptr->val = __raw_readl(ptr->reg);
+		S3C_PMDBG("saved %p value %08lx\n", ptr->reg, ptr->val);
+	}
+}
+
+/**
+ * s3c_pm_do_restore() - restore register values from the save list.
+ * @ptr: Pointer to an array of registers.
+ * @count: Size of the ptr array.
+ *
+ * Restore the register values saved from s3c_pm_do_save().
+ *
+ * Note, we do not use S3C_PMDBG() in here, as the system may not have
+ * restore the UARTs state yet
+*/
+
+void s3c_pm_do_restore(const struct sleep_save *ptr, int count)
+{
+	for (; count > 0; count--, ptr++) {
+		pr_debug("restore %p (restore %08lx, was %08x)\n",
+				ptr->reg, ptr->val, __raw_readl(ptr->reg));
+
+		__raw_writel(ptr->val, ptr->reg);
+	}
+}
+
+/**
+ * s3c_pm_do_restore_core() - early restore register values from save list.
+ *
+ * This is similar to s3c_pm_do_restore() except we try and minimise the
+ * side effects of the function in case registers that hardware might need
+ * to work has been restored.
+ *
+ * WARNING: Do not put any debug in here that may effect memory or use
+ * peripherals, as things may be changing!
+*/
+
+void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count)
+{
+	for (; count > 0; count--, ptr++)
+		__raw_writel(ptr->val, ptr->reg);
+}
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index a655192..0e7ac5f 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -65,62 +65,6 @@ int s3c_irqext_wake(struct irq_data *data, unsigned int state)
 	return 0;
 }
 
-/* helper functions to save and restore register state */
-
-/**
- * s3c_pm_do_save() - save a set of registers for restoration on resume.
- * @ptr: Pointer to an array of registers.
- * @count: Size of the ptr array.
- *
- * Run through the list of registers given, saving their contents in the
- * array for later restoration when we wakeup.
- */
-void s3c_pm_do_save(struct sleep_save *ptr, int count)
-{
-	for (; count > 0; count--, ptr++) {
-		ptr->val = __raw_readl(ptr->reg);
-		S3C_PMDBG("saved %p value %08lx\n", ptr->reg, ptr->val);
-	}
-}
-
-/**
- * s3c_pm_do_restore() - restore register values from the save list.
- * @ptr: Pointer to an array of registers.
- * @count: Size of the ptr array.
- *
- * Restore the register values saved from s3c_pm_do_save().
- *
- * Note, we do not use S3C_PMDBG() in here, as the system may not have
- * restore the UARTs state yet
-*/
-
-void s3c_pm_do_restore(const struct sleep_save *ptr, int count)
-{
-	for (; count > 0; count--, ptr++) {
-		printk(KERN_DEBUG "restore %p (restore %08lx, was %08x)\n",
-		       ptr->reg, ptr->val, __raw_readl(ptr->reg));
-
-		__raw_writel(ptr->val, ptr->reg);
-	}
-}
-
-/**
- * s3c_pm_do_restore_core() - early restore register values from save list.
- *
- * This is similar to s3c_pm_do_restore() except we try and minimise the
- * side effects of the function in case registers that hardware might need
- * to work has been restored.
- *
- * WARNING: Do not put any debug in here that may effect memory or use
- * peripherals, as things may be changing!
-*/
-
-void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count)
-{
-	for (; count > 0; count--, ptr++)
-		__raw_writel(ptr->val, ptr->reg);
-}
-
 /* s3c2410_pm_show_resume_irqs
  *
  * print any IRQs asserted at resume time (ie, we woke from)
-- 
1.8.5.2
