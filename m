From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 24 Sep 2009 01:18:23 +0530
Subject: [PATCH 4/8] [ARM] U8500: adds basic SoC support for U8500 CPU
Message-ID: <1253735303.21542.170.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This adds the cpu specific changes which
includes memory map of U8500, GIC interrupt
mapping, MutiTimerUnit (MTU) as system timer
(with clocksource, clockevent support) and
other supportive header files.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
Reviewed-by: Alessandro Rubini <ru@gnudd.com>
Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
---
 .../{mach-footbridge => mach-ux500}/Makefile.boot  |    0
 arch/arm/mach-ux500/cpu-u8500.c                    |   78 ++++++++++
 .../include/mach/clkdev.h                          |    0
 arch/arm/mach-ux500/include/mach/debug-macro.S     |   22 +++
 arch/arm/mach-ux500/include/mach/entry-macro.S     |   80 ++++++++++
 arch/arm/mach-ux500/include/mach/hardware.h        |  129 ++++++++++++++++
 arch/arm/mach-ux500/include/mach/io.h              |   22 +++
 arch/arm/mach-ux500/include/mach/irqs.h            |   71 +++++++++
 arch/arm/mach-ux500/include/mach/memory.h          |   18 ++
 arch/arm/mach-ux500/include/mach/mtu.h             |   53 +++++++
 arch/arm/mach-ux500/include/mach/setup.h           |   22 +++
 arch/arm/mach-ux500/include/mach/smp.h             |   29 ++++
 arch/arm/mach-ux500/include/mach/system.h          |   25 +++
 arch/arm/mach-ux500/include/mach/timex.h           |    6 +
 arch/arm/mach-ux500/include/mach/uncompress.h      |   58 +++++++
 arch/arm/mach-ux500/include/mach/vmalloc.h         |   18 ++
 arch/arm/mach-ux500/timer.c                        |  163 ++++++++++++++++++++
 17 files changed, 794 insertions(+), 0 deletions(-)
 copy arch/arm/{mach-footbridge => mach-ux500}/Makefile.boot (100%)
 create mode 100644 arch/arm/mach-ux500/cpu-u8500.c
 copy arch/arm/{mach-ep93xx => mach-ux500}/include/mach/clkdev.h (100%)
 create mode 100644 arch/arm/mach-ux500/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-ux500/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-ux500/include/mach/hardware.h
 create mode 100644 arch/arm/mach-ux500/include/mach/io.h
 create mode 100644 arch/arm/mach-ux500/include/mach/irqs.h
 create mode 100644 arch/arm/mach-ux500/include/mach/memory.h
 create mode 100644 arch/arm/mach-ux500/include/mach/mtu.h
 create mode 100644 arch/arm/mach-ux500/include/mach/setup.h
 create mode 100644 arch/arm/mach-ux500/include/mach/smp.h
 create mode 100644 arch/arm/mach-ux500/include/mach/system.h
 create mode 100644 arch/arm/mach-ux500/include/mach/timex.h
 create mode 100644 arch/arm/mach-ux500/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-ux500/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-ux500/timer.c

