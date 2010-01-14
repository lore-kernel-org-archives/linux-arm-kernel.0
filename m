From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:30 +0100
Subject: [PATCH 12/21] ARM: S5PC1XX: add S5PC110 cpu initialization code
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-13-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch adds CPU initialization code for S5PC110 sub-platform.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Byungho Min <bhmin@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc110/Kconfig                    |   17 +++
 arch/arm/mach-s5pc110/Makefile                   |   18 ++++
 arch/arm/mach-s5pc110/Makefile.boot              |    2 +
 arch/arm/mach-s5pc110/cpu.c                      |  117 ++++++++++++++++++++++
 arch/arm/mach-s5pc110/include/mach/debug-macro.S |   54 ++++++++++
 arch/arm/mach-s5pc110/include/mach/entry-macro.S |   56 ++++++++++
 arch/arm/mach-s5pc110/include/mach/system.h      |   31 ++++++
 arch/arm/mach-s5pc110/include/plat/regs-power.h  |   79 +++++++++++++++
 arch/arm/mach-s5pc110/uarts.c                    |   28 +++++
 arch/arm/plat-s5pc1xx/cpu.c                      |    9 ++
 arch/arm/plat-s5pc1xx/include/plat/s5pc110.h     |   36 +++++++
 arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h     |    1 +
 12 files changed, 448 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc110/Kconfig
 create mode 100644 arch/arm/mach-s5pc110/Makefile
 create mode 100644 arch/arm/mach-s5pc110/Makefile.boot
 create mode 100644 arch/arm/mach-s5pc110/cpu.c
 create mode 100644 arch/arm/mach-s5pc110/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-s5pc110/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-s5pc110/include/mach/system.h
 create mode 100644 arch/arm/mach-s5pc110/include/plat/regs-power.h
 create mode 100644 arch/arm/mach-s5pc110/uarts.c
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/s5pc110.h

