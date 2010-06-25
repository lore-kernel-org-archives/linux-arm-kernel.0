From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 23:27:11 +0900
Subject: [PATCH 2/8] ARM: S5PV310: Add new CPU initialization support
In-Reply-To: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277476037-8806-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds Samsung's S5PV310/S5PC210 CPU support.
The S5PV310/S5PC210 integrates a ARM Cortex A9 multi-core.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/cpu.c                      |  123 +++++++++++++
 arch/arm/mach-s5pv310/headsmp.S                  |   41 ++++
 arch/arm/mach-s5pv310/include/mach/debug-macro.S |   36 ++++
 arch/arm/mach-s5pv310/include/mach/entry-macro.S |   84 +++++++++
 arch/arm/mach-s5pv310/include/mach/gpio.h        |  135 ++++++++++++++
 arch/arm/mach-s5pv310/include/mach/hardware.h    |   18 ++
 arch/arm/mach-s5pv310/include/mach/io.h          |   26 +++
 arch/arm/mach-s5pv310/include/mach/map.h         |   63 +++++++
 arch/arm/mach-s5pv310/include/mach/memory.h      |   22 +++
 arch/arm/mach-s5pv310/include/mach/smp.h         |   29 +++
 arch/arm/mach-s5pv310/include/mach/system.h      |   22 +++
 arch/arm/mach-s5pv310/include/mach/timex.h       |   29 +++
 arch/arm/mach-s5pv310/include/mach/uncompress.h  |   27 +++
 arch/arm/mach-s5pv310/include/mach/vmalloc.h     |   22 +++
 arch/arm/mach-s5pv310/init.c                     |   40 ++++
 arch/arm/mach-s5pv310/platsmp.c                  |  212 ++++++++++++++++++++++
 arch/arm/mach-s5pv310/setup-i2c0.c               |   20 ++
 arch/arm/plat-s5p/cpu.c                          |   12 ++
 arch/arm/plat-s5p/include/plat/map-s5p.h         |   12 ++
 arch/arm/plat-s5p/include/plat/s5pv310.h         |   33 ++++
 20 files changed, 1006 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/cpu.c
 create mode 100644 arch/arm/mach-s5pv310/headsmp.S
 create mode 100644 arch/arm/mach-s5pv310/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-s5pv310/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-s5pv310/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/hardware.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/io.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/map.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/memory.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/smp.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/system.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/timex.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-s5pv310/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-s5pv310/init.c
 create mode 100644 arch/arm/mach-s5pv310/platsmp.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c0.c
 create mode 100644 arch/arm/plat-s5p/include/plat/s5pv310.h

diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
new file mode 100644
index 0000000..ac7a5e8
--- /dev/null
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -0,0 +1,123 @@
+/* linux/arch/arm/mach-s5pv310/cpu.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/sched.h>
+#include <linux/sysdev.h>
+
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <asm/proc-fns.h>
+
+#include <plat/cpu.h>
+#include <plat/clock.h>
+#include <plat/s5pv310.h>
+
+#include <mach/regs-irq.h>
+
+void __iomem *gic_cpu_base_addr;
+
+extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
+			 unsigned int irq_start);
+extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq);
+
+/* Initial IO mappings */
+static struct map_desc s5pv310_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_COREPERI_BASE,
+		.pfn		= __phys_to_pfn(S5PV310_PA_COREPERI),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
+		.pfn		= __phys_to_pfn(S5PV310_PA_COMBINER),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_L2CC,
+		.pfn		= __phys_to_pfn(S5PV310_PA_L2CC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static void s5pv310_idle(void)
+{
+	if (!need_resched())
+		cpu_do_idle();
+
+	local_irq_enable();
+}
+
+/* s5pv310_map_io
+ *
+ * register the standard cpu IO areas
+*/
+void __init s5pv310_map_io(void)
+{
+	iotable_init(s5pv310_iodesc, ARRAY_SIZE(s5pv310_iodesc));
+}
+
+void __init s5pv310_init_clocks(int xtal)
+{
+	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
+
+	s3c24xx_register_baseclocks(xtal);
+	s5p_register_clocks(xtal);
+	s5pv310_register_clocks();
+	s5pv310_setup_clocks();
+}
+
+void __init s5pv310_init_irq(void)
+{
+	int irq;
+
+	gic_cpu_base_addr = S5P_VA_GIC_CPU;
+	gic_dist_init(0, S5P_VA_GIC_DIST, IRQ_LOCALTIMER);
+	gic_cpu_init(0, S5P_VA_GIC_CPU);
+
+	for (irq = 0; irq < MAX_COMBINER_NR; irq++)
+		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
+			      COMBINER_IRQ(irq, 0));
+
+	for (irq = 0; irq < MAX_COMBINER_NR; irq++)
+		combiner_cascade_irq(irq, IRQ_SPI(irq));
+
+	/* The parameters of s5p_init_irq() are for VIC init.
+	 * Theses parameters should be NULL and 0 because S5PV310
+	 * uses GIC instead of VIC.
+	 */
+	s5p_init_irq(NULL, 0);
+}
+
+struct sysdev_class s5pv310_sysclass = {
+	.name	= "s5pv310-core",
+};
+
+static struct sys_device s5pv310_sysdev = {
+	.cls	= &s5pv310_sysclass,
+};
+
+static int __init s5pv310_core_init(void)
+{
+	return sysdev_class_register(&s5pv310_sysclass);
+}
+
+core_initcall(s5pv310_core_init);
+
+int __init s5pv310_init(void)
+{
+	printk(KERN_INFO "S5PV310: Initializing architecture\n");
+
+	/* set idle function */
+	pm_idle = s5pv310_idle;
+
+	return sysdev_register(&s5pv310_sysdev);
+}
diff --git a/arch/arm/mach-s5pv310/headsmp.S b/arch/arm/mach-s5pv310/headsmp.S
new file mode 100644
index 0000000..164b7b0
--- /dev/null
+++ b/arch/arm/mach-s5pv310/headsmp.S
@@ -0,0 +1,41 @@
+/*
+ *  linux/arch/arm/mach-s5pv310/headsmp.S
+ *
+ *  Cloned from linux/arch/arm/mach-realview/headsmp.S
+ *
+ *  Copyright (c) 2003 ARM Limited
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+
+/*
+ * s5pv310 specific entry point for secondary CPUs.  This provides
+ * a "holding pen" into which all secondary cores are held until we're
+ * ready for them to initialise.
+ */
+ENTRY(s5pv310_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+pen:	ldr	r7, [r6]
+	cmp	r7, r0
+	bne	pen
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
+1:	.long	.
+	.long	pen_release
diff --git a/arch/arm/mach-s5pv310/include/mach/debug-macro.S b/arch/arm/mach-s5pv310/include/mach/debug-macro.S
new file mode 100644
index 0000000..6fb3893
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/debug-macro.S
@@ -0,0 +1,36 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/debug-macro.S
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
+
+	/* note, for the boot process to work we have to keep the UART
+	 * virtual address aligned to an 1MiB boundary for the L1
+	 * mapping the head code makes. We keep the UART virtual address
+	 * aligned and add in the offset when we load the value here.
+	 */
+
+	.macro addruart, rx, tmp
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1
+		ldreq	\rx, = S3C_PA_UART
+		ldrne	\rx, = S3C_VA_UART
+#if CONFIG_DEBUG_S3C_UART != 0
+		add	\rx, \rx, #(0x10000 * CONFIG_DEBUG_S3C_UART)
+#endif
+	.endm
+
+#define fifo_full fifo_full_s5pv210
+#define fifo_level fifo_level_s5pv210
+
+#include <plat/debug-macro.S>
diff --git a/arch/arm/mach-s5pv310/include/mach/entry-macro.S b/arch/arm/mach-s5pv310/include/mach/entry-macro.S
new file mode 100644
index 0000000..e600e1d
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/entry-macro.S
@@ -0,0 +1,84 @@
+/* arch/arm/mach-s5pv310/include/mach/entry-macro.S
+ *
+ * Cloned from arch/arm/mach-realview/include/mach/entry-macro.S
+ *
+ * Low-level IRQ helper macros for S5PV310 platforms
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+*/
+
+#include <mach/hardware.h>
+#include <asm/hardware/gic.h>
+
+		.macro	disable_fiq
+		.endm
+
+		.macro  get_irqnr_preamble, base, tmp
+		ldr	\base, =gic_cpu_base_addr
+		ldr	\base, [\base]
+		.endm
+
+		.macro  arch_ret_to_user, tmp1, tmp2
+		.endm
+
+		/*
+		 * The interrupt numbering scheme is defined in the
+		 * interrupt controller spec.  To wit:
+		 *
+		 * Interrupts 0-15 are IPI
+		 * 16-28 are reserved
+		 * 29-31 are local.  We allow 30 to be used for the watchdog.
+		 * 32-1020 are global
+		 * 1021-1022 are reserved
+		 * 1023 is "spurious" (no interrupt)
+		 *
+		 * For now, we ignore all local interrupts so only return an interrupt if it's
+		 * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
+		 *
+		 * A simple read from the controller will tell us the number of the highest
+                 * priority enabled interrupt.  We then just need to check whether it is in the
+		 * valid range for an IRQ (30-1020 inclusive).
+		 */
+
+		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+		ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
+
+		ldr	\tmp, =1021
+
+		bic     \irqnr, \irqstat, #0x1c00
+
+		cmp     \irqnr, #29
+		cmpcc	\irqnr, \irqnr
+		cmpne	\irqnr, \tmp
+		cmpcs	\irqnr, \irqnr
+		addne	\irqnr, \irqnr, #32
+
+		.endm
+
+		/* We assume that irqstat (the raw value of the IRQ acknowledge
+		 * register) is preserved from the macro above.
+		 * If there is an IPI, we immediately signal end of interrupt on the
+		 * controller, since this requires the original irqstat value which
+		 * we won't easily be able to recreate later.
+		 */
+
+		.macro test_for_ipi, irqnr, irqstat, base, tmp
+		bic	\irqnr, \irqstat, #0x1c00
+		cmp	\irqnr, #16
+		strcc	\irqstat, [\base, #GIC_CPU_EOI]
+		cmpcs	\irqnr, \irqnr
+		.endm
+
+		/* As above, this assumes that irqstat and base are preserved.. */
+
+		.macro test_for_ltirq, irqnr, irqstat, base, tmp
+		bic	\irqnr, \irqstat, #0x1c00
+		mov	\tmp, #0
+		cmp	\irqnr, #29
+		moveq	\tmp, #1
+		streq	\irqstat, [\base, #GIC_CPU_EOI]
+		cmp	\tmp, #0
+		.endm
diff --git a/arch/arm/mach-s5pv310/include/mach/gpio.h b/arch/arm/mach-s5pv310/include/mach/gpio.h
new file mode 100644
index 0000000..20cb80c
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/gpio.h
@@ -0,0 +1,135 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/gpio.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - GPIO lib support
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
+/* Practically, GPIO banks upto GPZ are the configurable gpio banks */
+
+/* GPIO bank sizes */
+#define S5PV310_GPIO_A0_NR	(8)
+#define S5PV310_GPIO_A1_NR	(6)
+#define S5PV310_GPIO_B_NR	(8)
+#define S5PV310_GPIO_C0_NR	(5)
+#define S5PV310_GPIO_C1_NR	(5)
+#define S5PV310_GPIO_D0_NR	(4)
+#define S5PV310_GPIO_D1_NR	(4)
+#define S5PV310_GPIO_E0_NR	(5)
+#define S5PV310_GPIO_E1_NR	(8)
+#define S5PV310_GPIO_E2_NR	(6)
+#define S5PV310_GPIO_E3_NR	(8)
+#define S5PV310_GPIO_E4_NR	(8)
+#define S5PV310_GPIO_F0_NR	(8)
+#define S5PV310_GPIO_F1_NR	(8)
+#define S5PV310_GPIO_F2_NR	(8)
+#define S5PV310_GPIO_F3_NR	(6)
+#define S5PV310_GPIO_J0_NR	(8)
+#define S5PV310_GPIO_J1_NR	(5)
+#define S5PV310_GPIO_K0_NR	(7)
+#define S5PV310_GPIO_K1_NR	(7)
+#define S5PV310_GPIO_K2_NR	(7)
+#define S5PV310_GPIO_K3_NR	(7)
+#define S5PV310_GPIO_L0_NR	(8)
+#define S5PV310_GPIO_L1_NR	(3)
+#define S5PV310_GPIO_L2_NR	(8)
+#define S5PV310_GPIO_X0_NR	(8)
+#define S5PV310_GPIO_X1_NR	(8)
+#define S5PV310_GPIO_X2_NR	(8)
+#define S5PV310_GPIO_X3_NR	(8)
+#define S5PV310_GPIO_Z_NR	(7)
+
+/* GPIO bank numbers */
+
+#define S5PV310_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5p_gpio_number {
+	S5PV310_GPIO_A0_START	= 0,
+	S5PV310_GPIO_A1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_A0),
+	S5PV310_GPIO_B_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_A1),
+	S5PV310_GPIO_C0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_B),
+	S5PV310_GPIO_C1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_C0),
+	S5PV310_GPIO_D0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_C1),
+	S5PV310_GPIO_D1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_D0),
+	S5PV310_GPIO_E0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_D1),
+	S5PV310_GPIO_E1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E0),
+	S5PV310_GPIO_E2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E1),
+	S5PV310_GPIO_E3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E2),
+	S5PV310_GPIO_E4_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E3),
+	S5PV310_GPIO_F0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_E4),
+	S5PV310_GPIO_F1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_F0),
+	S5PV310_GPIO_F2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_F1),
+	S5PV310_GPIO_F3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_F2),
+	S5PV310_GPIO_J0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_F3),
+	S5PV310_GPIO_J1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_J0),
+	S5PV310_GPIO_K0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_J1),
+	S5PV310_GPIO_K1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_K0),
+	S5PV310_GPIO_K2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_K1),
+	S5PV310_GPIO_K3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_K2),
+	S5PV310_GPIO_L0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_K3),
+	S5PV310_GPIO_L1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_L0),
+	S5PV310_GPIO_L2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_L1),
+	S5PV310_GPIO_X0_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_L2),
+	S5PV310_GPIO_X1_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X0),
+	S5PV310_GPIO_X2_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X1),
+	S5PV310_GPIO_X3_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X2),
+	S5PV310_GPIO_Z_START	= S5PV310_GPIO_NEXT(S5PV310_GPIO_X3),
+};
+
+/* S5PV310 GPIO number definitions */
+#define S5PV310_GPA0(_nr)	(S5PV310_GPIO_A0_START + (_nr))
+#define S5PV310_GPA1(_nr)	(S5PV310_GPIO_A1_START + (_nr))
+#define S5PV310_GPB(_nr)	(S5PV310_GPIO_B_START + (_nr))
+#define S5PV310_GPC0(_nr)	(S5PV310_GPIO_C0_START + (_nr))
+#define S5PV310_GPC1(_nr)	(S5PV310_GPIO_C1_START + (_nr))
+#define S5PV310_GPD0(_nr)	(S5PV310_GPIO_D0_START + (_nr))
+#define S5PV310_GPD1(_nr)	(S5PV310_GPIO_D1_START + (_nr))
+#define S5PV310_GPE0(_nr)	(S5PV310_GPIO_E0_START + (_nr))
+#define S5PV310_GPE1(_nr)	(S5PV310_GPIO_E1_START + (_nr))
+#define S5PV310_GPE2(_nr)	(S5PV310_GPIO_E2_START + (_nr))
+#define S5PV310_GPE3(_nr)	(S5PV310_GPIO_E3_START + (_nr))
+#define S5PV310_GPE4(_nr)	(S5PV310_GPIO_E4_START + (_nr))
+#define S5PV310_GPF0(_nr)	(S5PV310_GPIO_F0_START + (_nr))
+#define S5PV310_GPF1(_nr)	(S5PV310_GPIO_F1_START + (_nr))
+#define S5PV310_GPF2(_nr)	(S5PV310_GPIO_F2_START + (_nr))
+#define S5PV310_GPF3(_nr)	(S5PV310_GPIO_F3_START + (_nr))
+#define S5PV310_GPJ0(_nr)	(S5PV310_GPIO_J0_START + (_nr))
+#define S5PV310_GPJ1(_nr)	(S5PV310_GPIO_J1_START + (_nr))
+#define S5PV310_GPK0(_nr)	(S5PV310_GPIO_K0_START + (_nr))
+#define S5PV310_GPK1(_nr)	(S5PV310_GPIO_K1_START + (_nr))
+#define S5PV310_GPK2(_nr)	(S5PV310_GPIO_K2_START + (_nr))
+#define S5PV310_GPK3(_nr)	(S5PV310_GPIO_K3_START + (_nr))
+#define S5PV310_GPL0(_nr)	(S5PV310_GPIO_L0_START + (_nr))
+#define S5PV310_GPL1(_nr)	(S5PV310_GPIO_L1_START + (_nr))
+#define S5PV310_GPL2(_nr)	(S5PV310_GPIO_L2_START + (_nr))
+#define S5PV310_GPX0(_nr)	(S5PV310_GPIO_X0_START + (_nr))
+#define S5PV310_GPX1(_nr)	(S5PV310_GPIO_X1_START + (_nr))
+#define S5PV310_GPX2(_nr)	(S5PV310_GPIO_X2_START + (_nr))
+#define S5PV310_GPX3(_nr)	(S5PV310_GPIO_X3_START + (_nr))
+#define S5PV310_GPZ(_nr)	(S5PV310_GPIO_Z_START + (_nr))
+
+/* the end of the S5PV310 specific gpios */
+#define S5PV310_GPIO_END	(S5PV310_GPZ(S5PV310_GPIO_Z_NR) + 1)
+#define S3C_GPIO_END		S5PV310_GPIO_END
+
+/* define the number of gpios we need to the one after the GPZ() range */
+#define ARCH_NR_GPIOS		(S5PV310_GPZ(S5PV310_GPIO_Z_NR) +	\
+				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
+
+#include <asm-generic/gpio.h>
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/hardware.h b/arch/arm/mach-s5pv310/include/mach/hardware.h
new file mode 100644
index 0000000..28ff988
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/hardware.h
@@ -0,0 +1,18 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/hardware.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - Hardware support
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
diff --git a/arch/arm/mach-s5pv310/include/mach/io.h b/arch/arm/mach-s5pv310/include/mach/io.h
new file mode 100644
index 0000000..8a7f912
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/io.h
@@ -0,0 +1,26 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/io.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Copyright 2008-2010 Ben Dooks <ben-linux@fluff.org>
+ *
+ * Based on arch/arm/mach-s5p6442/include/mach/io.h
+ *
+ * Default IO routines for S5PV310
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H __FILE__
+
+/* No current ISA/PCI bus support. */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#define IO_SPACE_LIMIT (0xFFFFFFFF)
+
+#endif /* __ASM_ARM_ARCH_IO_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
new file mode 100644
index 0000000..e44438e
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -0,0 +1,63 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/map.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - Memory map definitions
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
+
+/* */
+#define S3C_UART_OFFSET			(0x10000)
+
+#include <plat/map-s5p.h>
+
+#define S5PV310_PA_CHIPID		(0x10000000)
+#define S5P_PA_CHIPID			S5PV310_PA_CHIPID
+
+#define S5PV310_PA_SYSCON		(0x10020000)
+#define S5P_PA_SYSCON			S5PV310_PA_SYSCON
+
+#define S5PV310_PA_COMBINER		(0x10448000)
+
+#define S5PV310_PA_COREPERI		(0x10500000)
+#define S5PV310_PA_GIC_CPU		(0x10500100)
+#define S5PV310_PA_TWD			(0x10500600)
+#define S5PV310_PA_GIC_DIST		(0x10501000)
+#define S5PV310_PA_L2CC			(0x10502000)
+
+#define S5PV310_PA_GPIO			(0x11000000)
+#define S5P_PA_GPIO			S5PV310_PA_GPIO
+
+#define S5PV310_PA_UART			(0x13800000)
+
+#define S5P_PA_UART(x)			(S5PV310_PA_UART + ((x) * S3C_UART_OFFSET))
+#define S5P_PA_UART0			S5P_PA_UART(0)
+#define S5P_PA_UART1			S5P_PA_UART(1)
+#define S5P_PA_UART2			S5P_PA_UART(2)
+#define S5P_PA_UART3			S5P_PA_UART(3)
+#define S5P_PA_UART4			S5P_PA_UART(4)
+
+#define S5P_SZ_UART			SZ_256
+
+#define S5PV310_PA_IIC0			(0x13860000)
+
+#define S5PV310_PA_TIMER		(0x139D0000)
+#define S5P_PA_TIMER			S5PV310_PA_TIMER
+
+#define S5PV310_PA_SDRAM		(0x40000000)
+#define S5P_PA_SDRAM			S5PV310_PA_SDRAM
+
+/* compatibiltiy defines. */
+#define S3C_PA_UART			S5PV310_PA_UART
+#define S3C_PA_IIC			S5PV310_PA_IIC0
+
+#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/memory.h b/arch/arm/mach-s5pv310/include/mach/memory.h
new file mode 100644
index 0000000..1dffb48
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/memory.h
@@ -0,0 +1,22 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/memory.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - Memory definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H __FILE__
+
+#define PHYS_OFFSET		UL(0x40000000)
+
+/* Maximum of 256MiB in one bank */
+#define MAX_PHYSMEM_BITS	32
+#define SECTION_SIZE_BITS	28
+
+#endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/smp.h b/arch/arm/mach-s5pv310/include/mach/smp.h
new file mode 100644
index 0000000..990f3ba
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/smp.h
@@ -0,0 +1,29 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/smp.h
+ *
+ * Cloned from arch/arm/mach-realview/include/mach/smp.h
+*/
+
+#ifndef ASM_ARCH_SMP_H
+#define ASM_ARCH_SMP_H __FILE__
+
+#include <asm/hardware/gic.h>
+
+extern void __iomem *gic_cpu_base_addr;
+
+#define hard_smp_processor_id()			\
+	({						\
+		unsigned int cpunum;			\
+		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
+			: "=r" (cpunum));		\
+		cpunum &= 0x03;				\
+	})
+
+/*
+ * We use IRQ1 as the IPI
+ */
+static inline void smp_cross_call(const struct cpumask *mask)
+{
+	gic_raise_softirq(mask, 1);
+}
+
+#endif
diff --git a/arch/arm/mach-s5pv310/include/mach/system.h b/arch/arm/mach-s5pv310/include/mach/system.h
new file mode 100644
index 0000000..d10c009
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/system.h
@@ -0,0 +1,22 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/system.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - system support header
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H __FILE__
+
+#include <plat/system-reset.h>
+
+static void arch_idle(void)
+{
+	/* nothing here yet */
+}
+#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/timex.h b/arch/arm/mach-s5pv310/include/mach/timex.h
new file mode 100644
index 0000000..bd2359b
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/timex.h
@@ -0,0 +1,29 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/timex.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Copyright (c) 2003-2010 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Based on arch/arm/mach-s5p6442/include/mach/timex.h
+ *
+ * S5PV310 - time parameters
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_TIMEX_H
+#define __ASM_ARCH_TIMEX_H __FILE__
+
+/* CLOCK_TICK_RATE needs to be evaluatable by the cpp, so making it
+ * a variable is useless. It seems as long as we make our timers an
+ * exact multiple of HZ, any value that makes a 1->1 correspondence
+ * for the time conversion functions to/from jiffies is acceptable.
+*/
+
+#define CLOCK_TICK_RATE 12000000
+
+#endif /* __ASM_ARCH_TIMEX_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/uncompress.h b/arch/arm/mach-s5pv310/include/mach/uncompress.h
new file mode 100644
index 0000000..ad88c24
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/uncompress.h
@@ -0,0 +1,27 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/uncompress.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV310 - uncompress code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_UNCOMPRESS_H
+#define __ASM_ARCH_UNCOMPRESS_H __FILE__
+
+#include <mach/map.h>
+#include <plat/uncompress.h>
+
+static void arch_detect_cpu(void)
+{
+	/* we do not need to do any cpu detection here at the moment. */
+
+	fifo_mask = S5PV210_UFSTAT_TXMASK;
+	fifo_max = 63 << S5PV210_UFSTAT_TXSHIFT;
+}
+
+#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/vmalloc.h b/arch/arm/mach-s5pv310/include/mach/vmalloc.h
new file mode 100644
index 0000000..426d997
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/vmalloc.h
@@ -0,0 +1,22 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/vmalloc.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
+ *
+ * Based on arch/arm/mach-s5p6440/include/mach/vmalloc.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S5PV310 vmalloc definition
+*/
+
+#ifndef __ASM_ARCH_VMALLOC_H
+#define __ASM_ARCH_VMALLOC_H __FILE__
+
+#define VMALLOC_END	  (0xE0000000)
+
+#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5pv310/init.c b/arch/arm/mach-s5pv310/init.c
new file mode 100644
index 0000000..6c152c6
--- /dev/null
+++ b/arch/arm/mach-s5pv310/init.c
@@ -0,0 +1,40 @@
+/* linux/arch/arm/mach-s5pv310/init.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/serial_core.h>
+
+#include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/regs-serial.h>
+
+static struct s3c24xx_uart_clksrc s5pv310_serial_clocks[] = {
+	[0] = {
+		.name		= "uclk1",
+		.divisor	= 1,
+		.min_baud	= 0,
+		.max_baud	= 0,
+	},
+};
+
+/* uart registration process */
+void __init s5pv310_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
+{
+	struct s3c2410_uartcfg *tcfg = cfg;
+	u32 ucnt;
+
+	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
+		if (!tcfg->clocks) {
+			tcfg->clocks = s5pv310_serial_clocks;
+			tcfg->clocks_size = ARRAY_SIZE(s5pv310_serial_clocks);
+		}
+	}
+
+	s3c24xx_init_uartdevs("s5pv310-uart", s5p_uart_resources, cfg, no);
+}
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-s5pv310/platsmp.c
new file mode 100644
index 0000000..9325ac2
--- /dev/null
+++ b/arch/arm/mach-s5pv310/platsmp.c
@@ -0,0 +1,212 @@
+/* linux/arch/arm/mach-s5pv310/platsmp.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Cloned from linux/arch/arm/mach-realview/platsmp.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/cacheflush.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/localtimer.h>
+#include <asm/unified.h>
+
+#include <asm/smp_scu.h>
+#include <mach/regs-clock.h>
+
+extern void s5pv310_secondary_startup(void);
+
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+volatile int __cpuinitdata pen_release = -1;
+
+static void __iomem *scu_base_addr(void)
+{
+	return (void __iomem *)(S5P_VA_SCU);
+}
+
+static inline unsigned int get_core_count(void)
+{
+	void __iomem *scu_base = scu_base_addr();
+	if (scu_base)
+		return scu_get_core_count(scu_base);
+	return 1;
+}
+
+static DEFINE_SPINLOCK(boot_lock);
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	trace_hardirqs_off();
+
+	/*
+	 * if any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+	gic_cpu_init(0, gic_cpu_base_addr);
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	pen_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting to be released from
+	 * the holding pen - release it, then wait for it to flag
+	 * that it has been released by resetting pen_release.
+	 *
+	 * Note that "pen_release" is the hardware CPU ID, whereas
+	 * "cpu" is Linux's internal ID.
+	 */
+	pen_release = cpu;
+	flush_cache_all();
+
+	/*
+	 * XXX
+	 *
+	 * This is a later addition to the booting protocol: the
+	 * bootMonitor now puts secondary cores into WFI, so
+	 * poke_milo() no longer gets the cores moving; we need
+	 * to send a soft interrupt to wake the secondary core.
+	 * Use smp_cross_call() for this, since there's little
+	 * point duplicating the code here
+	 */
+	smp_cross_call(cpumask_of(cpu));
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (pen_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return pen_release != -1 ? -ENOSYS : 0;
+}
+
+static void __init poke_milo(void)
+{
+	/* nobody is to be released from the pen yet */
+	pen_release = -1;
+
+	/*
+	 * Write the address of secondary startup into the system-wide flags
+	 * register. The BootMonitor waits for this register to become
+	 * non-zero.
+	 */
+	__raw_writel(BSYM(virt_to_phys(s5pv310_secondary_startup)), S5P_INFORM0);
+
+	mb();
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	unsigned int i, ncores = get_core_count();
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = get_core_count();
+	unsigned int cpu = smp_processor_id();
+	int i;
+
+	/* sanity check */
+	if (ncores == 0) {
+		printk(KERN_ERR
+		       "Realview: strange CM count of 0? Default to 1\n");
+
+		ncores = 1;
+	}
+
+	if (ncores > NR_CPUS) {
+		printk(KERN_WARNING
+		       "Realview: no. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n",
+		       ncores, NR_CPUS);
+		ncores = NR_CPUS;
+	}
+
+	smp_store_cpu_info(cpu);
+
+	/*
+	 * are we trying to boot more cores than exist?
+	 */
+	if (max_cpus > ncores)
+		max_cpus = ncores;
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated at the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	/*
+	 * Initialise the SCU if there are more than one CPU and let
+	 * them know where to start. Note that, on modern versions of
+	 * MILO, the "poke" doesn't actually do anything until each
+	 * individual core is sent a soft interrupt to get it out of
+	 * WFI
+	 */
+	if (max_cpus > 1) {
+		/*
+		 * Enable the local timer or broadcast device for the
+		 * boot CPU, but only if we have more than one CPU.
+		 */
+		percpu_timer_setup();
+
+		scu_enable(scu_base_addr());
+		poke_milo();
+	}
+}
diff --git a/arch/arm/mach-s5pv310/setup-i2c0.c b/arch/arm/mach-s5pv310/setup-i2c0.c
new file mode 100644
index 0000000..d4f5a81
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-i2c0.c
@@ -0,0 +1,20 @@
+/* linux/arch/arm/mach-s5pv210/setup-i2c0.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * I2C0 GPIO configuration.
+ *
+ * Based on plat-s3c64xx/setup-i2c0.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct platform_device; /* don't need the contents */
+
+void s3c_i2c0_cfg_gpio(struct platform_device *dev)
+{
+/* will be implemented later */
+}
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index c478441..9261a27 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -21,6 +21,7 @@
 #include <plat/s5p6442.h>
 #include <plat/s5pc100.h>
 #include <plat/s5pv210.h>
