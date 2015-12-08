From: robh@kernel.org (Rob Herring)
Date: Tue,  8 Dec 2015 14:44:17 -0600
Subject: [PATCH 3/4] ARM: versatile: merge mach code into a single file
In-Reply-To: <1449607458-16850-1-git-send-email-robh@kernel.org>
References: <1449607458-16850-1-git-send-email-robh@kernel.org>
Message-ID: <1449607458-16850-4-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT-only support now in place and most of the legacy code removed,
the separation of core.c and versatile_dt.c makes little sense. The
headers in mach include directory also have to move for multi-platform
support, but with a single .c file the remaining definitions needed can
also be moved into the versatile_dt.c.

In the move, the system registers and IB2 registers are converted to
run-time mappings and all register accesses converted to use
readl/writel.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-versatile/Makefile                |   2 +-
 arch/arm/mach-versatile/core.c                  | 331 ------------------------
 arch/arm/mach-versatile/core.h                  |  41 ---
 arch/arm/mach-versatile/include/mach/hardware.h |  32 ---
 arch/arm/mach-versatile/include/mach/platform.h | 242 -----------------
 arch/arm/mach-versatile/versatile_dt.c          | 325 ++++++++++++++++++++++-
 6 files changed, 325 insertions(+), 648 deletions(-)
 delete mode 100644 arch/arm/mach-versatile/core.c
 delete mode 100644 arch/arm/mach-versatile/core.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/platform.h