diff --git a/arch/arm/mach-s5pc110/Kconfig b/arch/arm/mach-s5pc110/Kconfig
new file mode 100644
index 0000000..4257b96
--- /dev/null
+++ b/arch/arm/mach-s5pc110/Kconfig
@@ -0,0 +1,17 @@
+# arch/arm/mach-s5pc110/Kconfig
+#
+#  Copyright 2009 Samsung Electronics Co.
+#  Kyungmin Park <kyungmin.park@samsung.com>
+#
+# Licensed under GPLv2
+
+if ARCH_S5PC110
+
+# Configuration options for the S5PC110 CPU
+
+config CPU_S5PC110
+	bool
+	help
+	  Enable S5PC110 CPU support
+
+endif
diff --git a/arch/arm/mach-s5pc110/Makefile b/arch/arm/mach-s5pc110/Makefile
new file mode 100644
index 0000000..d9fecf0
--- /dev/null
+++ b/arch/arm/mach-s5pc110/Makefile
@@ -0,0 +1,18 @@
+# arch/arm/mach-s5pc100/Makefile
+#
+# Copyright 2009 Samsung Electronics Co.
+#
+# Licensed under GPLv2
+
+obj-y                           :=
+obj-m                           :=
+obj-n                           :=
+obj-                            :=
+
+# Core support for S5PC110 system
+
+obj-$(CONFIG_CPU_S5PC110)	+= cpu.o
+
+# Helper and device support
+
+# machine support
diff --git a/arch/arm/mach-s5pc110/Makefile.boot b/arch/arm/mach-s5pc110/Makefile.boot
new file mode 100644
index 0000000..b0909e3
--- /dev/null
+++ b/arch/arm/mach-s5pc110/Makefile.boot
@@ -0,0 +1,2 @@
+   zreladdr-y	:= 0x30008000
+params_phys-y	:= 0x30000100
diff --git a/arch/arm/mach-s5pc110/cpu.c b/arch/arm/mach-s5pc110/cpu.c
new file mode 100644
index 0000000..1a4a5e4
--- /dev/null
+++ b/arch/arm/mach-s5pc110/cpu.c
@@ -0,0 +1,117 @@
+/* linux/arch/arm/mach-s5pc110/cpu.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * Based on mach-s3c6410/cpu.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/sysdev.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+
+#include <asm/proc-fns.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <plat/regs-serial.h>
+#include <plat/regs-power.h>
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/clock.h>
+#include <plat/sdhci.h>
+#include <plat/iic-core.h>
+#include <plat/s5pc1xx.h>
+
+/* Initial IO mappings */
+
+static struct map_desc s5pc110_iodesc[] __initdata = {
+};
+
+static void s5pc110_idle(void)
+{
+	unsigned long tmp;
+
+	tmp = __raw_readl(S5PC110_IDLE_CFG);
+	tmp &= ~(S5PC110_IDLECFG_TOP_LOGIC_MASK |
+			S5PC110_IDLECFG_TOP_MEMORY_MASK |
+			S5PC110_IDLECFG_OSC_EN);
+	tmp |= S5PC110_IDLECFG_TOP_LOGIC_ON |
+		S5PC110_IDLECFG_TOP_MEMORY_ON;
+	__raw_writel(tmp, S5PC110_IDLE_CFG);
+
+	tmp = __raw_readl(S5PC110_PWR_CFG);
+	tmp &= ~S5PC110_PWRCFG_CFG_WFI_MASK;
+	/* S5pc110 EVT0 chip bug */
+	/* tmp |= S5PC110_PWRCFG_CFG_WFI_IDLE; */
+	__raw_writel(tmp, S5PC110_PWR_CFG);
+
+	tmp = __raw_readl(S5PC110_OTHERS);
+	tmp |= S5PC110_SYSCON_INT_DISABLE;
+	__raw_writel(tmp, S5PC110_OTHERS);
+
+	cpu_do_idle();
+}
+
+/* s5pc110_map_io
+ *
+ * register the standard cpu IO areas
+*/
+
+void __init s5pc110_map_io(void)
+{
+	iotable_init(s5pc110_iodesc, ARRAY_SIZE(s5pc110_iodesc));
+
+	/* initialise device information early */
+}
+
+void __init s5pc110_init_clocks(int xtal)
+{
+	printk(KERN_DEBUG "%s: initialising clocks\n", __func__);
+	s3c24xx_register_baseclocks(xtal);
+}
+
+void __init s5pc110_init_irq(void)
+{
+}
+
+struct sysdev_class s5pc110_sysclass = {
+	.name	= "s5pc110-core",
+};
+
+static struct sys_device s5pc110_sysdev = {
+	.cls	= &s5pc110_sysclass,
+};
+
+static int __init s5pc110_core_init(void)
+{
+	return sysdev_class_register(&s5pc110_sysclass);
+}
+
+core_initcall(s5pc110_core_init);
+
+int __init s5pc110_init(void)
+{
+	printk(KERN_DEBUG "S5PC110: Initialising architecture\n");
+
+	s5pc1xx_idle = s5pc110_idle;
+
+	return sysdev_register(&s5pc110_sysdev);
+}
diff --git a/arch/arm/mach-s5pc110/include/mach/debug-macro.S b/arch/arm/mach-s5pc110/include/mach/debug-macro.S
new file mode 100644
index 0000000..1f75af5
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/mach/debug-macro.S
@@ -0,0 +1,54 @@
+/* arch/arm/mach-s5pc110/include/mach/debug-macro.S
+ *
+ *  Copyright (C) 2009 Samsung Electronics Co.
+ *  Byungho Min <bhmin@samsung.com>
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * Based on mach-s3c6400/include/mach/debug-macro.S
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* pull in the relevant register and map files. */
+
+#include <mach/map.h>
+#include <plat/regs-serial.h>
+
+	/* note, for the boot process to work we have to keep the UART
+	 * virtual address aligned to an 1MiB boundary for the L1
+	 * mapping the head code makes. We keep the UART virtual address
+	 * aligned and add in the offset when we load the value here.
+	 */
+
+	.macro addruart, rx
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1
+		ldreq	\rx, = S3C_PA_UART
+		ldrne	\rx, = (S3C_VA_UART + S3C_PA_UART & 0xfffff)
+		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+	.endm
+
+	/*
+	 * S5PC110 has different TXMASK & TXFULL
+	 */
+        .macro fifo_level_s5pc110 rd, rx
+                ldr     \rd, [ \rx, # S3C2410_UFSTAT ]
+                and     \rd, \rd, #S5PC110_UFSTAT_TXMASK
+        .endm
+
+	.macro  fifo_full_s5pc110 rd, rx
+                ldr     \rd, [ \rx, # S3C2410_UFSTAT ]
+                tst     \rd, #S5PC110_UFSTAT_TXFULL
+        .endm
+
+#define fifo_level	fifo_level_s5pc110
+#define fifo_full	fifo_full_s5pc110
+
+/* include the reset of the code which will do the work, we're only
+ * compiling for a single cpu processor type so the default of s3c2440
+ * will be fine with us.
+ */
+
+#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-s5pc110/include/mach/entry-macro.S b/arch/arm/mach-s5pc110/include/mach/entry-macro.S
new file mode 100644
index 0000000..7695b9d
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/mach/entry-macro.S
@@ -0,0 +1,56 @@
+/* arch/arm/mach-s5pc110/include/mach/entry-macro.S
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * Based on mach-s3c6400/include/mach/entry-macro.S
+ *
+ * Low-level IRQ helper macros for the Samsung S5PC110 series
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+*/
+
+#include <asm/hardware/vic.h>
+#include <mach/map.h>
+#include <plat/irqs.h>
+
+	.macro	disable_fiq
+	.endm
+
+	.macro	get_irqnr_preamble, base, tmp
+	ldr	\base, =S3C_VA_VIC0
+	.endm
+
+	.macro	arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+	@ check the vic0
+	mov	\irqnr, # S3C_IRQ_OFFSET + 31
+	ldr	\irqstat, [ \base, # VIC_IRQ_STATUS ]
+	teq	\irqstat, #0
+
+	@ otherwise try vic1
+	addeq	\tmp, \base, #(S3C_VA_VIC1 - S3C_VA_VIC0)
+	addeq	\irqnr, \irqnr, #32
+	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
+	teqeq	\irqstat, #0
+
+	@ otherwise try vic2
+	addeq	\tmp, \base, #(S3C_VA_VIC2 - S3C_VA_VIC0)
+	addeq	\irqnr, \irqnr, #32
+	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
+	teqeq	\irqstat, #0
+
+	@ otherwise try vic3
+	addeq	\tmp, \base, #(S3C_VA_VIC3 - S3C_VA_VIC0)
+	addeq	\irqnr, \irqnr, #32
+	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
+	teqeq	\irqstat, #0
+
+	clzne	\irqstat, \irqstat
+	subne	\irqnr, \irqnr, \irqstat
+	.endm
diff --git a/arch/arm/mach-s5pc110/include/mach/system.h b/arch/arm/mach-s5pc110/include/mach/system.h
new file mode 100644
index 0000000..be40aa6
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/mach/system.h
@@ -0,0 +1,31 @@
+/* linux/arch/arm/mach-s5pc110/include/mach/system.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC110 - system implementation
+ *
+ * Based on mach-s3c6400/include/mach/system.h
+ */
+
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H __FILE__
+
+#include <linux/io.h>
+#include <mach/map.h>
+#include <plat/regs-clock.h>
+
+void (*s5pc1xx_idle)(void);
+
+static void arch_idle(void)
+{
+	if (s5pc1xx_idle)
+		s5pc1xx_idle();
+}
+
+static void arch_reset(char mode, const char *cmd)
+{
+	__raw_writel(0x1, S5PC110_SWRESET);
+	return;
+}
+#endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-s5pc110/include/plat/regs-power.h b/arch/arm/mach-s5pc110/include/plat/regs-power.h
new file mode 100644
index 0000000..db0880a
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/plat/regs-power.h
@@ -0,0 +1,79 @@
+/* arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * S5PC110 power control register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARM_REGS_PWR
+#define __ASM_ARM_REGS_PWR __FILE__
+
+#define S5PC1XX_PWRREG(x)			(S5PC1XX_VA_PWR + (x))
+
+/* s5pc110 (0xE010C000) register for power management */
+#define S5PC110_PWR_CFG				S5PC1XX_PWRREG(0x0)
+#define S5PC110_EINT_WAKEUP_MASK		S5PC1XX_PWRREG(0x4)
+#define S5PC110_WAKEUP_MASK			S5PC1XX_PWRREG(0x8)
+#define S5PC110_NORMAL_CFG			S5PC1XX_PWRREG(0x10)
+#define S5PC110_IDLE_CFG			S5PC1XX_PWRREG(0x20)
+#define S5PC110_STOP_CFG			S5PC1XX_PWRREG(0x30)
+#define S5PC110_STOP_MEM_CFG			S5PC1XX_PWRREG(0x34)
+#define S5PC110_SLEEP_CFG			S5PC1XX_PWRREG(0x40)
+#define S5PC110_OSC_FREQ			S5PC1XX_PWRREG(0x100)
+#define S5PC110_OSC_STABLE			S5PC1XX_PWRREG(0x104)
+#define S5PC110_PWR_STABLE			S5PC1XX_PWRREG(0x108)
+#define S5PC110_MTC_STABLE			S5PC1XX_PWRREG(0x110)
+#define S5PC110_CLAMP_STABLE			S5PC1XX_PWRREG(0x114)
+#define S5PC110_WAKEUP_STAT			S5PC1XX_PWRREG(0x200)
+#define S5PC110_BLK_PWR_STAT			S5PC1XX_PWRREG(0x204)
+#define S5PC110_BODY_BIAS_CON			S5PC1XX_PWRREG(0x300)
+#define S5PC110_ION_SKEW_CON			S5PC1XX_PWRREG(0x310)
+#define S5PC110_ION_SKEW_MON			S5PC1XX_PWRREG(0x314)
+#define S5PC110_IOFF_SKEW_CON			S5PC1XX_PWRREG(0x320)
+#define S5PC110_IOFF_SKEW_MON			S5PC1XX_PWRREG(0x324)
+#define S5PC110_OTHERS				S5PC1XX_PWRREG(0x2000)
+#define S5PC110_OM_STAT				S5PC1XX_PWRREG(0x2100)
+#define S5PC110_MIE_CONTROL			S5PC1XX_PWRREG(0x2800)
+#define S5PC110_HDMI_CONTROL			S5PC1XX_PWRREG(0x2804)
+#define S5PC110_USB_PHY_CONTROL			S5PC1XX_PWRREG(0x280C)
+#define S5PC110_DAC_CONTROL			S5PC1XX_PWRREG(0x2810)
+#define S5PC110_MIPI_DPHY_CONTROL		S5PC1XX_PWRREG(0x2814)
+#define S5PC110_ADC_CONTROL			S5PC1XX_PWRREG(0x2818)
+#define S5PC110_PS_HOLD_CONTROL			S5PC1XX_PWRREG(0x281C)
+#define S5PC110_INFORM0				S5PC1XX_PWRREG(0x3000)
+#define S5PC110_INFORM1				S5PC1XX_PWRREG(0x3004)
+#define S5PC110_INFORM2				S5PC1XX_PWRREG(0x3008)
+#define S5PC110_INFORM3				S5PC1XX_PWRREG(0x300C)
+#define S5PC110_INFORM4				S5PC1XX_PWRREG(0x3010)
+#define S5PC110_INFORM5				S5PC1XX_PWRREG(0x3014)
+#define S5PC110_INFORM6				S5PC1XX_PWRREG(0x3018)
+#define S5PC110_INFORM7				S5PC1XX_PWRREG(0x301C)
+
+/* PWR_CFG */
+#define S5PC110_PWRCFG_CFG_WFI_MASK		(3 << 8)
+#define S5PC110_PWRCFG_CFG_WFI_IGNORE		(0 << 8)
+#define S5PC110_PWRCFG_CFG_WFI_IDLE		(1 << 8)
+#define S5PC110_PWRCFG_CFG_WFI_STOP		(2 << 8)
+#define S5PC110_PWRCFG_CFG_WFI_SLEEP		(3 << 8)
+
+/* IDLE_CFG */
+#define S5PC110_IDLECFG_TOP_LOGIC_MASK		(3 << 30)
+#define S5PC110_IDLECFG_TOP_LOGIC_RET		(1 << 30)
+#define S5PC110_IDLECFG_TOP_LOGIC_ON		(2 << 30)
+#define S5PC110_IDLECFG_TOP_MEMORY_MASK		(3 << 28)
+#define S5PC110_IDLECFG_TOP_MEMORY_RET		(1 << 28)
+#define S5PC110_IDLECFG_TOP_MEMORY_ON		(2 << 28)
+#define S5PC110_IDLECFG_OSC_EN			(1 << 0)
+
+/* SLEEP_CFG */
+#define S5PC110_SLEEP_OSCUSB_EN			(1 << 1)
+#define S5PC110_SLEEP_OSC_EN			(1 << 0)
+
+/* OTHERS */
+#define S5PC110_SYSCON_INT_DISABLE		(1 << 0)
+
+#endif /* __ASM_ARM_REGS_PWR */
diff --git a/arch/arm/mach-s5pc110/uarts.c b/arch/arm/mach-s5pc110/uarts.c
new file mode 100644
index 0000000..7e63f77
--- /dev/null
+++ b/arch/arm/mach-s5pc110/uarts.c
@@ -0,0 +1,28 @@
+/*
+ * linux/arch/arm/mach-s5pc110/uarts.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * S5PC110 - CPU initialisation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/s5pc1xx.h>
+
+/* uart registration process */
+
+void __init s5pc110_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	/* The driver name is s5pc1xx-uart to reuse s5pc1xx_serial_drv  */
+	s3c24xx_init_uartdevs("s5pc110-uart", s5pc1xx_uart_resources, cfg, no);
+}
diff --git a/arch/arm/plat-s5pc1xx/cpu.c b/arch/arm/plat-s5pc1xx/cpu.c
index d30998d..893d433 100644
--- a/arch/arm/plat-s5pc1xx/cpu.c
+++ b/arch/arm/plat-s5pc1xx/cpu.c
@@ -36,6 +36,7 @@
 /* table of supported CPUs */
 
 static const char name_s5pc100[] = "S5PC100";
+static const char name_s5pc110[] = "S5PC110";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -46,6 +47,14 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init_uarts	= s5pc100_init_uarts,
 		.init		= s5pc100_init,
 		.name		= name_s5pc100,
+	}, {
+		.idcode		= 0x43110000,
+		.idmask		= 0xfffff000,
+		.map_io		= s5pc110_map_io,
+		.init_clocks	= s5pc110_init_clocks,
+		.init_uarts	= s5pc110_init_uarts,
+		.init		= s5pc110_init,
+		.name		= name_s5pc110,
 	},
 };
 /* minimal IO mapping */