+#include <plat/s5pv310.h>
 
 /* table of supported CPUs */
 
@@ -28,6 +29,7 @@ static const char name_s5p6440[] = "S5P6440";
 static const char name_s5p6442[] = "S5P6442";
 static const char name_s5pc100[] = "S5PC100";
 static const char name_s5pv210[] = "S5PV210/S5PC110";
+static const char name_s5pv310[] = "S5PV310";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -62,6 +64,14 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init_uarts	= s5pv210_init_uarts,
 		.init		= s5pv210_init,
 		.name		= name_s5pv210,
+	}, {
+		.idcode		= 0x43200000,
+		.idmask		= 0xfffff000,
+		.map_io		= s5pv310_map_io,
+		.init_clocks	= s5pv310_init_clocks,
+		.init_uarts	= s5pv310_init_uarts,
+		.init		= s5pv310_init,
+		.name		= name_s5pv310,
 	},
 };
 
@@ -83,6 +93,7 @@ static struct map_desc s5p_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S3C_PA_UART),
 		.length		= SZ_512K,
 		.type		= MT_DEVICE,
+#ifdef CONFIG_ARM_VIC
 	}, {
 		.virtual	= (unsigned long)VA_VIC0,
 		.pfn		= __phys_to_pfn(S5P_PA_VIC0),
@@ -93,6 +104,7 @@ static struct map_desc s5p_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S5P_PA_VIC1),
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
+#endif
 	}, {
 		.virtual	= (unsigned long)S3C_VA_TIMER,
 		.pfn		= __phys_to_pfn(S5P_PA_TIMER),
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 3d815f4..54e9fb9 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -18,6 +18,18 @@
 #define S5P_VA_SYSTIMER		S3C_ADDR(0x01200000)
 #define S5P_VA_SROMC		S3C_ADDR(0x01100000)
 
+#define S5P_VA_COMBINER_BASE	S3C_ADDR(0x00600000)
+#define S5P_VA_COMBINER(x)	(S5P_VA_COMBINER_BASE + ((x) >> 2) * 0x10)
+
+#define S5P_VA_COREPERI_BASE	S3C_ADDR(0x00800000)
+#define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
+#define S5P_VA_SCU		S5P_VA_COREPERI(0x0)
+#define S5P_VA_GIC_CPU		S5P_VA_COREPERI(0x100)
+#define S5P_VA_TWD		S5P_VA_COREPERI(0x600)
+#define S5P_VA_GIC_DIST		S5P_VA_COREPERI(0x1000)
+
+#define S5P_VA_L2CC		S3C_ADDR(0x00900000)
+
 #define S5P_VA_UART(x)		(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
 #define S5P_VA_UART0		S5P_VA_UART(0)
 #define S5P_VA_UART1		S5P_VA_UART(1)
diff --git a/arch/arm/plat-s5p/include/plat/s5pv310.h b/arch/arm/plat-s5p/include/plat/s5pv310.h
new file mode 100644
index 0000000..d2f05e1
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/s5pv310.h
@@ -0,0 +1,33 @@
+/* linux/arch/arm/plat-s5p/include/plat/s5pv310.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Header file for s5pv310 cpu support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* Common init code for S5PV310 related SoCs */
+
+extern void s5pv310_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern void s5pv310_register_clocks(void);
+extern void s5pv310_setup_clocks(void);
+
+#ifdef CONFIG_CPU_S5PV310
+
+extern  int s5pv310_init(void);
+extern void s5pv310_init_irq(void);
+extern void s5pv310_map_io(void);
+extern void s5pv310_init_clocks(int xtal);
+
+#define s5pv310_init_uarts s5pv310_common_init_uarts
+
+#else
+#define s5pv310_init_clocks NULL
+#define s5pv310_init_uarts NULL
+#define s5pv310_map_io NULL
+#define s5pv310_init NULL
+#endif
-- 
1.6.2.5
