From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  7 Jan 2011 20:00:22 +0000
Subject: [PATCH] ARM: aaec2000: remove support for mach-aaec2000
Message-ID: <1294430422-939-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-aaec2000 is no longer actively maintained and is only receiving
fixups to remain building with other kernel updates.

Cc: Bellido Nicolas <ml@acolin.be>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                                  |   11 -
 arch/arm/Makefile                                 |    1 -
 arch/arm/mach-aaec2000/Kconfig                    |   11 -
 arch/arm/mach-aaec2000/Makefile                   |    9 -
 arch/arm/mach-aaec2000/Makefile.boot              |    1 -
 arch/arm/mach-aaec2000/aaed2000.c                 |  102 -------
 arch/arm/mach-aaec2000/core.c                     |  298 ---------------------
 arch/arm/mach-aaec2000/core.h                     |   28 --
 arch/arm/mach-aaec2000/include/mach/aaec2000.h    |  207 --------------
 arch/arm/mach-aaec2000/include/mach/aaed2000.h    |   40 ---
 arch/arm/mach-aaec2000/include/mach/debug-macro.S |   35 ---
 arch/arm/mach-aaec2000/include/mach/entry-macro.S |   40 ---
 arch/arm/mach-aaec2000/include/mach/hardware.h    |   50 ----
 arch/arm/mach-aaec2000/include/mach/io.h          |   18 --
 arch/arm/mach-aaec2000/include/mach/irqs.h        |   46 ----
 arch/arm/mach-aaec2000/include/mach/memory.h      |   17 --
 arch/arm/mach-aaec2000/include/mach/system.h      |   24 --
 arch/arm/mach-aaec2000/include/mach/timex.h       |   18 --
 arch/arm/mach-aaec2000/include/mach/uncompress.h  |   46 ----
 arch/arm/mach-aaec2000/include/mach/vmalloc.h     |   16 --
 20 files changed, 0 insertions(+), 1018 deletions(-)
 delete mode 100644 arch/arm/mach-aaec2000/Kconfig
 delete mode 100644 arch/arm/mach-aaec2000/Makefile
 delete mode 100644 arch/arm/mach-aaec2000/Makefile.boot
 delete mode 100644 arch/arm/mach-aaec2000/aaed2000.c
 delete mode 100644 arch/arm/mach-aaec2000/core.c
 delete mode 100644 arch/arm/mach-aaec2000/core.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/aaec2000.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/aaed2000.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/io.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/memory.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/system.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/timex.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-aaec2000/include/mach/vmalloc.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e0b40ae..985f98d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -217,15 +217,6 @@ choice
 	prompt "ARM system type"
 	default ARCH_VERSATILE
 
-config ARCH_AAEC2000
-	bool "Agilent AAEC-2000 based"
-	select CPU_ARM920T
-	select ARM_AMBA
-	select HAVE_CLK
-	select ARCH_USES_GETTIMEOFFSET
-	help
-	  This enables support for systems based on the Agilent AAEC-2000
-
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	select ARM_AMBA
@@ -886,8 +877,6 @@ endchoice
 # Kconfigs may be included either alphabetically (according to the
 # plat- suffix) or along side the corresponding mach-* source.
 #
-source "arch/arm/mach-aaec2000/Kconfig"
-
 source "arch/arm/mach-at91/Kconfig"
 
 source "arch/arm/mach-bcmring/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c22c1ad..3920939 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -126,7 +126,6 @@ endif
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-machine-$(CONFIG_ARCH_AAEC2000)		:= aaec2000
 machine-$(CONFIG_ARCH_AT91)		:= at91
 machine-$(CONFIG_ARCH_BCMRING)		:= bcmring
 machine-$(CONFIG_ARCH_CLPS711X)		:= clps711x
