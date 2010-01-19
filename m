From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Jan 2010 09:43:43 +0100
Subject: [PATCH] arm: remove support for old way to pass kernel parameters
In-Reply-To: <20100119083803.GA17904@pengutronix.de>
References: <20100119083803.GA17904@pengutronix.de>
Message-ID: <1263890623-14952-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was deprecated in 2001 and announced to live on for 5 years.

squash_mem_tags is the only function defined in compat.c that is still
needed.  As setup.c is the only user move it into there and make is
static.  This allows removing compat.c.

The result is:

	add/remove: 0/2 grow/shrink: 2/0 up/down: 32/-476 (-444)
	function                                     old     new   delta
	setup_arch                                  1584    1612     +28
	cpu_init                                     108     112      +4
	squash_mem_tags                               64       -     -64
	convert_to_tag_list                          412       -    -412

(The change in cpu_init isn't really related.  There a

	mov     r1, #332

changed into

	ldr     r1, [pc, #56]

and so the size of the local pool is increased by one word.)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/Makefile |    2 +-
 arch/arm/kernel/compat.c |  226 ----------------------------------------------
 arch/arm/kernel/compat.h |   13 ---
 arch/arm/kernel/setup.c  |   14 ++--
 4 files changed, 8 insertions(+), 247 deletions(-)
 delete mode 100644 arch/arm/kernel/compat.c
 delete mode 100644 arch/arm/kernel/compat.h

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index dd00f74..e93d360 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -13,7 +13,7 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 
-obj-y		:= compat.o elf.o entry-armv.o entry-common.o irq.o \
+obj-y		:= elf.o entry-armv.o entry-common.o irq.o \
 		   process.o ptrace.o return_address.o setup.o signal.o \
 		   sys_arm.o stacktrace.o time.o traps.o
 
diff --git a/arch/arm/kernel/compat.c b/arch/arm/kernel/compat.c
deleted file mode 100644
index 0a13854..0000000
--- a/arch/arm/kernel/compat.c
+++ /dev/null
@@ -1,226 +0,0 @@
-/*
- *  linux/arch/arm/kernel/compat.c
- *
- *  Copyright (C) 2001 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * We keep the old params compatibility cruft in one place (here)
- * so we don't end up with lots of mess around other places.
- *
- * NOTE:
- *  The old struct param_struct is deprecated, but it will be kept in
- *  the kernel for 5 years from now (2001). This will allow boot loaders
- *  to convert to the new struct tag way.
- */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/init.h>
-
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-#include <asm/page.h>
-
-#include <asm/mach/arch.h>
-
-#include "compat.h"
-
-/*
- * Usage:
- *  - do not go blindly adding fields, add them at the end
- *  - when adding fields, don't rely on the address until
- *    a patch from me has been released
- *  - unused fields should be zero (for future expansion)
- *  - this structure is relatively short-lived - only
- *    guaranteed to contain useful data in setup_arch()
- *
- * This is the old deprecated way to pass parameters to the kernel
- */
-struct param_struct {
-    union {
-	struct {
-	    unsigned long page_size;		/*  0 */
-	    unsigned long nr_pages;		/*  4 */
-	    unsigned long ramdisk_size;		/*  8 */
-	    unsigned long flags;		/* 12 */
-#define FLAG_READONLY	1
-#define FLAG_RDLOAD	4
-#define FLAG_RDPROMPT	8
-	    unsigned long rootdev;		/* 16 */
-	    unsigned long video_num_cols;	/* 20 */
-	    unsigned long video_num_rows;	/* 24 */
-	    unsigned long video_x;		/* 28 */
-	    unsigned long video_y;		/* 32 */
-	    unsigned long memc_control_reg;	/* 36 */
-	    unsigned char sounddefault;		/* 40 */
-	    unsigned char adfsdrives;		/* 41 */
-	    unsigned char bytes_per_char_h;	/* 42 */
-	    unsigned char bytes_per_char_v;	/* 43 */
-	    unsigned long pages_in_bank[4];	/* 44 */
-	    unsigned long pages_in_vram;	/* 60 */
-	    unsigned long initrd_start;		/* 64 */
-	    unsigned long initrd_size;		/* 68 */
-	    unsigned long rd_start;		/* 72 */
-	    unsigned long system_rev;		/* 76 */
-	    unsigned long system_serial_low;	/* 80 */
-	    unsigned long system_serial_high;	/* 84 */
-	    unsigned long mem_fclk_21285;       /* 88 */
-	} s;
-	char unused[256];
-    } u1;
-    union {
-	char paths[8][128];
-	struct {
-	    unsigned long magic;
-	    char n[1024 - sizeof(unsigned long)];
-	} s;
-    } u2;
-    char commandline[COMMAND_LINE_SIZE];
-};
-
-static struct tag * __init memtag(struct tag *tag, unsigned long start, unsigned long size)
-{
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_MEM;
-	tag->hdr.size = tag_size(tag_mem32);
-	tag->u.mem.size = size;
-	tag->u.mem.start = start;
-
-	return tag;
-}
-
-static void __init build_tag_list(struct param_struct *params, void *taglist)
-{
-	struct tag *tag = taglist;
-
-	if (params->u1.s.page_size != PAGE_SIZE) {
-		printk(KERN_WARNING "Warning: bad configuration page, "
-		       "trying to continue\n");
-		return;
-	}
-
-	printk(KERN_DEBUG "Converting old-style param struct to taglist\n");
-
-#ifdef CONFIG_ARCH_NETWINDER
-	if (params->u1.s.nr_pages != 0x02000 &&
-	    params->u1.s.nr_pages != 0x04000 &&
-	    params->u1.s.nr_pages != 0x08000 &&
-	    params->u1.s.nr_pages != 0x10000) {
-		printk(KERN_WARNING "Warning: bad NeTTrom parameters "
-		       "detected, using defaults\n");
-
-		params->u1.s.nr_pages = 0x1000;	/* 16MB */
-		params->u1.s.ramdisk_size = 0;
-		params->u1.s.flags = FLAG_READONLY;
-		params->u1.s.initrd_start = 0;
-		params->u1.s.initrd_size = 0;
-		params->u1.s.rd_start = 0;
-	}
-#endif
-
-	tag->hdr.tag  = ATAG_CORE;
-	tag->hdr.size = tag_size(tag_core);
-	tag->u.core.flags = params->u1.s.flags & FLAG_READONLY;
-	tag->u.core.pagesize = params->u1.s.page_size;
-	tag->u.core.rootdev = params->u1.s.rootdev;
-
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_RAMDISK;
-	tag->hdr.size = tag_size(tag_ramdisk);
-	tag->u.ramdisk.flags = (params->u1.s.flags & FLAG_RDLOAD ? 1 : 0) |
-			       (params->u1.s.flags & FLAG_RDPROMPT ? 2 : 0);
-	tag->u.ramdisk.size  = params->u1.s.ramdisk_size;
-	tag->u.ramdisk.start = params->u1.s.rd_start;
-
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_INITRD;
-	tag->hdr.size = tag_size(tag_initrd);
-	tag->u.initrd.start = params->u1.s.initrd_start;
-	tag->u.initrd.size  = params->u1.s.initrd_size;
-
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_SERIAL;
-	tag->hdr.size = tag_size(tag_serialnr);
-	tag->u.serialnr.low = params->u1.s.system_serial_low;
-	tag->u.serialnr.high = params->u1.s.system_serial_high;
-
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_REVISION;
-	tag->hdr.size = tag_size(tag_revision);
-	tag->u.revision.rev = params->u1.s.system_rev;
-
-#ifdef CONFIG_ARCH_ACORN
-	if (machine_is_riscpc()) {
-		int i;
-		for (i = 0; i < 4; i++)
-			tag = memtag(tag, PHYS_OFFSET + (i << 26),
-				 params->u1.s.pages_in_bank[i] * PAGE_SIZE);
-	} else
-#endif
-	tag = memtag(tag, PHYS_OFFSET, params->u1.s.nr_pages * PAGE_SIZE);
-
-#ifdef CONFIG_FOOTBRIDGE
-	if (params->u1.s.mem_fclk_21285) {
-		tag = tag_next(tag);
-		tag->hdr.tag = ATAG_MEMCLK;
-		tag->hdr.size = tag_size(tag_memclk);
-		tag->u.memclk.fmemclk = params->u1.s.mem_fclk_21285;
-	}
-#endif
-
-#ifdef CONFIG_ARCH_EBSA285
-	if (machine_is_ebsa285()) {
-		tag = tag_next(tag);
-		tag->hdr.tag = ATAG_VIDEOTEXT;
-		tag->hdr.size = tag_size(tag_videotext);
-		tag->u.videotext.x            = params->u1.s.video_x;
-		tag->u.videotext.y            = params->u1.s.video_y;
-		tag->u.videotext.video_page   = 0;
-		tag->u.videotext.video_mode   = 0;
-		tag->u.videotext.video_cols   = params->u1.s.video_num_cols;
-		tag->u.videotext.video_ega_bx = 0;
-		tag->u.videotext.video_lines  = params->u1.s.video_num_rows;
-		tag->u.videotext.video_isvga  = 1;
-		tag->u.videotext.video_points = 8;
-	}
-#endif
-
-#ifdef CONFIG_ARCH_ACORN
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_ACORN;
-	tag->hdr.size = tag_size(tag_acorn);
-	tag->u.acorn.memc_control_reg = params->u1.s.memc_control_reg;
-	tag->u.acorn.vram_pages       = params->u1.s.pages_in_vram;
-	tag->u.acorn.sounddefault     = params->u1.s.sounddefault;
-	tag->u.acorn.adfsdrives       = params->u1.s.adfsdrives;
-#endif
-
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_CMDLINE;
-	tag->hdr.size = (strlen(params->commandline) + 3 +
-			 sizeof(struct tag_header)) >> 2;
-	strcpy(tag->u.cmdline.cmdline, params->commandline);
-
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_NONE;
-	tag->hdr.size = 0;
-
-	memmove(params, taglist, ((int)tag) - ((int)taglist) +
-				 sizeof(struct tag_header));
-}
-
-void __init convert_to_tag_list(struct tag *tags)
-{
-	struct param_struct *params = (struct param_struct *)tags;
-	build_tag_list(params, &params->u2);
-}
-
-void __init squash_mem_tags(struct tag *tag)
-{
-	for (; tag->hdr.size; tag = tag_next(tag))
-		if (tag->hdr.tag == ATAG_MEM)
-			tag->hdr.tag = ATAG_NONE;
-}
diff --git a/arch/arm/kernel/compat.h b/arch/arm/kernel/compat.h
deleted file mode 100644
index 27e61a6..0000000
--- a/arch/arm/kernel/compat.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- *  linux/arch/arm/kernel/compat.h
- *
- *  Copyright (C) 2001 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-extern void convert_to_tag_list(struct tag *tags);
-
-extern void squash_mem_tags(struct tag *tag);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 84a6e1f..7ccb203 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -43,7 +43,6 @@
 #include <asm/traps.h>
 #include <asm/unwind.h>
 
-#include "compat.h"
 #include "atags.h"
 #include "tcm.h"
 
@@ -699,6 +698,13 @@ static int __init customize_machine(void)
 }
 arch_initcall(customize_machine);
 
+static void __init squash_mem_tags(struct tag *tag)
+{
+	for (; tag->hdr.size; tag = tag_next(tag))
+		if (tag->hdr.tag == ATAG_MEM)
+			tag->hdr.tag = ATAG_NONE;
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
@@ -719,12 +725,6 @@ void __init setup_arch(char **cmdline_p)
 	else if (mdesc->boot_params)
 		tags = phys_to_virt(mdesc->boot_params);
 
-	/*
-	 * If we have the old style parameters, convert them to
-	 * a tag list.
-	 */
-	if (tags->hdr.tag != ATAG_CORE)
-		convert_to_tag_list(tags);
 	if (tags->hdr.tag != ATAG_CORE)
 		tags = (struct tag *)&init_tags;
 
-- 
1.6.6
