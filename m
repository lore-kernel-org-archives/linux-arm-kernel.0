From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 12 Jun 2013 17:25:17 -0400
Subject: [PATCH v2 3/3] ARM: keystone: Enable SMP support on Keystone machines
In-Reply-To: <1371072317-15030-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371072317-15030-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1371072317-15030-4-git-send-email-santosh.shilimkar@ti.com>
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
 arch/arm/mach-keystone/keystone.h |   17 ++++++++++++
 arch/arm/mach-keystone/platsmp.c  |   52 +++++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+)
 create mode 100644 arch/arm/mach-keystone/keystone.h
 create mode 100644 arch/arm/mach-keystone/platsmp.c

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index aebe8cd..2dbd4ce 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -4,6 +4,7 @@ config ARCH_KEYSTONE
 	select CPU_V7
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
+	select HAVE_SMP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SCHED_CLOCK
diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
index d4671d5..3f6b8ab 100644
--- a/arch/arm/mach-keystone/Makefile
+++ b/arch/arm/mach-keystone/Makefile
@@ -1 +1,2 @@
 obj-y					:= keystone.o
+obj-$(CONFIG_SMP)			+= platsmp.o
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index c4912c4..da54d15 100644
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
 	.init_machine	= keystone_init,
 	.dt_compat	= keystone_match,
 	.restart	= keystone_restart,
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
index 0000000..630ab3b
--- /dev/null
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -0,0 +1,52 @@
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
+#include <asm/prom.h>
+
+#include "keystone.h"
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
+	.smp_init_cpus		= arm_dt_init_cpu_maps,
+	.smp_boot_secondary	= keystone_smp_boot_secondary,
+};
-- 
1.7.9.5
