From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Oct 2013 19:24:01 +0100
Subject: [PATCHv4 1/6] arm64: unify smp_psci.c and psci.c
In-Reply-To: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
References: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1381515846-1684-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The functions in psci.c are only used from smp_psci.c, and smp_psci
cannot function without psci.c. Additionally psci.c is built when !SMP,
where it's expected that cpu_suspend may be useful.

This patch unifies the two files, removing pointless duplication and
paving the way for PSCI support in UP systems.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/psci.h | 19 ---------------
 arch/arm64/kernel/Makefile    |  2 +-
 arch/arm64/kernel/psci.c      | 54 ++++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/smp_psci.c  | 53 ------------------------------------------
 4 files changed, 54 insertions(+), 74 deletions(-)
 delete mode 100644 arch/arm64/kernel/smp_psci.c

diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
index 0604237..e5312ea 100644
--- a/arch/arm64/include/asm/psci.h
+++ b/arch/arm64/include/asm/psci.h
@@ -14,25 +14,6 @@
 #ifndef __ASM_PSCI_H
 #define __ASM_PSCI_H
 
-#define PSCI_POWER_STATE_TYPE_STANDBY		0
-#define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
-
-struct psci_power_state {
-	u16	id;
-	u8	type;
-	u8	affinity_level;
-};
-
-struct psci_operations {
-	int (*cpu_suspend)(struct psci_power_state state,
-			   unsigned long entry_point);
-	int (*cpu_off)(struct psci_power_state state);
-	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
-	int (*migrate)(unsigned long cpuid);
-};
-
-extern struct psci_operations psci_ops;
-
 int psci_init(void);
 
 #endif /* __ASM_PSCI_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7b4b564..75a90c1 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -14,7 +14,7 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
-arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o smp_psci.o
+arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 14f73c4..368b787 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -17,12 +17,31 @@
 
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/smp.h>
 
 #include <asm/compiler.h>
 #include <asm/errno.h>
 #include <asm/psci.h>
+#include <asm/smp_plat.h>
 
-struct psci_operations psci_ops;
+#define PSCI_POWER_STATE_TYPE_STANDBY		0
+#define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
+
+struct psci_power_state {
+	u16	id;
+	u8	type;
+	u8	affinity_level;
+};
+
+struct psci_operations {
+	int (*cpu_suspend)(struct psci_power_state state,
+			   unsigned long entry_point);
+	int (*cpu_off)(struct psci_power_state state);
+	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
+	int (*migrate)(unsigned long cpuid);
+};
+
+static struct psci_operations psci_ops;
 
 static int (*invoke_psci_fn)(u64, u64, u64, u64);
 
@@ -209,3 +228,36 @@ out_put_node:
 	of_node_put(np);
 	return err;
 }
+
+#ifdef CONFIG_SMP
+
+static int __init smp_psci_init_cpu(struct device_node *dn, int cpu)
+{
+	return 0;
+}
+
+static int __init smp_psci_prepare_cpu(int cpu)
+{
+	int err;
+
+	if (!psci_ops.cpu_on) {
+		pr_err("no cpu_on method, not booting CPU%d\n", cpu);
+		return -ENODEV;
+	}
+
+	err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa(secondary_holding_pen));
+	if (err) {
+		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
+		return err;
+	}
+
+	return 0;
+}
+
+const struct smp_enable_ops smp_psci_ops __initconst = {
+	.name		= "psci",
+	.init_cpu	= smp_psci_init_cpu,
+	.prepare_cpu	= smp_psci_prepare_cpu,
+};
+
+#endif
diff --git a/arch/arm64/kernel/smp_psci.c b/arch/arm64/kernel/smp_psci.c
deleted file mode 100644
index 0c53330..0000000
--- a/arch/arm64/kernel/smp_psci.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * PSCI SMP initialisation
- *
- * Copyright (C) 2013 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/init.h>
-#include <linux/of.h>
-#include <linux/smp.h>
-
-#include <asm/psci.h>
-#include <asm/smp_plat.h>
-
-static int __init smp_psci_init_cpu(struct device_node *dn, int cpu)
-{
-	return 0;
-}
-
-static int __init smp_psci_prepare_cpu(int cpu)
-{
-	int err;
-
-	if (!psci_ops.cpu_on) {
-		pr_err("psci: no cpu_on method, not booting CPU%d\n", cpu);
-		return -ENODEV;
-	}
-
-	err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa(secondary_holding_pen));
-	if (err) {
-		pr_err("psci: failed to boot CPU%d (%d)\n", cpu, err);
-		return err;
-	}
-
-	return 0;
-}
-
-const struct smp_enable_ops smp_psci_ops __initconst = {
-	.name		= "psci",
-	.init_cpu	= smp_psci_init_cpu,
-	.prepare_cpu	= smp_psci_prepare_cpu,
-};
-- 
1.8.1.1
