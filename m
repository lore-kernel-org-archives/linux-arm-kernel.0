From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Mar 2013 17:38:11 +0100
Subject: [PATCH v3 11/12] arm: zynq: Add hotplug support
In-Reply-To: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
References: <1364488692-18709-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <51507fc25e8f50378e7e909b083644c83f821ac4.1364488495.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
v3: Use zynq_ prefix for all functions

v2: Change platform_cpu_die name function to zynq_platform_cpu_dio
    Fix header
    Add cpu compilation flags to be able to build on V6 too
---
 arch/arm/mach-zynq/Makefile  |    3 ++
 arch/arm/mach-zynq/common.h  |    3 ++
 arch/arm/mach-zynq/hotplug.c |  104 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-zynq/platsmp.c |    3 ++
 4 files changed, 113 insertions(+)
 create mode 100644 arch/arm/mach-zynq/hotplug.c

diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index b595d22..1b25d92 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -4,4 +4,7 @@
 
 # Common support
 obj-y				:= common.o slcr.o
+CFLAGS_REMOVE_hotplug.o		=-march=armv6k
+CFLAGS_hotplug.o 		=-Wa,-march=armv7-a -mcpu=cortex-a9
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_SMP)		+= headsmp.o platsmp.o
diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index fd308f8..fbbd0e2 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -34,4 +34,7 @@ extern struct smp_operations zynq_smp_ops __initdata;
 extern void __iomem *zynq_slcr_base;
 extern void __iomem *zynq_scu_base;
 
+/* Hotplug */
+extern void zynq_platform_cpu_die(unsigned int cpu);
+
 #endif
diff --git a/arch/arm/mach-zynq/hotplug.c b/arch/arm/mach-zynq/hotplug.c
new file mode 100644
index 0000000..c89672b
--- /dev/null
+++ b/arch/arm/mach-zynq/hotplug.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) 2012-2013 Xilinx
+ *
+ * based on linux/arch/arm/mach-realview/hotplug.c
+ *
+ * Copyright (C) 2002 ARM Ltd.
+ * All Rights Reserved
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
+static inline void zynq_cpu_enter_lowpower(void)
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
+static inline void zynq_cpu_leave_lowpower(void)
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
+static inline void zynq_platform_do_lowpower(unsigned int cpu, int *spurious)
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
+void zynq_platform_cpu_die(unsigned int cpu)
+{
+	int spurious = 0;
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	zynq_cpu_enter_lowpower();
+	zynq_platform_do_lowpower(cpu, &spurious);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	zynq_cpu_leave_lowpower();
+
+	if (spurious)
+		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+}
diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
index cdfd888..3072cbd 100644
--- a/arch/arm/mach-zynq/platsmp.c
+++ b/arch/arm/mach-zynq/platsmp.c
@@ -146,4 +146,7 @@ struct smp_operations zynq_smp_ops __initdata = {
 	.smp_prepare_cpus	= zynq_smp_prepare_cpus,
 	.smp_secondary_init	= zynq_secondary_init,
 	.smp_boot_secondary	= zynq_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= zynq_platform_cpu_die,
+#endif
 };
-- 
1.7.9.7
