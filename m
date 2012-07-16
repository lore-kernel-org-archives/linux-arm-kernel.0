From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 16 Jul 2012 11:29:56 +0900
Subject: [RFC PATCH v2] ARM: Make a compile firmware conditionally
Message-ID: <20120716022956.GA619@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some boards can use the firmware at trustzone but others can't use this.
However we need to build it simultaneously. To address this issue,
introduce arm firmware support and use it at each board files.

e.g., In boot_secondary at mach-exynos/platsmp.c

        __raw_writel(virt_to_phys(exynos4_secondary_startup),
                CPU1_BOOT_REG);

        if (IS_ENABLED(CONFIG_ARM_FIRMWARE)) {
                /* Call Exynos specific smc call */
		firmware_ops.cpu_boot(cpu);
        }

        gic_raise_softirq(cpumask_of(cpu), 1);

        if (pen_release == -1)

Now smp_ops is not yet merged, now just call the firmware_init at init_early
 at board file

e.g., exynos4412 based board 

static void __init board_init_early(void)
{
	exynos_firmware_init();
}

TODO
	1. DT support.
	2. call firmware init by smp_ops.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/common/firmware.c b/arch/arm/common/firmware.c
new file mode 100644
index 0000000..ffb6822
--- /dev/null
+++ b/arch/arm/common/firmware.c
@@ -0,0 +1,23 @@
+/*
+ *  Copyright (C) 2012 Samsung Electronics.
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+
+#include <asm/firmware.h>
+
+static void cpu_boot(int cpu)
+{
+	/* Do nothing */
+}
+
+struct firmware_ops firmware_ops = {
+	.do_idle		= cpu_do_idle,
+	.cpu_boot		= cpu_boot,
+};
diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
new file mode 100644
index 0000000..c8c28bf
--- /dev/null
+++ b/arch/arm/include/asm/firmware.h
@@ -0,0 +1,20 @@
+/*
+ *  Copyright (C) 2012 Samsung Electronics.
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARM_FIRMWARE_H
+#define __ASM_ARM_FIRMWARE_H
+
+struct firmware_ops {
+	int	(*do_idle)(void);
+	void	(*cpu_boot)(int cpu);
+};
+
+extern struct firmware_ops firmware_ops;
+
+#endif
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
index 0000000..6aa423b
--- /dev/null
+++ b/arch/arm/mach-exynos/firmware.c
@@ -0,0 +1,33 @@
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
+int __init exynos_firmware_init(void)
+{
+	firmware_ops.do_idle = exynos_do_idle;
+	firmware_ops.cpu_boot = exynos_cpu_boot;
+	return 0;
+}
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
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 283fa1d..5b097ca 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -21,6 +21,9 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
 
+config ARM_FIRMWARE
+	bool
+
 config ICST
 	bool
 
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e8a4e58..4af6568 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_ARM_GIC)		+= gic.o
 obj-$(CONFIG_ARM_VIC)		+= vic.o
+obj-$(CONFIG_ARM_FIRMWARE)	+= firmware.o
 obj-$(CONFIG_ICST)		+= icst.o
 obj-$(CONFIG_SA1111)		+= sa1111.o
 obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
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
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 36c3984..3cec589 100644
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
+			firmware_ops.cpu_boot(cpu);
+		}
+
 		gic_raise_softirq(cpumask_of(cpu), 1);
 
 		if (pen_release == -1)
