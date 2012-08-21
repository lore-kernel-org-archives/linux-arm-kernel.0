From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 21 Aug 2012 20:59:32 +0400
Subject: [PATCH 1/4] ARM: clps711x: Remove board support for CEIVA
Message-ID: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current kernel does not fit in the CEIVA ROM. Also, some functional
has already been removed due migrate from 2.6 to 3.0, and it seems that
no one uses this platform. So, remove support for this board and modules
specific only to this board.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/Kconfig                 |    6 -
 arch/arm/mach-clps711x/Makefile                |    1 -
 arch/arm/mach-clps711x/ceiva.c                 |   64 --
 arch/arm/mach-clps711x/include/mach/hardware.h |   48 --
 arch/arm/tools/mach-types                      |    1 -
 drivers/video/Kconfig                          |   12 -
 drivers/video/Makefile                         |    1 -
 drivers/video/epson1355fb.c                    |  749 ------------------------
 include/video/epson1355.h                      |   64 --
 9 files changed, 0 insertions(+), 946 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/ceiva.c
 delete mode 100644 drivers/video/epson1355fb.c
 delete mode 100644 include/video/epson1355.h

diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index ea036d6..e613536 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -16,12 +16,6 @@ config ARCH_CDB89712
 	  The board includes 2 serial ports, Ethernet, IRDA, and expansion
 	  headers.  It comes with 16 MB SDRAM and 8 MB flash ROM.
 
-config ARCH_CEIVA
-	bool "CEIVA"
-	help
-	  Say Y here if you intend to run this kernel on the Ceiva/Polaroid
-	  PhotoMax Digital Picture Frame.
-
 config ARCH_CLEP7312
 	bool "CLEP7312"
 	help
diff --git a/arch/arm/mach-clps711x/Makefile b/arch/arm/mach-clps711x/Makefile
index f2f0256..aed9eb6 100644
--- a/arch/arm/mach-clps711x/Makefile
+++ b/arch/arm/mach-clps711x/Makefile
@@ -9,7 +9,6 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
-obj-$(CONFIG_ARCH_CEIVA) += ceiva.o
 obj-$(CONFIG_ARCH_AUTCPU12) += autcpu12.o
 obj-$(CONFIG_ARCH_CDB89712) += cdb89712.o
 obj-$(CONFIG_ARCH_CLEP7312) += clep7312.o
diff --git a/arch/arm/mach-clps711x/ceiva.c b/arch/arm/mach-clps711x/ceiva.c
deleted file mode 100644
index a70147e..0000000
--- a/arch/arm/mach-clps711x/ceiva.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- *  linux/arch/arm/mach-clps711x/arch-ceiva.c
- *
- *  Copyright (C) 2002, Rob Scott <rscott@mtrob.fdns.net>
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
-#include <linux/types.h>
-#include <linux/string.h>
-
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include <linux/kernel.h>
-
-#include <mach/hardware.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/sizes.h>
-
-#include <asm/mach/map.h>
-
-#include "common.h"
-
-static struct map_desc ceiva_io_desc[] __initdata = {
- 	/* SED1355 controlled video RAM & registers */
- 	{
-		.virtual	= CEIVA_VIRT_SED1355,
-		.pfn		= __phys_to_pfn(CEIVA_PHYS_SED1355),
-		.length		= SZ_2M,
-		.type		= MT_DEVICE
-	}
-};
-
-
-static void __init ceiva_map_io(void)
-{
-        clps711x_map_io();
-        iotable_init(ceiva_io_desc, ARRAY_SIZE(ceiva_io_desc));
-}
-
-
-MACHINE_START(CEIVA, "CEIVA/Polaroid Photo MAX Digital Picture Frame")
-	/* Maintainer: Rob Scott */
-	.atag_offset	= 0x100,
-	.map_io		= ceiva_map_io,
-	.init_irq	= clps711x_init_irq,
-	.timer		= &clps711x_timer,
-	.restart	= clps711x_restart,
-MACHINE_END
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index 13a64fc..8497775 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -116,7 +116,6 @@
 
 #endif /* CONFIG_ARCH_EDB7211 */
 