diff --git a/arch/arm/mach-aaec2000/Kconfig b/arch/arm/mach-aaec2000/Kconfig
deleted file mode 100644
index 5e4bef9..0000000
--- a/arch/arm/mach-aaec2000/Kconfig
+++ /dev/null
@@ -1,11 +0,0 @@
-if ARCH_AAEC2000
-
-menu "Agilent AAEC-2000 Implementations"
-
-config MACH_AAED2000
-	bool "Agilent AAED-2000 Development Platform"
-	select CPU_ARM920T
-
-endmenu
-
-endif
diff --git a/arch/arm/mach-aaec2000/Makefile b/arch/arm/mach-aaec2000/Makefile
deleted file mode 100644
index 20ec838..0000000
--- a/arch/arm/mach-aaec2000/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-# Common support (must be linked before board specific support)
-obj-y += core.o
-
-# Specific board support
-obj-$(CONFIG_MACH_AAED2000) += aaed2000.o
diff --git a/arch/arm/mach-aaec2000/Makefile.boot b/arch/arm/mach-aaec2000/Makefile.boot
deleted file mode 100644
index 8f5a8b7..0000000
--- a/arch/arm/mach-aaec2000/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-	zreladdr-y := 0xf0008000
diff --git a/arch/arm/mach-aaec2000/aaed2000.c b/arch/arm/mach-aaec2000/aaed2000.c
deleted file mode 100644
index 0eb3e3e..0000000
--- a/arch/arm/mach-aaec2000/aaed2000.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- *  linux/arch/arm/mach-aaec2000/aaed2000.c
- *
- *  Support for the Agilent AAED-2000 Development Platform.
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/major.h>
-#include <linux/interrupt.h>
-
-#include <asm/setup.h>
-#include <asm/memory.h>
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/irq.h>
-
-#include <mach/aaed2000.h>
-
-#include "core.h"
-
-static void aaed2000_clcd_disable(struct clcd_fb *fb)
-{
-	AAED_EXT_GPIO &= ~AAED_EGPIO_LCD_PWR_EN;
-}
-
-static void aaed2000_clcd_enable(struct clcd_fb *fb)
-{
-	AAED_EXT_GPIO |= AAED_EGPIO_LCD_PWR_EN;
-}
-
-struct aaec2000_clcd_info clcd_info = {
-	.enable = aaed2000_clcd_enable,
-	.disable = aaed2000_clcd_disable,
-	.panel = {
-		.mode	= {
-			.name		= "Sharp",
-			.refresh	= 60,
-			.xres		= 640,
-			.yres		= 480,
-			.pixclock	= 39721,
-			.left_margin	= 20,
-			.right_margin	= 44,
-			.upper_margin	= 21,
-			.lower_margin	= 34,
-			.hsync_len	= 96,
-			.vsync_len	= 2,
-			.sync		= 0,
-			.vmode	= FB_VMODE_NONINTERLACED,
-		},
-		.width	= -1,
-		.height	= -1,
-		.tim2	= TIM2_IVS | TIM2_IHS,
-		.cntl	= CNTL_LCDTFT,
-		.bpp	= 16,
-	},
-};
-
-static void __init aaed2000_init_irq(void)
-{
-	aaec2000_init_irq();
-}
-
-static void __init aaed2000_init(void)
-{
-	aaec2000_set_clcd_plat_data(&clcd_info);
-}
-
-static struct map_desc aaed2000_io_desc[] __initdata = {
-	{
-		.virtual	= EXT_GPIO_VBASE,
-		.pfn            = __phys_to_pfn(EXT_GPIO_PBASE),
-		.length         = EXT_GPIO_LENGTH,
-		.type           = MT_DEVICE
-	},
-};
-
-static void __init aaed2000_map_io(void)
-{
-	aaec2000_map_io();
-	iotable_init(aaed2000_io_desc, ARRAY_SIZE(aaed2000_io_desc));
-}
-
-MACHINE_START(AAED2000, "Agilent AAED-2000 Development Platform")
-	/* Maintainer: Nicolas Bellido Y Ortega */
-	.map_io		= aaed2000_map_io,
-	.init_irq	= aaed2000_init_irq,
-	.timer		= &aaec2000_timer,
-	.init_machine	= aaed2000_init,
-MACHINE_END
diff --git a/arch/arm/mach-aaec2000/core.c b/arch/arm/mach-aaec2000/core.c
deleted file mode 100644
index 3ef6833..0000000
--- a/arch/arm/mach-aaec2000/core.c
+++ /dev/null
@@ -1,298 +0,0 @@
-/*
- *  linux/arch/arm/mach-aaec2000/core.c
- *
- *  Code common to all AAEC-2000 machines
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
-#include <linux/timex.h>
-#include <linux/signal.h>
-#include <linux/clk.h>
-#include <linux/gfp.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm/sizes.h>
-
-#include <asm/mach/flash.h>
-#include <asm/mach/irq.h>
-#include <asm/mach/time.h>
-#include <asm/mach/map.h>
-
-#include "core.h"
-
-/*
- * Common I/O mapping:
- *
- * Static virtual address mappings are as follow:
- *
- * 0xf8000000-0xf8001ffff: Devices connected to APB bus
- * 0xf8002000-0xf8003ffff: Devices connected to AHB bus
- *
- * Below 0xe8000000 is reserved for vm allocation.
- *
- * The machine specific code must provide the extra mapping beside the
- * default mapping provided here.
- */
-static struct map_desc standard_io_desc[] __initdata = {
-	{
-		.virtual	= VIO_APB_BASE,
-		.pfn		= __phys_to_pfn(PIO_APB_BASE),
-		.length		= IO_APB_LENGTH,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= VIO_AHB_BASE,
-		.pfn		= __phys_to_pfn(PIO_AHB_BASE),
-		.length		= IO_AHB_LENGTH,
-		.type		= MT_DEVICE
-	}
-};
-
-void __init aaec2000_map_io(void)
-{
-	iotable_init(standard_io_desc, ARRAY_SIZE(standard_io_desc));
-}
-
-/*
- * Interrupt handling routines
- */
-static void aaec2000_int_ack(unsigned int irq)
-{
-	IRQ_INTSR = 1 << irq;
-}
-
-static void aaec2000_int_mask(unsigned int irq)
-{
-	IRQ_INTENC |= (1 << irq);
-}
-
-static void aaec2000_int_unmask(unsigned int irq)
-{
-	IRQ_INTENS |= (1 << irq);
-}
-
-static struct irq_chip aaec2000_irq_chip = {
-	.ack	= aaec2000_int_ack,
-	.mask	= aaec2000_int_mask,
-	.unmask	= aaec2000_int_unmask,
-};
-
-void __init aaec2000_init_irq(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < NR_IRQS; i++) {
-		set_irq_handler(i, handle_level_irq);
-		set_irq_chip(i, &aaec2000_irq_chip);
-		set_irq_flags(i, IRQF_VALID);
-	}
-
-	/* Disable all interrupts */
-	IRQ_INTENC = 0xffffffff;
-
-	/* Clear any pending interrupts */
-	IRQ_INTSR = IRQ_INTSR;
-}
-
-/*
- * Time keeping
- */
-/* IRQs are disabled before entering here from do_gettimeofday() */
-static unsigned long aaec2000_gettimeoffset(void)
-{
-	unsigned long ticks_to_match, elapsed, usec;
-
-	/* Get ticks before next timer match */
-	ticks_to_match = TIMER1_LOAD - TIMER1_VAL;
-
-	/* We need elapsed ticks since last match */
-	elapsed = LATCH - ticks_to_match;
-
-	/* Now, convert them to usec */
-	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
-
-	return usec;
-}
-
-/* We enter here with IRQs enabled */
-static irqreturn_t
-aaec2000_timer_interrupt(int irq, void *dev_id)
-{
-	/* TODO: Check timer accuracy */
-	timer_tick();
-	TIMER1_CLEAR = 1;
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction aaec2000_timer_irq = {
-	.name		= "AAEC-2000 Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= aaec2000_timer_interrupt,
-};
-
-static void __init aaec2000_timer_init(void)
-{
-	/* Disable timer 1 */
-	TIMER1_CTRL = 0;
-
-	/* We have somehow to generate a 100Hz clock.
-	 * We then use the 508KHz timer in periodic mode.
-	 */
-	TIMER1_LOAD = LATCH;
-	TIMER1_CLEAR = 1; /* Clear interrupt */
-
-	setup_irq(INT_TMR1_OFL, &aaec2000_timer_irq);
-
-	TIMER1_CTRL = TIMER_CTRL_ENABLE |
-	                TIMER_CTRL_PERIODIC |
-	                TIMER_CTRL_CLKSEL_508K;
-}
-
-struct sys_timer aaec2000_timer = {
-	.init		= aaec2000_timer_init,
-	.offset		= aaec2000_gettimeoffset,
-};
-
-static struct clcd_panel mach_clcd_panel;
-
-static int aaec2000_clcd_setup(struct clcd_fb *fb)
-{
-	dma_addr_t dma;
-
-	fb->panel = &mach_clcd_panel;
-
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, SZ_1M,
-			&dma, GFP_KERNEL);
-
-	if (!fb->fb.screen_base) {
-		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
-		return -ENOMEM;
-	}
-
-	fb->fb.fix.smem_start = dma;
-	fb->fb.fix.smem_len = SZ_1M;
-
-	return 0;
-}
-
-static int aaec2000_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
-{
-	return dma_mmap_writecombine(&fb->dev->dev, vma,
-			fb->fb.screen_base,
-			fb->fb.fix.smem_start,
-			fb->fb.fix.smem_len);
-}
-
-static void aaec2000_clcd_remove(struct clcd_fb *fb)
-{
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-			fb->fb.screen_base, fb->fb.fix.smem_start);
-}
-
-static struct clcd_board clcd_plat_data = {
-	.name	= "AAEC-2000",
-	.check	= clcdfb_check,
-	.decode	= clcdfb_decode,
-	.setup	= aaec2000_clcd_setup,
-	.mmap	= aaec2000_clcd_mmap,
-	.remove	= aaec2000_clcd_remove,
-};
-
-static struct amba_device clcd_device = {
-	.dev		= {
-		.init_name		= "mb:16",
-		.coherent_dma_mask	= ~0,
-		.platform_data		= &clcd_plat_data,
-	},
-	.res		= {
-		.start			= AAEC_CLCD_PHYS,
-		.end			= AAEC_CLCD_PHYS + SZ_4K - 1,
-		.flags			= IORESOURCE_MEM,
-	},
-	.irq		= { INT_LCD, NO_IRQ },
-	.periphid	= 0x41110,
-};
-
-static struct amba_device *amba_devs[] __initdata = {
-	&clcd_device,
-};
-
-void clk_disable(struct clk *clk)
-{
-}
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	return 0;
-}
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	return dev && strcmp(dev_name(dev), "mb:16") == 0 ? NULL : ERR_PTR(-ENOENT);
-}
-
-void clk_put(struct clk *clk)
-{
-}
-
-void __init aaec2000_set_clcd_plat_data(struct aaec2000_clcd_info *clcd)
-{
-	clcd_plat_data.enable = clcd->enable;
-	clcd_plat_data.disable = clcd->disable;
-	memcpy(&mach_clcd_panel, &clcd->panel, sizeof(struct clcd_panel));
-}
-
-static struct flash_platform_data aaec2000_flash_data = {
-	.map_name	= "cfi_probe",
-	.width		= 4,
-};
-
-static struct resource aaec2000_flash_resource = {
-	.start		= AAEC_FLASH_BASE,
-	.end		= AAEC_FLASH_BASE + AAEC_FLASH_SIZE,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device aaec2000_flash_device = {
-	.name		= "armflash",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &aaec2000_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &aaec2000_flash_resource,
-};
-
-static int __init aaec2000_init(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
-		struct amba_device *d = amba_devs[i];
-		amba_device_register(d, &iomem_resource);
-	}
-
-	platform_device_register(&aaec2000_flash_device);
-
-	return 0;
-};
-arch_initcall(aaec2000_init);
-
diff --git a/arch/arm/mach-aaec2000/core.h b/arch/arm/mach-aaec2000/core.h
deleted file mode 100644
index 59501b5..0000000
--- a/arch/arm/mach-aaec2000/core.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  linux/arch/arm/mach-aaec2000/core.h
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-
-#include <linux/amba/bus.h>
-#include <linux/amba/clcd.h>
-
-struct sys_timer;
-
-extern struct sys_timer aaec2000_timer;
-extern void __init aaec2000_map_io(void);
-extern void __init aaec2000_init_irq(void);
-
-struct aaec2000_clcd_info {
-	struct clcd_panel panel;
-	void (*disable)(struct clcd_fb *);
-	void (*enable)(struct clcd_fb *);
-};
-
-extern void __init aaec2000_set_clcd_plat_data(struct aaec2000_clcd_info *);
-
diff --git a/arch/arm/mach-aaec2000/include/mach/aaec2000.h b/arch/arm/mach-aaec2000/include/mach/aaec2000.h
deleted file mode 100644
index bc729c4..0000000
--- a/arch/arm/mach-aaec2000/include/mach/aaec2000.h
+++ /dev/null
@@ -1,207 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/aaec2000.h
- *
- *  AAEC-2000 registers definition
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_AAEC2000_H
-#define __ASM_ARCH_AAEC2000_H
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#error You must include hardware.h not this file
-#endif /* __ASM_ARCH_HARDWARE_H */
-
-/* Chip selects */
-#define AAEC_CS0	0x00000000
-#define AAEC_CS1	0x10000000
-#define AAEC_CS2	0x20000000
-#define AAEC_CS3	0x30000000
-
-/* Flash */
-#define AAEC_FLASH_BASE	AAEC_CS0
-#define AAEC_FLASH_SIZE	SZ_64M
-
-/* Interrupt controller */
-#define IRQ_BASE	__REG(0x80000500)
-#define IRQ_INTSR	__REG(0x80000500)	/* Int Status Register */
-#define IRQ_INTRSR	__REG(0x80000504)	/* Int Raw (unmasked) Status */
-#define IRQ_INTENS	__REG(0x80000508)	/* Int Enable Set */
-#define IRQ_INTENC	__REG(0x8000050c)	/* Int Enable Clear */
-
-/* UART 1 */
-#define UART1_BASE	__REG(0x80000600)
-#define UART1_DR	__REG(0x80000600) /* Data/FIFO Register */
-#define UART1_LCR	__REG(0x80000604) /* Link Control Register */
-#define UART1_BRCR	__REG(0x80000608) /* Baud Rate Control Register */
-#define UART1_CR	__REG(0x8000060c) /* Control Register */
-#define UART1_SR	__REG(0x80000610) /* Status Register */
-#define UART1_INT	__REG(0x80000614) /* Interrupt Status Register */
-#define UART1_INTM	__REG(0x80000618) /* Interrupt Mask Register */
-#define UART1_INTRES	__REG(0x8000061c) /* Int Result (masked status) Register */
-
-/* UART 2 */
-#define UART2_BASE	__REG(0x80000700)
-#define UART2_DR	__REG(0x80000700) /* Data/FIFO Register */
-#define UART2_LCR	__REG(0x80000704) /* Link Control Register */
-#define UART2_BRCR	__REG(0x80000708) /* Baud Rate Control Register */
-#define UART2_CR	__REG(0x8000070c) /* Control Register */
-#define UART2_SR	__REG(0x80000710) /* Status Register */
-#define UART2_INT	__REG(0x80000714) /* Interrupt Status Register */
-#define UART2_INTM	__REG(0x80000718) /* Interrupt Mask Register */
-#define UART2_INTRES	__REG(0x8000071c) /* Int Result (masked status) Register */
-
-/* UART 3 */
-#define UART3_BASE	__REG(0x80000800)
-#define UART3_DR	__REG(0x80000800) /* Data/FIFO Register */
-#define UART3_LCR	__REG(0x80000804) /* Link Control Register */
-#define UART3_BRCR	__REG(0x80000808) /* Baud Rate Control Register */
-#define UART3_CR	__REG(0x8000080c) /* Control Register */
-#define UART3_SR	__REG(0x80000810) /* Status Register */
-#define UART3_INT	__REG(0x80000814) /* Interrupt Status Register */
-#define UART3_INTM	__REG(0x80000818) /* Interrupt Mask Register */
-#define UART3_INTRES	__REG(0x8000081c) /* Int Result (masked status) Register */
-
-/* These are used in some places */
-#define _UART1_BASE __PREG(UART1_BASE)
-#define _UART2_BASE __PREG(UART2_BASE)
-#define _UART3_BASE __PREG(UART3_BASE)
-
-/* UART Registers Offsets */
-#define UART_DR		0x00
-#define UART_LCR	0x04
-#define UART_BRCR	0x08
-#define UART_CR		0x0c
-#define UART_SR		0x10
-#define UART_INT	0x14
-#define UART_INTM	0x18
-#define UART_INTRES	0x1c
-
-/* UART_LCR Bitmask */
-#define UART_LCR_BRK	(1 << 0) /* Send Break */
-#define UART_LCR_PEN	(1 << 1) /* Parity Enable */
-#define UART_LCR_EP	(1 << 2) /* Even/Odd Parity */
-#define UART_LCR_S2	(1 << 3) /* One/Two Stop bits */
-#define UART_LCR_FIFO	(1 << 4) /* FIFO Enable */
-#define UART_LCR_WL5	(0 << 5) /* Word Length - 5 bits */
-#define UART_LCR_WL6	(1 << 5) /* Word Length - 6 bits */
-#define UART_LCR_WL7	(1 << 6) /* Word Length - 7 bits */
-#define UART_LCR_WL8	(1 << 7) /* Word Length - 8 bits */
-
-/* UART_CR Bitmask */
-#define UART_CR_EN	(1 << 0) /* UART Enable */
-#define UART_CR_SIR	(1 << 1) /* IrDA SIR Enable */
-#define UART_CR_SIRLP	(1 << 2) /* Low Power IrDA Enable */
-#define UART_CR_RXP	(1 << 3) /* Receive Pin Polarity */
-#define UART_CR_TXP	(1 << 4) /* Transmit Pin Polarity */
-#define UART_CR_MXP	(1 << 5) /* Modem Pin Polarity */
-#define UART_CR_LOOP	(1 << 6) /* Loopback Mode */
-
-/* UART_SR Bitmask */
-#define UART_SR_CTS	(1 << 0) /* Clear To Send Status */
-#define UART_SR_DSR	(1 << 1) /* Data Set Ready Status */
-#define UART_SR_DCD	(1 << 2) /* Data Carrier Detect Status */
-#define UART_SR_TxBSY	(1 << 3) /* Transmitter Busy Status */
-#define UART_SR_RxFE	(1 << 4) /* Receive FIFO Empty Status */
-#define UART_SR_TxFF	(1 << 5) /* Transmit FIFO Full Status */
-#define UART_SR_RxFF	(1 << 6) /* Receive FIFO Full Status */
-#define UART_SR_TxFE	(1 << 7) /* Transmit FIFO Empty Status */
-
-/* UART_INT Bitmask */
-#define UART_INT_RIS	(1 << 0) /* Rx Interrupt */
-#define UART_INT_TIS	(1 << 1) /* Tx Interrupt */
-#define UART_INT_MIS	(1 << 2) /* Modem Interrupt */
-#define UART_INT_RTIS	(1 << 3) /* Receive Timeout Interrupt */
-
-/* Timer 1 */
-#define TIMER1_BASE	__REG(0x80000c00)
-#define TIMER1_LOAD	__REG(0x80000c00)	/* Timer 1 Load Register */
-#define TIMER1_VAL	__REG(0x80000c04)	/* Timer 1 Value Register */
-#define TIMER1_CTRL	__REG(0x80000c08)	/* Timer 1 Control Register */
-#define TIMER1_CLEAR	__REG(0x80000c0c)	/* Timer 1 Clear Register */
-
-/* Timer 2 */
-#define TIMER2_BASE	__REG(0x80000d00)
-#define TIMER2_LOAD	__REG(0x80000d00)	/* Timer 2 Load Register */
-#define TIMER2_VAL	__REG(0x80000d04)	/* Timer 2 Value Register */
-#define TIMER2_CTRL	__REG(0x80000d08)	/* Timer 2 Control Register */
-#define TIMER2_CLEAR	__REG(0x80000d0c)	/* Timer 2 Clear Register */
-
-/* Timer 3 */
-#define TIMER3_BASE	__REG(0x80000e00)
-#define TIMER3_LOAD	__REG(0x80000e00)	/* Timer 3 Load Register */
-#define TIMER3_VAL	__REG(0x80000e04)	/* Timer 3 Value Register */
-#define TIMER3_CTRL	__REG(0x80000e08)	/* Timer 3 Control Register */
-#define TIMER3_CLEAR	__REG(0x80000e0c)	/* Timer 3 Clear Register */
-
-/* Timer Control register bits */
-#define TIMER_CTRL_ENABLE	(1 << 7) /* Enable (Start Timer) */
-#define TIMER_CTRL_PERIODIC	(1 << 6) /* Periodic Running Mode */
-#define TIMER_CTRL_FREE_RUNNING (0 << 6) /* Normal Running Mode */
-#define TIMER_CTRL_CLKSEL_508K	(1 << 3) /* 508KHz Clock select (Timer 1, 2) */
-#define TIMER_CTRL_CLKSEL_2K	(0 << 3) /* 2KHz Clock Select (Timer 1, 2) */
-
-/* Power and State Control */
-#define POWER_BASE	__REG(0x80000400)
-#define POWER_PWRSR	__REG(0x80000400) /* Power Status Register */
-#define POWER_PWRCNT	__REG(0x80000404) /* Power/Clock control */
-#define POWER_HALT	__REG(0x80000408) /* Power Idle Mode */
-#define POWER_STDBY	__REG(0x8000040c) /* Power Standby Mode */
-#define POWER_BLEOI	__REG(0x80000410) /* Battery Low End of Interrupt */
-#define POWER_MCEOI	__REG(0x80000414) /* Media Changed EoI */
-#define POWER_TEOI	__REG(0x80000418) /* Tick EoI */
-#define POWER_STFCLR	__REG(0x8000041c) /* NbFlg, RSTFlg, PFFlg, CLDFlg Clear */
-#define POWER_CLKSET	__REG(0x80000420) /* Clock Speed Control */
-
-/* GPIO Registers */
-#define AAEC_GPIO_PHYS	0x80000e00
-
-#define AAEC_GPIO_PADR		__REG(AAEC_GPIO_PHYS + 0x00)
-#define AAEC_GPIO_PBDR		__REG(AAEC_GPIO_PHYS + 0x04)
-#define AAEC_GPIO_PCDR		__REG(AAEC_GPIO_PHYS + 0x08)
-#define AAEC_GPIO_PDDR		__REG(AAEC_GPIO_PHYS + 0x0c)
-#define AAEC_GPIO_PADDR		__REG(AAEC_GPIO_PHYS + 0x10)
-#define AAEC_GPIO_PBDDR		__REG(AAEC_GPIO_PHYS + 0x14)
-#define AAEC_GPIO_PCDDR		__REG(AAEC_GPIO_PHYS + 0x18)
-#define AAEC_GPIO_PDDDR		__REG(AAEC_GPIO_PHYS + 0x1c)
-#define AAEC_GPIO_PEDR		__REG(AAEC_GPIO_PHYS + 0x20)
-#define AAEC_GPIO_PEDDR		__REG(AAEC_GPIO_PHYS + 0x24)
-#define AAEC_GPIO_KSCAN		__REG(AAEC_GPIO_PHYS + 0x28)
-#define AAEC_GPIO_PINMUX	__REG(AAEC_GPIO_PHYS + 0x2c)
-#define AAEC_GPIO_PFDR		__REG(AAEC_GPIO_PHYS + 0x30)
-#define AAEC_GPIO_PFDDR		__REG(AAEC_GPIO_PHYS + 0x34)
-#define AAEC_GPIO_PGDR		__REG(AAEC_GPIO_PHYS + 0x38)
-#define AAEC_GPIO_PGDDR		__REG(AAEC_GPIO_PHYS + 0x3c)
-#define AAEC_GPIO_PHDR		__REG(AAEC_GPIO_PHYS + 0x40)
-#define AAEC_GPIO_PHDDR		__REG(AAEC_GPIO_PHYS + 0x44)
-#define AAEC_GPIO_RAZ		__REG(AAEC_GPIO_PHYS + 0x48)
-#define AAEC_GPIO_INTTYPE1	__REG(AAEC_GPIO_PHYS + 0x4c)
-#define AAEC_GPIO_INTTYPE2	__REG(AAEC_GPIO_PHYS + 0x50)
-#define AAEC_GPIO_FEOI		__REG(AAEC_GPIO_PHYS + 0x54)
-#define AAEC_GPIO_INTEN		__REG(AAEC_GPIO_PHYS + 0x58)
-#define AAEC_GPIO_INTSTATUS	__REG(AAEC_GPIO_PHYS + 0x5c)
-#define AAEC_GPIO_RAWINTSTATUS	__REG(AAEC_GPIO_PHYS + 0x60)
-#define AAEC_GPIO_DB		__REG(AAEC_GPIO_PHYS + 0x64)
-#define AAEC_GPIO_PAPINDR	__REG(AAEC_GPIO_PHYS + 0x68)
-#define AAEC_GPIO_PBPINDR	__REG(AAEC_GPIO_PHYS + 0x6c)
-#define AAEC_GPIO_PCPINDR	__REG(AAEC_GPIO_PHYS + 0x70)
-#define AAEC_GPIO_PDPINDR	__REG(AAEC_GPIO_PHYS + 0x74)
-#define AAEC_GPIO_PEPINDR	__REG(AAEC_GPIO_PHYS + 0x78)
-#define AAEC_GPIO_PFPINDR	__REG(AAEC_GPIO_PHYS + 0x7c)
-#define AAEC_GPIO_PGPINDR	__REG(AAEC_GPIO_PHYS + 0x80)
-#define AAEC_GPIO_PHPINDR	__REG(AAEC_GPIO_PHYS + 0x84)
-
-#define AAEC_GPIO_PINMUX_PE0CON		(1 << 0)
-#define AAEC_GPIO_PINMUX_PD0CON		(1 << 1)
-#define AAEC_GPIO_PINMUX_CODECON	(1 << 2)
-#define AAEC_GPIO_PINMUX_UART3CON	(1 << 3)
-
-/* LCD Controller */
-#define AAEC_CLCD_PHYS	0x80003000
-
-#endif /* __ARM_ARCH_AAEC2000_H */
diff --git a/arch/arm/mach-aaec2000/include/mach/aaed2000.h b/arch/arm/mach-aaec2000/include/mach/aaed2000.h
deleted file mode 100644
index f821295..0000000
--- a/arch/arm/mach-aaec2000/include/mach/aaed2000.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/aaed2000.h
- *
- *  AAED-2000 specific bits definition
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_AAED2000_H
-#define __ASM_ARCH_AAED2000_H
-
-/* External GPIOs. */
-
-#define EXT_GPIO_PBASE	AAEC_CS3
-#define EXT_GPIO_VBASE	0xf8100000
-#define EXT_GPIO_LENGTH	0x00001000
-
-#define __ext_gpio_p2v(x)	((x) - EXT_GPIO_PBASE + EXT_GPIO_VBASE)
-#define __ext_gpio_v2p(x)	((x) + EXT_GPIO_PBASE - EXT_GPIO_VBASE)
-
-#define __EXT_GPIO_REG(x)	(*((volatile u32 *)__ext_gpio_p2v(x)))
-#define __EXT_GPIO_PREG(x)	(__ext_gpio_v2p((u32)&(x)))
-
-#define AAED_EXT_GPIO	__EXT_GPIO_REG(EXT_GPIO_PBASE)
-
-#define AAED_EGPIO_KBD_SCAN	0x00003fff /* Keyboard scan data */
-#define AAED_EGPIO_PWR_INT	0x00008fff /* Smart battery charger interrupt */
-#define AAED_EGPIO_SWITCHED	0x000f0000 /* DIP Switches */
-#define AAED_EGPIO_USB_VBUS	0x00400000 /* USB Vbus sense */
-#define AAED_EGPIO_LCD_PWR_EN	0x02000000 /* LCD and backlight PWR enable */
-#define AAED_EGPIO_nLED0	0x20000000 /* LED 0 */
-#define AAED_EGPIO_nLED1	0x20000000 /* LED 1 */
-#define AAED_EGPIO_nLED2	0x20000000 /* LED 2 */
-
-
-#endif /* __ARM_ARCH_AAED2000_H */
diff --git a/arch/arm/mach-aaec2000/include/mach/debug-macro.S b/arch/arm/mach-aaec2000/include/mach/debug-macro.S
deleted file mode 100644
index bc7ad55..0000000
--- a/arch/arm/mach-aaec2000/include/mach/debug-macro.S
+++ /dev/null
@@ -1,35 +0,0 @@
-/*  arch/arm/mach-aaec2000/include/mach/debug-macro.S
- *
- *  Debugging macro include header
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#include "hardware.h"
-		.macro	addruart, rp, rv
-		mov	\rp, 0x00000800
-		orr	\rv, \rp, #io_p2v(0x80000000)	@ virtual
-		orr	\rp, \rp, #0x80000000		@ physical
-		.endm
-
-		.macro	senduart,rd,rx
-		str	\rd, [\rx, #0]
-		.endm
-
-		.macro	busyuart,rd,rx
-1002:		ldr	\rd, [\rx, #0x10]
-		tst	\rd, #(1 << 7)
-		beq	1002b
-		.endm
-
-		.macro	waituart,rd,rx
-#if 0
-1001:		ldr	\rd, [\rx, #0x10]
-		tst	\rd, #(1 << 5)
-		beq	1001b
-#endif
-		.endm
diff --git a/arch/arm/mach-aaec2000/include/mach/entry-macro.S b/arch/arm/mach-aaec2000/include/mach/entry-macro.S
deleted file mode 100644
index c8fb344..0000000
--- a/arch/arm/mach-aaec2000/include/mach/entry-macro.S
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/entry-macro.S
- *
- *  Low-level IRQ helper for aaec-2000 based platforms
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-#include <mach/irqs.h>
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  get_irqnr_preamble, base, tmp
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		mov	r4, #0xf8000000
-		add	r4, r4, #0x00000500
-		mov	\base, r4
-		ldr	\irqstat, [\base, #0]
-		cmp	\irqstat, #0
-		bne	1001f
-		ldr	\irqnr, =NR_IRQS+1
-		b       1003f
-1001:		mov	\irqnr, #0
-1002:		ands	\tmp, \irqstat, #1
-		mov	\irqstat, \irqstat, LSR #1
-		add	\irqnr, \irqnr, #1
-		beq	1002b
-		sub	\irqnr, \irqnr, #1
-1003:
-		.endm
diff --git a/arch/arm/mach-aaec2000/include/mach/hardware.h b/arch/arm/mach-aaec2000/include/mach/hardware.h
deleted file mode 100644
index 965a6f6..0000000
--- a/arch/arm/mach-aaec2000/include/mach/hardware.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/hardware.h
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include <asm/sizes.h>
-#include <mach/aaec2000.h>
-
-/* The kernel is loaded at physical address 0xf8000000.
- * We map the IO space a bit after
- */
-#define PIO_APB_BASE	0x80000000
-#define VIO_APB_BASE	0xf8000000
-#define IO_APB_LENGTH	0x2000
-#define PIO_AHB_BASE	0x80002000
-#define VIO_AHB_BASE	0xf8002000
-#define IO_AHB_LENGTH	0x2000
-
-#define VIO_BASE    VIO_APB_BASE
-#define PIO_BASE    PIO_APB_BASE
-
-#define io_p2v(x) ( (x) - PIO_BASE + VIO_BASE )
-#define io_v2p(x) ( (x) + PIO_BASE - VIO_BASE )
-
-#ifndef __ASSEMBLY__
-
-#include <asm/types.h>
-
-/* FIXME: Is it needed to optimize this a la pxa ?? */
-#define __REG(x)    (*((volatile u32 *)io_p2v(x)))
-#define __PREG(x)   (io_v2p((u32)&(x)))
-
-#else /* __ASSEMBLY__ */
-
-#define __REG(x)    io_p2v(x)
-#define __PREG(x)   io_v2p(x)
-
-#endif
-
-#include "aaec2000.h"
-
-#endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-aaec2000/include/mach/io.h b/arch/arm/mach-aaec2000/include/mach/io.h
deleted file mode 100644
index ab4fe5d..0000000
--- a/arch/arm/mach-aaec2000/include/mach/io.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/io.h
- *
- *  Copied from asm/arch/sa1100/io.h
- */
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-#define __mem_pci(a)	(a)
-
-#endif
diff --git a/arch/arm/mach-aaec2000/include/mach/irqs.h b/arch/arm/mach-aaec2000/include/mach/irqs.h
deleted file mode 100644
index bf45c6d..0000000
--- a/arch/arm/mach-aaec2000/include/mach/irqs.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/irqs.h
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_IRQS_H
-#define __ASM_ARCH_IRQS_H
-
-
-#define INT_GPIOF0_FIQ	0  /* External GPIO Port F O Fast Interrupt Input */
-#define INT_BL_FIQ	1  /* Battery Low Fast Interrupt */
-#define INT_WE_FIQ	2  /* Watchdog Expired Fast Interrupt */
-#define INT_MV_FIQ	3  /* Media Changed Interrupt */
-#define INT_SC		4  /* Sound Codec Interrupt */
-#define INT_GPIO1	5  /* GPIO Port F Configurable Int 1 */
-#define INT_GPIO2	6  /* GPIO Port F Configurable Int 2 */
-#define INT_GPIO3	7  /* GPIO Port F Configurable Int 3 */
-#define INT_TMR1_OFL	8  /* Timer 1 Overflow Interrupt */
-#define INT_TMR2_OFL	9  /* Timer 2 Overflow Interrupt */
-#define INT_RTC_CM	10 /* RTC Compare Match Interrupt */
-#define INT_TICK	11 /* 64Hz Tick Interrupt */
-#define INT_UART1	12 /* UART1 Interrupt */
-#define INT_UART2	13 /* UART2 & Modem State Changed Interrupt */
-#define INT_LCD		14 /* LCD Interrupt */
-#define INT_SSI		15 /* SSI End of Transfer Interrupt */
-#define INT_UART3	16 /* UART3 Interrupt */
-#define INT_SCI		17 /* SCI Interrupt */
-#define INT_AAC		18 /* Advanced Audio Codec Interrupt */
-#define INT_MMC		19 /* MMC Interrupt */
-#define INT_USB		20 /* USB Interrupt */
-#define INT_DMA		21 /* DMA Interrupt */
-#define INT_TMR3_UOFL	22 /* Timer 3 Underflow Interrupt */
-#define INT_GPIO4	23 /* GPIO Port F Configurable Int 4 */
-#define INT_GPIO5	24 /* GPIO Port F Configurable Int 4 */
-#define INT_GPIO6	25 /* GPIO Port F Configurable Int 4 */
-#define INT_GPIO7	26 /* GPIO Port F Configurable Int 4 */
-#define INT_BMI		27 /* BMI Interrupt */
-
-#define NR_IRQS		(INT_BMI + 1)
-
-#endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-aaec2000/include/mach/memory.h b/arch/arm/mach-aaec2000/include/mach/memory.h
deleted file mode 100644
index 4f93c56..0000000
--- a/arch/arm/mach-aaec2000/include/mach/memory.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/memory.h
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-
-#define PHYS_OFFSET	UL(0xf0000000)
-
-#endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-aaec2000/include/mach/system.h b/arch/arm/mach-aaec2000/include/mach/system.h
deleted file mode 100644
index fe08ca1..0000000
--- a/arch/arm/mach-aaec2000/include/mach/system.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *  arch/arm/mach-aaed2000/include/mach/system.h
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-	cpu_reset(0);
-}
-
-#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-aaec2000/include/mach/timex.h b/arch/arm/mach-aaec2000/include/mach/timex.h
deleted file mode 100644
index 6c8edf4..0000000
--- a/arch/arm/mach-aaec2000/include/mach/timex.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/timex.h
- *
- *  AAEC-2000 Architecture timex specification
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_TIMEX_H
-#define __ASM_ARCH_TIMEX_H
-
-#define CLOCK_TICK_RATE		508000
-
-#endif /* __ASM_ARCH_TIMEX_H */
diff --git a/arch/arm/mach-aaec2000/include/mach/uncompress.h b/arch/arm/mach-aaec2000/include/mach/uncompress.h
deleted file mode 100644
index 381ecad..0000000
--- a/arch/arm/mach-aaec2000/include/mach/uncompress.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/uncompress.h
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_UNCOMPRESS_H
-#define __ASM_ARCH_UNCOMPRESS_H
-
-#include "hardware.h"
-
-#define UART(x)         (*(volatile unsigned long *)(serial_port + (x)))
-
-static void putc(int c)
-{
-	unsigned long serial_port;
-        do {
-		serial_port = _UART3_BASE;
-		if (UART(UART_CR) & UART_CR_EN) break;
-		serial_port = _UART1_BASE;
-		if (UART(UART_CR) & UART_CR_EN) break;
-		serial_port = _UART2_BASE;
-		if (UART(UART_CR) & UART_CR_EN) break;
-		return;
-	} while (0);
-
-	/* wait for space in the UART's transmitter */
-	while ((UART(UART_SR) & UART_SR_TxFF))
-		barrier();
-
-	/* send the character out. */
-	UART(UART_DR) = c;
-}
-
-static inline void flush(void)
-{
-}
-
-#define arch_decomp_setup()
-#define arch_decomp_wdog()
-
-#endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-aaec2000/include/mach/vmalloc.h b/arch/arm/mach-aaec2000/include/mach/vmalloc.h
deleted file mode 100644
index a6299e8..0000000
--- a/arch/arm/mach-aaec2000/include/mach/vmalloc.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- *  arch/arm/mach-aaec2000/include/mach/vmalloc.h
- *
- *  Copyright (c) 2005 Nicolas Bellido Y Ortega
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END		0xd0000000UL
-
-#endif /* __ASM_ARCH_VMALLOC_H */
-- 
1.7.3.4
