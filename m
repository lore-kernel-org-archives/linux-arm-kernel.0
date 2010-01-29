From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 29 Jan 2010 11:06:14 +0900
Subject: [PATCH v2 1/7] ARM: S5P6442: Add Samsung S5P6442 CPU support
Message-ID: <1264730774-15959-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Samsung S5P6442 CPU. This patch also adds
an entry for S5P6442 cpu in plat-s5p cpu table.

Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/Kconfig                    |   24 ++++
 arch/arm/mach-s5p6442/Makefile                   |   18 ++++
 arch/arm/mach-s5p6442/Makefile.boot              |    2 +
 arch/arm/mach-s5p6442/cpu.c                      |  121 +++++++++++++++++++++
 arch/arm/mach-s5p6442/include/mach/debug-macro.S |   36 +++++++
 arch/arm/mach-s5p6442/include/mach/entry-macro.S |   48 +++++++++
 arch/arm/mach-s5p6442/include/mach/gpio.h        |  123 ++++++++++++++++++++++
 arch/arm/mach-s5p6442/include/mach/hardware.h    |   18 +++
 arch/arm/mach-s5p6442/include/mach/map.h         |   59 ++++++++++
 arch/arm/mach-s5p6442/include/mach/memory.h      |   19 ++++
 arch/arm/mach-s5p6442/include/mach/system.h      |   26 +++++
 arch/arm/mach-s5p6442/include/mach/uncompress.h  |   24 ++++
 arch/arm/mach-s5p6442/init.c                     |   44 ++++++++
 arch/arm/plat-s3c/include/plat/debug-macro.S     |   12 ++
 arch/arm/plat-s5p/cpu.c                          |   10 ++
 arch/arm/plat-s5p/include/plat/map-s5p.h         |    1 +
 arch/arm/plat-s5p/include/plat/s5p6442.h         |   33 ++++++
 17 files changed, 618 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6442/Kconfig
 create mode 100644 arch/arm/mach-s5p6442/Makefile
 create mode 100644 arch/arm/mach-s5p6442/Makefile.boot
 create mode 100644 arch/arm/mach-s5p6442/cpu.c
 create mode 100644 arch/arm/mach-s5p6442/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-s5p6442/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-s5p6442/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/hardware.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/map.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/memory.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/system.h
 create mode 100644 arch/arm/mach-s5p6442/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-s5p6442/init.c
 create mode 100644 arch/arm/plat-s5p/include/plat/s5p6442.h