-
 /*
  * Relevant bits in port D, which controls power to the various parts of
  * the LCD on the EDB7211.
@@ -125,51 +124,4 @@
 #define EDB_PD2_LCDEN		(1<<2)
 #define EDB_PD3_LCDBL		(1<<3)
 
-
-#if defined (CONFIG_ARCH_CEIVA)
-
-/*
- * The two flash banks are wired to chip selects 0 and 1. This is the mapping
- * for them.
- *
- * nCS0 and nCS1 are@0x70000000 and 0x60000000, respectively, when running
- * in jumpered boot mode.
- */
-#define CEIVA_PHYS_FLASH1	CS0_PHYS_BASE	/* physical */
-#define CEIVA_PHYS_FLASH2	CS1_PHYS_BASE	/* physical */
-
-#define CEIVA_VIRT_FLASH1	(0xfa000000)	/* virtual */
-#define CEIVA_VIRT_FLASH2	(0xfb000000)	/* virtual */
-
-#define CEIVA_FLASH_SIZE        0x100000
-#define CEIVA_FLASH_WIDTH       2
-
-/*
- * SED1355 LCD controller
- */
-#define CEIVA_PHYS_SED1355	CS2_PHYS_BASE
-#define CEIVA_VIRT_SED1355	(0xfc000000)
-
-/*
- * Relevant bits in port D, which controls power to the various parts of
- * the LCD on the Ceiva Photo Max, and reset to the LCD controller.
- */
-
-// Reset line to SED1355 (must be high to operate)
-#define CEIVA_PD1_LCDRST	(1<<1)
-// LCD panel enable (set to one, to enable LCD)
-#define CEIVA_PD4_LCDEN		(1<<4)
-// Backlight (set to one, to turn on backlight
-#define CEIVA_PD5_LCDBL		(1<<5)
-
-/*
- * Relevant bits in port B, which report the status of the buttons.
- */
-
-// White button
-#define CEIVA_PB4_WHT_BTN	(1<<4)
-// Black button
-#define CEIVA_PB0_BLK_BTN	(1<<0)
-#endif // #if defined (CONFIG_ARCH_CEIVA)
-
 #endif
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 2997e56..ae87c5e 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -66,7 +66,6 @@ iq80321			ARCH_IQ80321		IQ80321			169
 ks8695			ARCH_KS8695		KS8695			180
 karo			ARCH_KARO		KARO			190
 smdk2410		ARCH_SMDK2410		SMDK2410		193
-ceiva			ARCH_CEIVA		CEIVA			200
 voiceblue		MACH_VOICEBLUE		VOICEBLUE		218
 h5400			ARCH_H5400		H5400			220
 omap_innovator		MACH_OMAP_INNOVATOR	OMAP_INNOVATOR		234
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0217f74..8c17adb 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -979,18 +979,6 @@ config FB_PVR2
 	  (<file:drivers/video/pvr2fb.c>). Please see the file
 	  <file:Documentation/fb/pvr2fb.txt>.
 
-config FB_EPSON1355
-	bool "Epson 1355 framebuffer support"
-	depends on (FB = y) && ARCH_CEIVA
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  Build in support for the SED1355 Epson Research Embedded RAMDAC
-	  LCD/CRT Controller (since redesignated as the S1D13505) as a
-	  framebuffer.  Product specs at
-	  <http://vdc.epson.com/>.
-
 config FB_S1D13XXX
 	tristate "Epson S1D13XXX framebuffer support"
 	depends on FB
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index ee8dafb..1940359 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -94,7 +94,6 @@ obj-$(CONFIG_FB_G364)             += g364fb.o
 obj-$(CONFIG_FB_EP93XX)		  += ep93xx-fb.o
 obj-$(CONFIG_FB_SA1100)           += sa1100fb.o
 obj-$(CONFIG_FB_HIT)              += hitfb.o
-obj-$(CONFIG_FB_EPSON1355)	  += epson1355fb.o
 obj-$(CONFIG_FB_ATMEL)		  += atmel_lcdfb.o
 obj-$(CONFIG_FB_PVR2)             += pvr2fb.o
 obj-$(CONFIG_FB_VOODOO1)          += sstfb.o
diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
deleted file mode 100644
index 68b9b51..0000000
--- a/drivers/video/epson1355fb.c
+++ /dev/null
@@ -1,749 +0,0 @@
-/*
- * linux/drivers/video/epson1355fb.c -- Epson S1D13505 frame buffer for 2.5.
- *
- * Epson Research S1D13505 Embedded RAMDAC LCD/CRT Controller
- *   (previously known as SED1355)
- *
- * Cf. http://vdc.epson.com/
- *
- *
- * Copyright (C) Hewlett-Packard Company.  All rights reserved.
- *
- * Written by Christopher Hoover <ch@hpl.hp.com>
- *
- * Adapted from:
- *
- *  linux/drivers/video/skeletonfb.c
- *  Modified to new api Jan 2001 by James Simmons (jsimmons at infradead.org)
- *  Created 28 Dec 1997 by Geert Uytterhoeven
- *
- *  linux/drivers/video/epson1355fb.c (2.4 driver)
- *  Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file COPYING in the main directory of this archive for
- * more details.
- *
- *
- * Noteworthy Issues
- * -----------------
- *
- * This driver is complicated by the fact that this is a 16-bit chip
- * and, on at least one platform (ceiva), we can only do 16-bit reads
- * and writes to the framebuffer.  We hide this from user space
- * except in the case of mmap().
- *
- *
- * To Do
- * -----
- *
- * - Test 8-bit pseudocolor mode
- * - Allow setting bpp, virtual resolution
- * - Implement horizontal panning
- * - (maybe) Implement hardware cursor
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/fb.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-
-#include <asm/types.h>
-#include <asm/io.h>
-#include <linux/uaccess.h>
-
-#include <video/epson1355.h>
-
-struct epson1355_par {
-	unsigned long reg_addr;
-	u32 pseudo_palette[16];
-};
-
-/* ------------------------------------------------------------------------- */
-
-#if defined(CONFIG_ARM)
-
-# ifdef CONFIG_ARCH_CEIVA
-#  include <mach/hardware.h>
-#  define EPSON1355FB_BASE_PHYS	(CEIVA_PHYS_SED1355)
-# endif
-
-static inline u8 epson1355_read_reg(struct epson1355_par *par, int index)
-{
-	return __raw_readb(par->reg_addr + index);
-}
-
-static inline void epson1355_write_reg(struct epson1355_par *par, u8 data, int index)
-{
-	__raw_writeb(data, par->reg_addr + index);
-}
-
-#else
-# error "no architecture-specific epson1355_{read,write}_reg"
-#endif
-
-#ifndef EPSON1355FB_BASE_PHYS
-# error  "EPSON1355FB_BASE_PHYS is not defined"
-#endif
-
-#define EPSON1355FB_REGS_OFS	(0)
-#define EPSON1355FB_REGS_PHYS	(EPSON1355FB_BASE_PHYS + EPSON1355FB_REGS_OFS)
-#define EPSON1355FB_REGS_LEN	(64)
-
-#define EPSON1355FB_FB_OFS	(0x00200000)
-#define EPSON1355FB_FB_PHYS	(EPSON1355FB_BASE_PHYS + EPSON1355FB_FB_OFS)
-#define EPSON1355FB_FB_LEN	(2 * 1024 * 1024)
-
-/* ------------------------------------------------------------------------- */
-
-static inline u16 epson1355_read_reg16(struct epson1355_par *par, int index)
-{
-	u8 lo = epson1355_read_reg(par, index);
-	u8 hi = epson1355_read_reg(par, index + 1);
-
-	return (hi << 8) | lo;
-}
-
-static inline void epson1355_write_reg16(struct epson1355_par *par, u16 data, int index)
-{
-	u8 lo = data & 0xff;
-	u8 hi = (data >> 8) & 0xff;
-
-	epson1355_write_reg(par, lo, index);
-	epson1355_write_reg(par, hi, index + 1);
-}
-
-static inline u32 epson1355_read_reg20(struct epson1355_par *par, int index)
-{
-	u8 b0 = epson1355_read_reg(par, index);
-	u8 b1 = epson1355_read_reg(par, index + 1);
-	u8 b2 = epson1355_read_reg(par, index + 2);
-
-	return (b2 & 0x0f) << 16 | (b1 << 8) | b0;
-}
-
-static inline void epson1355_write_reg20(struct epson1355_par *par, u32 data, int index)
-{
-	u8 b0 = data & 0xff;
-	u8 b1 = (data >> 8) & 0xff;
-	u8 b2 = (data >> 16) & 0x0f;
-
-	epson1355_write_reg(par, b0, index);
-	epson1355_write_reg(par, b1, index + 1);
-	epson1355_write_reg(par, b2, index + 2);
-}
-
-/* ------------------------------------------------------------------------- */
-
-static void set_lut(struct epson1355_par *par, u8 index, u8 r, u8 g, u8 b)
-{
-	epson1355_write_reg(par, index, REG_LUT_ADDR);
-	epson1355_write_reg(par, r, REG_LUT_DATA);
-	epson1355_write_reg(par, g, REG_LUT_DATA);
-	epson1355_write_reg(par, b, REG_LUT_DATA);
-}
-
-
-/**
- *  	epson1355fb_setcolreg - sets a color register.
- *      @regno: Which register in the CLUT we are programming
- *      @red: The red value which can be up to 16 bits wide
- *	@green: The green value which can be up to 16 bits wide
- *	@blue:  The blue value which can be up to 16 bits wide.
- *	@transp: If supported the alpha value which can be up to 16 bits wide.
- *      @info: frame buffer info structure
- *
- *	Returns negative errno on error, or zero on success.
- */
-static int epson1355fb_setcolreg(unsigned regno, unsigned r, unsigned g,
-				 unsigned b, unsigned transp,
-				 struct fb_info *info)
-{
-	struct epson1355_par *par = info->par;
-
-	if (info->var.grayscale)
-		r = g = b = (19595 * r + 38470 * g + 7471 * b) >> 16;
-
-	switch (info->fix.visual) {
-	case FB_VISUAL_TRUECOLOR:
-		if (regno >= 16)
-			return -EINVAL;
-
-		((u32 *) info->pseudo_palette)[regno] =
-		    (r & 0xf800) | (g & 0xfc00) >> 5 | (b & 0xf800) >> 11;
-
-		break;
-	case FB_VISUAL_PSEUDOCOLOR:
-		if (regno >= 256)
-			return -EINVAL;
-
-		set_lut(par, regno, r >> 8, g >> 8, b >> 8);
-
-		break;
-	default:
-		return -ENOSYS;
-	}
-	return 0;
-}
-
-/* ------------------------------------------------------------------------- */
-
-/**
- *      epson1355fb_pan_display - Pans the display.
- *      @var: frame buffer variable screen structure
- *      @info: frame buffer structure that represents a single frame buffer
- *
- *	Pan (or wrap, depending on the `vmode' field) the display using the
- *  	`xoffset' and `yoffset' fields of the `var' structure.
- *  	If the values don't fit, return -EINVAL.
- *
- *      Returns negative errno on error, or zero on success.
- */
-static int epson1355fb_pan_display(struct fb_var_screeninfo *var,
-				   struct fb_info *info)
-{
-	struct epson1355_par *par = info->par;
-	u32 start;
-
-	if (var->xoffset != 0)	/* not yet ... */
-		return -EINVAL;
-
-	if (var->yoffset + info->var.yres > info->var.yres_virtual)
-		return -EINVAL;
-
-	start = (info->fix.line_length >> 1) * var->yoffset;
-
-	epson1355_write_reg20(par, start, REG_SCRN1_DISP_START_ADDR0);
-
-	return 0;
-}
-
-/* ------------------------------------------------------------------------- */
-
-static void lcd_enable(struct epson1355_par *par, int enable)
-{
-	u8 mode = epson1355_read_reg(par, REG_DISPLAY_MODE);
-
-	if (enable)
-		mode |= 1;
-	else
-		mode &= ~1;
-
-	epson1355_write_reg(par, mode, REG_DISPLAY_MODE);
-}
-
-#if defined(CONFIG_ARCH_CEIVA)
-static void backlight_enable(int enable)
-{
-	/* ### this should be protected by a spinlock ... */
-	u8 pddr = clps_readb(PDDR);
-	if (enable)
-		pddr |= (1 << 5);
-	else
-		pddr &= ~(1 << 5);
-	clps_writeb(pddr, PDDR);
-}
-#else
-static void backlight_enable(int enable)
-{
-}
-#endif
-
-
-/**
- *      epson1355fb_blank - blanks the display.
- *      @blank_mode: the blank mode we want.
- *      @info: frame buffer structure that represents a single frame buffer
- *
- *      Blank the screen if blank_mode != 0, else unblank. Return 0 if
- *      blanking succeeded, != 0 if un-/blanking failed due to e.g. a
- *      video mode which doesn't support it. Implements VESA suspend
- *      and powerdown modes on hardware that supports disabling hsync/vsync:
- *      blank_mode == 2: suspend vsync
- *      blank_mode == 3: suspend hsync
- *      blank_mode == 4: powerdown
- *
- *      Returns negative errno on error, or zero on success.
- *
- */
-static int epson1355fb_blank(int blank_mode, struct fb_info *info)
-{
-	struct epson1355_par *par = info->par;
-
-	switch (blank_mode) {
-	case FB_BLANK_UNBLANK:
-	case FB_BLANK_NORMAL:
-		lcd_enable(par, 1);
-		backlight_enable(1);
-		break;
-	case FB_BLANK_VSYNC_SUSPEND:
-	case FB_BLANK_HSYNC_SUSPEND:
-		backlight_enable(0);
-		break;
-	case FB_BLANK_POWERDOWN:
-		backlight_enable(0);
-		lcd_enable(par, 0);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* let fbcon do a soft blank for us */
-	return (blank_mode == FB_BLANK_NORMAL) ? 1 : 0;
-}
-
-/* ------------------------------------------------------------------------- */
-
-/*
- * We can't use the cfb generic routines, as we have to limit
- * ourselves to 16-bit or 8-bit loads and stores to this 16-bit
- * chip.
- */
-
-static inline void epson1355fb_fb_writel(unsigned long v, unsigned long *a)
-{
-	u16 *p = (u16 *) a;
-	u16 l = v & 0xffff;
-	u16 h = v >> 16;
-
-	fb_writew(l, p);
-	fb_writew(h, p + 1);
-}
-
-static inline unsigned long epson1355fb_fb_readl(const unsigned long *a)
-{
-	const u16 *p = (u16 *) a;
-	u16 l = fb_readw(p);
-	u16 h = fb_readw(p + 1);
-
-	return (h << 16) | l;
-}
-
-#define FB_READL epson1355fb_fb_readl
-#define FB_WRITEL epson1355fb_fb_writel
-
-/* ------------------------------------------------------------------------- */
-
-static inline unsigned long copy_from_user16(void *to, const void *from,
-					     unsigned long n)
-{
-	u16 *dst = (u16 *) to;
-	u16 *src = (u16 *) from;
-
-	if (!access_ok(VERIFY_READ, from, n))
-		return n;
-
-	while (n > 1) {
-		u16 v;
-		if (__get_user(v, src))
-			return n;
-
-		fb_writew(v, dst);
-
-		src++, dst++;
-		n -= 2;
-	}
-
-	if (n) {
-		u8 v;
-
-		if (__get_user(v, ((u8 *) src)))
-			return n;
-
-		fb_writeb(v, dst);
-	}
-	return 0;
-}
-
-static inline unsigned long copy_to_user16(void *to, const void *from,
-					   unsigned long n)
-{
-	u16 *dst = (u16 *) to;
-	u16 *src = (u16 *) from;
-
-	if (!access_ok(VERIFY_WRITE, to, n))
-		return n;
-
-	while (n > 1) {
-		u16 v = fb_readw(src);
-
-		if (__put_user(v, dst))
-			return n;
-
-		src++, dst++;
-		n -= 2;
-	}
-
-	if (n) {
-		u8 v = fb_readb(src);
-
-		if (__put_user(v, ((u8 *) dst)))
-			return n;
-	}
-	return 0;
-}
-
-
-static ssize_t
-epson1355fb_read(struct fb_info *info, char *buf, size_t count, loff_t * ppos)
-{
-	unsigned long p = *ppos;
-
-	if (p >= info->fix.smem_len)
-		return 0;
-	if (count >= info->fix.smem_len)
-		count = info->fix.smem_len;
-	if (count + p > info->fix.smem_len)
-		count = info->fix.smem_len - p;
-
-	if (count) {
-		char *base_addr;
-
-		base_addr = info->screen_base;
-		count -= copy_to_user16(buf, base_addr + p, count);
-		if (!count)
-			return -EFAULT;
-		*ppos += count;
-	}
-	return count;
-}
-
-static ssize_t
-epson1355fb_write(struct fb_info *info, const char *buf,
-		  size_t count, loff_t * ppos)
-{
-	unsigned long p = *ppos;
-	int err;
-
-	/* from fbmem.c except for our own copy_*_user */
-	if (p > info->fix.smem_len)
-		return -ENOSPC;
-	if (count >= info->fix.smem_len)
-		count = info->fix.smem_len;
-	err = 0;
-	if (count + p > info->fix.smem_len) {
-		count = info->fix.smem_len - p;
-		err = -ENOSPC;
-	}
-
-	if (count) {
-		char *base_addr;
-
-		base_addr = info->screen_base;
-		count -= copy_from_user16(base_addr + p, buf, count);
-		*ppos += count;
-		err = -EFAULT;
-	}
-	if (count)
-		return count;
-	return err;
-}
-
-/* ------------------------------------------------------------------------- */
-
-static struct fb_ops epson1355fb_fbops = {
-	.owner 		= THIS_MODULE,
-	.fb_setcolreg 	= epson1355fb_setcolreg,
-	.fb_pan_display = epson1355fb_pan_display,
-	.fb_blank 	= epson1355fb_blank,
-	.fb_fillrect 	= cfb_fillrect,
-	.fb_copyarea 	= cfb_copyarea,
-	.fb_imageblit 	= cfb_imageblit,
-	.fb_read 	= epson1355fb_read,
-	.fb_write 	= epson1355fb_write,
-};
-
-/* ------------------------------------------------------------------------- */
-
-static __init unsigned int get_fb_size(struct fb_info *info)
-{
-	unsigned int size = 2 * 1024 * 1024;
-	char *p = info->screen_base;
-
-	/* the 512k framebuffer is aliased at start + 0x80000 * n */
-	fb_writeb(1, p);
-	fb_writeb(0, p + 0x80000);
-	if (!fb_readb(p))
-		size = 512 * 1024;
-
-	fb_writeb(0, p);
-
-	return size;
-}
-
-static int epson1355_width_tab[2][4] __devinitdata =
-    { {4, 8, 16, -1}, {9, 12, 16, -1} };
-static int epson1355_bpp_tab[8] __devinitdata = { 1, 2, 4, 8, 15, 16 };
-
-static void __devinit fetch_hw_state(struct fb_info *info, struct epson1355_par *par)
-{
-	struct fb_var_screeninfo *var = &info->var;
-	struct fb_fix_screeninfo *fix = &info->fix;
-	u8 panel, display;
-	u16 offset;
-	u32 xres, yres;
-	u32 xres_virtual, yres_virtual;
-	int bpp, lcd_bpp;
-	int is_color, is_dual, is_tft;
-	int lcd_enabled, crt_enabled;
-
-	fix->type = FB_TYPE_PACKED_PIXELS;
-
-	display = epson1355_read_reg(par, REG_DISPLAY_MODE);
-	bpp = epson1355_bpp_tab[(display >> 2) & 7];
-
-	switch (bpp) {
-	case 8:
-		fix->visual = FB_VISUAL_PSEUDOCOLOR;
-		var->bits_per_pixel = 8;
-		var->red.offset = var->green.offset = var->blue.offset = 0;
-		var->red.length = var->green.length = var->blue.length = 8;
-		break;
-	case 16:
-		/* 5-6-5 RGB */
-		fix->visual = FB_VISUAL_TRUECOLOR;
-		var->bits_per_pixel = 16;
-		var->red.offset = 11;
-		var->red.length = 5;
-		var->green.offset = 5;
-		var->green.length = 6;
-		var->blue.offset = 0;
-		var->blue.length = 5;
-		break;
-	default:
-		BUG();
-	}
-	fb_alloc_cmap(&(info->cmap), 256, 0);
-
-	panel = epson1355_read_reg(par, REG_PANEL_TYPE);
-	is_color = (panel & 0x04) != 0;
-	is_dual = (panel & 0x02) != 0;
-	is_tft = (panel & 0x01) != 0;
-	crt_enabled = (display & 0x02) != 0;
-	lcd_enabled = (display & 0x01) != 0;
-	lcd_bpp = epson1355_width_tab[is_tft][(panel >> 4) & 3];
-
-	xres = (epson1355_read_reg(par, REG_HORZ_DISP_WIDTH) + 1) * 8;
-	yres = (epson1355_read_reg16(par, REG_VERT_DISP_HEIGHT0) + 1) *
-	    ((is_dual && !crt_enabled) ? 2 : 1);
-	offset = epson1355_read_reg16(par, REG_MEM_ADDR_OFFSET0) & 0x7ff;
-	xres_virtual = offset * 16 / bpp;
-	yres_virtual = fix->smem_len / (offset * 2);
-
-	var->xres = xres;
-	var->yres = yres;
-	var->xres_virtual = xres_virtual;
-	var->yres_virtual = yres_virtual;
-	var->xoffset = var->yoffset = 0;
-
-	fix->line_length = offset * 2;
-
-	fix->xpanstep = 0;	/* no pan yet */
-	fix->ypanstep = 1;
-	fix->ywrapstep = 0;
-	fix->accel = FB_ACCEL_NONE;
-
-	var->grayscale = !is_color;
-
-#ifdef DEBUG
-	printk(KERN_INFO
-	       "epson1355fb: xres=%d, yres=%d, "
-	       "is_color=%d, is_dual=%d, is_tft=%d\n",
-	       xres, yres, is_color, is_dual, is_tft);
-	printk(KERN_INFO
-	       "epson1355fb: bpp=%d, lcd_bpp=%d, "
-	       "crt_enabled=%d, lcd_enabled=%d\n",
-	       bpp, lcd_bpp, crt_enabled, lcd_enabled);
-#endif
-}
-
-
-static void clearfb16(struct fb_info *info)
-{
-	u16 *dst = (u16 *) info->screen_base;
-	unsigned long n = info->fix.smem_len;
-
-	while (n > 1) {
-		fb_writew(0, dst);
-		dst++, n -= 2;
-	}
-
-	if (n)
-		fb_writeb(0, dst);
-}
-
-static int epson1355fb_remove(struct platform_device *dev)
-{
-	struct fb_info *info = platform_get_drvdata(dev);
-	struct epson1355_par *par = info->par;
-
-	backlight_enable(0);
-	if (par) {
-		lcd_enable(par, 0);
-		if (par && par->reg_addr)
-			iounmap((void *) par->reg_addr);
-	}
-
-	if (info) {
-		fb_dealloc_cmap(&info->cmap);
-		if (info->screen_base)
-			iounmap(info->screen_base);
-		framebuffer_release(info);
-	}
-	release_mem_region(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN);
-	release_mem_region(EPSON1355FB_REGS_PHYS, EPSON1355FB_REGS_LEN);
-	return 0;
-}
-
-static int __devinit epson1355fb_probe(struct platform_device *dev)
-{
-	struct epson1355_par *default_par;
-	struct fb_info *info;
-	u8 revision;
-	int rc = 0;
-
-	if (!request_mem_region(EPSON1355FB_REGS_PHYS, EPSON1355FB_REGS_LEN, "S1D13505 registers")) {
-		printk(KERN_ERR "epson1355fb: unable to reserve "
-		       "registers at 0x%0x\n", EPSON1355FB_REGS_PHYS);
-		rc = -EBUSY;
-		goto bail;
-	}
-
-	if (!request_mem_region(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN,
-				"S1D13505 framebuffer")) {
-		printk(KERN_ERR "epson1355fb: unable to reserve "
-		       "framebuffer at 0x%0x\n", EPSON1355FB_FB_PHYS);
-		rc = -EBUSY;
-		goto bail;
-	}
-
-	info = framebuffer_alloc(sizeof(struct epson1355_par), &dev->dev);
-	if (!info) {
-		rc = -ENOMEM;
-		goto bail;
-	}
-
-	default_par = info->par;
-	default_par->reg_addr = (unsigned long) ioremap(EPSON1355FB_REGS_PHYS, EPSON1355FB_REGS_LEN);
-	if (!default_par->reg_addr) {
-		printk(KERN_ERR "epson1355fb: unable to map registers\n");
-		rc = -ENOMEM;
-		goto bail;
-	}
-	info->pseudo_palette = default_par->pseudo_palette;
-
-	info->screen_base = ioremap(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN);
-	if (!info->screen_base) {
-		printk(KERN_ERR "epson1355fb: unable to map framebuffer\n");
-		rc = -ENOMEM;
-		goto bail;
-	}
-
-	revision = epson1355_read_reg(default_par, REG_REVISION_CODE);
-	if ((revision >> 2) != 3) {
-		printk(KERN_INFO "epson1355fb: epson1355 not found\n");
-		rc = -ENODEV;
-		goto bail;
-	}
-
-	info->fix.mmio_start = EPSON1355FB_REGS_PHYS;
-	info->fix.mmio_len = EPSON1355FB_REGS_LEN;
-	info->fix.smem_start = EPSON1355FB_FB_PHYS;
-	info->fix.smem_len = get_fb_size(info);
-
-	printk(KERN_INFO "epson1355fb: regs mapped at 0x%lx, fb %d KiB mapped at 0x%p\n",
-	       default_par->reg_addr, info->fix.smem_len / 1024, info->screen_base);
-
-	strcpy(info->fix.id, "S1D13505");
-	info->par = default_par;
-	info->fbops = &epson1355fb_fbops;
-	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
-
-	/* we expect the boot loader to have initialized the chip
-	   with appropriate parameters from which we can determinte
-	   the flavor of lcd panel attached */
-	fetch_hw_state(info, default_par);
-
-	/* turn this puppy on ... */
-	clearfb16(info);
-	backlight_enable(1);
-	lcd_enable(default_par, 1);
-
-	if (register_framebuffer(info) < 0) {
-		rc = -EINVAL;
-		goto bail;
-	}
-	/*
-	 * Our driver data.
-	 */
-	platform_set_drvdata(dev, info);
-
-	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-	       info->node, info->fix.id);
-
-	return 0;
-
-      bail:
-	epson1355fb_remove(dev);
-	return rc;
-}
-
-static struct platform_driver epson1355fb_driver = {
-	.probe	= epson1355fb_probe,
-	.remove	= epson1355fb_remove,
-	.driver	= {
-		.name	= "epson1355fb",
-	},
-};
-
-static struct platform_device *epson1355fb_device;
-
-int __init epson1355fb_init(void)
-{
-	int ret = 0;
-
-	if (fb_get_options("epson1355fb", NULL))
-		return -ENODEV;
-
-	ret = platform_driver_register(&epson1355fb_driver);
-
-	if (!ret) {
-		epson1355fb_device = platform_device_alloc("epson1355fb", 0);
-
-		if (epson1355fb_device)
-			ret = platform_device_add(epson1355fb_device);
-		else
-			ret = -ENOMEM;
-
-		if (ret) {
-			platform_device_put(epson1355fb_device);
-			platform_driver_unregister(&epson1355fb_driver);
-		}
-	}
-
-	return ret;
-}
-
-module_init(epson1355fb_init);
-	
-#ifdef MODULE
-static void __exit epson1355fb_exit(void)
-{
-	platform_device_unregister(epson1355fb_device);
-	platform_driver_unregister(&epson1355fb_driver);
-}
-
-/* ------------------------------------------------------------------------- */
-
-module_exit(epson1355fb_exit);
-#endif
-
-MODULE_AUTHOR("Christopher Hoover <ch@hpl.hp.com>");
-MODULE_DESCRIPTION("Framebuffer driver for Epson S1D13505");
-MODULE_LICENSE("GPL");
diff --git a/include/video/epson1355.h b/include/video/epson1355.h
deleted file mode 100644
index 9759f29..0000000
--- a/include/video/epson1355.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * include/video/epson13xx.h -- Epson 13xx frame buffer
- *
- * Copyright (C) Hewlett-Packard Company.  All rights reserved.
- *
- * Written by Christopher Hoover <ch@hpl.hp.com>
- *
- */
-
-#ifndef _EPSON13XX_H_
-#define _EPSON13XX_H_
-
-#define REG_REVISION_CODE              0x00
-#define REG_MEMORY_CONFIG              0x01
-#define REG_PANEL_TYPE                 0x02
-#define REG_MOD_RATE                   0x03
-#define REG_HORZ_DISP_WIDTH            0x04
-#define REG_HORZ_NONDISP_PERIOD        0x05
-#define REG_HRTC_START_POSITION        0x06
-#define REG_HRTC_PULSE_WIDTH           0x07
-#define REG_VERT_DISP_HEIGHT0          0x08
-#define REG_VERT_DISP_HEIGHT1          0x09
-#define REG_VERT_NONDISP_PERIOD        0x0A
-#define REG_VRTC_START_POSITION        0x0B
-#define REG_VRTC_PULSE_WIDTH           0x0C
-#define REG_DISPLAY_MODE               0x0D
-#define REG_SCRN1_LINE_COMPARE0        0x0E
-#define REG_SCRN1_LINE_COMPARE1        0x0F
-#define REG_SCRN1_DISP_START_ADDR0     0x10
-#define REG_SCRN1_DISP_START_ADDR1     0x11
-#define REG_SCRN1_DISP_START_ADDR2     0x12
-#define REG_SCRN2_DISP_START_ADDR0     0x13
-#define REG_SCRN2_DISP_START_ADDR1     0x14
-#define REG_SCRN2_DISP_START_ADDR2     0x15
-#define REG_MEM_ADDR_OFFSET0           0x16
-#define REG_MEM_ADDR_OFFSET1           0x17
-#define REG_PIXEL_PANNING              0x18
-#define REG_CLOCK_CONFIG               0x19
-#define REG_POWER_SAVE_CONFIG          0x1A
-#define REG_MISC                       0x1B
-#define REG_MD_CONFIG_READBACK0        0x1C
-#define REG_MD_CONFIG_READBACK1        0x1D
-#define REG_GPIO_CONFIG0               0x1E
-#define REG_GPIO_CONFIG1               0x1F
-#define REG_GPIO_CONTROL0              0x20
-#define REG_GPIO_CONTROL1              0x21
-#define REG_PERF_ENHANCEMENT0          0x22
-#define REG_PERF_ENHANCEMENT1          0x23
-#define REG_LUT_ADDR                   0x24
-#define REG_RESERVED_1                 0x25
-#define REG_LUT_DATA                   0x26
-#define REG_INK_CURSOR_CONTROL         0x27
-#define REG_CURSOR_X_POSITION0         0x28
-#define REG_CURSOR_X_POSITION1         0x29
-#define REG_CURSOR_Y_POSITION0         0x2A
-#define REG_CURSOR_Y_POSITION1         0x2B
-#define REG_INK_CURSOR_COLOR0_0        0x2C
-#define REG_INK_CURSOR_COLOR0_1        0x2D
-#define REG_INK_CURSOR_COLOR1_0        0x2E
-#define REG_INK_CURSOR_COLOR1_1        0x2F
-#define REG_INK_CURSOR_START_ADDR      0x30
-#define REG_ALTERNATE_FRM              0x31
-
-#endif
-- 
1.7.8.6
