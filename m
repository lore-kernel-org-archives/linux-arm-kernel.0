From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Dec 2012 16:35:41 +0000
Subject: [PATCH v2 6/6] ARM: mach-virt: add SMP support using PSCI
In-Reply-To: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
Message-ID: <1355762141-29616-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for SMP to mach-virt using the PSCI
infrastructure.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-virt/Kconfig   |  1 +
 arch/arm/mach-virt/Makefile  |  1 +
 arch/arm/mach-virt/platsmp.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-virt/virt.c    |  6 ++++
 4 files changed, 84 insertions(+)
 create mode 100644 arch/arm/mach-virt/platsmp.c

diff --git a/arch/arm/mach-virt/Kconfig b/arch/arm/mach-virt/Kconfig
index a568a2a..8958f0d 100644
--- a/arch/arm/mach-virt/Kconfig
+++ b/arch/arm/mach-virt/Kconfig
@@ -3,6 +3,7 @@ config ARCH_VIRT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select ARM_ARCH_TIMER
+	select ARM_PSCI
 	select HAVE_SMP
 	select CPU_V7
 	select SPARSE_IRQ
diff --git a/arch/arm/mach-virt/Makefile b/arch/arm/mach-virt/Makefile
index 7ddbfa6..042afc1 100644
--- a/arch/arm/mach-virt/Makefile
+++ b/arch/arm/mach-virt/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-y					:= virt.o
+obj-$(CONFIG_SMP)			+= platsmp.o
diff --git a/arch/arm/mach-virt/platsmp.c b/arch/arm/mach-virt/platsmp.c
new file mode 100644
index 0000000..930362b
--- /dev/null
+++ b/arch/arm/mach-virt/platsmp.c
@@ -0,0 +1,76 @@
+/*
+ * Dummy Virtual Machine - does what it says on the tin.
+ *
+ * Copyright (C) 2012 ARM Ltd
+ * Author: Will Deacon <will.deacon@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/of.h>
+
+#include <asm/psci.h>
+#include <asm/smp_plat.h>
+#include <asm/hardware/gic.h>
+
+extern void secondary_startup(void);
+
+/*
+ * Enumerate the possible CPU set from the device tree.
+ */
+static void __init virt_smp_init_cpus(void)
+{
+	struct device_node *dn = NULL;
+	int cpu = 0;
+
+	while ((dn = of_find_node_by_type(dn, "cpu"))) {
+		if (cpu < NR_CPUS)
+			set_cpu_possible(cpu, true);
+		cpu++;
+	}
+
+	/* sanity check */
+	if (cpu > NR_CPUS)
+		pr_warning("no. of cores (%d) greater than configured maximum "
+			   "of %d - clipping\n",
+			   cpu, NR_CPUS);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+static void __init virt_smp_prepare_cpus(unsigned int max_cpus)
+{
+}
+
+static int __cpuinit virt_boot_secondary(unsigned int cpu,
+					 struct task_struct *idle)
+{
+	if (psci_ops.cpu_on)
+		return psci_ops.cpu_on(cpu_logical_map(cpu),
+				       __pa(secondary_startup));
+	return -ENODEV;
+}
+
+static void __cpuinit virt_secondary_init(unsigned int cpu)
+{
+	gic_secondary_init(0);
+}
+
+struct smp_operations __initdata virt_smp_ops = {
+	.smp_init_cpus		= virt_smp_init_cpus,
+	.smp_prepare_cpus	= virt_smp_prepare_cpus,
+	.smp_secondary_init	= virt_secondary_init,
+	.smp_boot_secondary	= virt_boot_secondary,
+};
diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
index 174b9da..d764835 100644
--- a/arch/arm/mach-virt/virt.c
+++ b/arch/arm/mach-virt/virt.c
@@ -20,6 +20,7 @@
 
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/smp.h>
 
 #include <asm/arch_timer.h>
 #include <asm/hardware/gic.h>
@@ -56,10 +57,15 @@ static struct sys_timer virt_timer = {
 	.init = virt_timer_init,
 };
 
+#ifdef CONFIG_SMP
+extern struct smp_operations virt_smp_ops;
+#endif
+
 DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
 	.init_irq	= gic_init_irq,
 	.handle_irq     = gic_handle_irq,
 	.timer		= &virt_timer,
 	.init_machine	= virt_init,
+	.smp		= smp_ops(virt_smp_ops),
 	.dt_compat	= virt_dt_match,
 MACHINE_END
-- 
1.8.0