diff --git a/arch/arm/mach-footbridge/Makefile.boot b/arch/arm/mach-ux500/Makefile.boot
similarity index 100%
copy from arch/arm/mach-footbridge/Makefile.boot
copy to arch/arm/mach-ux500/Makefile.boot
diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
new file mode 100644
index 0000000..6769df8
--- /dev/null
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -0,0 +1,78 @@
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
+static struct map_desc u8500_io_desc[] __initdata = {
+	{
+		.virtual =	IO_ADDRESS(U8500_GIC_CPU_BASE),
+		.pfn =		__phys_to_pfn(U8500_GIC_CPU_BASE),
+		.length =	SZ_4K,
+		.type = 	MT_DEVICE,
+	},
+	{
+		.virtual =	IO_ADDRESS(U8500_GIC_DIST_BASE),
+		.pfn =		__phys_to_pfn(U8500_GIC_DIST_BASE),
+		.length =	SZ_4K,
+		.type = 	MT_DEVICE,
+	},
+	{
+		.virtual =	IO_ADDRESS(U8500_MTU0_BASE),
+		.pfn =		__phys_to_pfn(U8500_MTU0_BASE),
+		.length =	SZ_4K,
+		.type = 	MT_DEVICE,
+	},
+	{
+		.virtual =	IO_ADDRESS(U8500_TWD_BASE),
+		.pfn =		__phys_to_pfn(U8500_TWD_BASE),
+		.length =	SZ_4K,
+		.type = 	MT_DEVICE,
+	},
+	{
+		.virtual =	IO_ADDRESS(U8500_SCU_BASE),
+		.pfn =		__phys_to_pfn(U8500_SCU_BASE),
+		.length =	SZ_4K,
+		.type = 	MT_DEVICE,
+	},
+	{
+		.virtual =	U8500_BACKUPRAM0_VA_BASE,
+		.pfn =		__phys_to_pfn(U8500_BACKUPRAM0_BASE),
+		.length =	SZ_8K,
+		.type = 	MT_DEVICE,
+	},
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
+ * This function is called from the board init ("init_machine").
+ */
+void __init u8500_init_devices(void)
+{
+	return;
+}
diff --git a/arch/arm/mach-ep93xx/include/mach/clkdev.h b/arch/arm/mach-ux500/include/mach/clkdev.h
similarity index 100%
copy from arch/arm/mach-ep93xx/include/mach/clkdev.h
copy to arch/arm/mach-ux500/include/mach/clkdev.h
diff --git a/arch/arm/mach-ux500/include/mach/debug-macro.S b/arch/arm/mach-ux500/include/mach/debug-macro.S
new file mode 100644
index 0000000..8dfa54f
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/debug-macro.S
@@ -0,0 +1,22 @@
+/* arch/arm/mach-u8500/include/mach/debug-macro.S
+ *
+ * Debugging macro include header
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/amba/serial.h>
+		.macro	addruart,rx
+		mrc	p15, 0, \rx, c1, c0
+		tst	\rx, #1			@MMU enabled?
+		moveq	\rx, #0x80007000	@MMU off, Physical address
+		movne	\rx, #0xF0007000	@MMU on, Virtual address
+		.endm
+
+#include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
new file mode 100644
index 0000000..61d9403
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/entry-macro.S
@@ -0,0 +1,80 @@
+/*
+ * Low-level IRQ helper macros for U8500 platforms
+ *
+ * This file is a copy of ARM Realview platform.
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
+		mov 	\tmp, #0
+		cmp	\irqnr, #29
+		moveq	\tmp, #1
+		streq	\irqstat, [\base, #GIC_CPU_EOI]
+		cmp	\tmp, #0
+		.endm
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
new file mode 100644
index 0000000..23fec82
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -0,0 +1,129 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson.
+ *
+ * U8500 hardware definitions
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef __ASM_ARCH_HARDWARE_H
+#define __ASM_ARCH_HARDWARE_H
+
+/* macros to get at IO space when running virtually
+ * We dont map all the peripherals, let ioremap do
+ * this for us. We map only very basic peripherals here.
+ */
+#define U8500_IO_VIRTUAL	0xf0000000
+#define U8500_IO_PHYSICAL	0xa0000000
+
+/* this macro is used in assembly, so no cast */
+#define IO_ADDRESS(x)	((x) - U8500_IO_PHYSICAL + U8500_IO_VIRTUAL)
+
+/* typesafe io address */
+#define __io_address(n)         __io(IO_ADDRESS(n))
+
+/*
+ * Base address definitions for U8500 Onchip IPs. All the
+ * peripherals are contained in a single 1 Mbyte region, with
+ * AHB peripherals at the bottom and APB peripherals at the
+ * top of the region. PER stands for PERIPHERAL region which
+ * itself divided into sub regions.
+ */
+#define U8500_PER3_BASE		0x80000000
+#define U8500_PER2_BASE		0x80110000
+#define U8500_PER1_BASE		0x80120000
+#define U8500_PER4_BASE		0x80150000
+
+#define U8500_PER6_BASE		0xa03c0000
+#define U8500_PER5_BASE		0xa03e0000
+#define U8500_PER7_BASE		0xa03d0000
+
+#define U8500_SVA_BASE		0xa0100000
+#define U8500_SIA_BASE		0xa0200000
+
+#define U8500_SGA_BASE		0xa0300000
+#define U8500_MCDE_BASE		0xa0350000
+#define U8500_DMA_BASE		0xa0362000
+
+#define U8500_SCU_BASE		0xa0410000
+#define U8500_GIC_CPU_BASE	0xa0410100
+#define U8500_TWD_BASE		0xa0410600
+#define U8500_GIC_DIST_BASE	0xa0411000
+#define U8500_L2CC_BASE		0xa0412000
+
+#define U8500_TWD_SIZE		0x100
+
+/* per7 base addressess */
+#define U8500_CR_BASE		(U8500_PER7_BASE + 0x8000)
+#define U8500_MTU0_BASE		(U8500_PER7_BASE + 0xa000)
+#define U8500_MTU1_BASE		(U8500_PER7_BASE + 0xb000)
+#define U8500_TZPC0_BASE	(U8500_PER7_BASE + 0xc000)
+#define U8500_CLKRST7_BASE	(U8500_PER7_BASE + 0xf000)
+
+/* per6 base addressess */
+#define U8500_RNG_BASE		(U8500_PER6_BASE + 0x0000)
+#define U8500_PKA_BASE		(U8500_PER6_BASE + 0x1000)
+#define U8500_PKAM_BASE		(U8500_PER6_BASE + 0x2000)
+#define U8500_CRYPTO0_BASE	(U8500_PER6_BASE + 0xa000)
+#define U8500_CRYPTO1_BASE	(U8500_PER6_BASE + 0xb000)
+#define U8500_CLKRST6_BASE	(U8500_PER7_BASE + 0xf000)
+
+/* per5 base addressess */
+#define U8500_USBOTG_BASE	(U8500_PER5_BASE + 0x00000)
+#define U8500_GPIO5_BASE	(U8500_PER5_BASE + 0x1e000)
+#define U8500_CLKRST5_BASE	(U8500_PER7_BASE + 0x1f000)
+
+/* per4 base addressess */
+#define U8500_BACKUPRAM0_BASE	(U8500_PER4_BASE + 0x0000)
+#define U8500_BACKUPRAM1_BASE	(U8500_PER4_BASE + 0x1000)
+#define U8500_RTT0_BASE		(U8500_PER4_BASE + 0x2000)
+#define U8500_RTT1_BASE		(U8500_PER4_BASE + 0x3000)
+#define U8500_RTC_BASE		(U8500_PER4_BASE + 0x4000)
+#define U8500_SCR_BASE		(U8500_PER4_BASE + 0x5000)
+#define U8500_DMC_BASE		(U8500_PER4_BASE + 0x6000)
+#define U8500_PRCMU_BASE	(U8500_PER4_BASE + 0x7000)
+
+/* per3 base addressess */
+#define U8500_FSMC_BASE		(U8500_PER3_BASE + 0x0000)
+#define U8500_SSP0_BASE		(U8500_PER3_BASE + 0x2000)
+#define U8500_SSP1_BASE		(U8500_PER3_BASE + 0x3000)
+#define U8500_I2C0_BASE		(U8500_PER3_BASE + 0x4000)
+#define U8500_SDI2_BASE		(U8500_PER3_BASE + 0x5000)
+#define U8500_SKE_BASE		(U8500_PER3_BASE + 0x6000)
+#define U8500_UART2_BASE	(U8500_PER3_BASE + 0x7000)
+#define U8500_SDI5_BASE		(U8500_PER3_BASE + 0x8000)
+#define U8500_GPIO3_BASE	(U8500_PER3_BASE + 0xe000)
+#define U8500_CLKRST3_BASE	(U8500_PER7_BASE + 0xf000)
+
+/* per2 base addressess */
+#define U8500_I2C3_BASE		(U8500_PER2_BASE + 0x0000)
+#define U8500_SPI2_BASE		(U8500_PER2_BASE + 0x1000)
+#define U8500_SPI1_BASE		(U8500_PER2_BASE + 0x2000)
+#define U8500_PWL_BASE		(U8500_PER2_BASE + 0x3000)
+#define U8500_SDI4_BASE		(U8500_PER2_BASE + 0x4000)
+#define U8500_MSP2_BASE		(U8500_PER2_BASE + 0x7000)
+#define U8500_SDI1_BASE		(U8500_PER2_BASE + 0x8000)
+#define U8500_SDI3_BASE		(U8500_PER2_BASE + 0x9000)
+#define U8500_SPI0_BASE		(U8500_PER2_BASE + 0xa000)
+#define U8500_HSIR_BASE		(U8500_PER2_BASE + 0xb000)
+#define U8500_HSIT_BASE		(U8500_PER2_BASE + 0xc000)
+#define U8500_GPIO2_BASE	(U8500_PER2_BASE + 0xe000)
+#define U8500_CLKRST2_BASE	(U8500_PER2_BASE + 0xf000)
+
+/* per1 base addresses */
+#define U8500_UART0_BASE	(U8500_PER1_BASE + 0x0000)
+#define U8500_UART1_BASE	(U8500_PER1_BASE + 0x1000)
+#define U8500_I2C1_BASE		(U8500_PER1_BASE + 0x2000)
+#define U8500_MSP0_BASE		(U8500_PER1_BASE + 0x3000)
+#define U8500_MSP1_BASE		(U8500_PER1_BASE + 0x4000)
+#define U8500_SDI0_BASE		(U8500_PER1_BASE + 0x6000)
+#define U8500_I2C2_BASE		(U8500_PER1_BASE + 0x8000)
+#define U8500_SPI3_BASE		(U8500_PER1_BASE + 0x9000)
+#define U8500_SLIM0_BASE	(U8500_PER1_BASE + 0xa000)
+#define U8500_GPIO1_BASE	(U8500_PER1_BASE + 0xe000)
+#define U8500_CLKRST1_BASE	(U8500_PER2_BASE + 0xf000)
+
+#define U8500_BACKUPRAM0_VA_BASE	0xf0413000
+
+#endif				/* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-ux500/include/mach/io.h b/arch/arm/mach-ux500/include/mach/io.h
new file mode 100644
index 0000000..1cf3f44
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/io.h
@@ -0,0 +1,22 @@
+/*
+ * arch/arm/mach-u8500/include/mach/io.h
+ *
+ * Copyright (C) 1997-1999 Russell King
+ *
+ * Modifications:
+ *  06-12-1997	RMK	Created.
+ *  07-04-1999	RMK	Major cleanup
+ */
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
new file mode 100644
index 0000000..fc80ad8
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -0,0 +1,71 @@
+/*
+ *  Copyright (C) 2008 STMicroelectronics
+ *  Copyright (C) 2009 ST-Ericsson.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef ASM_ARCH_IRQS_H
+#define ASM_ARCH_IRQS_H
+
+#include <mach/hardware.h>
+
+#define IRQ_LOCALTIMER                  29
+#define IRQ_LOCALWDOG                   30
+
+/* Shared Peripheral Interrupt */
+#define IRQ_SPI_START			32
+
+/* Interrupt numbers generic for shared peripheral */
+#define IRQ_MTU0		(IRQ_SPI_START + 4)
+#define IRQ_SPI2		(IRQ_SPI_START + 6)
+#define IRQ_SPI0		(IRQ_SPI_START + 8)
+#define IRQ_UART0		(IRQ_SPI_START + 11)
+#define IRQ_I2C3		(IRQ_SPI_START + 12)
+#define IRQ_SSP0		(IRQ_SPI_START + 14)
+#define IRQ_MTU1		(IRQ_SPI_START + 17)
+#define IRQ_RTC_RTT		(IRQ_SPI_START + 18)
+#define IRQ_UART1		(IRQ_SPI_START + 19)
+#define IRQ_I2C0		(IRQ_SPI_START + 21)
+#define IRQ_I2C1		(IRQ_SPI_START + 22)
+#define IRQ_USBOTG		(IRQ_SPI_START + 23)
+#define IRQ_DMA			(IRQ_SPI_START + 25)
+#define IRQ_UART2		(IRQ_SPI_START + 26)
+#define IRQ_HSIR_EXCEP		(IRQ_SPI_START + 29)
+#define IRQ_MSP0		(IRQ_SPI_START + 31)
+#define IRQ_HSIR_CH0_OVRRUN	(IRQ_SPI_START + 32)
+#define IRQ_HSIR_CH1_OVRRUN	(IRQ_SPI_START + 33)
+#define IRQ_HSIR_CH2_OVRRUN	(IRQ_SPI_START + 34)
+#define IRQ_HSIR_CH3_OVRRUN	(IRQ_SPI_START + 35)
+#define STW4500_IRQ		(IRQ_SPI_START + 40)
+#define IRQ_DISP		(IRQ_SPI_START + 48)
+#define IRQ_SPI3		(IRQ_SPI_START + 49)
+#define IRQ_SSP1		(IRQ_SPI_START + 52)
+#define IRQ_I2C2		(IRQ_SPI_START + 55)
+#define IRQ_SDMMC0		(IRQ_SPI_START + 60)
+#define IRQ_MSP1		(IRQ_SPI_START + 62)
+#define IRQ_SPI1		(IRQ_SPI_START + 96)
+#define IRQ_MSP2		(IRQ_SPI_START + 98)
+#define IRQ_SDMMC4		(IRQ_SPI_START + 99)
+#define IRQ_HSIRD0		(IRQ_SPI_START + 104)
+#define IRQ_HSIRD1		(IRQ_SPI_START + 105)
+#define IRQ_HSITD0		(IRQ_SPI_START + 106)
+#define IRQ_HSITD1		(IRQ_SPI_START + 107)
+#define IRQ_GPIO0		(IRQ_SPI_START + 119)
+#define IRQ_GPIO1		(IRQ_SPI_START + 120)
+#define IRQ_GPIO2		(IRQ_SPI_START + 121)
+#define IRQ_GPIO3		(IRQ_SPI_START + 122)
+#define IRQ_GPIO4		(IRQ_SPI_START + 123)
+#define IRQ_GPIO5		(IRQ_SPI_START + 124)
+#define IRQ_GPIO6		(IRQ_SPI_START + 125)
+#define IRQ_GPIO7		(IRQ_SPI_START + 126)
+#define IRQ_GPIO8		(IRQ_SPI_START + 127)
+
+/* There are 128 shared peripheral interrupts assigned to
+ * INTID[160:32]. The first 32 interrupts are reserved.
+ */
+#define NR_IRQS			161
+
+#endif /*ASM_ARCH_IRQS_H*/
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
diff --git a/arch/arm/mach-ux500/include/mach/mtu.h b/arch/arm/mach-ux500/include/mach/mtu.h
new file mode 100644
index 0000000..32380be
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/mtu.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson
+ * MultiTimerUnit register definitions, copied from Nomadik 8815
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __ASM_ARCH_MTU_H
+#define __ASM_ARCH_MTU_H
+
+/*
+ * The MTU device hosts four different counters, with 4 set of
+ * registers. These are register names.
+ */
+
+#define MTU_IMSC	0x00	/* Interrupt mask set/clear */
+#define MTU_RIS		0x04	/* Raw interrupt status */
+#define MTU_MIS		0x08	/* Masked interrupt status */
+#define MTU_ICR		0x0C	/* Interrupt clear register */
+
+/* per-timer registers take 0..3 as argument */
+#define MTU_LR(x)	(0x10 + 0x10 * (x) + 0x00)	/* Load value */
+#define MTU_VAL(x)	(0x10 + 0x10 * (x) + 0x04)	/* Current value */
+#define MTU_CR(x)	(0x10 + 0x10 * (x) + 0x08)	/* Control reg */
+#define MTU_BGLR(x)	(0x10 + 0x10 * (x) + 0x0c)	/* At next overflow */
+
+/* bits for the control register */
+#define MTU_CRn_ENA		0x80
+#define MTU_CRn_PERIODIC	0x40	/* if 0 = free-running */
+#define MTU_CRn_PRESCALE_MASK	0x0c
+#define MTU_CRn_PRESCALE_1		0x00
+#define MTU_CRn_PRESCALE_16		0x04
+#define MTU_CRn_PRESCALE_256		0x08
+#define MTU_CRn_32BITS		0x02
+#define MTU_CRn_ONESHOT		0x01	/* if 0 = wraps reloading from BGLR*/
+
+/* Other registers are usual amba/primecell registers, currently not used */
+#define MTU_ITCR	0xff0
+#define MTU_ITOP	0xff4
+
+#define MTU_PERIPH_ID0	0xfe0
+#define MTU_PERIPH_ID1	0xfe4
+#define MTU_PERIPH_ID2	0xfe8
+#define MTU_PERIPH_ID3	0xfeC
+
+#define MTU_PCELL0	0xff0
+#define MTU_PCELL1	0xff4
+#define MTU_PCELL2	0xff8
+#define MTU_PCELL3	0xffC
+
+#endif /* __ASM_ARCH_MTU_H */
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
new file mode 100644
index 0000000..0807e4f
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -0,0 +1,22 @@
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
+extern struct sys_timer u8500_timer;
+
+#endif /*  __ASM_ARCH_SETUP_H */
diff --git a/arch/arm/mach-ux500/include/mach/smp.h b/arch/arm/mach-ux500/include/mach/smp.h
new file mode 100644
index 0000000..43ec7ad
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/smp.h
@@ -0,0 +1,29 @@
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
index 0000000..0ac9899
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
+#define U8500_UART_DR		0x101FB000
+#define U8500_UART_LCRH		0x101FB02c
+#define U8500_UART_CR		0x101FB030
+#define U8500_UART_FR		0x101FB018
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
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
new file mode 100644
index 0000000..b97c0ba
--- /dev/null
+++ b/arch/arm/mach-ux500/timer.c
@@ -0,0 +1,163 @@
+/*
+ * linux/arch/arm/mach-u8500/timer.c
+ *
+ * Copyright (C) 2008 STMicroelectronics
+ * Copyright (C) 2009 Alessandro Rubini
+ * Copyright (C) 2009 ST-Ericsson.
+ *	Adapted to u8500 platform, heavily based on 8815
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/clockchips.h>
+#include <linux/jiffies.h>
+#include <asm/mach/time.h>
+#include <asm/localtimer.h>
+#include <mach/mtu.h>
+
+static u32	u8500_count;	/* accumulated count */
+static u32	u8500_cycle;	/* write-once */
+static __iomem void *mtu_base;
+
+/*
+ * clocksource: the MTU device is a decrementing counters, so we negate
+ * the value being read.
+ */
+static cycle_t u8500_read_timer(struct clocksource *cs)
+{
+	u32 count = readl(mtu_base + MTU_VAL(0));
+	return u8500_count + u8500_cycle - count;
+}
+
+static struct clocksource u8500_clksrc = {
+	.name		= "mtu_0",
+	.rating		= 400,
+	.read		= u8500_read_timer,
+	.shift		= 20,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+/*
+ * Clockevent device: currently only periodic mode is supported
+ */
+static void u8500_clkevt_mode(enum clock_event_mode mode,
+			     struct clock_event_device *dev)
+{
+	unsigned long flags;
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* enable interrupts -- and count current value? */
+		raw_local_irq_save(flags);
+		writel(readl(mtu_base + MTU_IMSC) | 1, mtu_base + MTU_IMSC);
+		raw_local_irq_restore(flags);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		BUG(); /* Not yet supported */
+		/* FALLTHROUGH */
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		/* disable irq */
+		raw_local_irq_save(flags);
+		writel(readl(mtu_base + MTU_IMSC) & ~1, mtu_base + MTU_IMSC);
+		raw_local_irq_restore(flags);
+		break;
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static struct clock_event_device u8500_clkevt = {
+	.name		= "mtu_0",
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.shift		= 32,
+	.rating		= 400,
+	.set_mode	= u8500_clkevt_mode,
+};
+
+/*
+ * IRQ Handler for the timer 0 of the MTU block. The irq is not shared
+ * as we are the only users of mtu0 by now.
+ */
+static irqreturn_t u8500_timer_interrupt(int irq, void *dev_id)
+{
+	/* ack: "interrupt clear register" */
+	writel(1 << 0, mtu_base + MTU_ICR);
+
+	/* we can't count lost ticks, unfortunately */
+	u8500_count += u8500_cycle;
+	u8500_clkevt.event_handler(&u8500_clkevt);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Set up timer interrupt, and return the current time in seconds.
+ */
+static struct irqaction u8500_timer_irq = {
+	.name		= "U8500 Timer Tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.handler	= u8500_timer_interrupt,
+};
+
+static void u8500_timer_reset(void)
+{
+	u32 cr;
+
+	writel(0, mtu_base + MTU_CR(0)); /* off */
+
+	/* configure load and background-load, and fire it up */
+	writel(u8500_cycle, mtu_base + MTU_LR(0));
+	writel(u8500_cycle, mtu_base + MTU_BGLR(0));
+	cr = MTU_CRn_PERIODIC | MTU_CRn_PRESCALE_1 | MTU_CRn_32BITS;
+	writel(cr, mtu_base + MTU_CR(0));
+	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
+}
+
+static void __init u8500_timer_init(void)
+{
+	unsigned long rate;
+	int bits;
+
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_base = __io_address(U8500_TWD_BASE);
+#endif
+	rate = CLOCK_TICK_RATE; /* 2.4MHz */
+	u8500_cycle = (rate + HZ/2) / HZ;
+
+	/* Save global pointer to mtu, used by functions above */
+	mtu_base = __io_address(U8500_MTU0_BASE);
+
+	/* Init the timer and register clocksource */
+	u8500_timer_reset();
+
+	u8500_clksrc.mult = clocksource_hz2mult(rate, u8500_clksrc.shift);
+	bits =  8*sizeof(u8500_count);
+	u8500_clksrc.mask = CLOCKSOURCE_MASK(bits);
+
+	if (clocksource_register(&u8500_clksrc))
+		printk(KERN_ERR "u8500 timer: failed to initialize clock "
+			"source %s\n", u8500_clksrc.name);
+
+	/* Register irq and clockevents */
+	setup_irq(IRQ_MTU0, &u8500_timer_irq);
+	u8500_clkevt.mult = div_sc(rate, NSEC_PER_SEC, u8500_clkevt.shift);
+	u8500_clkevt.cpumask = cpumask_of(0);
+	clockevents_register_device(&u8500_clkevt);
+}
+
+static void u8500_timer_suspend(void)
+{
+	/* not supported yet */
+}
+
+struct sys_timer u8500_timer = {
+	.init		= u8500_timer_init,
+	.suspend	= u8500_timer_suspend,
+	.resume		= u8500_timer_reset,
+};
-- 
1.6.3.GIT