diff --git a/arch/arm/mach-versatile/Makefile b/arch/arm/mach-versatile/Makefile
index ccef512..41b124b 100644
--- a/arch/arm/mach-versatile/Makefile
+++ b/arch/arm/mach-versatile/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y					:= core.o versatile_dt.o
+obj-y					:= versatile_dt.o
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
deleted file mode 100644
index 072ae19..0000000
--- a/arch/arm/mach-versatile/core.c
+++ /dev/null
@@ -1,331 +0,0 @@
-/*
- *  linux/arch/arm/mach-versatile/core.c
- *
- *  Copyright (C) 1999 - 2003 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/of_platform.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/clcd.h>
-#include <linux/platform_data/video-clcd-versatile.h>
-#include <linux/amba/mmci.h>
-#include <linux/io.h>
-#include <linux/mtd/physmap.h>
-#include <linux/reboot.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
-#include "core.h"
-
-static struct map_desc versatile_io_desc[] __initdata __maybe_unused = {
-	{
-		.virtual	=  IO_ADDRESS(VERSATILE_SYS_BASE),
-		.pfn		= __phys_to_pfn(VERSATILE_SYS_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	=  IO_ADDRESS(VERSATILE_SCTL_BASE),
-		.pfn		= __phys_to_pfn(VERSATILE_SCTL_BASE),
-		.length		= SZ_4K * 9,
-		.type		= MT_DEVICE
-	},
- 	{
-		.virtual	=  IO_ADDRESS(VERSATILE_IB2_BASE),
-		.pfn		= __phys_to_pfn(VERSATILE_IB2_BASE),
-		.length		= SZ_64M,
-		.type		= MT_DEVICE
-	},
-};
-
-void __init versatile_map_io(void)
-{
-	debug_ll_io_init();
-	iotable_init(versatile_io_desc, ARRAY_SIZE(versatile_io_desc));
-}
-
-
-#define VERSATILE_FLASHCTRL    (__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_FLASH_OFFSET)
-
-static void versatile_flash_set_vpp(struct platform_device *pdev, int on)
-{
-	u32 val;
-
-	val = __raw_readl(VERSATILE_FLASHCTRL);
-	if (on)
-		val |= VERSATILE_FLASHPROG_FLVPPEN;
-	else
-		val &= ~VERSATILE_FLASHPROG_FLVPPEN;
-	__raw_writel(val, VERSATILE_FLASHCTRL);
-}
-
-static struct physmap_flash_data versatile_flash_data = {
-	.width			= 4,
-	.set_vpp		= versatile_flash_set_vpp,
-};
-
-static struct resource versatile_flash_resource = {
-	.start			= VERSATILE_FLASH_BASE,
-	.end			= VERSATILE_FLASH_BASE + VERSATILE_FLASH_SIZE - 1,
-	.flags			= IORESOURCE_MEM,
-};
-
-struct platform_device versatile_flash_device = {
-	.name			= "physmap-flash",
-	.id			= 0,
-	.dev			= {
-		.platform_data	= &versatile_flash_data,
-	},
-	.num_resources		= 1,
-	.resource		= &versatile_flash_resource,
-};
-
-#define VERSATILE_SYSMCI	(__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_MCI_OFFSET)
-
-unsigned int mmc_status(struct device *dev)
-{
-	struct amba_device *adev = container_of(dev, struct amba_device, dev);
-	u32 mask;
-
-	if (adev->res.start == VERSATILE_MMCI0_BASE)
-		mask = 1;
-	else
-		mask = 2;
-
-	return readl(VERSATILE_SYSMCI) & mask;
-}
-
-static struct mmci_platform_data mmc0_plat_data = {
-	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.status		= mmc_status,
-	.gpio_wp	= -1,
-	.gpio_cd	= -1,
-};
-
-static struct mmci_platform_data mmc1_plat_data = {
-	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.status		= mmc_status,
-	.gpio_wp	= -1,
-	.gpio_cd	= -1,
-};
-
-/*
- * CLCD support.
- */
-#define SYS_CLCD_MODE_MASK	(3 << 0)
-#define SYS_CLCD_MODE_888	(0 << 0)
-#define SYS_CLCD_MODE_5551	(1 << 0)
-#define SYS_CLCD_MODE_565_RLSB	(2 << 0)
-#define SYS_CLCD_MODE_565_BLSB	(3 << 0)
-#define SYS_CLCD_NLCDIOON	(1 << 2)
-#define SYS_CLCD_VDDPOSSWITCH	(1 << 3)
-#define SYS_CLCD_PWR3V5SWITCH	(1 << 4)
-#define SYS_CLCD_ID_MASK	(0x1f << 8)
-#define SYS_CLCD_ID_SANYO_3_8	(0x00 << 8)
-#define SYS_CLCD_ID_UNKNOWN_8_4	(0x01 << 8)
-#define SYS_CLCD_ID_EPSON_2_2	(0x02 << 8)
-#define SYS_CLCD_ID_SANYO_2_5	(0x07 << 8)
-#define SYS_CLCD_ID_VGA		(0x1f << 8)
-
-static bool is_sanyo_2_5_lcd;
-
-/*
- * Disable all display connectors on the interface module.
- */
-static void versatile_clcd_disable(struct clcd_fb *fb)
-{
-	void __iomem *sys_clcd = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
-	u32 val;
-
-	val = readl(sys_clcd);
-	val &= ~SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH;
-	writel(val, sys_clcd);
-
-	/*
-	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light off
-	 */
-	if (of_machine_is_compatible("arm,versatile-ab") && is_sanyo_2_5_lcd) {
-		void __iomem *versatile_ib2_ctrl = __io_address(VERSATILE_IB2_CTRL);
-		unsigned long ctrl;
-
-		ctrl = readl(versatile_ib2_ctrl);
-		ctrl &= ~0x01;
-		writel(ctrl, versatile_ib2_ctrl);
-	}
-}
-
-/*
- * Enable the relevant connector on the interface module.
- */
-static void versatile_clcd_enable(struct clcd_fb *fb)
-{
-	struct fb_var_screeninfo *var = &fb->fb.var;
-	void __iomem *sys_clcd = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
-	u32 val;
-
-	val = readl(sys_clcd);
-	val &= ~SYS_CLCD_MODE_MASK;
-
-	switch (var->green.length) {
-	case 5:
-		val |= SYS_CLCD_MODE_5551;
-		break;
-	case 6:
-		if (var->red.offset == 0)
-			val |= SYS_CLCD_MODE_565_RLSB;
-		else
-			val |= SYS_CLCD_MODE_565_BLSB;
-		break;
-	case 8:
-		val |= SYS_CLCD_MODE_888;
-		break;
-	}
-
-	/*
-	 * Set the MUX
-	 */
-	writel(val, sys_clcd);
-
-	/*
-	 * And now enable the PSUs
-	 */
-	val |= SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH;
-	writel(val, sys_clcd);
-
-	/*
-	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light on
-	 */
-	if (of_machine_is_compatible("arm,versatile-ab") && is_sanyo_2_5_lcd) {
-		void __iomem *versatile_ib2_ctrl = __io_address(VERSATILE_IB2_CTRL);
-		unsigned long ctrl;
-
-		ctrl = readl(versatile_ib2_ctrl);
-		ctrl |= 0x01;
-		writel(ctrl, versatile_ib2_ctrl);
-	}
-}
-
-/*
- * Detect which LCD panel is connected, and return the appropriate
- * clcd_panel structure.  Note: we do not have any information on
- * the required timings for the 8.4in panel, so we presently assume
- * VGA timings.
- */
-static int versatile_clcd_setup(struct clcd_fb *fb)
-{
-	void __iomem *sys_clcd = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
-	const char *panel_name;
-	u32 val;
-
-	is_sanyo_2_5_lcd = false;
-
-	val = readl(sys_clcd) & SYS_CLCD_ID_MASK;
-	if (val == SYS_CLCD_ID_SANYO_3_8)
-		panel_name = "Sanyo TM38QV67A02A";
-	else if (val == SYS_CLCD_ID_SANYO_2_5) {
-		panel_name = "Sanyo QVGA Portrait";
-		is_sanyo_2_5_lcd = true;
-	} else if (val == SYS_CLCD_ID_EPSON_2_2)
-		panel_name = "Epson L2F50113T00";
-	else if (val == SYS_CLCD_ID_VGA)
-		panel_name = "VGA";
-	else {
-		printk(KERN_ERR "CLCD: unknown LCD panel ID 0x%08x, using VGA\n",
-			val);
-		panel_name = "VGA";
-	}
-
-	fb->panel = versatile_clcd_get_panel(panel_name);
-	if (!fb->panel)
-		return -EINVAL;
-
-	return versatile_clcd_setup_dma(fb, SZ_1M);
-}
-
-static void versatile_clcd_decode(struct clcd_fb *fb, struct clcd_regs *regs)
-{
-	clcdfb_decode(fb, regs);
-
-	/* Always clear BGR for RGB565: we do the routing externally */
-	if (fb->fb.var.green.length == 6)
-		regs->cntl &= ~CNTL_BGR;
-}
-
-static struct clcd_board clcd_plat_data = {
-	.name		= "Versatile",
-	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
-	.check		= clcdfb_check,
-	.decode		= versatile_clcd_decode,
-	.disable	= versatile_clcd_disable,
-	.enable		= versatile_clcd_enable,
-	.setup		= versatile_clcd_setup,
-	.mmap		= versatile_clcd_mmap_dma,
-	.remove		= versatile_clcd_remove_dma,
-};
-
-/*
- * Lookup table for attaching a specific name and platform_data pointer to
- * devices as they get created by of_platform_populate().  Ideally this table
- * would not exist, but the current clock implementation depends on some devices
- * having a specific name.
- */
-struct of_dev_auxdata versatile_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI0_BASE, "fpga:05", &mmc0_plat_data),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI1_BASE, "fpga:0b", &mmc1_plat_data),
-
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_CLCD_BASE, "dev:20", &clcd_plat_data),
-
-	{}
-};
-
-void versatile_restart(enum reboot_mode mode, const char *cmd)
-{
-	void __iomem *sys = __io_address(VERSATILE_SYS_BASE);
-	u32 val;
-
-	val = __raw_readl(sys + VERSATILE_SYS_RESETCTL_OFFSET);
-	val |= 0x105;
-
-	__raw_writel(0xa05f, sys + VERSATILE_SYS_LOCK_OFFSET);
-	__raw_writel(val, sys + VERSATILE_SYS_RESETCTL_OFFSET);
-	__raw_writel(0, sys + VERSATILE_SYS_LOCK_OFFSET);
-}
-
-/* Early initializations */
-void __init versatile_init_early(void)
-{
-	u32 val;
-
-	/*
-	 * set clock frequency:
-	 *	VERSATILE_REFCLK is 32KHz
-	 *	VERSATILE_TIMCLK is 1MHz
-	 */
-	val = readl(__io_address(VERSATILE_SCTL_BASE));
-	writel((VERSATILE_TIMCLK << VERSATILE_TIMER1_EnSel) |
-	       (VERSATILE_TIMCLK << VERSATILE_TIMER2_EnSel) |
-	       (VERSATILE_TIMCLK << VERSATILE_TIMER3_EnSel) |
-	       (VERSATILE_TIMCLK << VERSATILE_TIMER4_EnSel) | val,
-	       __io_address(VERSATILE_SCTL_BASE));
-}
diff --git a/arch/arm/mach-versatile/core.h b/arch/arm/mach-versatile/core.h
deleted file mode 100644
index c3d7157..0000000
--- a/arch/arm/mach-versatile/core.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- *  linux/arch/arm/mach-versatile/core.h
- *
- *  Copyright (C) 2004 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __ASM_ARCH_VERSATILE_H
-#define __ASM_ARCH_VERSATILE_H
-
-#include <linux/amba/bus.h>
-#include <linux/of_platform.h>
-#include <linux/reboot.h>
-
-extern struct platform_device versatile_flash_device;
-
-extern void __init versatile_init_early(void);
-extern void __init versatile_init_irq(void);
-extern void __init versatile_map_io(void);
-extern void versatile_timer_init(void);
-extern void versatile_restart(enum reboot_mode, const char *);
-extern unsigned int mmc_status(struct device *dev);
-#ifdef CONFIG_OF
-extern struct of_dev_auxdata versatile_auxdata_lookup[];
-#endif
-
-#endif
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
deleted file mode 100644
index 22a1158..0000000
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- *  arch/arm/mach-versatile/include/mach/hardware.h
- *
- *  This file contains the hardware definitions of the Versatile boards.
- *
- *  Copyright (C) 2003 ARM Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include <asm/sizes.h>
-
-/* macro to get at MMIO space when running virtually */
-#define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
-
-#define __io_address(n)		((void __iomem __force *)IO_ADDRESS(n))
-
-#endif
diff --git a/arch/arm/mach-versatile/include/mach/platform.h b/arch/arm/mach-versatile/include/mach/platform.h
deleted file mode 100644
index 7fe008b..0000000
--- a/arch/arm/mach-versatile/include/mach/platform.h
+++ /dev/null
@@ -1,242 +0,0 @@
-/*
- * arch/arm/mach-versatile/include/mach/platform.h
- *
- * Copyright (c) ARM Limited 2003.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __address_h
-#define __address_h                     1
-
-/*
- * Memory definitions
- */
-#define VERSATILE_BOOT_ROM_LO          0x30000000		/* DoC Base (64Mb)...*/
-#define VERSATILE_BOOT_ROM_HI          0x30000000
-#define VERSATILE_BOOT_ROM_BASE        VERSATILE_BOOT_ROM_HI	 /*  Normal position */
-#define VERSATILE_BOOT_ROM_SIZE        SZ_64M
-
-#define VERSATILE_SSRAM_BASE           /* VERSATILE_SSMC_BASE ? */
-#define VERSATILE_SSRAM_SIZE           SZ_2M
-
-#define VERSATILE_FLASH_BASE           0x34000000
-#define VERSATILE_FLASH_SIZE           SZ_64M
-
-/* 
- *  SDRAM
- */
-#define VERSATILE_SDRAM_BASE           0x00000000
-
-/* 
- *  Logic expansion modules
- * 
- */
-
-
-/* ------------------------------------------------------------------------
- *  Versatile Registers
- * ------------------------------------------------------------------------
- * 
- */
-#define VERSATILE_SYS_ID_OFFSET               0x00
-#define VERSATILE_SYS_SW_OFFSET               0x04
-#define VERSATILE_SYS_LED_OFFSET              0x08
-#define VERSATILE_SYS_OSC0_OFFSET             0x0C
-
-#if defined(CONFIG_ARCH_VERSATILE_PB)
-#define VERSATILE_SYS_OSC1_OFFSET             0x10
-#define VERSATILE_SYS_OSC2_OFFSET             0x14
-#define VERSATILE_SYS_OSC3_OFFSET             0x18
-#define VERSATILE_SYS_OSC4_OFFSET             0x1C
-#elif defined(CONFIG_MACH_VERSATILE_AB)
-#define VERSATILE_SYS_OSC1_OFFSET             0x1C
-#endif
-
-#define VERSATILE_SYS_OSCCLCD_OFFSET          0x1c
-
-#define VERSATILE_SYS_LOCK_OFFSET             0x20
-#define VERSATILE_SYS_100HZ_OFFSET            0x24
-#define VERSATILE_SYS_CFGDATA1_OFFSET         0x28
-#define VERSATILE_SYS_CFGDATA2_OFFSET         0x2C
-#define VERSATILE_SYS_FLAGS_OFFSET            0x30
-#define VERSATILE_SYS_FLAGSSET_OFFSET         0x30
-#define VERSATILE_SYS_FLAGSCLR_OFFSET         0x34
-#define VERSATILE_SYS_NVFLAGS_OFFSET          0x38
-#define VERSATILE_SYS_NVFLAGSSET_OFFSET       0x38
-#define VERSATILE_SYS_NVFLAGSCLR_OFFSET       0x3C
-#define VERSATILE_SYS_RESETCTL_OFFSET         0x40
-#define VERSATILE_SYS_PCICTL_OFFSET           0x44
-#define VERSATILE_SYS_MCI_OFFSET              0x48
-#define VERSATILE_SYS_FLASH_OFFSET            0x4C
-#define VERSATILE_SYS_CLCD_OFFSET             0x50
-#define VERSATILE_SYS_CLCDSER_OFFSET          0x54
-#define VERSATILE_SYS_BOOTCS_OFFSET           0x58
-#define VERSATILE_SYS_24MHz_OFFSET            0x5C
-#define VERSATILE_SYS_MISC_OFFSET             0x60
-#define VERSATILE_SYS_TEST_OSC0_OFFSET        0x80
-#define VERSATILE_SYS_TEST_OSC1_OFFSET        0x84
-#define VERSATILE_SYS_TEST_OSC2_OFFSET        0x88
-#define VERSATILE_SYS_TEST_OSC3_OFFSET        0x8C
-#define VERSATILE_SYS_TEST_OSC4_OFFSET        0x90
-
-#define VERSATILE_SYS_BASE                    0x10000000
-#define VERSATILE_SYS_ID                      (VERSATILE_SYS_BASE + VERSATILE_SYS_ID_OFFSET)
-#define VERSATILE_SYS_SW                      (VERSATILE_SYS_BASE + VERSATILE_SYS_SW_OFFSET)
-#define VERSATILE_SYS_LED                     (VERSATILE_SYS_BASE + VERSATILE_SYS_LED_OFFSET)
-#define VERSATILE_SYS_OSC0                    (VERSATILE_SYS_BASE + VERSATILE_SYS_OSC0_OFFSET)
-#define VERSATILE_SYS_OSC1                    (VERSATILE_SYS_BASE + VERSATILE_SYS_OSC1_OFFSET)
-
-#if defined(CONFIG_ARCH_VERSATILE_PB)
-#define VERSATILE_SYS_OSC2                    (VERSATILE_SYS_BASE + VERSATILE_SYS_OSC2_OFFSET)
-#define VERSATILE_SYS_OSC3                    (VERSATILE_SYS_BASE + VERSATILE_SYS_OSC3_OFFSET)
-#define VERSATILE_SYS_OSC4                    (VERSATILE_SYS_BASE + VERSATILE_SYS_OSC4_OFFSET)
-#endif
-
-#define VERSATILE_SYS_LOCK                    (VERSATILE_SYS_BASE + VERSATILE_SYS_LOCK_OFFSET)
-#define VERSATILE_SYS_100HZ                   (VERSATILE_SYS_BASE + VERSATILE_SYS_100HZ_OFFSET)
-#define VERSATILE_SYS_CFGDATA1                (VERSATILE_SYS_BASE + VERSATILE_SYS_CFGDATA1_OFFSET)
-#define VERSATILE_SYS_CFGDATA2                (VERSATILE_SYS_BASE + VERSATILE_SYS_CFGDATA2_OFFSET)
-#define VERSATILE_SYS_FLAGS                   (VERSATILE_SYS_BASE + VERSATILE_SYS_FLAGS_OFFSET)
-#define VERSATILE_SYS_FLAGSSET                (VERSATILE_SYS_BASE + VERSATILE_SYS_FLAGSSET_OFFSET)
-#define VERSATILE_SYS_FLAGSCLR                (VERSATILE_SYS_BASE + VERSATILE_SYS_FLAGSCLR_OFFSET)
-#define VERSATILE_SYS_NVFLAGS                 (VERSATILE_SYS_BASE + VERSATILE_SYS_NVFLAGS_OFFSET)
-#define VERSATILE_SYS_NVFLAGSSET              (VERSATILE_SYS_BASE + VERSATILE_SYS_NVFLAGSSET_OFFSET)
-#define VERSATILE_SYS_NVFLAGSCLR              (VERSATILE_SYS_BASE + VERSATILE_SYS_NVFLAGSCLR_OFFSET)
-#define VERSATILE_SYS_RESETCTL                (VERSATILE_SYS_BASE + VERSATILE_SYS_RESETCTL_OFFSET)
-#define VERSATILE_SYS_PCICTL                  (VERSATILE_SYS_BASE + VERSATILE_SYS_PCICTL_OFFSET)
-#define VERSATILE_SYS_MCI                     (VERSATILE_SYS_BASE + VERSATILE_SYS_MCI_OFFSET)
-#define VERSATILE_SYS_FLASH                   (VERSATILE_SYS_BASE + VERSATILE_SYS_FLASH_OFFSET)
-#define VERSATILE_SYS_CLCD                    (VERSATILE_SYS_BASE + VERSATILE_SYS_CLCD_OFFSET)
-#define VERSATILE_SYS_CLCDSER                 (VERSATILE_SYS_BASE + VERSATILE_SYS_CLCDSER_OFFSET)
-#define VERSATILE_SYS_BOOTCS                  (VERSATILE_SYS_BASE + VERSATILE_SYS_BOOTCS_OFFSET)
-#define VERSATILE_SYS_24MHz                   (VERSATILE_SYS_BASE + VERSATILE_SYS_24MHz_OFFSET)
-#define VERSATILE_SYS_MISC                    (VERSATILE_SYS_BASE + VERSATILE_SYS_MISC_OFFSET)
-#define VERSATILE_SYS_TEST_OSC0               (VERSATILE_SYS_BASE + VERSATILE_SYS_TEST_OSC0_OFFSET)
-#define VERSATILE_SYS_TEST_OSC1               (VERSATILE_SYS_BASE + VERSATILE_SYS_TEST_OSC1_OFFSET)
-#define VERSATILE_SYS_TEST_OSC2               (VERSATILE_SYS_BASE + VERSATILE_SYS_TEST_OSC2_OFFSET)
-#define VERSATILE_SYS_TEST_OSC3               (VERSATILE_SYS_BASE + VERSATILE_SYS_TEST_OSC3_OFFSET)
-#define VERSATILE_SYS_TEST_OSC4               (VERSATILE_SYS_BASE + VERSATILE_SYS_TEST_OSC4_OFFSET)
-
-/* 
- * Values for VERSATILE_SYS_RESET_CTRL
- */
-#define VERSATILE_SYS_CTRL_RESET_CONFIGCLR    0x01
-#define VERSATILE_SYS_CTRL_RESET_CONFIGINIT   0x02
-#define VERSATILE_SYS_CTRL_RESET_DLLRESET     0x03
-#define VERSATILE_SYS_CTRL_RESET_PLLRESET     0x04
-#define VERSATILE_SYS_CTRL_RESET_POR          0x05
-#define VERSATILE_SYS_CTRL_RESET_DoC          0x06
-
-#define VERSATILE_SYS_CTRL_LED         (1 << 0)
-
-
-/* ------------------------------------------------------------------------
- *  Versatile control registers
- * ------------------------------------------------------------------------
- */
-
-/* 
- * VERSATILE_IDFIELD
- *
- * 31:24 = manufacturer (0x41 = ARM)
- * 23:16 = architecture (0x08 = AHB system bus, ASB processor bus)
- * 15:12 = FPGA (0x3 = XVC600 or XVC600E)
- * 11:4  = build value
- * 3:0   = revision number (0x1 = rev B (AHB))
- */
-
-/*
- * VERSATILE_SYS_LOCK
- *     control access to SYS_OSCx, SYS_CFGDATAx, SYS_RESETCTL, 
- *     SYS_CLD, SYS_BOOTCS
- */
-#define VERSATILE_SYS_LOCK_LOCKED    (1 << 16)
-#define VERSATILE_SYS_LOCKVAL_MASK	0xFFFF		/* write 0xA05F to enable write access */
-
-/*
- * VERSATILE_SYS_FLASH
- */
-#define VERSATILE_FLASHPROG_FLVPPEN	(1 << 0)	/* Enable writing to flash */
-
-/*
- * VERSATILE_INTREG
- *     - used to acknowledge and control MMCI and UART interrupts 
- */
-#define VERSATILE_INTREG_WPROT        0x00    /* MMC protection status (no interrupt generated) */
-#define VERSATILE_INTREG_RI0          0x01    /* Ring indicator UART0 is asserted,              */
-#define VERSATILE_INTREG_CARDIN       0x08    /* MMCI card in detect                            */
-                                                /* write 1 to acknowledge and clear               */
-#define VERSATILE_INTREG_RI1          0x02    /* Ring indicator UART1 is asserted,              */
-#define VERSATILE_INTREG_CARDINSERT   0x03    /* Signal insertion of MMC card                   */
-
-/*
- * VERSATILE peripheral addresses
- */
-#define VERSATILE_MMCI0_BASE           0x10005000	/* MMC interface */
-#define VERSATILE_MMCI1_BASE           0x1000B000    /* MMC Interface */
-#define VERSATILE_CLCD_BASE            0x10120000	/* CLCD */
-#define VERSATILE_SCTL_BASE            0x101E0000	/* System controller */
-#define VERSATILE_IB2_BASE             0x24000000	/* IB2 module */
-
-/*
- *  LED settings, bits [7:0]
- */
-#define VERSATILE_SYS_LED0             (1 << 0)
-#define VERSATILE_SYS_LED1             (1 << 1)
-#define VERSATILE_SYS_LED2             (1 << 2)
-#define VERSATILE_SYS_LED3             (1 << 3)
-#define VERSATILE_SYS_LED4             (1 << 4)
-#define VERSATILE_SYS_LED5             (1 << 5)
-#define VERSATILE_SYS_LED6             (1 << 6)
-#define VERSATILE_SYS_LED7             (1 << 7)
-
-#define ALL_LEDS                  0xFF
-
-#define LED_BANK                  VERSATILE_SYS_LED
-
-/* 
- * Control registers
- */
-#define VERSATILE_IDFIELD_OFFSET	0x0	/* Versatile build information */
-#define VERSATILE_FLASHPROG_OFFSET	0x4	/* Flash devices */
-#define VERSATILE_INTREG_OFFSET		0x8	/* Interrupt control */
-#define VERSATILE_DECODE_OFFSET		0xC	/* Fitted logic modules */
-
-/*
- * System controller bit assignment
- */
-#define VERSATILE_REFCLK	0
-#define VERSATILE_TIMCLK	1
-
-#define VERSATILE_TIMER1_EnSel	15
-#define VERSATILE_TIMER2_EnSel	17
-#define VERSATILE_TIMER3_EnSel	19
-#define VERSATILE_TIMER4_EnSel	21
-
-
-/*
- * IB2 Versatile/AB expansion board definitions
- */
-/* VICINTSOURCE27 */
-#define VERSATILE_IB2_INT_BASE		(VERSATILE_IB2_BASE + 0x02000000)
-#define VERSATILE_IB2_IER		(VERSATILE_IB2_INT_BASE + 0)
-#define VERSATILE_IB2_ISR		(VERSATILE_IB2_INT_BASE + 4)
-
-#define VERSATILE_IB2_CTL_BASE		(VERSATILE_IB2_BASE + 0x03000000)
-#define VERSATILE_IB2_CTRL		(VERSATILE_IB2_CTL_BASE + 0)
-#define VERSATILE_IB2_STAT		(VERSATILE_IB2_CTL_BASE + 4)
-
-#endif
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 86fa2d3..c448718 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -28,13 +28,334 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
+#include <linux/platform_data/video-clcd-versatile.h>
+#include <linux/amba/mmci.h>
+#include <linux/mtd/physmap.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 
-#include "core.h"
+/* macro to get at MMIO space when running virtually */
+#define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
+#define __io_address(n)		((void __iomem __force *)IO_ADDRESS(n))
 
