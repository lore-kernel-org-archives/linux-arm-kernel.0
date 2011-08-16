From: robherring2@gmail.com (Rob Herring)
Date: Tue, 16 Aug 2011 15:34:56 -0500
Subject: [PATCH 4/6] ARM: highbank: add SMP support
In-Reply-To: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
Message-ID: <1313526898-19920-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This enables SMP support on highbank processor.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                    |    2 +-
 arch/arm/mach-highbank/Makefile     |    2 +
 arch/arm/mach-highbank/localtimer.c |   37 ++++++++++++++++
 arch/arm/mach-highbank/platsmp.c    |   79 +++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-highbank/localtimer.c
 create mode 100644 arch/arm/mach-highbank/platsmp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index eecee3d..51abd0c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1365,7 +1365,7 @@ config SMP
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
 		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
-		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
+		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || ARCH_HIGHBANK
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
 	help
diff --git a/arch/arm/mach-highbank/Makefile b/arch/arm/mach-highbank/Makefile
index b5de3b9..d443f7e 100644
--- a/arch/arm/mach-highbank/Makefile
+++ b/arch/arm/mach-highbank/Makefile
@@ -1 +1,3 @@
 obj-y					:= clock.o highbank.o system.o
+obj-$(CONFIG_SMP)			+= platsmp.o
+obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
diff --git a/arch/arm/mach-highbank/localtimer.c b/arch/arm/mach-highbank/localtimer.c
new file mode 100644
index 0000000..ed54821
--- /dev/null
+++ b/arch/arm/mach-highbank/localtimer.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright 2010-2011 Calxeda, Inc.
+ * Based on localtimer.c, Copyright (C) 2002 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/init.h>
+#include <linux/clockchips.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <asm/smp_twd.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
+	twd_base = of_iomap(np, 0);
+	evt->irq = irq_of_parse_and_map(np, 0);
+	twd_timer_setup(evt);
+	return 0;
+}
diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
new file mode 100644
index 0000000..c582f5b
--- /dev/null
+++ b/arch/arm/mach-highbank/platsmp.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright 2010-2011 Calxeda, Inc.
+ * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/smp_scu.h>
+#include <asm/hardware/gic.h>
+
+#include "core.h"
+
+extern void secondary_startup(void);
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	gic_secondary_init(0);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	gic_raise_softirq(cpumask_of(cpu), 1);
+	return 0;
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	void __iomem *scu_base = a9_base_addr;
+	unsigned int i, ncores;
+
+	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+
+	/* sanity check */
+	if (ncores > NR_CPUS) {
+		printk(KERN_WARNING
+		       "highbank: no. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n",
+		       ncores, NR_CPUS);
+		ncores = NR_CPUS;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	set_smp_cross_call(gic_raise_softirq);
+}
+
+void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+	int i;
+
+	scu_enable(a9_base_addr);
+
+	/*
+	 * Write the address of secondary startup into the jump table
+	 * The cores are in wfi and wait until they receive a soft interrupt
+	 * and a non-zero value to jump to. Then the secondary CPU branches
+	 * to this address.
+	 */
+	for (i = 1; i < max_cpus; i++)
+		highbank_set_cpu_jump(i, secondary_startup);
+}
-- 
1.7.4.1
