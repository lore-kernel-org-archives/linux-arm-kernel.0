From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Fri, 27 Nov 2009 05:25:56 +0530
Subject: [PATCH v4 3/6] ARM: U8500 core machine support
Message-ID: <1259279756.13327.72.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Date: Fri, 27 Nov 2009 15:40:59 +0530

Adds core support for the ST-Ericsson U8500
platform. It supports memory mappings, binds to
the existing modules like GIC, SCU, TWD and
local timers and sets up the infrastructure for
the secondary core.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
Reviewed-by: Alessandro Rubini <rubini@unipv.it>
Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig                    |   15 ++
 arch/arm/mach-ux500/Makefile                   |    8 +
 arch/arm/mach-ux500/board-mop500.c             |  158 +++++++++++++++++++++
 arch/arm/mach-ux500/cpu-u8500.c                |   64 +++++++++
 arch/arm/mach-ux500/headsmp.S                  |   38 +++++
 arch/arm/mach-ux500/include/mach/debug-macro.S |   19 +++
 arch/arm/mach-ux500/include/mach/entry-macro.S |   89 ++++++++++++
 arch/arm/mach-ux500/include/mach/memory.h      |   18 +++
 arch/arm/mach-ux500/include/mach/setup.h       |   23 +++
 arch/arm/mach-ux500/include/mach/smp.h         |   32 +++++
 arch/arm/mach-ux500/include/mach/system.h      |   25 ++++
 arch/arm/mach-ux500/include/mach/timex.h       |    6 +
 arch/arm/mach-ux500/include/mach/uncompress.h  |   58 ++++++++
 arch/arm/mach-ux500/include/mach/vmalloc.h     |   18 +++
 arch/arm/mach-ux500/localtimer.c               |   28 ++++
 arch/arm/mach-ux500/platsmp.c                  |  177 ++++++++++++++++++++++++
 16 files changed, 776 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/Kconfig
 create mode 100644 arch/arm/mach-ux500/Makefile
 create mode 100644 arch/arm/mach-ux500/board-mop500.c
 create mode 100644 arch/arm/mach-ux500/cpu-u8500.c
 create mode 100644 arch/arm/mach-ux500/headsmp.S
 create mode 100644 arch/arm/mach-ux500/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-ux500/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-ux500/include/mach/memory.h
 create mode 100644 arch/arm/mach-ux500/include/mach/setup.h
 create mode 100644 arch/arm/mach-ux500/include/mach/smp.h
 create mode 100644 arch/arm/mach-ux500/include/mach/system.h
 create mode 100644 arch/arm/mach-ux500/include/mach/timex.h
 create mode 100644 arch/arm/mach-ux500/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-ux500/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-ux500/localtimer.c
 create mode 100644 arch/arm/mach-ux500/platsmp.c

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
new file mode 100644
index 0000000..03625d7
--- /dev/null
+++ b/arch/arm/mach-ux500/Kconfig
@@ -0,0 +1,15 @@
+menu "ST-Ericsson platform type"
+	depends on ARCH_U8500
+
+comment "ST-Ericsson Multicore Mobile Platforms"
+
+config MACH_U8500_MOP
+	bool "U8500 Early Development platform"
+	default y
+	select ARM_GIC
+	select HAS_MTU
+	help
+	  Include support for mop500 development platform
+	  based on U8500 architecture. The platform is based
+	  on early drop silicon version of 8500.
+endmenu
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
new file mode 100644
index 0000000..95e6e24
--- /dev/null
+++ b/arch/arm/mach-ux500/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the linux kernel, U8500 machine.
+#
+
+obj-y				:= clock.o
+obj-$(CONFIG_ARCH_U8500)	+= cpu-u8500.o
+obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
new file mode 100644
index 0000000..aa5afbc
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (C) 2008-2009 ST-Ericsson
+ *
+ * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/pl022.h>
+#include <linux/spi/spi.h>
+
+#include <asm/localtimer.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <plat/mtu.h>
+
+#include <mach/hardware.h>
+#include <mach/setup.h>
+
+#define __MEM_4K_RESOURCE(x) \
+	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
+
+/* These are active devices on this board */
+static struct amba_device uart0_device = {
+	.dev = { .init_name = "uart0" },
+	__MEM_4K_RESOURCE(U8500_UART0_BASE),
+	.irq = {IRQ_UART0, NO_IRQ},
+};
+
+static struct amba_device uart1_device = {
+	.dev = { .init_name = "uart1" },
+	__MEM_4K_RESOURCE(U8500_UART1_BASE),
+	.irq = {IRQ_UART1, NO_IRQ},
+};
+
+static struct amba_device uart2_device = {
+	.dev = { .init_name = "uart2" },
+	__MEM_4K_RESOURCE(U8500_UART2_BASE),
+	.irq = {IRQ_UART2, NO_IRQ},
+};
+
+static void ab4500_spi_cs_control(u32 command)
+{
+	/* set the FRM signal, which is CS  - TODO */
+}
+
+struct pl022_config_chip ab4500_chip_info = {
+	.lbm = LOOPBACK_DISABLED,
+	.com_mode = INTERRUPT_TRANSFER,
+	.iface = SSP_INTERFACE_MOTOROLA_SPI,
+	/* we can act as master only */
+	.hierarchy = SSP_MASTER,
+	.slave_tx_disable = 0,
+	.endian_rx = SSP_RX_MSB,
+	.endian_tx = SSP_TX_MSB,
+	.data_size = SSP_DATA_BITS_24,
+	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
+	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
+	.clk_phase = SSP_CLK_SECOND_EDGE,
+	.clk_pol = SSP_CLK_POL_IDLE_HIGH,
+	.cs_control = ab4500_spi_cs_control,
+};
+
+static struct spi_board_info u8500_spi_devices[] = {
+	{
+		.modalias = "ab4500",
+		.controller_data = &ab4500_chip_info,
+		.max_speed_hz = 12000000,
+		.bus_num = 0,
+		.chip_select = 0,
+		.mode = SPI_MODE_0,
+		.irq = IRQ_AB4500,
+	},
+};
+
+static struct pl022_ssp_controller ssp0_platform_data = {
+	.bus_id = 0,
+	/* pl022 not yet supports dma */
+	.enable_dma = 0,
+	/* on this platform, gpio 31,142,144,214 &
+	 * 224 are connected as chip selects
+	 */
+	.num_chipselect = 5,
+};
+
+static struct amba_device pl022_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "pl022",
+		.platform_data = &ssp0_platform_data,
+	},
+	.res = {
+		.start = U8500_SSP0_BASE,
+		.end   = U8500_SSP0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_SSP0, NO_IRQ },
+	/* ST-Ericsson modified id */
+	.periphid = SSP_PER_ID,
+};
+
+static struct amba_device *amba_devs[] __initdata = {
+	&uart0_device,
+	&uart1_device,
+	&uart2_device,
+	&pl022_device,
+};
+
+static void __init u8500_timer_init(void)
+{
+#ifdef CONFIG_LOCAL_TIMERS
+	/* Setup the local timer base */
+	twd_base = __io_address(U8500_TWD_BASE);
+#endif
+	/* Setup the MTU base */
+	mtu_base = __io_address(U8500_MTU0_BASE);
+
+	nmdk_timer_init();
+}
+
+static struct sys_timer u8500_timer = {
+	.init	= u8500_timer_init,
+};
+
+static void __init u8500_init_machine(void)
+{
+	int i;
+
+	/* Register the active AMBA devices on this board */
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
+		amba_device_register(amba_devs[i], &iomem_resource);
+
+	spi_register_board_info(u8500_spi_devices,
+			ARRAY_SIZE(u8500_spi_devices));
+
+	u8500_init_devices();
+}
+
+MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
+	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
+	.phys_io	= U8500_UART2_BASE,
+	.io_pg_offst	= (IO_ADDRESS(U8500_UART2_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x100,
+	.map_io		= u8500_map_io,
+	.init_irq	= u8500_init_irq,
+	/* we re-use nomadik timer here */
+	.timer		= &u8500_timer,
+	.init_machine	= u8500_init_machine,
+MACHINE_END
diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
new file mode 100644
index 0000000..5f05e58
--- /dev/null
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2008-2009 ST-Ericsson
+ *
+ * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/amba/bus.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+
+#include <asm/hardware/gic.h>
+#include <asm/mach/map.h>
+#include <mach/hardware.h>
+
+/* add any platform devices here - TODO */
+static struct platform_device *platform_devs[] __initdata = {
+	/* yet to be added, add i2c0, gpio.. */
+};
+
+#define __IO_DEV_DESC(x, sz)	{		\
+	.virtual	= IO_ADDRESS(x),	\
+	.pfn		= __phys_to_pfn(x),	\
+	.length		= sz,			\
+	.type		= MT_DEVICE,		\
+}
+
+/* minimum static i/o mapping required to boot U8500 platforms */
+static struct map_desc u8500_io_desc[] __initdata = {
+	__IO_DEV_DESC(U8500_GIC_CPU_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_TWD_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),
+};
+
+void __init u8500_map_io(void)
+{
+	iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
+}
+
+void __init u8500_init_irq(void)
+{
+	gic_dist_init(0, __io_address(U8500_GIC_DIST_BASE), 29);
+	gic_cpu_init(0, __io_address(U8500_GIC_CPU_BASE));
+}
+
+/*
+ * This function is called from the board init
+ */
+void __init u8500_init_devices(void)
+{
+	/* Register the platform devices */
+	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
+
+	return ;
+}
diff --git a/arch/arm/mach-ux500/headsmp.S b/arch/arm/mach-ux500/headsmp.S
new file mode 100644
index 0000000..a6be2cd
--- /dev/null
+++ b/arch/arm/mach-ux500/headsmp.S
@@ -0,0 +1,38 @@
+/*
+ *  Copyright (c) 2009 ST-Ericsson
+ *	This file is based  ARM Realview platform
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
+ * U8500 specific entry point for secondary CPUs.
+ */
+ENTRY(u8500_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+	dsb
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
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
new file mode 100644
index 0000000..8f21b6a
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -0,0 +1,19 @@
+/*
+ * Debugging macro include header
+ *
+ *  Copyright (C) 2009 ST-Ericsson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+	.macro	addruart,rx
+	mrc	p15, 0, \rx, c1, c0
+	tst	\rx, #1			@MMU enabled?
+	moveq	\rx, #0x80000000	@MMU off, Physical address
+	movne	\rx, #0xF0000000	@MMU on, Virtual address
+	orr	\rx, \rx, #0x7000
+	.endm
+
+#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
new file mode 100644
index 0000000..eece330
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/entry-macro.S
@@ -0,0 +1,89 @@
+/*
+ * Low-level IRQ helper macros for U8500 platforms
+ *
+ * Copyright (C) 2009 ST-Ericsson.
+ *
+ * This file is a copy of ARM Realview platform.
+ *	-just satisfied checkpatch script.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <mach/hardware.h>
+#include <asm/hardware/gic.h>
+
+		.macro	disable_fiq
+		.endm
+
+		.macro  get_irqnr_preamble, base, tmp
+		ldr     \base, =IO_ADDRESS(U8500_GIC_CPU_BASE)
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
+		 * For now, we ignore all local interrupts so only return an
+		 * interrupt if it's between 30 and 1020. The test_for_ipi
+		 * routine below will pick up on IPIs.
+		 *
+		 * A simple read from the controller will tell us the number
+		 * of the highest priority enabled interrupt. We then just
+		 * need to check whether it is in the valid range for an
+		 * IRQ (30-1020 inclusive).
+		 */
+
+		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+		/* bits 12-10 = src CPU, 9-0 = int # */
+		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
+
+		ldr	\tmp, =1021
+
+		bic     \irqnr, \irqstat, #0x1c00
+
+		cmp     \irqnr, #29
+		cmpcc	\irqnr, \irqnr
+		cmpne	\irqnr, \tmp
+		cmpcs	\irqnr, \irqnr
+
+		.endm
+
+		/* We assume that irqstat (the raw value of the IRQ
+		 * acknowledge register) is preserved from the macro above.
+		 * If there is an IPI, we immediately signal end of
+		 * interrupt on the controller, since this requires the
+		 * original irqstat value which we won't easily be able
+		 * to recreate later.
+		 */
+
+		.macro test_for_ipi, irqnr, irqstat, base, tmp
+		bic	\irqnr, \irqstat, #0x1c00
+		cmp	\irqnr, #16
+		strcc	\irqstat, [\base, #GIC_CPU_EOI]
+		cmpcs	\irqnr, \irqnr
+		.endm
+
+		/* As above, this assumes that irqstat and base
+		 * are preserved..
+		 */
+
+		.macro test_for_ltirq, irqnr, irqstat, base, tmp
+		bic	\irqnr, \irqstat, #0x1c00
+		mov 	\tmp, #0
+		cmp	\irqnr, #29
+		moveq	\tmp, #1
+		streq	\irqstat, [\base, #GIC_CPU_EOI]
+		cmp	\tmp, #0
+		.endm
diff --git a/arch/arm/mach-ux500/include/mach/memory.h b/arch/arm/mach-ux500/include/mach/memory.h
new file mode 100644
index 0000000..510571a
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/memory.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+/*
+ * Physical DRAM offset.
+ */
+#define PHYS_OFFSET	UL(0x00000000)
+#define BUS_OFFSET	UL(0x00000000)
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
new file mode 100644
index 0000000..cf0ce16
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * These symbols are needed for board-specific files to call their
+ * own cpu-specific files
+ */
+#ifndef __ASM_ARCH_SETUP_H
+#define __ASM_ARCH_SETUP_H
+
+#include <asm/mach/time.h>
+#include <linux/init.h>
+
+extern void u8500_map_io(void);
+extern void u8500_init_devices(void);
+extern void u8500_init_irq(void);
+/* We re-use nomadik_timer for this platform */
+extern void nmdk_timer_init(void);
+
+#endif /*  __ASM_ARCH_SETUP_H */
diff --git a/arch/arm/mach-ux500/include/mach/smp.h b/arch/arm/mach-ux500/include/mach/smp.h
new file mode 100644
index 0000000..b59f7bc
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/smp.h
@@ -0,0 +1,32 @@
+/*
+ * This file is based ARM realview platform.
+ * Copyright (C) ARM Limited.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef ASMARM_ARCH_SMP_H
+#define ASMARM_ARCH_SMP_H
+
+#include <asm/hardware/gic.h>
+
+/* This is required to wakeup the secondary core */
+extern void u8500_secondary_startup(void);
+
+#define hard_smp_processor_id()				\
+	({						\
+		unsigned int cpunum;			\
+		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
+			: "=r" (cpunum));		\
+		cpunum &= 0x0F;				\
+	})
+
+/*
+ * We use IRQ1 as the IPI
+ */
+static inline void smp_cross_call(const struct cpumask *mask)
+{
+	gic_raise_softirq(mask, 1);
+}
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/system.h b/arch/arm/mach-ux500/include/mach/system.h
new file mode 100644
index 0000000..c0cd800
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/system.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef __ASM_ARCH_SYSTEM_H
+#define __ASM_ARCH_SYSTEM_H
+
+static inline void arch_idle(void)
+{
+	/*
+	 * This should do all the clock switching
+	 * and wait for interrupt tricks
+	 */
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	/* yet to be implemented - TODO */
+}
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/timex.h b/arch/arm/mach-ux500/include/mach/timex.h
new file mode 100644
index 0000000..d0942c1
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/timex.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_ARCH_TIMEX_H
+#define __ASM_ARCH_TIMEX_H
+
+#define CLOCK_TICK_RATE		110000000
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
new file mode 100644
index 0000000..8552eb1
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -0,0 +1,58 @@
+/*
+ *  Copyright (C) 2009 ST-Ericsson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __ASM_ARCH_UNCOMPRESS_H
+#define __ASM_ARCH_UNCOMPRESS_H
+
+#include <asm/setup.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+
+#define U8500_UART_DR		0x80007000
+#define U8500_UART_LCRH		0x8000702c
+#define U8500_UART_CR		0x80007030
+#define U8500_UART_FR		0x80007018
+
+static void putc(const char c)
+{
+	/* Do nothing if the UART is not enabled. */
+	if (!(readb(U8500_UART_CR) & 0x1))
+		return;
+
+	if (c == '\n')
+		putc('\r');
+
+	while (readb(U8500_UART_FR) & (1 << 5))
+		barrier();
+	writeb(c, U8500_UART_DR);
+}
+
+static void flush(void)
+{
+	if (!(readb(U8500_UART_CR) & 0x1))
+		return;
+	while (readb(U8500_UART_FR) & (1 << 3))
+		barrier();
+}
+
+static inline void arch_decomp_setup(void)
+{
+}
+
+#define arch_decomp_wdog() /* nothing to do here */
+
+#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-ux500/include/mach/vmalloc.h b/arch/arm/mach-ux500/include/mach/vmalloc.h
new file mode 100644
index 0000000..86cdbbc
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/vmalloc.h
@@ -0,0 +1,18 @@
+/*
+ *  Copyright (C) 2009 ST-Ericsson
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#define VMALLOC_END	0xf0000000
diff --git a/arch/arm/mach-ux500/localtimer.c b/arch/arm/mach-ux500/localtimer.c
new file mode 100644
index 0000000..2288f6a
--- /dev/null
+++ b/arch/arm/mach-ux500/localtimer.c
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2008-2009 ST-Ericsson
+ * Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
+ *
+ * This file is heavily based on relaview platform, almost a copy.
+ *
+ * Copyright (C) 2002 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clockchips.h>
+
+#include <asm/irq.h>
+#include <asm/smp_twd.h>
+#include <asm/localtimer.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+void __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+	twd_timer_setup(evt);
+}
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
new file mode 100644
index 0000000..8dfe7ca
--- /dev/null
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -0,0 +1,177 @@
+/*
+ * Copyright (C) 2002 ARM Ltd.
+ * Copyright (C) 2008 STMicroelctronics.
+ * Copyright (C) 2009 ST-Ericsson.
+ * Author: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
+ *
+ * This file is based on arm realview platform
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/cacheflush.h>
+#include <asm/localtimer.h>
+#include <asm/smp_scu.h>
+#include <mach/hardware.h>
+
+/*
+ * control for which core is the next to come out of the secondary
+ * boot "holding pen"
+ */
+volatile int __cpuinitdata pen_release = -1;
+
+static unsigned int __init get_core_count(void)
+{
+	return scu_get_core_count(__io_address(U8500_SCU_BASE));
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
+	gic_cpu_init(0, __io_address(U8500_GIC_CPU_BASE));
+
+	/*
+	 * let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	pen_release = -1;
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
+	 */
+	pen_release = cpu;
+	flush_cache_all();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		if (pen_release == -1)
+			break;
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
+static void __init wakeup_secondary(void)
+{
+	/* nobody is to be released from the pen yet */
+	pen_release = -1;
+
+	/*
+	 * write the address of secondary startup into the backup ram register
+	 * at offset 0x1FF4, then write the magic number 0xA1FEED01 to the
+	 * backup ram register at offset 0x1FF0, which is what boot rom code
+	 * is waiting for. This would wake up the secondary core from WFE
+	 */
+#define U8500_CPU1_JUMPADDR_OFFSET 0x1FF4
+	__raw_writel(virt_to_phys(u8500_secondary_startup),
+		(void __iomem *)IO_ADDRESS(U8500_BACKUPRAM0_BASE) +
+		U8500_CPU1_JUMPADDR_OFFSET);
+
+#define U8500_CPU1_WAKEMAGIC_OFFSET 0x1FF0
+	__raw_writel(0xA1FEED01,
+		(void __iomem *)IO_ADDRESS(U8500_BACKUPRAM0_BASE) +
+		U8500_CPU1_WAKEMAGIC_OFFSET);
+
+	/* make sure write buffer is drained */
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
+		       "U8500: strange CM count of 0? Default to 1\n");
+		ncores = 1;
+	}
+
+	if (ncores > num_possible_cpus())	{
+		printk(KERN_WARNING
+		       "U8500: no. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n",
+		       ncores, num_possible_cpus());
+		ncores = num_possible_cpus();
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
+	if (max_cpus > 1) {
+		/*
+		 * Enable the local timer or broadcast device for the
+		 * boot CPU, but only if we have more than one CPU.
+		 */
+		percpu_timer_setup();
+		scu_enable(__io_address(U8500_SCU_BASE));
+		wakeup_secondary();
+	}
+}
-- 
1.6.3.GIT
