From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 30 May 2014 22:18:17 +0200
Subject: [PATCH 4/5] ARM: mvebu: implement CPU hotplug support for Armada XP
In-Reply-To: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1401481098-23326-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit implements CPU hotplug support for the Marvell Armada XP
platform. The CPU hotplug stub functions from hotplug.c are moved into
platsmp.c, as it doesn't make much sense to have a separate file just
for these two functions.

In addition, this commit:

 * Implements the ->cpu_die() function of SMP operations by calling
   armada_370_xp_pmsu_idle_enter() to enter the deep idle state for
   CPUs going offline.

 * Implements a dummy ->cpu_kill() function, simply needed for the
   kernel to know we have CPU hotplug support.

 * The armada_xp_boot_secondary() function makes sure to wake up the
   CPU if waiting in deep idle state by sending an IPI. This is
   because armada_xp_boot_secondary() is now used in two different
   situations: for the initial boot of secondary CPUs (where CPU reset
   deassert is used to wake up CPUs) and for CPU hotplug (where an IPI
   is used to take CPU out of deep idle).

 * At boot time, we exit from the idle state in the
   ->smp_secondary_init() hook.

This commit has been tested using CPU hotplug through sysfs
(/sys/devices/system/cpu/cpuX/online) and using kexec.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Makefile  |  1 -
 arch/arm/mach-mvebu/common.h  |  2 --
 arch/arm/mach-mvebu/hotplug.c | 31 ----------------------------
 arch/arm/mach-mvebu/platsmp.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 34 deletions(-)
 delete mode 100644 arch/arm/mach-mvebu/hotplug.c

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 2ecb828..7075243 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -9,7 +9,6 @@ obj-y				 += system-controller.o mvebu-soc-id.o
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
 obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
-obj-$(CONFIG_HOTPLUG_CPU)	 += hotplug.o
 endif
 
 obj-$(CONFIG_MACH_DOVE)		 += dove.o
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index b67fb7a..0d05eaa 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -22,6 +22,4 @@ int mvebu_cpu_reset_deassert(int cpu);
 void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
 void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
 
-void armada_xp_cpu_die(unsigned int cpu);
-
 #endif
diff --git a/arch/arm/mach-mvebu/hotplug.c b/arch/arm/mach-mvebu/hotplug.c
deleted file mode 100644
index d95e910..0000000
--- a/arch/arm/mach-mvebu/hotplug.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Symmetric Multi Processing (SMP) support for Armada XP
- *
- * Copyright (C) 2012 Marvell
- *
- * Lior Amsalem <alior@marvell.com>
- * Gregory CLEMENT <gregory.clement@free-electrons.com>
- * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-#include <asm/proc-fns.h>
-#include "common.h"
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void __ref armada_xp_cpu_die(unsigned int cpu)
-{
-	cpu_do_idle();
-
-	/* We should never return from idle */
-	panic("mvebu: cpu %d unexpectedly exit from shutdown\n", cpu);
-}
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 88b976b3..b6fa9f0 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -78,6 +78,17 @@ static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 	hw_cpu = cpu_logical_map(cpu);
 	mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_xp_secondary_startup);
+
+	/*
+	 * This is needed to wake up CPUs in the offline state after
+	 * using CPU hotplug.
+	 */
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	/*
+	 * This is needed to take secondary CPUs out of reset on the
+	 * initial boot.
+	 */
 	ret = mvebu_cpu_reset_deassert(hw_cpu);
 	if (ret) {
 		pr_warn("unable to boot CPU: %d\n", ret);
@@ -87,6 +98,19 @@ static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+/*
+ * When a CPU is brought back online, either through CPU hotplug, or
+ * because of the boot of a kexec'ed kernel, the PMSU configuration
+ * for this CPU might be in the deep idle state, preventing this CPU
+ * from receiving interrupts. Here, we therefore take out the current
+ * CPU from this state, which was entered by armada_xp_cpu_die()
+ * below.
+ */
+static void armada_xp_secondary_init(unsigned int cpu)
+{
+	armada_370_xp_pmsu_idle_exit();
+}
+
 static void __init armada_xp_smp_init_cpus(void)
 {
 	unsigned int ncores = num_possible_cpus();
@@ -122,12 +146,36 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 		panic("The address for the BootROM is incorrect");
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void armada_xp_cpu_die(unsigned int cpu)
+{
+	/*
+	 * CPU hotplug is implemented by putting offline CPUs into the
+	 * deep idle sleep state.
+	 */
+	armada_370_xp_pmsu_idle_enter(true);
+}
+
+/*
+ * We need a dummy function, so that platform_can_cpu_hotplug() knows
+ * we support CPU hotplug. However, the function does not need to do
+ * anything, because CPUs going offline can enter the deep idle state
+ * by themselves, without any help from a still alive CPU.
+ */
+static int armada_xp_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
+#endif
+
 struct smp_operations armada_xp_smp_ops __initdata = {
 	.smp_init_cpus		= armada_xp_smp_init_cpus,
 	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
 	.smp_boot_secondary	= armada_xp_boot_secondary,
+	.smp_secondary_init     = armada_xp_secondary_init,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= armada_xp_cpu_die,
+	.cpu_kill               = armada_xp_cpu_kill,
 #endif
 };
 
-- 
1.9.3
