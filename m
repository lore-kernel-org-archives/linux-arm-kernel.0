From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 24 Aug 2012 09:24:45 +0900
Subject: [PATCH v4 2/2] ARM: EXYNOS: SMC instruction (aka firmware) support
Message-ID: <20120824002445.GA17053@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some boards, e.g., exynos4412, can use smc instruction (aka firmware) interally.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 9b58024..8ee779c 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -30,6 +30,11 @@ obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
+obj-$(CONFIG_ARM_FIRMWARE)	+= exynos-smc.o firmware.o
+
+plus_sec := $(call as-instr,.arch_extension sec,+sec)
+AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
+
 # machine support
 
 obj-$(CONFIG_MACH_SMDKC210)		+= mach-smdkv310.o
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index aed2eeb..540918f 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -21,6 +21,8 @@ void exynos4_restart(char mode, const char *cmd);
 void exynos5_restart(char mode, const char *cmd);
 void exynos_init_late(void);
 
+void exynos_firmware_init(void);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS
 int exynos_pm_late_initcall(void);
 #else
diff --git a/arch/arm/mach-exynos/exynos-smc.S b/arch/arm/mach-exynos/exynos-smc.S
new file mode 100644
index 0000000..2e27aa3
--- /dev/null
+++ b/arch/arm/mach-exynos/exynos-smc.S
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2012 Samsung Electronics.
+ *
+ * Copied from omap-smc.S Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+/*
+ * Function signature: void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3)
+ */
+
+ENTRY(exynos_smc)
+	stmfd	sp!, {r4-r11, lr}
+	dsb
+	smc	#0
+	ldmfd	sp!, {r4-r11, pc}
+ENDPROC(exynos_smc)
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
new file mode 100644
index 0000000..a144593
--- /dev/null
+++ b/arch/arm/mach-exynos/firmware.c
@@ -0,0 +1,37 @@
+/*
+ *  Copyright (C) 2012 Samsung Electronics.
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm/firmware.h>
+
+#include "smc.h"
+
+static int exynos_do_idle(void)
+{
+        exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
+        return 0;
+}
+
+static void exynos_cpu_boot(int cpu)
+{
+	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
+}
+
+static struct firmware_ops exynos_firmware_ops __initdata = {
+	.do_idle	= exynos_do_idle,
+	.cpu_boot	= exynos_cpu_boot,
+};
+
+int __init exynos_firmware_init(void)
+{
+	firmware_ops = exynos_firmware_ops;
+	return 0;
+}
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 36c3984..25f039d 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -25,6 +25,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
+#include <asm/firmware.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
@@ -139,6 +140,12 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		__raw_writel(virt_to_phys(exynos4_secondary_startup),
 			CPU1_BOOT_REG);
+
+		if (IS_ENABLED(CONFIG_ARM_FIRMWARE)) {
+			/* Call Exynos specific smc call */
+			firmware_ops->cpu_boot(cpu);
+		}
+
 		gic_raise_softirq(cpumask_of(cpu), 1);
 
 		if (pen_release == -1)
diff --git a/arch/arm/mach-exynos/smc.h b/arch/arm/mach-exynos/smc.h
new file mode 100644
index 0000000..e972390
--- /dev/null
+++ b/arch/arm/mach-exynos/smc.h
@@ -0,0 +1,31 @@
+/*
+ *  Copyright (c) 2012 Samsung Electronics.
+ *
+ * EXYNOS - SMC Call
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_EXYNOS_SMC_H
+#define __ASM_ARCH_EXYNOS_SMC_H
+
+#define SMC_CMD_INIT            (-1)
+#define SMC_CMD_INFO            (-2)
+/* For Power Management */
+#define SMC_CMD_SLEEP           (-3)
+#define SMC_CMD_CPU1BOOT        (-4)
+#define SMC_CMD_CPU0AFTR        (-5)
+/* For CP15 Access */
+#define SMC_CMD_C15RESUME       (-11)
+/* For L2 Cache Access */
+#define SMC_CMD_L2X0CTRL        (-21)
+#define SMC_CMD_L2X0SETUP1      (-22)
+#define SMC_CMD_L2X0SETUP2      (-23)
+#define SMC_CMD_L2X0INVALL      (-24)
+#define SMC_CMD_L2X0DEBUG       (-25)
+
+extern void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3);
+
+#endif
