From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 17 Nov 2010 19:59:31 +0900
Subject: [PATCH] ARM: mach-shmobile: Initial AG5 and AG5EVM support
Message-ID: <20101117105931.21300.89918.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This patch adds initial support for Renesas SH-Mobile AG5.

At this point the AG5 CPU support is limited to the ARM
core, SCIF serial and a CMT timer together with L2 cache
and the GIC. The AG5EVM board also supports Ethernet.

Future patches will add support for GPIO, INTCS, CPGA
and platform data / driver updates for devices such as
IIC, LCDC, FSI, KEYSC, CEU and SDHI among others.

The code in entry-macro.S will be cleaned up when the
ARM IRQ demux code improvements have been merged.

Depends on the AG5EVM mach-type recently registered but
not yet present in arch/arm/tools/mach-types.

As the AG5EVM board comes with 512MiB memory it is
recommended to turn on HIGHMEM.

Many thanks to Yoshii-san for initial bring up.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Based on the rmobile/core topic branch in the sh git tree.

 arch/arm/mach-shmobile/Kconfig                    |   12 +
 arch/arm/mach-shmobile/Makefile                   |    2 
 arch/arm/mach-shmobile/board-ag5evm.c             |  159 ++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c             |  101 +++++++++
 arch/arm/mach-shmobile/include/mach/common.h      |    4 
 arch/arm/mach-shmobile/include/mach/entry-macro.S |   78 +++++++
 arch/arm/mach-shmobile/include/mach/irqs.h        |    3 
 arch/arm/mach-shmobile/include/mach/sh73a0.h      |    6 
 arch/arm/mach-shmobile/setup-sh73a0.c             |  234 +++++++++++++++++++++
 arch/arm/mm/Kconfig                               |    2 
 drivers/serial/sh-sci.h                           |    7 
 11 files changed, 607 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-11-17 19:26:28.000000000 +0900
@@ -20,6 +20,12 @@ config ARCH_SH7372
 	select SH_CLK_CPG
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 
+config ARCH_SH73A0
+	bool "SH-Mobile AG5 (R8A73A00)"
+	select CPU_V7
+	select SH_CLK_CPG
+	select ARM_GIC
+
 comment "SH-Mobile Board Type"
 
 config MACH_G3EVM
@@ -51,6 +57,10 @@ config AP4EVB_WVGA
 
 endchoice
 
+config MACH_AG5EVM
+	bool "AG5EVM board"
+	depends on ARCH_SH73A0
+
 comment "SH-Mobile System Configuration"
 
 menu "Memory configuration"
@@ -60,6 +70,7 @@ config MEMORY_START
 	default "0x50000000" if MACH_G3EVM
 	default "0x40000000" if MACH_G4EVM
 	default "0x40000000" if MACH_AP4EVB
+	default "0x40000000" if MACH_AG5EVM
 	default "0x00000000"
 	---help---
 	  Tweak this only when porting to a new machine which does not
@@ -71,6 +82,7 @@ config MEMORY_SIZE
 	default "0x08000000" if MACH_G3EVM
 	default "0x08000000" if MACH_G4EVM
 	default "0x10000000" if MACH_AP4EVB
+	default "0x20000000" if MACH_AG5EVM
 	default "0x04000000"
 	help
 	  This sets the default memory size assumed by your kernel. It can
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-11-17 19:25:51.000000000 +0900
@@ -9,6 +9,7 @@ obj-y				:= timer.o console.o clock.o pm
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
 obj-$(CONFIG_ARCH_SH7377)	+= setup-sh7377.o clock-sh7377.o intc-sh7377.o
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
+obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o
 
 # Pinmux setup
 pfc-$(CONFIG_ARCH_SH7367)	:= pfc-sh7367.o
@@ -20,3 +21,4 @@ obj-$(CONFIG_GENERIC_GPIO)	+= $(pfc-y)
 obj-$(CONFIG_MACH_G3EVM)	+= board-g3evm.o
 obj-$(CONFIG_MACH_G4EVM)	+= board-g4evm.o
 obj-$(CONFIG_MACH_AP4EVB)	+= board-ap4evb.o
+obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2010-11-17 19:25:52.000000000 +0900
@@ -0,0 +1,159 @@
+/*
+ * arch/arm/mach-shmobile/board-ag5evm.c
+ *
+ * Copyright (C) 2010  Takashi Yoshii <yoshii.takashi.zj@renesas.com>
+ * Copyright (C) 2009  Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/serial_sci.h>
+#include <linux/smsc911x.h>
+#include <linux/gpio.h>
+#include <mach/hardware.h>
+#include <mach/sh73a0.h>
+#include <mach/common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/traps.h>
+
+static struct resource smsc9220_resources[] = {
+	[0] = {
+		.start		= 0x14000000,
+		.end		= 0x14000000 + SZ_64K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= gic_spi(33), /* PINT1 */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct smsc911x_platform_config smsc9220_platdata = {
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+};
+
+static struct platform_device eth_device = {
+	.name		= "smsc911x",
+	.id		= 0,
+	.dev  = {
+		.platform_data = &smsc9220_platdata,
+	},
+	.resource	= smsc9220_resources,
+	.num_resources	= ARRAY_SIZE(smsc9220_resources),
+};
+
+static struct platform_device *ag5evm_devices[] __initdata = {
+	&eth_device,
+};
+
+static struct map_desc ag5evm_io_desc[] __initdata = {
+	/* create a 1:1 entity map for 0xe6xxxxxx
+	 * used by CPGA, INTC and PFC.
+	 */
+	{
+		.virtual	= 0xe6000000,
+		.pfn		= __phys_to_pfn(0xe6000000),
+		.length		= 256 << 20,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+static void __init ag5evm_map_io(void)
+{
+	iotable_init(ag5evm_io_desc, ARRAY_SIZE(ag5evm_io_desc));
+
+	/* setup early devices and console here as well */
+	sh73a0_add_early_devices();
+	shmobile_setup_console();
+}
+
+#define PINTC_ADDR	0xe6900000
+#define PINTER0A	(PINTC_ADDR + 0xa0)
+#define PINTCR0A	(PINTC_ADDR + 0xb0)
+
+void __init ag5evm_init_irq(void)
+{
+	/* setup PINT: enable PINTA2 as active low */
+	__raw_writel(__raw_readl(PINTER0A) | (1<<29), PINTER0A);
+	__raw_writew(__raw_readw(PINTCR0A) | (2<<10), PINTCR0A);
+
+	gic_dist_init(0, __io(0xf0001000), 29);
+	gic_cpu_init(0, __io(0xf0000100));
+}
+
+#define PORT144CR 0xe6052090
+#define PORT145CR 0xe6052091
+
+#define PORT154CR 0xe605209a
+#define PORT155CR 0xe605209b
+#define PORT156CR 0xe605209c
+#define PORT157CR 0xe605209d
+
+#define PORTR159_128DR 0xe6056004
+
+static void __init ag5evm_init(void)
+{
+	/* enable SCIFA2 */
+	__raw_writeb(0x12, PORT154CR); /* TXD */
+	__raw_writeb(0x22, PORT155CR); /* RXD */
+	__raw_writeb(0x12, PORT156CR); /* RTS */
+	__raw_writeb(0x22, PORT157CR); /* CTS */
+
+	/* enable SMSC911X */
+	__raw_writeb(0x20, PORT144CR); /* PINTA2 */
+	__raw_writeb(0x10, PORT145CR); /* RESET */
+	__raw_writel(__raw_readl(PORTR159_128DR) & ~(1 << 17), PORTR159_128DR);
+
+#ifdef CONFIG_CACHE_L2X0
+	/* Shared attribute override enable, 64K*8way */
+	l2x0_init(__io(0xf0100000), 0x00460000, 0xc2000fff);
+#endif
+	sh73a0_add_standard_devices();
+	platform_add_devices(ag5evm_devices, ARRAY_SIZE(ag5evm_devices));
+}
+
+static void __init ag5evm_timer_init(void)
+{
+	sh73a0_clock_init();
+	shmobile_timer.init();
+	return;
+}
+
+struct sys_timer ag5evm_timer = {
+	.init	= ag5evm_timer_init,
+};
+
+MACHINE_START(AG5EVM, "ag5evm")
+	.map_io		= ag5evm_map_io,
+	.init_irq	= ag5evm_init_irq,
+	.init_machine	= ag5evm_init,
+	.timer		= &ag5evm_timer,
+MACHINE_END
--- /dev/null
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2010-11-17 19:31:15.000000000 +0900
@@ -0,0 +1,101 @@
+/*
+ * sh73a0 clock framework support
+ *
+ * Copyright (C) 2010 Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
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
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/sh_clk.h>
+#include <mach/common.h>
+#include <asm/clkdev.h>
+
+#define SMSTPCR0	0xe6150130
+#define SMSTPCR1	0xe6150134
+#define SMSTPCR2	0xe6150138
+#define SMSTPCR3	0xe615013c
+#define SMSTPCR4	0xe6150140
+#define SMSTPCR5	0xe6150144
+
+/* Fixed 32 KHz root clock from EXTALR pin */
+static struct clk r_clk = {
+	.rate           = 32768,
+};
+
+/* Temporarily fixed 48 MHz SUB clock */
+static struct clk sub_clk = {
+	.rate           = 48000000,
+};
+
+static struct clk *main_clks[] = {
+	&r_clk,
+	&sub_clk,
+};
+
+enum { MSTP219,
+	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
+	MSTP331, MSTP329,
+	MSTP_NR };
+
+#define MSTP(_parent, _reg, _bit, _flags) \
+	SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
+
+static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP219] = MSTP(&sub_clk, SMSTPCR2, 19, 0), /* SCIFA7 */
+	[MSTP207] = MSTP(&sub_clk, SMSTPCR2, 7, 0), /* SCIFA5 */
+	[MSTP206] = MSTP(&sub_clk, SMSTPCR2, 6, 0), /* SCIFB */
+	[MSTP204] = MSTP(&sub_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
+	[MSTP203] = MSTP(&sub_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
+	[MSTP202] = MSTP(&sub_clk, SMSTPCR2, 2, 0), /* SCIFA2 */
+	[MSTP201] = MSTP(&sub_clk, SMSTPCR2, 1, 0), /* SCIFA3 */
+	[MSTP200] = MSTP(&sub_clk, SMSTPCR2, 0, 0), /* SCIFA4 */
+	[MSTP331] = MSTP(&sub_clk, SMSTPCR3, 31, 0), /* SCIFA6 */
+	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
+};
+
+#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
+	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
+	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP202]), /* SCIFA2 */
+	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
+	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
+	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
+	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
+};
+
+void __init sh73a0_clock_init(void)
+{
+	int k, ret = 0;
+
+	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
+		ret = clk_register(main_clks[k]);
+
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	if (!ret)
+		clk_init();
+	else
+		panic("failed to setup sh73a0 clocks\n");
+}
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-11-17 19:25:51.000000000 +0900
@@ -30,4 +30,8 @@ extern void sh7372_pinmux_init(void);
 extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
 
