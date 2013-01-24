From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Jan 2013 01:27:50 -0500
Subject: [PATCH v2 07/16] ARM: b.L: generic SMP secondary bringup and hotplug
 support
In-Reply-To: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359008879-9015-8-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the b.L power API is in place, we can use it for SMP secondary
bringup and CPU hotplug in a generic fashion.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/Makefile     |  2 +-
 arch/arm/common/bL_platsmp.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/common/bL_platsmp.c

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index aa797237a7..d1eaae8eb7 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -13,4 +13,4 @@ obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
-obj-$(CONFIG_BIG_LITTLE)	+= bL_head.o bL_entry.o vlock.o
+obj-$(CONFIG_BIG_LITTLE)	+= bL_head.o bL_entry.o bL_platsmp.o vlock.o
diff --git a/arch/arm/common/bL_platsmp.c b/arch/arm/common/bL_platsmp.c
new file mode 100644
index 0000000000..e28dd50640
--- /dev/null
+++ b/arch/arm/common/bL_platsmp.c
@@ -0,0 +1,79 @@
+/*
+ * linux/arch/arm/mach-vexpress/bL_platsmp.c
+ *
+ * Created by:  Nicolas Pitre, November 2012
+ * Copyright:   (C) 2012-2013  Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Code to handle secondary CPU bringup and hotplug for the bL power API.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+
+#include <asm/bL_entry.h>
+#include <asm/smp_plat.h>
+#include <asm/hardware/gic.h>
+
+static void __init simple_smp_init_cpus(void)
+{
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+static int __cpuinit bL_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned int pcpu, pcluster, ret;
+	extern void secondary_startup(void);
+
+	pcpu = cpu_logical_map(cpu) & 0xff;
+	pcluster = (cpu_logical_map(cpu) >> 8) & 0xff;
+	pr_debug("%s: logical CPU %d is physical CPU %d cluster %d\n",
+		 __func__, cpu, pcpu, pcluster);
+
+	bL_set_entry_vector(pcpu, pcluster, NULL);
+	ret = bL_cpu_power_up(pcpu, pcluster);
+	if (ret)
+		return ret;
+	bL_set_entry_vector(pcpu, pcluster, secondary_startup);
+	gic_raise_softirq(cpumask_of(cpu), 0);
+	dsb_sev();
+	return 0;
+}
+
+static void __cpuinit bL_secondary_init(unsigned int cpu)
+{
+	bL_cpu_powered_up();
+	gic_secondary_init(0);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static int bL_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * We assume all CPUs may be shut down.
+	 * This would be the hook to use for eventual Secure
+	 * OS migration requests.
+	 */
+	return 0;
+}
+
+static void __ref bL_cpu_die(unsigned int cpu)
+{
+	bL_cpu_power_down();
+}
+
+#endif
+
+struct smp_operations __initdata bL_smp_ops = {
+	.smp_init_cpus		= simple_smp_init_cpus,
+	.smp_boot_secondary	= bL_boot_secondary,
+	.smp_secondary_init	= bL_secondary_init,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= bL_cpu_disable,
+	.cpu_die		= bL_cpu_die,
+#endif
+};
-- 
1.8.0
