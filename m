From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Mar 2014 14:07:03 +0100
Subject: [PATCH 07/10] ARM: mvebu: add SMP support for Armada 375 and Armada
 38x
In-Reply-To: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396012026-5997-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This commit adds the SMP support for Armada 375 and Armada 38x. It
turns out that the SMP logic for both of these SOCs are fairly
similar, the only differences being:

 * A different method to set the secondary CPU boot address

 * An Armada 375 specific workaround needed for the early Z1 stepping,
   added by the following patch.

Other than that, the patch is fairly straightforward and adds the
usual platsmp and headsmp code, defining the smp_operations structure
that is referenced from the DT_MACHINE structures.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig      |  4 +++
 arch/arm/mach-mvebu/Makefile     |  2 +-
 arch/arm/mach-mvebu/board-v7.c   |  2 ++
 arch/arm/mach-mvebu/common.h     |  4 +++
 arch/arm/mach-mvebu/headsmp-a9.S | 22 ++++++++++++++
 arch/arm/mach-mvebu/platsmp-a9.c | 63 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-mvebu/headsmp-a9.S
 create mode 100644 arch/arm/mach-mvebu/platsmp-a9.c

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 8634222..e88d951 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -45,6 +45,8 @@ config MACH_ARMADA_375
 	select ARMADA_375_CLK
 	select CPU_V7
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select NEON
 	select PINCTRL_ARMADA_375
@@ -60,6 +62,8 @@ config MACH_ARMADA_38X
 	select ARMADA_38X_CLK
 	select CPU_V7
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select NEON
 	select PINCTRL_ARMADA_38X
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 0e0eab5..18d623f 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -6,5 +6,5 @@ AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 obj-y				 += system-controller.o mvebu-soc-id.o cpu-reset.o
 obj-$(CONFIG_MACH_MVEBU_V7)      += board-v7.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
-obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
+obj-$(CONFIG_SMP)                += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 6260cb8..9ded4b9 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -146,6 +146,7 @@ static const char * const armada_375_dt_compat[] = {
 };
 
 DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
+	.smp		= smp_ops(mvebu_cortex_a9_smp_ops),
 	.init_time	= mvebu_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_375_dt_compat,
@@ -158,6 +159,7 @@ static const char * const armada_38x_dt_compat[] = {
 };
 
 DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
+	.smp		= smp_ops(mvebu_cortex_a9_smp_ops),
 	.init_time	= mvebu_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_38x_dt_compat,
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index b67fb7a..c05de82 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -24,4 +24,8 @@ void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
 
 void armada_xp_cpu_die(unsigned int cpu);
 
+#ifdef CONFIG_SMP
+extern struct smp_operations mvebu_cortex_a9_smp_ops;
+#endif
+
 #endif
diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
new file mode 100644
index 0000000..78e66c9
--- /dev/null
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -0,0 +1,22 @@
+/*
+ * SMP support: Entry point for secondary CPUs of Marvell EBU
+ * Cortex-A9 based SOCs (Armada 375 and Armada 38x).
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__CPUINIT
+ENTRY(mvebu_cortex_a9_secondary_startup)
+	bl      v7_invalidate_l1
+	b	secondary_startup
+ENDPROC(mvebu_cortex_a9_secondary_startup)
diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
new file mode 100644
index 0000000..f29eb95
--- /dev/null
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -0,0 +1,63 @@
+/*
+ * Symmetric Multi Processing (SMP) support for Marvell EBU Cortex-A9
+ * based SOCs (Armada 375/38x).
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+#include <asm/smp_scu.h>
+#include <asm/smp_plat.h>
+#include "common.h"
+#include "pmsu.h"
+
+extern void mvebu_cortex_a9_secondary_startup(void);
+
+static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
+						    struct task_struct *idle)
+{
+	int ret, hw_cpu;
+
+	pr_info("Booting CPU %d\n", cpu);
+
+	/*
+	 * Write the address of secondary startup into the system-wide
+	 * flags register. The boot monitor waits until it receives a
+	 * soft interrupt, and then the secondary CPU branches to this
+	 * address.
+	 */
+	hw_cpu = cpu_logical_map(cpu);
+
+	if (of_machine_is_compatible("marvell,armada375"))
+		mvebu_system_controller_set_cpu_boot_addr(mvebu_cortex_a9_secondary_startup);
+	else
+		mvebu_pmsu_set_cpu_boot_addr(hw_cpu,
+					     mvebu_cortex_a9_secondary_startup);
+
+	smp_wmb();
+	ret = mvebu_cpu_reset_deassert(hw_cpu);
+	if (ret) {
+		pr_err("Could not start the secondary CPU: %d\n", ret);
+		return ret;
+	}
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	return 0;
+}
+
+struct smp_operations mvebu_cortex_a9_smp_ops __initdata = {
+	.smp_boot_secondary	= mvebu_cortex_a9_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= armada_xp_cpu_die,
+#endif
+};
-- 
1.8.3.2
