From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 10 Jun 2013 15:55:22 -0400
Subject: [PATCH 2/3] ARM: keystone: Enable SMP support on Keystone machines
In-Reply-To: <1370894123-26846-1-git-send-email-santosh.shilimkar@ti.com>
References: <1370894123-26846-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1370894123-26846-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic SMP support for Keystone machines. This does not
include support for CPU hotplug for now.

Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: arm at kernel.org

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/Kconfig    |    1 +
 arch/arm/mach-keystone/Makefile   |    1 +
 arch/arm/mach-keystone/keystone.c |    4 +++
 arch/arm/mach-keystone/keystone.h |   17 ++++++++++
 arch/arm/mach-keystone/platsmp.c  |   67 +++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+)
 create mode 100644 arch/arm/mach-keystone/keystone.h
 create mode 100644 arch/arm/mach-keystone/platsmp.c

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 39fab74..6054673 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -3,6 +3,7 @@ config ARCH_KEYSTONE
 	select CPU_V7
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
+	select HAVE_SMP
 	select USE_OF
 	select MULTI_IRQ_HANDLER
 	select CLKSRC_MMIO
diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
index d4671d5..3f6b8ab 100644
--- a/arch/arm/mach-keystone/Makefile
+++ b/arch/arm/mach-keystone/Makefile
@@ -1 +1,2 @@
 obj-y					:= keystone.o
+obj-$(CONFIG_SMP)			+= platsmp.o
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 6c6fc42..5dd3b32 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -19,6 +19,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/smp_plat.h>
+
+#include "keystone.h"
 
 #define PLL_RESET_WRITE_KEY_MASK		0xffff0000
 #define PLL_RESET_WRITE_KEY			0x5a69
@@ -67,6 +70,7 @@ void keystone_restart(char mode, const char *cmd)
 }
 
 DT_MACHINE_START(KEYSTONE, "Keystone")
+	.smp		= smp_ops(keystone_smp_ops),
 	.map_io		= debug_ll_io_init,
 	.init_machine	= keystone_init,
 	.dt_compat	= keystone_match,
diff --git a/arch/arm/mach-keystone/keystone.h b/arch/arm/mach-keystone/keystone.h
new file mode 100644
index 0000000..43a1b47
--- /dev/null
+++ b/arch/arm/mach-keystone/keystone.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright 2013 Texas Instruments, Inc.
+ *	Cyril Chemparathy <cyril@ti.com>
+ *	Santosh Shilimkar <santosh.shillimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef __KEYSTONE_H__
+#define __KEYSTONE_H__
+
+extern struct smp_operations keystone_smp_ops;
+extern void secondary_startup(void);
+
+#endif /* __KEYSTONE_H__ */
diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
new file mode 100644
index 0000000..3071dda
--- /dev/null
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -0,0 +1,67 @@
+/*
+ * Keystone SOC SMP platform code
+ *
+ * Copyright 2013 Texas Instruments, Inc.
+ *	Cyril Chemparathy <cyril@ti.com>
+ *	Santosh Shilimkar <santosh.shillimkar@ti.com>
+ *
+ * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/smp_plat.h>
+
+#include "keystone.h"
+
+static void __init keystone_smp_init_cpus(void)
+{
+	unsigned int i, ncores;
+
+	ncores = 4;
+
+	/* sanity check */
+	if (ncores > NR_CPUS) {
+		pr_warn("restricted to %d cpus\n", NR_CPUS);
+		ncores = NR_CPUS;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+static int __cpuinit keystone_smp_boot_secondary(unsigned int cpu,
+						struct task_struct *idle)
+{
+	unsigned long start = virt_to_phys(&secondary_startup);
+	int error;
+
+	pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
+		 cpu, start);
+
+	asm volatile (
+		"mov    r0, #0\n"	/* power on cmd	*/
+		"mov    r1, %1\n"	/* cpu		*/
+		"mov    r2, %2\n"	/* start	*/
+		".inst  0xe1600070\n"	/* smc #0	*/
+		"mov    %0, r0\n"
+		: "=r" (error)
+		: "r"(cpu), "r"(start)
+		: "cc", "r0", "r1", "r2", "memory"
+	);
+
+	pr_debug("keystone-smp: monitor returned %d\n", error);
+
+	return error;
+}
+
+struct smp_operations keystone_smp_ops __initdata = {
+	.smp_init_cpus		= keystone_smp_init_cpus,
+	.smp_boot_secondary	= keystone_smp_boot_secondary,
+};
-- 
1.7.9.5
