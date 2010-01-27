From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 27 Jan 2010 19:03:48 +0900
Subject: [PATCH v4 1/8] ARM: S5PV210: Add Samsung S5PV210 CPU support
Message-ID: <1264586628-22862-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Samsung S5PV210 CPU. This patch also adds
an entry for S5PV210 cpu in plat-s5p cpu table.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig                    |   40 +++++++
 arch/arm/mach-s5pv210/Makefile                   |   18 +++
 arch/arm/mach-s5pv210/Makefile.boot              |    2 +
 arch/arm/mach-s5pv210/cpu.c                      |  126 +++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/debug-macro.S |   42 +++++++
 arch/arm/mach-s5pv210/include/mach/entry-macro.S |   54 +++++++++
 arch/arm/mach-s5pv210/include/mach/gpio.h        |  129 ++++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/hardware.h    |   18 +++
 arch/arm/mach-s5pv210/include/mach/map.h         |   65 +++++++++++
 arch/arm/mach-s5pv210/include/mach/memory.h      |   23 ++++
 arch/arm/mach-s5pv210/include/mach/system.h      |   26 +++++
 arch/arm/mach-s5pv210/include/mach/uncompress.h  |   24 ++++
 arch/arm/mach-s5pv210/init.c                     |   44 ++++++++
 arch/arm/plat-s3c/include/plat/debug-macro.S     |   12 ++
 arch/arm/plat-s5p/cpu.c                          |   10 ++
 arch/arm/plat-s5p/include/plat/map-s5p.h         |    2 +
 arch/arm/plat-s5p/include/plat/s5pv210.h         |   33 ++++++
 17 files changed, 668 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/Kconfig
 create mode 100644 arch/arm/mach-s5pv210/Makefile
 create mode 100644 arch/arm/mach-s5pv210/Makefile.boot
 create mode 100644 arch/arm/mach-s5pv210/cpu.c
 create mode 100644 arch/arm/mach-s5pv210/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-s5pv210/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-s5pv210/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/hardware.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/map.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/memory.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/system.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-s5pv210/init.c
 create mode 100644 arch/arm/plat-s5p/include/plat/s5pv210.h

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
new file mode 100644
index 0000000..af33a1a
--- /dev/null
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -0,0 +1,40 @@
+# arch/arm/mach-s5pv210/Kconfig
+#
+# Copyright (c) 2010 Samsung Electronics Co., Ltd.
+#		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+# Configuration options for the S5PV210/S5PC110
+
+if ARCH_S5PV210
+
+config CPU_S5PV210
+	bool
+	select PLAT_S5P
+	help
+	  Enable S5PV210 CPU support
+
+choice
+	prompt "Select machine type"
+	depends on ARCH_S5PV210
+	default MACH_SMDKV210
+
+config MACH_SMDKV210
+	bool "SMDKV210"
+	select CPU_S5PV210
+	select ARCH_SPARSEMEM_ENABLE
+	help
+	  Machine support for Samsung SMDKV210
+
+config MACH_SMDKC110
+	bool "SMDKC110"
+	select CPU_S5PV210
+	select ARCH_SPARSEMEM_ENABLE
+	help
+	  Machine support for Samsung SMDKC110
+	  S5PC110(MCP) is one of package option of S5PV210
+
+endchoice
+
+endif
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
new file mode 100644
index 0000000..a76adc8
--- /dev/null
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -0,0 +1,18 @@
+# arch/arm/mach-s5pv210/Makefile
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
+# Core support for S5PV210 system
+
+obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o
+
+# machine support
+
diff --git a/arch/arm/mach-s5pv210/Makefile.boot b/arch/arm/mach-s5pv210/Makefile.boot
new file mode 100644
index 0000000..ff90aa1
--- /dev/null
+++ b/arch/arm/mach-s5pv210/Makefile.boot
@@ -0,0 +1,2 @@
+   zreladdr-y	:= 0x20008000
+params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
new file mode 100644
index 0000000..0e0f8fd
--- /dev/null
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -0,0 +1,126 @@
+/* linux/arch/arm/mach-s5pv210/cpu.c
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
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/sysdev.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <asm/proc-fns.h>
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/clock.h>
+#include <plat/s5pv210.h>
+
+/* Initial IO mappings */
+
+static struct map_desc s5pv210_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
+		.pfn		= __phys_to_pfn(S5PV210_PA_SYSTIMER),
+		.length		= SZ_1M,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC2,
+		.pfn		= __phys_to_pfn(S5PV210_PA_VIC2),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)VA_VIC3,
+		.pfn		= __phys_to_pfn(S5PV210_PA_VIC3),
+		.length		= SZ_16K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_SROMC,
+		.pfn		= __phys_to_pfn(S5PV210_PA_SROMC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}
+};
+
+static void s5pv210_idle(void)
+{
+	if (!need_resched())
+		cpu_do_idle();
+
+	local_irq_enable();
+}
+
+/* s5pv210_map_io
+ *
+ * register the standard cpu IO areas
+*/
+
+void __init s5pv210_map_io(void)
+{
+	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
+}
+
+void __init s5pv210_init_clocks(int xtal)
+{
+	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
+
+	s3c24xx_register_baseclocks(xtal);
+	s5p_register_clocks(xtal);
+	s5pv210_register_clocks();
+	s5pv210_setup_clocks();
+}
+
+void __init s5pv210_init_irq(void)
+{
+	u32 vic[4];	/* S5PV210 supports 4 VIC */
+
+	/* All the VICs are fully populated. */
+	vic[0] = ~0;
+	vic[1] = ~0;
+	vic[2] = ~0;
+	vic[3] = ~0;
+
+	s5p_init_irq(vic, ARRAY_SIZE(vic));
+}
+
+static struct sysdev_class s5pv210_sysclass = {
+	.name	= "s5pv210-core",
+};
+
+static struct sys_device s5pv210_sysdev = {
+	.cls	= &s5pv210_sysclass,
+};
+
+static int __init s5pv210_core_init(void)
+{
+	return sysdev_class_register(&s5pv210_sysclass);
+}
+
+core_initcall(s5pv210_core_init);
+
+int __init s5pv210_init(void)
+{
+	printk(KERN_INFO "S5PV210: Initializing architecture\n");
+
+	/* set idle function */
+	pm_idle = s5pv210_idle;
+
+	return sysdev_register(&s5pv210_sysdev);
+}
diff --git a/arch/arm/mach-s5pv210/include/mach/debug-macro.S b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
new file mode 100644
index 0000000..8aec853
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/debug-macro.S
@@ -0,0 +1,42 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/debug-macro.S
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
diff --git a/arch/arm/mach-s5pv210/include/mach/entry-macro.S b/arch/arm/mach-s5pv210/include/mach/entry-macro.S
new file mode 100644
index 0000000..3aa41ac
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/entry-macro.S
@@ -0,0 +1,54 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/entry-macro.S
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Low-level IRQ helper macros for the Samsung S5PV210
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
+	@ otherwise try vic3
+	addeq	\tmp, \base, #(VA_VIC3 - VA_VIC0)
+	addeq	\irqnr, \irqnr, #32
+	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
+	teqeq	\irqstat, #0
+
+	clzne	\irqstat, \irqstat
+	subne	\irqnr, \irqnr, \irqstat
+	.endm
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
new file mode 100644
index 0000000..533b020
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
@@ -0,0 +1,129 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/gpio.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - GPIO lib support
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
+#define S5PV210_GPIO_A0_NR	(8)
+#define S5PV210_GPIO_A1_NR	(4)
+#define S5PV210_GPIO_B_NR	(8)
+#define S5PV210_GPIO_C0_NR	(5)
+#define S5PV210_GPIO_C1_NR	(5)
+#define S5PV210_GPIO_D0_NR	(4)
+#define S5PV210_GPIO_D1_NR	(6)
+#define S5PV210_GPIO_E0_NR	(8)
+#define S5PV210_GPIO_E1_NR	(5)
+#define S5PV210_GPIO_F0_NR	(8)
+#define S5PV210_GPIO_F1_NR	(8)
+#define S5PV210_GPIO_F2_NR	(8)
+#define S5PV210_GPIO_F3_NR	(6)
+#define S5PV210_GPIO_G0_NR	(7)
+#define S5PV210_GPIO_G1_NR	(7)
+#define S5PV210_GPIO_G2_NR	(7)
+#define S5PV210_GPIO_G3_NR	(7)
+#define S5PV210_GPIO_H0_NR	(8)
+#define S5PV210_GPIO_H1_NR	(8)
+#define S5PV210_GPIO_H2_NR	(8)
+#define S5PV210_GPIO_H3_NR	(8)
+#define S5PV210_GPIO_I_NR	(7)
+#define S5PV210_GPIO_J0_NR	(8)
+#define S5PV210_GPIO_J1_NR	(6)
+#define S5PV210_GPIO_J2_NR	(8)
+#define S5PV210_GPIO_J3_NR	(8)
+#define S5PV210_GPIO_J4_NR	(5)
+
+/* GPIO bank numbers */
+
+/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
+ * space for debugging purposes so that any accidental
+ * change from one gpio bank to another can be caught.
+*/
+
+#define S5PV210_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5p_gpio_number {
+	S5PV210_GPIO_A0_START	= 0,
+	S5PV210_GPIO_A1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_A0),
+	S5PV210_GPIO_B_START 	= S5PV210_GPIO_NEXT(S5PV210_GPIO_A1),
+	S5PV210_GPIO_C0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_B),
+	S5PV210_GPIO_C1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_C0),
+	S5PV210_GPIO_D0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_C1),
+	S5PV210_GPIO_D1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_D0),
+	S5PV210_GPIO_E0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_D1),
+	S5PV210_GPIO_E1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_E0),
+	S5PV210_GPIO_F0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_E1),
+	S5PV210_GPIO_F1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F0),
+	S5PV210_GPIO_F2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F1),
+	S5PV210_GPIO_F3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F2),
+	S5PV210_GPIO_G0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_F3),
+	S5PV210_GPIO_G1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G0),
+	S5PV210_GPIO_G2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G1),
+	S5PV210_GPIO_G3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G2),
+	S5PV210_GPIO_H0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_G3),
+	S5PV210_GPIO_H1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H0),
+	S5PV210_GPIO_H2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H1),
+	S5PV210_GPIO_H3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H2),
+	S5PV210_GPIO_I_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_H3),
+	S5PV210_GPIO_J0_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_I),
+	S5PV210_GPIO_J1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J0),
+	S5PV210_GPIO_J2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J1),
+	S5PV210_GPIO_J3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J2),
+	S5PV210_GPIO_J4_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J3),
+};
+
+/* S5PV210 GPIO number definitions */
+#define S5PV210_GPA0(_nr)	(S5PV210_GPIO_A0_START + (_nr))
+#define S5PV210_GPA1(_nr)	(S5PV210_GPIO_A1_START + (_nr))
+#define S5PV210_GPB(_nr)	(S5PV210_GPIO_B_START + (_nr))
+#define S5PV210_GPC0(_nr)	(S5PV210_GPIO_C0_START + (_nr))
+#define S5PV210_GPC1(_nr)	(S5PV210_GPIO_C1_START + (_nr))
+#define S5PV210_GPD0(_nr)	(S5PV210_GPIO_D0_START + (_nr))
+#define S5PV210_GPD1(_nr)	(S5PV210_GPIO_D1_START + (_nr))
+#define S5PV210_GPE0(_nr)	(S5PV210_GPIO_E0_START + (_nr))
+#define S5PV210_GPE1(_nr)	(S5PV210_GPIO_E1_START + (_nr))
+#define S5PV210_GPF0(_nr)	(S5PV210_GPIO_F0_START + (_nr))
+#define S5PV210_GPF1(_nr)	(S5PV210_GPIO_F1_START + (_nr))
+#define S5PV210_GPF2(_nr)	(S5PV210_GPIO_F2_START + (_nr))
+#define S5PV210_GPF3(_nr)	(S5PV210_GPIO_F3_START + (_nr))
+#define S5PV210_GPG0(_nr)	(S5PV210_GPIO_G0_START + (_nr))
+#define S5PV210_GPG1(_nr)	(S5PV210_GPIO_G1_START + (_nr))
+#define S5PV210_GPG2(_nr)	(S5PV210_GPIO_G2_START + (_nr))
+#define S5PV210_GPG3(_nr)	(S5PV210_GPIO_G3_START + (_nr))
+#define S5PV210_GPH0(_nr)	(S5PV210_GPIO_H0_START + (_nr))
+#define S5PV210_GPH1(_nr)	(S5PV210_GPIO_H1_START + (_nr))
+#define S5PV210_GPH2(_nr)	(S5PV210_GPIO_H2_START + (_nr))
+#define S5PV210_GPH3(_nr)	(S5PV210_GPIO_H3_START + (_nr))
+#define S5PV210_GPI(_nr)	(S5PV210_GPIO_I_START + (_nr))
+#define S5PV210_GPJ0(_nr)	(S5PV210_GPIO_J0_START + (_nr))
+#define S5PV210_GPJ1(_nr)	(S5PV210_GPIO_J1_START + (_nr))
+#define S5PV210_GPJ2(_nr)	(S5PV210_GPIO_J2_START + (_nr))
+#define S5PV210_GPJ3(_nr)	(S5PV210_GPIO_J3_START + (_nr))
+#define S5PV210_GPJ4(_nr)	(S5PV210_GPIO_J4_START + (_nr))
+
+/* the end of the S5PV210 specific gpios */
+#define S5PV210_GPIO_END	(S5PV210_GPJ4(S5PV210_GPIO_J4_NR) + 1)
+#define S3C_GPIO_END		S5PV210_GPIO_END
+
+/* define the number of gpios we need to the one after the GPJ4() range */
+#define ARCH_NR_GPIOS		(S5PV210_GPJ4(S5PV210_GPIO_J4_NR) +	\
+				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
+
+#include <asm-generic/gpio.h>
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/hardware.h b/arch/arm/mach-s5pv210/include/mach/hardware.h
new file mode 100644
index 0000000..fada7a3
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/hardware.h
@@ -0,0 +1,18 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/hardware.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - Hardware support
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
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
new file mode 100644
index 0000000..c22694c
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -0,0 +1,65 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/map.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - Memory map definitions
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
+#define S5PV210_PA_CHIPID	(0xE0000000)
+#define S5P_PA_CHIPID		S5PV210_PA_CHIPID
+
+#define S5PV210_PA_SYSCON	(0xE0100000)
+#define S5P_PA_SYSCON		S5PV210_PA_SYSCON
+
+#define S5PV210_PA_GPIO		(0xE0200000)
+#define S5P_PA_GPIO		S5PV210_PA_GPIO
+
+#define S5PV210_PA_IIC0		(0xE1800000)
+
+#define S5PV210_PA_TIMER	(0xE2500000)
+#define S5P_PA_TIMER		S5PV210_PA_TIMER
+
+#define S5PV210_PA_SYSTIMER	(0xE2600000)
+
+#define S5PV210_PA_UART		(0xE2900000)
+
+#define S5P_PA_UART0		(S5PV210_PA_UART + 0x0)
+#define S5P_PA_UART1		(S5PV210_PA_UART + 0x400)
+#define S5P_PA_UART2		(S5PV210_PA_UART + 0x800)
+#define S5P_PA_UART3		(S5PV210_PA_UART + 0xC00)
+
+#define S5P_SZ_UART		SZ_256
+
+#define S5PV210_PA_SROMC	(0xE8000000)
+
+#define S5PV210_PA_VIC0		(0xF2000000)
+#define S5P_PA_VIC0		S5PV210_PA_VIC0
+
+#define S5PV210_PA_VIC1		(0xF2100000)
+#define S5P_PA_VIC1		S5PV210_PA_VIC1
+
+#define S5PV210_PA_VIC2		(0xF2200000)
+#define S5P_PA_VIC2		S5PV210_PA_VIC2
+
+#define S5PV210_PA_VIC3		(0xF2300000)
+#define S5P_PA_VIC3		S5PV210_PA_VIC3
+
+#define S5PV210_PA_SDRAM	(0x20000000)
+#define S5P_PA_SDRAM		S5PV210_PA_SDRAM
+
+/* compatibiltiy defines. */
+#define S3C_PA_UART		S5PV210_PA_UART
+#define S3C_PA_IIC		S5PV210_PA_IIC0
+
+#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/memory.h b/arch/arm/mach-s5pv210/include/mach/memory.h
new file mode 100644
index 0000000..379117e
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/memory.h
@@ -0,0 +1,23 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/memory.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - Memory definitions
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
+#define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
+
+/* Maximum of 256MiB in one bank */
+#define MAX_PHYSMEM_BITS	32
+#define SECTION_SIZE_BITS	28
+
+#endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/system.h b/arch/arm/mach-s5pv210/include/mach/system.h
new file mode 100644
index 0000000..1ca04d5
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/system.h
@@ -0,0 +1,26 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/system.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - system support header
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
diff --git a/arch/arm/mach-s5pv210/include/mach/uncompress.h b/arch/arm/mach-s5pv210/include/mach/uncompress.h
new file mode 100644
index 0000000..08ff2fd
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/uncompress.h
@@ -0,0 +1,24 @@
+/* linux/arch/arm/mach-s5pv210/include/mach/uncompress.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - uncompress code
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
diff --git a/arch/arm/mach-s5pv210/init.c b/arch/arm/mach-s5pv210/init.c
new file mode 100644
index 0000000..4865ae2
--- /dev/null
+++ b/arch/arm/mach-s5pv210/init.c
@@ -0,0 +1,44 @@
+/* linux/arch/arm/mach-s5pv210/init.c
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
+#include <plat/s5pv210.h>
+#include <plat/regs-serial.h>
+
+static struct s3c24xx_uart_clksrc s5pv210_serial_clocks[] = {
+	[0] = {
+		.name		= "pclk",
+		.divisor	= 1,
+		.min_baud	= 0,
+		.max_baud	= 0,
+	},
+};
+
+/* uart registration process */
+void __init s5pv210_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	struct s3c2410_uartcfg *tcfg = cfg;
+	u32 ucnt;
+
+	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
+		if (!tcfg->clocks) {
+			tcfg->clocks = s5pv210_serial_clocks;
+			tcfg->clocks_size = ARRAY_SIZE(s5pv210_serial_clocks);
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
index ee9c6b3..787b48d 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -18,10 +18,12 @@
 #include <mach/regs-clock.h>
 #include <plat/cpu.h>
 #include <plat/s5p6440.h>
+#include <plat/s5pv210.h>
 
 /* table of supported CPUs */
 
 static const char name_s5p6440[] = "S5P6440";
+static const char name_s5pv210[] = "S5PV210/S5PC110";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -32,6 +34,14 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init_uarts	= s5p6440_init_uarts,
 		.init		= s5p6440_init,
 		.name		= name_s5p6440,
+	}, {
+		.idcode		= 0x43110000,
+		.idmask		= 0xfffff000,
+		.map_io		= s5pv210_map_io,
+		.init_clocks	= s5pv210_init_clocks,
+		.init_uarts	= s5pv210_init_uarts,
+		.init		= s5pv210_init,
+		.name		= name_s5pv210,
 	},
 };
 
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 51d9cb5..1482852 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -28,5 +28,7 @@
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
 #define VA_VIC1			VA_VIC(1)
+#define VA_VIC2			VA_VIC(2)
+#define VA_VIC3			VA_VIC(3)
 
 #endif /* __ASM_PLAT_MAP_S5P_H */
diff --git a/arch/arm/plat-s5p/include/plat/s5pv210.h b/arch/arm/plat-s5p/include/plat/s5pv210.h
new file mode 100644
index 0000000..6c93a0c
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/s5pv210.h
@@ -0,0 +1,33 @@
+/* linux/arch/arm/plat-s5p/include/plat/s5pv210.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Header file for s5pv210 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* Common init code for S5PV210 related SoCs */
+
+extern void s5pv210_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern void s5pv210_register_clocks(void);
+extern void s5pv210_setup_clocks(void);
+
+#ifdef CONFIG_CPU_S5PV210
+
+extern  int s5pv210_init(void);
+extern void s5pv210_init_irq(void);
+extern void s5pv210_map_io(void);
+extern void s5pv210_init_clocks(int xtal);
+
+#define s5pv210_init_uarts s5pv210_common_init_uarts
+
+#else
+#define s5pv210_init_clocks NULL
+#define s5pv210_init_uarts NULL
+#define s5pv210_map_io NULL
+#define s5pv210_init NULL
+#endif
-- 
1.6.2.5
