From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 25 Mar 2013 14:53:15 +0100
Subject: [PATCH 09/10] arm: zynq: Add hotplug support
In-Reply-To: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <1364219596-4954-9-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/Makefile  |    1 +
 arch/arm/mach-zynq/common.h  |    3 ++
 arch/arm/mach-zynq/hotplug.c |  102 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-zynq/platsmp.c |    3 ++
 4 files changed, 109 insertions(+)
 create mode 100644 arch/arm/mach-zynq/hotplug.c

diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index 8493a89..8e75490 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -4,4 +4,5 @@
 
 # Common support
 obj-y				:= common.o slcr.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_SMP)		+= platsmp.o
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 84145fb..b4614fa 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -30,4 +30,7 @@ extern struct smp_operations zynq_smp_ops __initdata;
 extern void __iomem *zynq_slcr_base;
 extern void __iomem *scu_base;
 
+/* Hotplug */
+extern void platform_cpu_die(unsigned int cpu);
+
 #endif
diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
new file mode 100644
index 0000000..012bddf
--- /dev/null
+++ b/arch/arm/mach-zynq/hotplug.c
@@ -0,0 +1,102 @@
+/*
+ *  linux/arch/arm/mach-realview/hotplug.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include "common.h"
+
+static inline void cpu_enter_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_all();
+	asm volatile(
+	"	mcr	p15, 0, %1, c7, c5, 0\n"
+	"	dsb\n"
+	/*
+	 * Turn off coherency
+	 */
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, #0x40\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, %2\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "r" (0), "Ir" (CR_C)
+	  : "cc");
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, #0x40\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  : "Ir" (CR_C)
+	  : "cc");
+}
+
+static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+{
+	/*
+	 * there is no power-control hardware on this platform, so all
+	 * we can do is put the core into WFI; this is safe as the calling
+	 * code will have already disabled interrupts
+	 */
+	for (;;) {
+		dsb();
+		wfi();
+
+		/*
+		 * Getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * Just note it happening - when we're woken, we can report
+		 * its occurrence.
+		 */
+		(*spurious)++;
+	}
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+	int spurious = 0;
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	cpu_enter_lowpower();
+	platform_do_lowpower(cpu, &spurious);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	cpu_leave_lowpower();
+
+	if (spurious)
+		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+}
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index d31ef72..9757a2d 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -157,4 +157,7 @@ struct smp_operations zynq_smp_ops __initdata = {
 	.smp_prepare_cpus	= zynq_smp_prepare_cpus,
 	.smp_secondary_init	= zynq_secondary_init,
 	.smp_boot_secondary	= zynq_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= platform_cpu_die,
+#endif
 };
-- 
1.7.9.7