+extern void sh73a0_add_early_devices(void);
+extern void sh73a0_add_standard_devices(void);
+extern void sh73a0_clock_init(void);
+
 #endif /* __ARCH_MACH_COMMON_H */
--- 0001/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ work/arch/arm/mach-shmobile/include/mach/entry-macro.S	2010-11-17 19:30:03.000000000 +0900
@@ -20,6 +20,7 @@
 	.macro  disable_fiq
 	.endm
 
+#if !defined(CONFIG_ARCH_SH73A0)
 	.macro  get_irqnr_preamble, base, tmp
 	ldr     \base, =INTFLGA
 	.endm
@@ -37,3 +38,80 @@
 
 1000:
 	.endm
+#else
+/*
+ * arch/arm/mach-realview/include/mach/entry-macro.S
+ *
+ * Low-level IRQ helper macros for RealView platforms
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <asm/hardware/gic.h>
+
+	.macro	get_irqnr_preamble, base, tmp
+	ldr	\base, =(0xf0000100)
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
+/*
+ * The interrupt numbering scheme is defined in the
+ * interrupt controller spec.  To wit:
+ *
+ * Interrupts 0-15 are IPI
+ * 16-28 are reserved
+ * 29-31 are local.  We allow 30 to be used for the watchdog.
+ * 32-1020 are global
+ * 1021-1022 are reserved
+ * 1023 is "spurious" (no interrupt)
+ *
+ * For now, we ignore all local interrupts so only return an interrupt if it's
+ * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
+ *
+ * A simple read from the controller will tell us the number of the highest
+ * priority enabled interrupt.  We then just need to check whether it is in the
+ * valid range for an IRQ (30-1020 inclusive).
+ */
+
+	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+
+	ldr	\irqstat, [\base, #GIC_CPU_INTACK]
+	/* bits 12-10 = src CPU, 9-0 = int # */
+
+	ldr	\tmp, =1021
+	bic	\irqnr, \irqstat, #0x1c00
+	cmp	\irqnr, #29
+	cmpcc	\irqnr, \irqnr
+	cmpne	\irqnr, \tmp
+	cmpcs	\irqnr, \irqnr
+
+	.endm
+
+	/* We assume that irqstat (the raw value of the IRQ acknowledge
+	 * register) is preserved from the macro above.
+	 * If there is an IPI, we immediately signal end of interrupt on the
+	 * controller, since this requires the original irqstat value which
+	 * we won't easily be able to recreate later.
+	 */
+
+	.macro test_for_ipi, irqnr, irqstat, base, tmp
+	bic	\irqnr, \irqstat, #0x1c00
+	cmp	\irqnr, #16
+	strcc	\irqstat, [\base, #GIC_CPU_EOI]
+	cmpcs	\irqnr, \irqnr
+	.endm
+
+	/* As above, this assumes that irqstat and base are preserved.. */
+
+	.macro test_for_ltirq, irqnr, irqstat, base, tmp
+	bic	\irqnr, \irqstat, #0x1c00
+	mov 	\tmp, #0
+	cmp	\irqnr, #29
+	moveq	\tmp, #1
+	streq	\irqstat, [\base, #GIC_CPU_EOI]
+	cmp	\tmp, #0
+	.endm
+#endif
--- 0001/arch/arm/mach-shmobile/include/mach/irqs.h
+++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2010-11-17 19:25:51.000000000 +0900
@@ -3,6 +3,9 @@
 
 #define NR_IRQS         512
 
+/* GIC */
+#define gic_spi(nr)		((nr) + 32)
+
 /* INTCA */
 #define evt2irq(evt)		(((evt) >> 5) - 16)
 #define irq2evt(irq)		(((irq) + 16) << 5)
--- /dev/null
+++ work/arch/arm/mach-shmobile/include/mach/sh73a0.h	2010-11-17 19:25:52.000000000 +0900
@@ -0,0 +1,6 @@
+#ifndef __ASM_SH73A0_H__
+#define __ASM_SH73A0_H__
+
+/* This will soon be replaced by pinmux enums */
+
+#endif /* __ASM_SH73A0_H__ */
--- /dev/null
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2010-11-17 19:25:52.000000000 +0900
@@ -0,0 +1,234 @@
+/*
+ * sh73a0 processor support
+ *
+ * Copyright (C) 2010  Takashi Yoshii
+ * Copyright (C) 2010  Magnus Damm
+ * Copyright (C) 2008  Yoshihiro Shimoda
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/io.h>
+#include <linux/serial_sci.h>
+#include <linux/sh_intc.h>
+#include <linux/sh_timer.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xe6c40000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { gic_spi(72), gic_spi(72),
+			    gic_spi(72), gic_spi(72) },
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xe6c50000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { gic_spi(73), gic_spi(73),
+			    gic_spi(73), gic_spi(73) },
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif1_platform_data,
+	},
+};
+
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xe6c60000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { gic_spi(74), gic_spi(74),
+			    gic_spi(74), gic_spi(74) },
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &scif2_platform_data,
+	},
+};
+
+static struct plat_sci_port scif3_platform_data = {
+	.mapbase	= 0xe6c70000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { gic_spi(75), gic_spi(75),
+			    gic_spi(75), gic_spi(75) },
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id		= 3,
+	.dev		= {
+		.platform_data	= &scif3_platform_data,
+	},
+};
+
+static struct plat_sci_port scif4_platform_data = {
+	.mapbase	= 0xe6c80000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { gic_spi(78), gic_spi(78),
+			    gic_spi(78), gic_spi(78) },
+};
+
+static struct platform_device scif4_device = {
+	.name		= "sh-sci",
+	.id		= 4,
+	.dev		= {
+		.platform_data	= &scif4_platform_data,
+	},
+};
+
+static struct plat_sci_port scif5_platform_data = {
+	.mapbase	= 0xe6cb0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { gic_spi(79), gic_spi(79),
+			    gic_spi(79), gic_spi(79) },
+};
+
+static struct platform_device scif5_device = {
+	.name		= "sh-sci",
+	.id		= 5,
+	.dev		= {
+		.platform_data	= &scif5_platform_data,
+	},
+};
+
+static struct plat_sci_port scif6_platform_data = {
+	.mapbase	= 0xe6cc0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { gic_spi(156), gic_spi(156),
+			    gic_spi(156), gic_spi(156) },
+};
+
+static struct platform_device scif6_device = {
+	.name		= "sh-sci",
+	.id		= 6,
+	.dev		= {
+		.platform_data	= &scif6_platform_data,
+	},
+};
+
+static struct plat_sci_port scif7_platform_data = {
+	.mapbase	= 0xe6cd0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { gic_spi(143), gic_spi(143),
+			    gic_spi(143), gic_spi(143) },
+};
+
+static struct platform_device scif7_device = {
+	.name		= "sh-sci",
+	.id		= 7,
+	.dev		= {
+		.platform_data	= &scif7_platform_data,
+	},
+};
+
+static struct plat_sci_port scif8_platform_data = {
+	.mapbase	= 0xe6c30000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFB,
+	.irqs		= { gic_spi(80), gic_spi(80),
+			    gic_spi(80), gic_spi(80) },
+};
+
+static struct platform_device scif8_device = {
+	.name		= "sh-sci",
+	.id		= 8,
+	.dev		= {
+		.platform_data	= &scif8_platform_data,
+	},
+};
+
+static struct sh_timer_config cmt10_platform_data = {
+	.name = "CMT10",
+	.channel_offset = 0x10,
+	.timer_bit = 0,
+	.clockevent_rating = 125,
+	.clocksource_rating = 125,
+};
+
+static struct resource cmt10_resources[] = {
+	[0] = {
+		.name	= "CMT10",
+		.start	= 0xe6138010,
+		.end	= 0xe613801b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(65),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt10_device = {
+	.name		= "sh_cmt",
+	.id		= 10,
+	.dev = {
+		.platform_data	= &cmt10_platform_data,
+	},
+	.resource	= cmt10_resources,
+	.num_resources	= ARRAY_SIZE(cmt10_resources),
+};
+
+static struct platform_device *sh73a0_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&scif6_device,
+	&scif7_device,
+	&scif8_device,
+	&cmt10_device,
+};
+
+void __init sh73a0_add_standard_devices(void)
+{
+	platform_add_devices(sh73a0_early_devices,
+			    ARRAY_SIZE(sh73a0_early_devices));
+}
+
+void __init sh73a0_add_early_devices(void)
+{
+	early_platform_add_devices(sh73a0_early_devices,
+				   ARRAY_SIZE(sh73a0_early_devices));
+}
--- 0001/arch/arm/mm/Kconfig
+++ work/arch/arm/mm/Kconfig	2010-11-17 19:25:51.000000000 +0900
@@ -772,7 +772,7 @@ config CACHE_L2X0
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_S5PV310 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4
+		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
--- 0001/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2010-11-17 19:25:51.000000000 +0900
@@ -31,6 +31,7 @@
 # define SCSCR_INIT(port) (port->mapbase == SCIF2) ? 0xF3 : 0xF0
 #elif defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+      defined(CONFIG_ARCH_SH73A0) || \
       defined(CONFIG_ARCH_SH7367) || \
       defined(CONFIG_ARCH_SH7377) || \
       defined(CONFIG_ARCH_SH7372)
@@ -244,6 +245,7 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_ARCH_SH73A0) || \
     defined(CONFIG_ARCH_SH7367) || \
     defined(CONFIG_ARCH_SH7377) || \
     defined(CONFIG_ARCH_SH7372)
@@ -280,6 +282,7 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_ARCH_SH73A0) || \
     defined(CONFIG_ARCH_SH7367) || \
     defined(CONFIG_ARCH_SH7377) || \
     defined(CONFIG_ARCH_SH7372)
@@ -378,6 +381,7 @@
   }
 
 #if defined(CONFIG_CPU_SH3) || \
+    defined(CONFIG_ARCH_SH73A0) || \
     defined(CONFIG_ARCH_SH7367) || \
     defined(CONFIG_ARCH_SH7377) || \
     defined(CONFIG_ARCH_SH7372)
@@ -391,6 +395,7 @@
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+      defined(CONFIG_ARCH_SH73A0) || \
       defined(CONFIG_ARCH_SH7367) || \
       defined(CONFIG_ARCH_SH7377)
 #define SCIF_FNS(name, scif_offset, scif_size) \
@@ -433,6 +438,7 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_ARCH_SH73A0) || \
     defined(CONFIG_ARCH_SH7367) || \
     defined(CONFIG_ARCH_SH7377)
 
@@ -632,6 +638,7 @@ static inline int sci_rxd_in(struct uart
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+      defined(CONFIG_ARCH_SH73A0) || \
       defined(CONFIG_ARCH_SH7367) || \
       defined(CONFIG_ARCH_SH7377) || \
       defined(CONFIG_ARCH_SH7372)
