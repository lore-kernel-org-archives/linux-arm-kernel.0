From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 25 Mar 2013 14:53:14 +0100
Subject: [PATCH 08/10] arm: zynq: Add smp support
In-Reply-To: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <1364219596-4954-8-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zynq is dual core Cortex A9 which starts always
at zero. Using simple trampoline ensure long jump
to secondary_startup code.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/Makefile  |    1 +
 arch/arm/mach-zynq/common.c  |    1 +
 arch/arm/mach-zynq/common.h  |    7 ++
 arch/arm/mach-zynq/platsmp.c |  160 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-zynq/slcr.c    |   29 ++++++++
 5 files changed, 198 insertions(+)
 create mode 100644 arch/arm/mach-zynq/platsmp.c

diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index 13ee09b..8493a89 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -4,3 +4,4 @@
 
 # Common support
 obj-y				:= common.o slcr.o
+obj-$(CONFIG_SMP)		+= platsmp.o
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 292f775..a58f9d6 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -103,6 +103,7 @@ static const char *xilinx_dt_match[] = {
 };
 
 MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
+	.smp		= smp_ops(zynq_smp_ops),
 	.map_io		= xilinx_map_io,
 	.init_irq	= irqchip_init,
 	.init_machine	= xilinx_init_machine,
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index e5628f7..84145fb 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -19,6 +19,13 @@
 
 extern int slcr_init(void);
 extern void slcr_system_reset(void);
+extern void slcr_cpu_stop(int cpu);
+extern void slcr_cpu_start(int cpu);
+
+#ifdef CONFIG_SMP
+extern void secondary_startup(void);
+#endif
+extern struct smp_operations zynq_smp_ops __initdata;
 
 extern void __iomem *zynq_slcr_base;
 extern void __iomem *scu_base;
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
new file mode 100644
index 0000000..d31ef72
--- /dev/null
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -0,0 +1,160 @@
+/*
+ * This file contains Xilinx specific SMP code, used to start up
+ * the second processor.
+ *
+ * Copyright (C) 2011 - 2013 Xilinx
+ *
+ * based on linux/arch/arm/mach-realview/platsmp.c
+ *
+ * Copyright (C) 2002 ARM Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/export.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_scu.h>
+#include <linux/irqchip/arm-gic.h>
+#include "common.h"
+
+static DEFINE_SPINLOCK(boot_lock);
+
+/*
+ * Store number of cores in the system
+ * Because of scu_get_core_count() must be in __init section and can't
+ * be called from zynq_cpun_start() because it is in __cpuinit section.
+ */
+static int ncores;
+
+/* Secondary CPU kernel startup is a 2 step process. The primary CPU
+ * starts the secondary CPU by giving it the address of the kernel and
+ * then sending it an event to wake it up. The secondary CPU then
+ * starts the kernel and tells the primary CPU it's up and running.
+ */
+static void __cpuinit zynq_secondary_init(unsigned int cpu)
+{
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_secondary_init(0);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit zynq_cpun_start(u32 address, int cpu)
+{
+	if (cpu > ncores) {
+		pr_warn("CPU No. is not available in the system\n");
+		return -1;
+	}
+
+	/* MS: Expectation that SLCR are directly map and accessible */
+	/* Not possible to jump to non aligned address */
+	if (!(address & 3) && (!address || (address >= 0xC))) {
+		slcr_cpu_stop(cpu);
+
+		/*
+		 * This is elegant way how to jump to any address
+		 * 0x0: Load address at 0x8 to r0
+		 * 0x4: Jump by mov instruction
+		 * 0x8: Jumping address
+		 */
+		if (address) {
+			/* 0: ldr r0, [8] */
+			__raw_writel(0xe59f0000, phys_to_virt(0x0));
+			/* 4: mov pc, r0 */
+			__raw_writel(0xe1a0f000, phys_to_virt(0x4));
+			__raw_writel(address, phys_to_virt(0x8));
+		}
+
+		flush_cache_all();
+		outer_flush_all();
+		wmb();
+
+		slcr_cpu_start(cpu);
+
+		return 0;
+	}
+
+	pr_warn("Can't start CPU%d: Wrong starting address %x\n", cpu, address);
+
+	return -1;
+}
+EXPORT_SYMBOL(zynq_cpun_start);
+
+static int __cpuinit zynq_boot_secondary(unsigned int cpu,
+						struct task_struct *idle)
+{
+	int ret;
+
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	ret = zynq_cpun_start(virt_to_phys(secondary_startup), cpu);
+	if (ret) {
+		spin_unlock(&boot_lock);
+		return -1;
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return 0;
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+static void __init zynq_smp_init_cpus(void)
+{
+	int i;
+
+	ncores = scu_get_core_count(scu_base);
+
+	for (i = 0; i < ncores && i < CONFIG_NR_CPUS; i++)
+		set_cpu_possible(i, true);
+}
+
+static void __init zynq_smp_prepare_cpus(unsigned int max_cpus)
+{
+	int i;
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated@the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	scu_enable(scu_base);
+}
+
+struct smp_operations zynq_smp_ops __initdata = {
+	.smp_init_cpus		= zynq_smp_init_cpus,
+	.smp_prepare_cpus	= zynq_smp_prepare_cpus,
+	.smp_secondary_init	= zynq_secondary_init,
+	.smp_boot_secondary	= zynq_boot_secondary,
+};
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 36b79d8..7f2a919 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -33,6 +33,11 @@
 #define SLCR_UNLOCK			0x8   /* SCLR unlock register */
 
 #define SLCR_PSS_RST_CTRL_OFFSET	0x200 /* PS Software Reset Control */
+
+#define SLCR_A9_CPU_CLKSTOP		0x10
+#define SLCR_A9_CPU_RST			0x1
+
+#define SLCR_A9_CPU_RST_CTRL		0x244 /* CPU Software Reset Control */
 #define SLCR_REBOOT_STATUS		0x258 /* PS Reboot Status */
 
 void __iomem *zynq_slcr_base;
@@ -61,6 +66,30 @@ void slcr_system_reset(void)
 }
 
 /**
+ * slcr_cpu_start - Start cpu
+ * @cpu:	cpu number
+ */
+void slcr_cpu_start(int cpu)
+{
+	/* enable CPUn */
+	writel(SLCR_A9_CPU_CLKSTOP << cpu,
+	       zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
+	/* enable CLK for CPUn */
+	writel(0x0 << cpu, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
+}
+
+/**
+ * slcr_cpu_stop - Stop cpu
+ * @cpu:	cpu number
+ */
+void slcr_cpu_stop(int cpu)
+{
+	/* stop CLK and reset CPUn */
+	writel((SLCR_A9_CPU_CLKSTOP | SLCR_A9_CPU_RST) << cpu,
+	       zynq_slcr_base + SLCR_A9_CPU_RST_CTRL);
+}
+
+/**
  * xslcr_init()
  * Returns 0 on success, negative errno otherwise.
  *
-- 
1.7.9.7
