From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 14 Mar 2015 19:49:41 +0800
Subject: [PATCH 06/10] ARM: zx: add cpu hotplug support
In-Reply-To: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1426333785-3952-7-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's a clone of vexpress cpu hotplug implementation.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm/mach-zx/Makefile  |   1 +
 arch/arm/mach-zx/core.h    |   1 +
 arch/arm/mach-zx/hotplug.c | 108 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-zx/platsmp.c |   3 ++
 4 files changed, 113 insertions(+)
 create mode 100644 arch/arm/mach-zx/hotplug.c

diff --git a/arch/arm/mach-zx/Makefile b/arch/arm/mach-zx/Makefile
index 7c2edf6..a3b386e7 100644
--- a/arch/arm/mach-zx/Makefile
+++ b/arch/arm/mach-zx/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_SOC_ZX296702) += zx296702.o
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
+obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
diff --git a/arch/arm/mach-zx/core.h b/arch/arm/mach-zx/core.h
index 400c7b4..9f6b719 100644
--- a/arch/arm/mach-zx/core.h
+++ b/arch/arm/mach-zx/core.h
@@ -13,5 +13,6 @@
 extern struct smp_operations zx_smp_ops;
 
 void zx_secondary_startup(void);
+void zx_cpu_die(unsigned int cpu);
 
 #endif /* __MACH_ZX_CORE_H */
diff --git a/arch/arm/mach-zx/hotplug.c b/arch/arm/mach-zx/hotplug.c
new file mode 100644
index 0000000..1b660e1
--- /dev/null
+++ b/arch/arm/mach-zx/hotplug.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright 2014 Linaro Ltd.
+ * Copyright (C) 2014 ZTE Corporation.
+ *
+ * Copyright (C) 2002 ARM Ltd.
+ * All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+#include <asm/smp_plat.h>
+#include <asm/cp15.h>
+
+static inline void cpu_enter_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile(
+		"mcr	p15, 0, %1, c7, c5, 0\n"
+	"	mcr	p15, 0, %1, c7, c10, 4\n"
+	/*
+	 * Turn off coherency
+	 */
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, %3\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, %2\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
+	  : "cc");
+}
+
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile(
+		"mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	orr	%0, %0, %2\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	  : "=&r" (v)
+	  : "Ir" (CR_C), "Ir" (0x40)
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
+		wfi();
+
+		if (pen_release == cpu_logical_map(cpu)) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
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
+void __ref zx_cpu_die(unsigned int cpu)
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
diff --git a/arch/arm/mach-zx/platsmp.c b/arch/arm/mach-zx/platsmp.c
index e508a9c..ca157c3 100644
--- a/arch/arm/mach-zx/platsmp.c
+++ b/arch/arm/mach-zx/platsmp.c
@@ -144,4 +144,7 @@ struct smp_operations zx_smp_ops __initdata = {
 	.smp_prepare_cpus	= zx_smp_prepare_cpus,
 	.smp_secondary_init	= zx_secondary_init,
 	.smp_boot_secondary	= zx_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= zx_cpu_die,
+#endif
 };
-- 
1.9.1