diff --git a/arch/arm/mach-s5p6442/Kconfig b/arch/arm/mach-s5p6442/Kconfig
new file mode 100644
index 0000000..cc9fc4f
--- /dev/null
+++ b/arch/arm/mach-s5p6442/Kconfig
@@ -0,0 +1,24 @@
+# arch/arm/mach-s5p6442/Kconfig
+#
+# Copyright (c) 2010 Samsung Electronics Co., Ltd.
+#		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+# Configuration options for the S5P6442
+
+if ARCH_S5P6442
+
+config CPU_S5P6442
+	bool
+	select PLAT_S5P
+	help
+	  Enable S5P6442 CPU support
+
+config MACH_SMDK6442
+	bool "SMDK6442"
+	select CPU_S5P6442
+	help
+	  Machine support for Samsung SMDK6442
+
+endif
diff --git a/arch/arm/mach-s5p6442/Makefile b/arch/arm/mach-s5p6442/Makefile
new file mode 100644
index 0000000..0a45d01
--- /dev/null
+++ b/arch/arm/mach-s5p6442/Makefile
@@ -0,0 +1,18 @@
+# arch/arm/mach-s5p6442/Makefile
+#
+# Copyright (c) 2010 Samsung Electronics Co., Ltd.
+# 		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:=
+obj-				:=
+
+# Core support for S5P6442 system
+
+obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o
+
+# machine support
+
diff --git a/arch/arm/mach-s5p6442/Makefile.boot b/arch/arm/mach-s5p6442/Makefile.boot
new file mode 100644
index 0000000..ff90aa1
--- /dev/null
+++ b/arch/arm/mach-s5p6442/Makefile.boot
@@ -0,0 +1,2 @@
+   zreladdr-y	:= 0x20008000
+params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-s5p6442/cpu.c b/arch/arm/mach-s5p6442/cpu.c
new file mode 100644
index 0000000..bc2524d
--- /dev/null
+++ b/arch/arm/mach-s5p6442/cpu.c
@@ -0,0 +1,121 @@
+/* linux/arch/arm/mach-s5p6442/cpu.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
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
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <asm/proc-fns.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <asm/irq.h>
+
+#include <plat/regs-serial.h>
+#include <mach/regs-clock.h>
+
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/clock.h>
+#include <plat/s5p6442.h>
+
+/* Initial IO mappings */
+
+static struct map_desc s5p6442_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
+		.pfn		= __phys_to_pfn(S5P6442_PA_SYSTIMER),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC2,
+		.pfn		= __phys_to_pfn(S5P6442_PA_VIC2),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}
+};
+
+static void s5p6442_idle(void)
+{
+	if (!need_resched())
+		cpu_do_idle();
+
+	local_irq_enable();
+}
+
+/* s5p6442_map_io
+ *
+ * register the standard cpu IO areas
+*/
+
+void __init s5p6442_map_io(void)
+{
+	iotable_init(s5p6442_iodesc, ARRAY_SIZE(s5p6442_iodesc));
+}
+
+void __init s5p6442_init_clocks(int xtal)
+{
+	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
+
+	s3c24xx_register_baseclocks(xtal);
+	s5p_register_clocks(xtal);
+	s5p6442_register_clocks();
+	s5p6442_setup_clocks();
+}
+
+void __init s5p6442_init_irq(void)
+{
+	/* S5P6442 supports 3 VIC */
+	u32 vic[3];
+
+	/* VIC0, VIC1, and VIC2: some interrupt reserved */
+	vic[0] = 0x7fefffff;
+	vic[1] = 0X7f389c81;
+	vic[2] = 0X1bbbcfff;
+
+	s5p_init_irq(vic, ARRAY_SIZE(vic));
+}
+
+static struct sysdev_class s5p6442_sysclass = {
+	.name	= "s5p6442-core",
+};
+
+static struct sys_device s5p6442_sysdev = {
+	.cls	= &s5p6442_sysclass,
+};
+
+static int __init s5p6442_core_init(void)
+{
+	return sysdev_class_register(&s5p6442_sysclass);
+}
+
+core_initcall(s5p6442_core_init);
+
+int __init s5p6442_init(void)
+{
+	printk(KERN_INFO "S5P6442: Initializing architecture\n");
+
+	/* set idle function */
+	pm_idle = s5p6442_idle;
+
+	return sysdev_register(&s5p6442_sysdev);
+}
diff --git a/arch/arm/mach-s5p6442/include/mach/debug-macro.S b/arch/arm/mach-s5p6442/include/mach/debug-macro.S
new file mode 100644
index 0000000..593a21a
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/debug-macro.S
@@ -0,0 +1,36 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/debug-macro.S
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Based on arch/arm/mach-s3c6400/include/mach/debug-macro.S
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
+	.macro addruart, rx
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1
+		ldreq	\rx, = S3C_PA_UART
+		ldrne	\rx, = S3C_VA_UART
+#if CONFIG_DEBUG_S3C_UART != 0
+		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
+#endif
+	.endm
+
+#define fifo_full fifo_full_s5pv210
+#define fifo_level fifo_level_s5pv210
+
+/* include the reset of the code which will do the work, we're only
+ * compiling for a single cpu processor type so the default of s3c2440
+ * will be fine with us.
+ */
+
+#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-s5p6442/include/mach/entry-macro.S b/arch/arm/mach-s5p6442/include/mach/entry-macro.S
new file mode 100644
index 0000000..6d574ed
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/entry-macro.S
@@ -0,0 +1,48 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/entry-macro.S
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Low-level IRQ helper macros for the Samsung S5P6442
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
+	ldr	\base, =VA_VIC0
+	.endm
+
+	.macro	arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+	@ check the vic0
+	mov	\irqnr, # S5P_IRQ_OFFSET + 31
+	ldr	\irqstat, [ \base, # VIC_IRQ_STATUS ]
+	teq	\irqstat, #0
+
+	@ otherwise try vic1
+	addeq	\tmp, \base, #(VA_VIC1 - VA_VIC0)
+	addeq	\irqnr, \irqnr, #32
+	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
+	teqeq	\irqstat, #0
+
+	@ otherwise try vic2
+	addeq	\tmp, \base, #(VA_VIC2 - VA_VIC0)
+	addeq	\irqnr, \irqnr, #32
+	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
+	teqeq	\irqstat, #0
+
+	clzne	\irqstat, \irqstat
+	subne	\irqnr, \irqnr, \irqstat
+	.endm
diff --git a/arch/arm/mach-s5p6442/include/mach/gpio.h b/arch/arm/mach-s5p6442/include/mach/gpio.h
new file mode 100644
index 0000000..b8715df
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/gpio.h
@@ -0,0 +1,123 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/gpio.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - GPIO lib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H __FILE__
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+/* GPIO bank sizes */
+#define S5P6442_GPIO_A0_NR	(8)
+#define S5P6442_GPIO_A1_NR	(2)
+#define S5P6442_GPIO_B_NR	(4)
+#define S5P6442_GPIO_C0_NR	(5)
+#define S5P6442_GPIO_C1_NR	(5)
+#define S5P6442_GPIO_D0_NR	(2)
+#define S5P6442_GPIO_D1_NR	(6)
+#define S5P6442_GPIO_E0_NR	(8)
+#define S5P6442_GPIO_E1_NR	(5)
+#define S5P6442_GPIO_F0_NR	(8)
+#define S5P6442_GPIO_F1_NR	(8)
+#define S5P6442_GPIO_F2_NR	(8)
+#define S5P6442_GPIO_F3_NR	(6)
+#define S5P6442_GPIO_G0_NR	(7)
+#define S5P6442_GPIO_G1_NR	(7)
+#define S5P6442_GPIO_G2_NR	(7)
+#define S5P6442_GPIO_H0_NR	(8)
+#define S5P6442_GPIO_H1_NR	(8)
+#define S5P6442_GPIO_H2_NR	(8)
+#define S5P6442_GPIO_H3_NR	(8)
+#define S5P6442_GPIO_J0_NR	(8)
+#define S5P6442_GPIO_J1_NR	(6)
+#define S5P6442_GPIO_J2_NR	(8)
+#define S5P6442_GPIO_J3_NR	(8)
+#define S5P6442_GPIO_J4_NR	(5)
+
+/* GPIO bank numbers */
+
+/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
+ * space for debugging purposes so that any accidental
+ * change from one gpio bank to another can be caught.
+*/
+
+#define S5P6442_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5p_gpio_number {
+	S5P6442_GPIO_A0_START	= 0,
+	S5P6442_GPIO_A1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_A0),
+	S5P6442_GPIO_B_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_A1),
+	S5P6442_GPIO_C0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_B),
+	S5P6442_GPIO_C1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_C0),
+	S5P6442_GPIO_D0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_C1),
+	S5P6442_GPIO_D1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_D0),
+	S5P6442_GPIO_E0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_D1),
+	S5P6442_GPIO_E1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_E0),
+	S5P6442_GPIO_F0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_E1),
+	S5P6442_GPIO_F1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_F0),
+	S5P6442_GPIO_F2_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_F1),
+	S5P6442_GPIO_F3_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_F2),
+	S5P6442_GPIO_G0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_F3),
+	S5P6442_GPIO_G1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_G0),
+	S5P6442_GPIO_G2_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_G1),
+	S5P6442_GPIO_H0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_G2),
+	S5P6442_GPIO_H1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_H0),
+	S5P6442_GPIO_H2_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_H1),
+	S5P6442_GPIO_H3_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_H2),
+	S5P6442_GPIO_J0_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_H3),
+	S5P6442_GPIO_J1_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_J0),
+	S5P6442_GPIO_J2_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_J1),
+	S5P6442_GPIO_J3_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_J2),
+	S5P6442_GPIO_J4_START	= S5P6442_GPIO_NEXT(S5P6442_GPIO_J3),
+};
+
+/* S5P6442 GPIO number definitions. */
+#define S5P6442_GPA0(_nr)	(S5P6442_GPIO_A0_START + (_nr))
+#define S5P6442_GPA1(_nr)	(S5P6442_GPIO_A1_START + (_nr))
+#define S5P6442_GPB(_nr)	(S5P6442_GPIO_B_START + (_nr))
+#define S5P6442_GPC0(_nr)	(S5P6442_GPIO_C0_START + (_nr))
+#define S5P6442_GPC1(_nr)	(S5P6442_GPIO_C1_START + (_nr))
+#define S5P6442_GPD0(_nr)	(S5P6442_GPIO_D0_START + (_nr))
+#define S5P6442_GPD1(_nr)	(S5P6442_GPIO_D1_START + (_nr))
+#define S5P6442_GPE0(_nr)	(S5P6442_GPIO_E0_START + (_nr))
+#define S5P6442_GPE1(_nr)	(S5P6442_GPIO_E1_START + (_nr))
+#define S5P6442_GPF0(_nr)	(S5P6442_GPIO_F0_START + (_nr))
+#define S5P6442_GPF1(_nr)	(S5P6442_GPIO_F1_START + (_nr))
+#define S5P6442_GPF2(_nr)	(S5P6442_GPIO_F2_START + (_nr))
+#define S5P6442_GPF3(_nr)	(S5P6442_GPIO_F3_START + (_nr))
+#define S5P6442_GPG0(_nr)	(S5P6442_GPIO_G0_START + (_nr))
+#define S5P6442_GPG1(_nr)	(S5P6442_GPIO_G1_START + (_nr))
+#define S5P6442_GPG2(_nr)	(S5P6442_GPIO_G2_START + (_nr))
+#define S5P6442_GPH0(_nr)	(S5P6442_GPIO_H0_START + (_nr))
+#define S5P6442_GPH1(_nr)	(S5P6442_GPIO_H1_START + (_nr))
+#define S5P6442_GPH2(_nr)	(S5P6442_GPIO_H2_START + (_nr))
+#define S5P6442_GPH3(_nr)	(S5P6442_GPIO_H3_START + (_nr))
+#define S5P6442_GPJ0(_nr)	(S5P6442_GPIO_J0_START + (_nr))
+#define S5P6442_GPJ1(_nr)	(S5P6442_GPIO_J1_START + (_nr))
+#define S5P6442_GPJ2(_nr)	(S5P6442_GPIO_J2_START + (_nr))
+#define S5P6442_GPJ3(_nr)	(S5P6442_GPIO_J3_START + (_nr))
+#define S5P6442_GPJ4(_nr)	(S5P6442_GPIO_J4_START + (_nr))
+
+/* the end of the S5P6442 specific gpios */
+#define S5P6442_GPIO_END	(S5P6442_GPJ4(S5P6442_GPIO_J4_NR) + 1)
+#define S3C_GPIO_END		S5P6442_GPIO_END
+
+/* define the number of gpios we need to the one after the GPJ4() range */
+#define ARCH_NR_GPIOS		(S5P6442_GPJ4(S5P6442_GPIO_J4_NR) +	\
+				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
+
+#include <asm-generic/gpio.h>
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/hardware.h b/arch/arm/mach-s5p6442/include/mach/hardware.h
new file mode 100644
index 0000000..8cd7b67
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/hardware.h
@@ -0,0 +1,18 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/hardware.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - Hardware support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H __FILE__
+
+/* currently nothing here, placeholder */
+
+#endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/map.h b/arch/arm/mach-s5p6442/include/mach/map.h
new file mode 100644
index 0000000..07d22e9
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/map.h
@@ -0,0 +1,58 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/map.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - Memory map definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MAP_H
+#define __ASM_ARCH_MAP_H __FILE__
+
+#include <plat/map-base.h>
+#include <plat/map-s5p.h>
+
+#define S5P6442_PA_CHIPID	(0xE0000000)
+#define S5P_PA_CHIPID		S5P6442_PA_CHIPID
+
+#define S5P6442_PA_SYSCON	(0xE0100000)
+#define S5P_PA_SYSCON		S5P6442_PA_SYSCON
+
+#define S5P6442_PA_GPIO		(0xE0200000)
+#define S5P_PA_GPIO		S5P6442_PA_GPIO
+
+#define S5P6442_PA_VIC0		(0xE4000000)
+#define S5P_PA_VIC0		S5P6442_PA_VIC0
+
+#define S5P6442_PA_VIC1		(0xE4100000)
+#define S5P_PA_VIC1		S5P6442_PA_VIC1
+
+#define S5P6442_PA_VIC2		(0xE4200000)
+#define S5P_PA_VIC2		S5P6442_PA_VIC2
+
+#define S5P6442_PA_TIMER	(0xEA000000)
+#define S5P_PA_TIMER		S5P6442_PA_TIMER
+
+#define S5P6442_PA_SYSTIMER   	(0xEA100000)
+
+#define S5P6442_PA_UART		(0xEC000000)
+
+#define S5P_PA_UART0		(S5P6442_PA_UART + 0x0)
+#define S5P_PA_UART1		(S5P6442_PA_UART + 0x400)
+#define S5P_PA_UART2		(S5P6442_PA_UART + 0x800)
+#define S5P_SZ_UART		SZ_256
+
+#define S5P6442_PA_IIC0		(0xEC100000)
+
+#define S5P6442_PA_SDRAM	(0x20000000)
+#define S5P_PA_SDRAM		S5P6442_PA_SDRAM
+
+/* compatibiltiy defines. */
+#define S3C_PA_UART		S5P6442_PA_UART
+#define S3C_PA_IIC		S5P6442_PA_IIC0
+
+#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/memory.h b/arch/arm/mach-s5p6442/include/mach/memory.h
new file mode 100644
index 0000000..9ddd877
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/memory.h
@@ -0,0 +1,19 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/memory.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - Memory definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+#define PHYS_OFFSET		UL(0x20000000)
+#define CONSISTENT_DMA_SIZE	SZ_8M
+
+#endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/system.h b/arch/arm/mach-s5p6442/include/mach/system.h
new file mode 100644
index 0000000..8bcd8ed
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/system.h
@@ -0,0 +1,26 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/system.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - system support header
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H __FILE__
+
+static void arch_idle(void)
+{
+	/* nothing here yet */
+}
+
+static void arch_reset(char mode, const char *cmd)
+{
+	/* nothing here yet */
+}
+
+#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/uncompress.h b/arch/arm/mach-s5p6442/include/mach/uncompress.h
new file mode 100644
index 0000000..5ac7cbe
--- /dev/null
+++ b/arch/arm/mach-s5p6442/include/mach/uncompress.h
@@ -0,0 +1,24 @@
+/* linux/arch/arm/mach-s5p6442/include/mach/uncompress.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6442 - uncompress code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_UNCOMPRESS_H
+#define __ASM_ARCH_UNCOMPRESS_H
+
+#include <mach/map.h>
+#include <plat/uncompress.h>
+
+static void arch_detect_cpu(void)
+{
+	/* we do not need to do any cpu detection here at the moment. */
+}
+
+#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5p6442/init.c b/arch/arm/mach-s5p6442/init.c
new file mode 100644
index 0000000..1874bdb
--- /dev/null
+++ b/arch/arm/mach-s5p6442/init.c
@@ -0,0 +1,44 @@
+/* linux/arch/arm/mach-s5p6442/s5p6442-init.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/s5p6442.h>
+#include <plat/regs-serial.h>
+
+static struct s3c24xx_uart_clksrc s5p6442_serial_clocks[] = {
+	[0] = {
+		.name		= "pclk",
+		.divisor	= 1,
+		.min_baud	= 0,
+		.max_baud	= 0,
+	},
+};
+
+/* uart registration process */
+void __init s5p6442_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	struct s3c2410_uartcfg *tcfg = cfg;
+	u32 ucnt;
+
+	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
+		if (!tcfg->clocks) {
+			tcfg->clocks = s5p6442_serial_clocks;
+			tcfg->clocks_size = ARRAY_SIZE(s5p6442_serial_clocks);
+		}
+	}
+
+	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
+}
diff --git a/arch/arm/plat-s3c/include/plat/debug-macro.S b/arch/arm/plat-s3c/include/plat/debug-macro.S
index 3634d4e..cbde9f1 100644
--- a/arch/arm/plat-s3c/include/plat/debug-macro.S
+++ b/arch/arm/plat-s3c/include/plat/debug-macro.S
@@ -11,6 +11,18 @@
 
 #include <plat/regs-serial.h>
 