+/*
+ * Memory definitions
+ */
+#define VERSATILE_FLASH_BASE           0x34000000
+#define VERSATILE_FLASH_SIZE           SZ_64M
+
+/*
+ * ------------------------------------------------------------------------
+ *  Versatile Registers
+ * ------------------------------------------------------------------------
+ */
+#define VERSATILE_SYS_LOCK_OFFSET             0x20
+#define VERSATILE_SYS_RESETCTL_OFFSET         0x40
 #define VERSATILE_SYS_PCICTL_OFFSET           0x44
+#define VERSATILE_SYS_MCI_OFFSET              0x48
+#define VERSATILE_SYS_FLASH_OFFSET            0x4C
+#define VERSATILE_SYS_CLCD_OFFSET             0x50
+
+/*
+ * VERSATILE_SYS_FLASH
+ */
+#define VERSATILE_FLASHPROG_FLVPPEN	(1 << 0)	/* Enable writing to flash */
+
+/*
+ * VERSATILE peripheral addresses
+ */
+#define VERSATILE_MMCI0_BASE           0x10005000	/* MMC interface */
+#define VERSATILE_MMCI1_BASE           0x1000B000	/* MMC Interface */
+#define VERSATILE_CLCD_BASE            0x10120000	/* CLCD */
+#define VERSATILE_SCTL_BASE            0x101E0000	/* System controller */
+#define VERSATILE_IB2_BASE             0x24000000	/* IB2 module */
+#define VERSATILE_IB2_CTL_BASE		(VERSATILE_IB2_BASE + 0x03000000)
+
+/*
+ * System controller bit assignment
+ */
+#define VERSATILE_REFCLK	0
+#define VERSATILE_TIMCLK	1
+
+#define VERSATILE_TIMER1_EnSel	15
+#define VERSATILE_TIMER2_EnSel	17
+#define VERSATILE_TIMER3_EnSel	19
+#define VERSATILE_TIMER4_EnSel	21
+
 static void __iomem *versatile_sys_base;
