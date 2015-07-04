From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 4 Jul 2015 21:01:48 +0800
Subject: [RFC PATCH 1/3] arm: psci: rename psci_smp.c to psci.c
In-Reply-To: <1436014910-1201-1-git-send-email-jszhang@marvell.com>
References: <1436014910-1201-1-git-send-email-jszhang@marvell.com>
Message-ID: <1436014910-1201-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will prepare for next commit to enable PSCI for UP systems so that
calls like cpu_suspend can be made functional on UP too.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/Makefile   |   2 +-
 arch/arm/kernel/psci.c     | 130 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/psci_smp.c | 130 ---------------------------------------------
 3 files changed, 131 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm/kernel/psci.c
 delete mode 100644 arch/arm/kernel/psci_smp.c

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 3b995f5..c57b2c0 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -90,7 +90,7 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
 ifeq ($(CONFIG_ARM_PSCI),y)
 obj-y				+= psci-call.o
-obj-$(CONFIG_SMP)		+= psci_smp.o
+obj-$(CONFIG_SMP)		+= psci.o
 endif
 
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
new file mode 100644
index 0000000..61c04b0
--- /dev/null
+++ b/arch/arm/kernel/psci.c
@@ -0,0 +1,130 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/psci.h>
+
+#include <uapi/linux/psci.h>
+
+#include <asm/psci.h>
+#include <asm/smp_plat.h>
+
+/*
+ * psci_smp assumes that the following is true about PSCI:
+ *
+ * cpu_suspend   Suspend the execution on a CPU
+ * @state        we don't currently describe affinity levels, so just pass 0.
+ * @entry_point  the first instruction to be executed on return
+ * returns 0  success, < 0 on failure
+ *
+ * cpu_off       Power down a CPU
+ * @state        we don't currently describe affinity levels, so just pass 0.
+ * no return on successful call
+ *
+ * cpu_on        Power up a CPU
+ * @cpuid        cpuid of target CPU, as from MPIDR
+ * @entry_point  the first instruction to be executed on return
+ * returns 0  success, < 0 on failure
+ *
+ * migrate       Migrate the context to a different CPU
+ * @cpuid        cpuid of target CPU, as from MPIDR
+ * returns 0  success, < 0 on failure
+ *
+ */
+
+extern void secondary_startup(void);
+
+static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	if (psci_ops.cpu_on)
+		return psci_ops.cpu_on(cpu_logical_map(cpu),
+					virt_to_idmap(&secondary_startup));
+	return -ENODEV;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+int psci_cpu_disable(unsigned int cpu)
+{
+	/* Fail early if we don't have CPU_OFF support */
+	if (!psci_ops.cpu_off)
+		return -EOPNOTSUPP;
+
+	/* Trusted OS will deny CPU_OFF */
+	if (psci_tos_resident_on(cpu))
+		return -EPERM;
+
+	return 0;
+}
+
+void __ref psci_cpu_die(unsigned int cpu)
+{
+	u32 state = PSCI_POWER_STATE_TYPE_POWER_DOWN <<
+		    PSCI_0_2_POWER_STATE_TYPE_SHIFT;
+
+	if (psci_ops.cpu_off)
+		psci_ops.cpu_off(state);
+
+	/* We should never return */
+	panic("psci: cpu %d failed to shutdown\n", cpu);
+}
+
+int __ref psci_cpu_kill(unsigned int cpu)
+{
+	int err, i;
+
+	if (!psci_ops.affinity_info)
+		return 1;
+	/*
+	 * cpu_kill could race with cpu_die and we can
+	 * potentially end up declaring this cpu undead
+	 * while it is dying. So, try again a few times.
+	 */
+
+	for (i = 0; i < 10; i++) {
+		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
+		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
+			pr_info("CPU%d killed.\n", cpu);
+			return 1;
+		}
+
+		msleep(10);
+		pr_info("Retrying again to check for CPU kill\n");
+	}
+
+	pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
+			cpu, err);
+	/* Make platform_cpu_kill() fail. */
+	return 0;
+}
+
+#endif
+
+bool __init psci_smp_available(void)
+{
+	/* is cpu_on available at least? */
+	return (psci_ops.cpu_on != NULL);
+}
+
+struct smp_operations __initdata psci_smp_ops = {
+	.smp_boot_secondary	= psci_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= psci_cpu_disable,
+	.cpu_die		= psci_cpu_die,
+	.cpu_kill		= psci_cpu_kill,
+#endif
+};
diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
deleted file mode 100644
index 61c04b0..0000000
--- a/arch/arm/kernel/psci_smp.c
+++ /dev/null
@@ -1,130 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Copyright (C) 2012 ARM Limited
- *
- * Author: Will Deacon <will.deacon@arm.com>
- */
-
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/of.h>
-#include <linux/delay.h>
-#include <linux/psci.h>
-
-#include <uapi/linux/psci.h>
-
-#include <asm/psci.h>
-#include <asm/smp_plat.h>
-
-/*
- * psci_smp assumes that the following is true about PSCI:
- *
- * cpu_suspend   Suspend the execution on a CPU
- * @state        we don't currently describe affinity levels, so just pass 0.
- * @entry_point  the first instruction to be executed on return
- * returns 0  success, < 0 on failure
- *
- * cpu_off       Power down a CPU
- * @state        we don't currently describe affinity levels, so just pass 0.
- * no return on successful call
- *
- * cpu_on        Power up a CPU
- * @cpuid        cpuid of target CPU, as from MPIDR
- * @entry_point  the first instruction to be executed on return
- * returns 0  success, < 0 on failure
- *
- * migrate       Migrate the context to a different CPU
- * @cpuid        cpuid of target CPU, as from MPIDR
- * returns 0  success, < 0 on failure
- *
- */
-
-extern void secondary_startup(void);
-
-static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
-{
-	if (psci_ops.cpu_on)
-		return psci_ops.cpu_on(cpu_logical_map(cpu),
-					virt_to_idmap(&secondary_startup));
-	return -ENODEV;
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-int psci_cpu_disable(unsigned int cpu)
-{
-	/* Fail early if we don't have CPU_OFF support */
-	if (!psci_ops.cpu_off)
-		return -EOPNOTSUPP;
-
-	/* Trusted OS will deny CPU_OFF */
-	if (psci_tos_resident_on(cpu))
-		return -EPERM;
-
-	return 0;
-}
-
-void __ref psci_cpu_die(unsigned int cpu)
-{
-	u32 state = PSCI_POWER_STATE_TYPE_POWER_DOWN <<
-		    PSCI_0_2_POWER_STATE_TYPE_SHIFT;
-
-	if (psci_ops.cpu_off)
-		psci_ops.cpu_off(state);
-
-	/* We should never return */
-	panic("psci: cpu %d failed to shutdown\n", cpu);
-}
-
-int __ref psci_cpu_kill(unsigned int cpu)
-{
-	int err, i;
-
-	if (!psci_ops.affinity_info)
-		return 1;
-	/*
-	 * cpu_kill could race with cpu_die and we can
-	 * potentially end up declaring this cpu undead
-	 * while it is dying. So, try again a few times.
-	 */
-
-	for (i = 0; i < 10; i++) {
-		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
-		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
-			pr_info("CPU%d killed.\n", cpu);
-			return 1;
-		}
-
-		msleep(10);
-		pr_info("Retrying again to check for CPU kill\n");
-	}
-
-	pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
-			cpu, err);
-	/* Make platform_cpu_kill() fail. */
-	return 0;
-}
-
-#endif
-
-bool __init psci_smp_available(void)
-{
-	/* is cpu_on available@least? */
-	return (psci_ops.cpu_on != NULL);
-}
-
-struct smp_operations __initdata psci_smp_ops = {
-	.smp_boot_secondary	= psci_boot_secondary,
-#ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= psci_cpu_disable,
-	.cpu_die		= psci_cpu_die,
-	.cpu_kill		= psci_cpu_kill,
-#endif
-};
-- 
2.1.4