diff --git a/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h b/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h
new file mode 100644
index 0000000..93c623b
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/plat/s5pc110.h
@@ -0,0 +1,36 @@
+/* arch/arm/plat-s5pc1xx/include/plat/s5pc100.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * Header file for s5pc100 cpu support
+ *
+ * Based on plat-s3c64xx/include/plat/s3c6400.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* Common init code for S5PC110 related SoCs */
+
+#ifdef CONFIG_CPU_S5PC110
+
+extern void s5pc110_map_io(void);
+extern void s5pc110_init_clocks(int xtal);
+extern void s5pc110_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern  int s5pc110_init(void);
+
+extern void s5pc110_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern void s5pc110_init_irq(void);
+extern void s5pc110_register_clocks(void);
+extern void s5pc110_setup_clocks(void);
+
+#else
+
+#define s5pc110_map_io NULL
+#define s5pc110_init_clocks NULL
+#define s5pc110_init_uarts NULL
+#define s5pc110_init NULL
+
+#endif
diff --git a/arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h b/arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h
index 398251f..d8d7a43 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h
+++ b/arch/arm/plat-s5pc1xx/include/plat/s5pc1xx.h
@@ -19,3 +19,4 @@ extern void s5pc1xx_register_clocks(void);
 extern struct s3c24xx_uart_resources s5pc1xx_uart_resources[];
 
 #include <plat/s5pc100.h>
+#include <plat/s5pc110.h>
-- 
1.6.4