+static void __iomem *versatile_ib2_ctrl;
+
+static void versatile_flash_set_vpp(struct platform_device *pdev, int on)
+{
+	u32 val;
+
+	val = readl(versatile_sys_base + VERSATILE_SYS_FLASH_OFFSET);
+	if (on)
+		val |= VERSATILE_FLASHPROG_FLVPPEN;
+	else
+		val &= ~VERSATILE_FLASHPROG_FLVPPEN;
+	writel(val, versatile_sys_base + VERSATILE_SYS_FLASH_OFFSET);
+}
+
+static struct physmap_flash_data versatile_flash_data = {
+	.width			= 4,
+	.set_vpp		= versatile_flash_set_vpp,
+};
+
+static struct resource versatile_flash_resource = {
+	.start			= VERSATILE_FLASH_BASE,
+	.end			= VERSATILE_FLASH_BASE + VERSATILE_FLASH_SIZE - 1,
+	.flags			= IORESOURCE_MEM,
+};
+
+struct platform_device versatile_flash_device = {
+	.name			= "physmap-flash",
+	.id			= 0,
+	.dev			= {
+		.platform_data	= &versatile_flash_data,
+	},
+	.num_resources		= 1,
+	.resource		= &versatile_flash_resource,
+};
+
+unsigned int mmc_status(struct device *dev)
+{
+	struct amba_device *adev = container_of(dev, struct amba_device, dev);
+	u32 mask;
+
+	if (adev->res.start == VERSATILE_MMCI0_BASE)
+		mask = 1;
+	else
+		mask = 2;
+
+	return readl(versatile_sys_base + VERSATILE_SYS_MCI_OFFSET) & mask;
+}
+
+static struct mmci_platform_data mmc0_plat_data = {
+	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
+	.status		= mmc_status,
+	.gpio_wp	= -1,
+	.gpio_cd	= -1,
+};
+
+static struct mmci_platform_data mmc1_plat_data = {
+	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
+	.status		= mmc_status,
+	.gpio_wp	= -1,
+	.gpio_cd	= -1,
+};
+
+/*
+ * CLCD support.
+ */
+#define SYS_CLCD_MODE_MASK	(3 << 0)
+#define SYS_CLCD_MODE_888	(0 << 0)
+#define SYS_CLCD_MODE_5551	(1 << 0)
+#define SYS_CLCD_MODE_565_RLSB	(2 << 0)
+#define SYS_CLCD_MODE_565_BLSB	(3 << 0)
+#define SYS_CLCD_NLCDIOON	(1 << 2)
+#define SYS_CLCD_VDDPOSSWITCH	(1 << 3)
+#define SYS_CLCD_PWR3V5SWITCH	(1 << 4)
+#define SYS_CLCD_ID_MASK	(0x1f << 8)
+#define SYS_CLCD_ID_SANYO_3_8	(0x00 << 8)
+#define SYS_CLCD_ID_UNKNOWN_8_4	(0x01 << 8)
+#define SYS_CLCD_ID_EPSON_2_2	(0x02 << 8)
+#define SYS_CLCD_ID_SANYO_2_5	(0x07 << 8)
+#define SYS_CLCD_ID_VGA		(0x1f << 8)
+
+static bool is_sanyo_2_5_lcd;
+
+/*
+ * Disable all display connectors on the interface module.
+ */
+static void versatile_clcd_disable(struct clcd_fb *fb)
+{
+	void __iomem *sys_clcd = versatile_sys_base + VERSATILE_SYS_CLCD_OFFSET;
+	u32 val;
+
+	val = readl(sys_clcd);
+	val &= ~SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH;
+	writel(val, sys_clcd);
+
+	/*
+	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light off
+	 */
+	if (of_machine_is_compatible("arm,versatile-ab") && is_sanyo_2_5_lcd) {
+		unsigned long ctrl;
+
+		ctrl = readl(versatile_ib2_ctrl);
+		ctrl &= ~0x01;
+		writel(ctrl, versatile_ib2_ctrl);
+	}
+}
+
+/*
+ * Enable the relevant connector on the interface module.
+ */
+static void versatile_clcd_enable(struct clcd_fb *fb)
+{
+	struct fb_var_screeninfo *var = &fb->fb.var;
+	void __iomem *sys_clcd = versatile_sys_base + VERSATILE_SYS_CLCD_OFFSET;
+	u32 val;
+
+	val = readl(sys_clcd);
+	val &= ~SYS_CLCD_MODE_MASK;
+
+	switch (var->green.length) {
+	case 5:
+		val |= SYS_CLCD_MODE_5551;
+		break;
+	case 6:
+		if (var->red.offset == 0)
+			val |= SYS_CLCD_MODE_565_RLSB;
+		else
+			val |= SYS_CLCD_MODE_565_BLSB;
+		break;
+	case 8:
+		val |= SYS_CLCD_MODE_888;
+		break;
+	}
+
+	/*
+	 * Set the MUX
+	 */
+	writel(val, sys_clcd);
+
+	/*
+	 * And now enable the PSUs
+	 */
+	val |= SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH;
+	writel(val, sys_clcd);
+
+	/*
+	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light on
+	 */
+	if (of_machine_is_compatible("arm,versatile-ab") && is_sanyo_2_5_lcd) {
+		unsigned long ctrl;
+
+		ctrl = readl(versatile_ib2_ctrl);
+		ctrl |= 0x01;
+		writel(ctrl, versatile_ib2_ctrl);
+	}
+}
+
+/*
+ * Detect which LCD panel is connected, and return the appropriate
+ * clcd_panel structure.  Note: we do not have any information on
+ * the required timings for the 8.4in panel, so we presently assume
+ * VGA timings.
+ */
+static int versatile_clcd_setup(struct clcd_fb *fb)
+{
+	void __iomem *sys_clcd = versatile_sys_base + VERSATILE_SYS_CLCD_OFFSET;
+	const char *panel_name;
+	u32 val;
+
+	is_sanyo_2_5_lcd = false;
+
+	val = readl(sys_clcd) & SYS_CLCD_ID_MASK;
+	if (val == SYS_CLCD_ID_SANYO_3_8)
+		panel_name = "Sanyo TM38QV67A02A";
+	else if (val == SYS_CLCD_ID_SANYO_2_5) {
+		panel_name = "Sanyo QVGA Portrait";
+		is_sanyo_2_5_lcd = true;
+	} else if (val == SYS_CLCD_ID_EPSON_2_2)
+		panel_name = "Epson L2F50113T00";
+	else if (val == SYS_CLCD_ID_VGA)
+		panel_name = "VGA";
+	else {
+		printk(KERN_ERR "CLCD: unknown LCD panel ID 0x%08x, using VGA\n",
+			val);
+		panel_name = "VGA";
+	}
+
+	fb->panel = versatile_clcd_get_panel(panel_name);
+	if (!fb->panel)
+		return -EINVAL;
+
+	return versatile_clcd_setup_dma(fb, SZ_1M);
+}
+
+static void versatile_clcd_decode(struct clcd_fb *fb, struct clcd_regs *regs)
+{
+	clcdfb_decode(fb, regs);
+
+	/* Always clear BGR for RGB565: we do the routing externally */
+	if (fb->fb.var.green.length == 6)
+		regs->cntl &= ~CNTL_BGR;
+}
+
+static struct clcd_board clcd_plat_data = {
+	.name		= "Versatile",
+	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
+	.check		= clcdfb_check,
+	.decode		= versatile_clcd_decode,
+	.disable	= versatile_clcd_disable,
+	.enable		= versatile_clcd_enable,
+	.setup		= versatile_clcd_setup,
+	.mmap		= versatile_clcd_mmap_dma,
+	.remove		= versatile_clcd_remove_dma,
+};
+
+/*
+ * Lookup table for attaching a specific name and platform_data pointer to
+ * devices as they get created by of_platform_populate().  Ideally this table
+ * would not exist, but the current clock implementation depends on some devices
+ * having a specific name.
+ */
+struct of_dev_auxdata versatile_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI0_BASE, "fpga:05", &mmc0_plat_data),
+	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI1_BASE, "fpga:0b", &mmc1_plat_data),
+	OF_DEV_AUXDATA("arm,primecell", VERSATILE_CLCD_BASE, "dev:20", &clcd_plat_data),
+	{}
+};
+
+static struct map_desc versatile_io_desc[] __initdata __maybe_unused = {
+	{
+		.virtual	=  IO_ADDRESS(VERSATILE_SCTL_BASE),
+		.pfn		= __phys_to_pfn(VERSATILE_SCTL_BASE),
+		.length		= SZ_4K * 9,
+		.type		= MT_DEVICE
+	}
+};
+
+static void __init versatile_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(versatile_io_desc, ARRAY_SIZE(versatile_io_desc));
+}
+
+static void __init versatile_init_early(void)
+{
+	u32 val;
+
+	/*
+	 * set clock frequency:
+	 *	VERSATILE_REFCLK is 32KHz
+	 *	VERSATILE_TIMCLK is 1MHz
+	 */
+	val = readl(__io_address(VERSATILE_SCTL_BASE));
+	writel((VERSATILE_TIMCLK << VERSATILE_TIMER1_EnSel) |
+	       (VERSATILE_TIMCLK << VERSATILE_TIMER2_EnSel) |
+	       (VERSATILE_TIMCLK << VERSATILE_TIMER3_EnSel) |
+	       (VERSATILE_TIMCLK << VERSATILE_TIMER4_EnSel) | val,
+	       __io_address(VERSATILE_SCTL_BASE));
+}
+
+static void versatile_restart(enum reboot_mode mode, const char *cmd)
+{
+	u32 val;
+
+	val = readl(versatile_sys_base + VERSATILE_SYS_RESETCTL_OFFSET);
+	val |= 0x105;
+
+	writel(0xa05f, versatile_sys_base + VERSATILE_SYS_LOCK_OFFSET);
+	writel(val, versatile_sys_base + VERSATILE_SYS_RESETCTL_OFFSET);
+	writel(0, versatile_sys_base + VERSATILE_SYS_LOCK_OFFSET);
+}
 
 static void __init versatile_dt_pci_init(void)
 {
@@ -79,6 +400,8 @@ static void __init versatile_dt_init(void)
 		versatile_sys_base = of_iomap(np, 0);
 	WARN_ON(!versatile_sys_base);
 
+	versatile_ib2_ctrl = ioremap(VERSATILE_IB2_CTL_BASE, SZ_4K);
+
 	versatile_dt_pci_init();
 
 	platform_device_register(&versatile_flash_device);
-- 
2.5.0