+/* The S5PV210/S5PC110 and S5P6442 implementations are as belows. */
+
+	.macro fifo_level_s5pv210 rd, rx
+		ldr	\rd, [ \rx, # S3C2410_UFSTAT ]
+		and	\rd, \rd, #S5PV210_UFSTAT_TXMASK
+	.endm
+
+	.macro  fifo_full_s5pv210 rd, rx
+		ldr	\rd, [ \rx, # S3C2410_UFSTAT ]
+		tst	\rd, #S5PV210_UFSTAT_TXFULL
+	.endm
+
 /* The S3C2440 implementations are used by default as they are the
  * most widely re-used */
 
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index ee9c6b3..e699924 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -18,10 +18,12 @@
 #include <mach/regs-clock.h>
 #include <plat/cpu.h>
 #include <plat/s5p6440.h>
+#include <plat/s5p6442.h>
 
 /* table of supported CPUs */
 
 static const char name_s5p6440[] = "S5P6440";
+static const char name_s5p6442[] = "S5P6442";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -32,6 +34,14 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init_uarts	= s5p6440_init_uarts,
 		.init		= s5p6440_init,
 		.name		= name_s5p6440,
+	}, {
+		.idcode		= 0x36442000,
+		.idmask		= 0xffffff00,
+		.map_io		= s5p6442_map_io,
+		.init_clocks	= s5p6442_init_clocks,
+		.init_uarts	= s5p6442_init_uarts,
+		.init		= s5p6442_init,
+		.name		= name_s5p6442,
 	},
 };
 
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 51d9cb5..cc60604 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -28,5 +28,6 @@
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
 #define VA_VIC1			VA_VIC(1)
+#define VA_VIC2			VA_VIC(2)
 
 #endif /* __ASM_PLAT_MAP_S5P_H */
diff --git a/arch/arm/plat-s5p/include/plat/s5p6442.h b/arch/arm/plat-s5p/include/plat/s5p6442.h
new file mode 100644
index 0000000..1f49ef7
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/s5p6442.h
@@ -0,0 +1,33 @@
+/* arch/arm/plat-s5p/include/plat/s5p6442.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Header file for s5p6442 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* Common init code for S5P6442 related SoCs */
+
+extern void s5p6442_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern void s5p6442_register_clocks(void);
+extern void s5p6442_setup_clocks(void);
+
+#ifdef CONFIG_CPU_S5P6442
+
+extern  int s5p6442_init(void);
+extern void s5p6442_init_irq(void);
+extern void s5p6442_map_io(void);
+extern void s5p6442_init_clocks(int xtal);
+
+#define s5p6442_init_uarts s5p6442_common_init_uarts
+
+#else
+#define s5p6442_init_clocks NULL
+#define s5p6442_init_uarts NULL
+#define s5p6442_map_io NULL
+#define s5p6442_init NULL
+#endif
-- 
1.6.2.5
