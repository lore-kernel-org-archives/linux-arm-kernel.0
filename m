From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 23 Sep 2010 17:18:02 -0400 (EDT)
Subject: [PATCH] ARM: abstract atags parsing
Message-ID: <alpine.LFD.2.00.1009231713570.13233@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Make atags parsing into a source file of its own, namely atags_parse.c.
Also rename compat.c to atags_compat.c to make it clearer what it is
about.  Same for atags.c which is now atags_proc.c. Gather all the atags
function declarations into a common atags.h, and the generic setup ones
into setup.h.

This code movement will make it cleaner and easier to introduce support 
for device tree which is basically an alternative to atags. No functional
changes are introduced by this patch.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Jeremy Kerr <jeremy.kerr@canonical.com>

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 980b78e..0f4fdbb 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -13,11 +13,11 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 
-obj-y		:= elf.o entry-armv.o entry-common.o irq.o \
+obj-y		:= atags_parse.o elf.o entry-armv.o entry-common.o irq.o \
 		   process.o ptrace.o return_address.o setup.o signal.o \
 		   sys_arm.o stacktrace.o time.o traps.o
 
-obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += compat.o
+obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
 
 obj-$(CONFIG_LEDS)		+= leds.o
 obj-$(CONFIG_OC_ETM)		+= etm.o
@@ -35,7 +35,7 @@ obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-decode.o
-obj-$(CONFIG_ATAGS_PROC)	+= atags.o
+obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
 obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
diff --git a/arch/arm/kernel/atags.c b/arch/arm/kernel/atags.c
deleted file mode 100644
index 42a1a14..0000000
--- a/arch/arm/kernel/atags.c
+++ /dev/null
@@ -1,83 +0,0 @@
-#include <linux/slab.h>
-#include <linux/proc_fs.h>
-#include <asm/setup.h>
-#include <asm/types.h>
-#include <asm/page.h>
-
-struct buffer {
-	size_t size;
-	char data[];
-};
-
-static int
-read_buffer(char* page, char** start, off_t off, int count,
-	int* eof, void* data)
-{
-	struct buffer *buffer = (struct buffer *)data;
-
-	if (off >= buffer->size) {
-		*eof = 1;
-		return 0;
-	}
-
-	count = min((int) (buffer->size - off), count);
-
-	memcpy(page, &buffer->data[off], count);
-
-	return count;
-}
-
-#define BOOT_PARAMS_SIZE 1536
-static char __initdata atags_copy[BOOT_PARAMS_SIZE];
-
-void __init save_atags(const struct tag *tags)
-{
-	memcpy(atags_copy, tags, sizeof(atags_copy));
-}
-
-static int __init init_atags_procfs(void)
-{
-	/*
-	 * This cannot go into save_atags() because kmalloc and proc don't work
-	 * yet when it is called.
-	 */
-	struct proc_dir_entry *tags_entry;
-	struct tag *tag = (struct tag *)atags_copy;
-	struct buffer *b;
-	size_t size;
-
-	if (tag->hdr.tag != ATAG_CORE) {
-		printk(KERN_INFO "No ATAGs?");
-		return -EINVAL;
-	}
-
-	for (; tag->hdr.size; tag = tag_next(tag))
-		;
-
-	/* include the terminating ATAG_NONE */
-	size = (char *)tag - atags_copy + sizeof(struct tag_header);
-
-	WARN_ON(tag->hdr.tag != ATAG_NONE);
-
-	b = kmalloc(sizeof(*b) + size, GFP_KERNEL);
-	if (!b)
-		goto nomem;
-
-	b->size = size;
-	memcpy(b->data, atags_copy, size);
-
-	tags_entry = create_proc_read_entry("atags", 0400,
-			NULL, read_buffer, b);
-
-	if (!tags_entry)
-		goto nomem;
-
-	return 0;
-
-nomem:
-	kfree(b);
-	printk(KERN_ERR "Exporting ATAGs: not enough memory\n");
-
-	return -ENOMEM;
-}
-arch_initcall(init_atags_procfs);
diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index e5f028d..d6ee11f 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -3,3 +3,6 @@ extern void save_atags(struct tag *tags);
 #else
 static inline void save_atags(struct tag *tags) { }
 #endif
+
+extern void convert_to_tag_list(struct tag *tags);
+extern void atags_init(struct machine_desc *mdesc, char **cmdline_p);
diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
new file mode 100644
index 0000000..5236ad3
--- /dev/null
+++ b/arch/arm/kernel/atags_compat.c
@@ -0,0 +1,219 @@
+/*
+ *  linux/arch/arm/kernel/atags_compat.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * We keep the old params compatibility cruft in one place (here)
+ * so we don't end up with lots of mess around other places.
+ *
+ * NOTE:
+ *  The old struct param_struct is deprecated, but it will be kept in
+ *  the kernel for 5 years from now (2001). This will allow boot loaders
+ *  to convert to the new struct tag way.
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/init.h>
+
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/page.h>
+
+#include <asm/mach/arch.h>
+
+#include "atags.h"
+
+/*
+ * Usage:
+ *  - do not go blindly adding fields, add them at the end
+ *  - when adding fields, don't rely on the address until
+ *    a patch from me has been released
+ *  - unused fields should be zero (for future expansion)
+ *  - this structure is relatively short-lived - only
+ *    guaranteed to contain useful data in setup_arch()
+ *
+ * This is the old deprecated way to pass parameters to the kernel
+ */
+struct param_struct {
+    union {
+	struct {
+	    unsigned long page_size;		/*  0 */
+	    unsigned long nr_pages;		/*  4 */
+	    unsigned long ramdisk_size;		/*  8 */
+	    unsigned long flags;		/* 12 */
+#define FLAG_READONLY	1
+#define FLAG_RDLOAD	4
+#define FLAG_RDPROMPT	8
+	    unsigned long rootdev;		/* 16 */
+	    unsigned long video_num_cols;	/* 20 */
+	    unsigned long video_num_rows;	/* 24 */
+	    unsigned long video_x;		/* 28 */
+	    unsigned long video_y;		/* 32 */
+	    unsigned long memc_control_reg;	/* 36 */
+	    unsigned char sounddefault;		/* 40 */
+	    unsigned char adfsdrives;		/* 41 */
+	    unsigned char bytes_per_char_h;	/* 42 */
+	    unsigned char bytes_per_char_v;	/* 43 */
+	    unsigned long pages_in_bank[4];	/* 44 */
+	    unsigned long pages_in_vram;	/* 60 */
+	    unsigned long initrd_start;		/* 64 */
+	    unsigned long initrd_size;		/* 68 */
+	    unsigned long rd_start;		/* 72 */
+	    unsigned long system_rev;		/* 76 */
+	    unsigned long system_serial_low;	/* 80 */
+	    unsigned long system_serial_high;	/* 84 */
+	    unsigned long mem_fclk_21285;       /* 88 */
+	} s;
+	char unused[256];
+    } u1;
+    union {
+	char paths[8][128];
+	struct {
+	    unsigned long magic;
+	    char n[1024 - sizeof(unsigned long)];
+	} s;
+    } u2;
+    char commandline[COMMAND_LINE_SIZE];
+};
+
+static struct tag * __init memtag(struct tag *tag, unsigned long start, unsigned long size)
+{
+	tag = tag_next(tag);
+	tag->hdr.tag = ATAG_MEM;
+	tag->hdr.size = tag_size(tag_mem32);
+	tag->u.mem.size = size;
+	tag->u.mem.start = start;
+
+	return tag;
+}
+
+static void __init build_tag_list(struct param_struct *params, void *taglist)
+{
+	struct tag *tag = taglist;
+
+	if (params->u1.s.page_size != PAGE_SIZE) {
+		printk(KERN_WARNING "Warning: bad configuration page, "
+		       "trying to continue\n");
+		return;
+	}
+
+	printk(KERN_DEBUG "Converting old-style param struct to taglist\n");
+
+#ifdef CONFIG_ARCH_NETWINDER
+	if (params->u1.s.nr_pages != 0x02000 &&
+	    params->u1.s.nr_pages != 0x04000 &&
+	    params->u1.s.nr_pages != 0x08000 &&
+	    params->u1.s.nr_pages != 0x10000) {
+		printk(KERN_WARNING "Warning: bad NeTTrom parameters "
+		       "detected, using defaults\n");
+
+		params->u1.s.nr_pages = 0x1000;	/* 16MB */
+		params->u1.s.ramdisk_size = 0;
+		params->u1.s.flags = FLAG_READONLY;
+		params->u1.s.initrd_start = 0;
+		params->u1.s.initrd_size = 0;
+		params->u1.s.rd_start = 0;
+	}
+#endif
+
+	tag->hdr.tag  = ATAG_CORE;
+	tag->hdr.size = tag_size(tag_core);
+	tag->u.core.flags = params->u1.s.flags & FLAG_READONLY;
+	tag->u.core.pagesize = params->u1.s.page_size;
+	tag->u.core.rootdev = params->u1.s.rootdev;
+
+	tag = tag_next(tag);
+	tag->hdr.tag = ATAG_RAMDISK;
+	tag->hdr.size = tag_size(tag_ramdisk);
+	tag->u.ramdisk.flags = (params->u1.s.flags & FLAG_RDLOAD ? 1 : 0) |
+			       (params->u1.s.flags & FLAG_RDPROMPT ? 2 : 0);
+	tag->u.ramdisk.size  = params->u1.s.ramdisk_size;
+	tag->u.ramdisk.start = params->u1.s.rd_start;
+
+	tag = tag_next(tag);
+	tag->hdr.tag = ATAG_INITRD;
+	tag->hdr.size = tag_size(tag_initrd);
+	tag->u.initrd.start = params->u1.s.initrd_start;
+	tag->u.initrd.size  = params->u1.s.initrd_size;
+
+	tag = tag_next(tag);
+	tag->hdr.tag = ATAG_SERIAL;
+	tag->hdr.size = tag_size(tag_serialnr);
+	tag->u.serialnr.low = params->u1.s.system_serial_low;
+	tag->u.serialnr.high = params->u1.s.system_serial_high;
+
+	tag = tag_next(tag);
+	tag->hdr.tag = ATAG_REVISION;
+	tag->hdr.size = tag_size(tag_revision);
+	tag->u.revision.rev = params->u1.s.system_rev;
+
+#ifdef CONFIG_ARCH_ACORN
+	if (machine_is_riscpc()) {
+		int i;
+		for (i = 0; i < 4; i++)
+			tag = memtag(tag, PHYS_OFFSET + (i << 26),
+				 params->u1.s.pages_in_bank[i] * PAGE_SIZE);
+	} else
+#endif
+	tag = memtag(tag, PHYS_OFFSET, params->u1.s.nr_pages * PAGE_SIZE);
+
+#ifdef CONFIG_FOOTBRIDGE
+	if (params->u1.s.mem_fclk_21285) {
+		tag = tag_next(tag);
+		tag->hdr.tag = ATAG_MEMCLK;
+		tag->hdr.size = tag_size(tag_memclk);
+		tag->u.memclk.fmemclk = params->u1.s.mem_fclk_21285;
+	}
+#endif
+
+#ifdef CONFIG_ARCH_EBSA285
+	if (machine_is_ebsa285()) {
+		tag = tag_next(tag);
+		tag->hdr.tag = ATAG_VIDEOTEXT;
+		tag->hdr.size = tag_size(tag_videotext);
+		tag->u.videotext.x            = params->u1.s.video_x;
+		tag->u.videotext.y            = params->u1.s.video_y;
+		tag->u.videotext.video_page   = 0;
+		tag->u.videotext.video_mode   = 0;
+		tag->u.videotext.video_cols   = params->u1.s.video_num_cols;
+		tag->u.videotext.video_ega_bx = 0;
+		tag->u.videotext.video_lines  = params->u1.s.video_num_rows;
+		tag->u.videotext.video_isvga  = 1;
+		tag->u.videotext.video_points = 8;
+	}
+#endif
+
+#ifdef CONFIG_ARCH_ACORN
+	tag = tag_next(tag);
+	tag->hdr.tag = ATAG_ACORN;
+	tag->hdr.size = tag_size(tag_acorn);
+	tag->u.acorn.memc_control_reg = params->u1.s.memc_control_reg;
+	tag->u.acorn.vram_pages       = params->u1.s.pages_in_vram;
+	tag->u.acorn.sounddefault     = params->u1.s.sounddefault;
+	tag->u.acorn.adfsdrives       = params->u1.s.adfsdrives;
+#endif
+
+	tag = tag_next(tag);
+	tag->hdr.tag = ATAG_CMDLINE;
+	tag->hdr.size = (strlen(params->commandline) + 3 +
+			 sizeof(struct tag_header)) >> 2;
+	strcpy(tag->u.cmdline.cmdline, params->commandline);
+
+	tag = tag_next(tag);
+	tag->hdr.tag = ATAG_NONE;
+	tag->hdr.size = 0;
+
+	memmove(params, taglist, ((int)tag) - ((int)taglist) +
+				 sizeof(struct tag_header));
+}
+
+void __init convert_to_tag_list(struct tag *tags)
+{
+	struct param_struct *params = (struct param_struct *)tags;
+	build_tag_list(params, &params->u2);
+}
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
new file mode 100644
index 0000000..00fec0e
--- /dev/null
+++ b/arch/arm/kernel/atags_parse.c
@@ -0,0 +1,205 @@
+/*
+ * Tag parsing.
+ *
+ * Copyright (C) 1995-2001 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * This is the traditional way of passing data to the kernel at boot time.  Rather
+ * than passing a fixed inflexible structure to the kernel, we pass a list
+ * of variable-sized tags to the kernel.  The first tag must be a ATAG_CORE
+ * tag for the list to be recognised (to distinguish the tagged list from
+ * a param_struct).  The list is terminated with a zero-length tag (this tag
+ * is not parsed in any way).
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/root_dev.h>
+#include <linux/screen_info.h>
+
+#include <asm/setup.h>
+#include <asm/page.h>
+#include <asm/mach/arch.h>
+
+#include "atags.h"
+#include "setup.h"
+
+
+#ifndef MEM_SIZE
+#define MEM_SIZE	(16*1024*1024)
+#endif
+
+static struct {
+	struct tag_header hdr1;
+	struct tag_core   core;
+	struct tag_header hdr2;
+	struct tag_mem32  mem;
+	struct tag_header hdr3;
+} default_tags __initdata = {
+	{ tag_size(tag_core), ATAG_CORE },
+	{ 1, PAGE_SIZE, 0xff },
+	{ tag_size(tag_mem32), ATAG_MEM },
+	{ MEM_SIZE, PHYS_OFFSET },
+	{ 0, ATAG_NONE }
+};
+
+unsigned int __atags_pointer __initdata;
+
+static int __init parse_tag_core(const struct tag *tag)
+{
+	if (tag->hdr.size > 2) {
+		if ((tag->u.core.flags & 1) == 0)
+			root_mountflags &= ~MS_RDONLY;
+		ROOT_DEV = old_decode_dev(tag->u.core.rootdev);
+	}
+	return 0;
+}
+
+__tagtable(ATAG_CORE, parse_tag_core);
+
+static int __init parse_tag_mem32(const struct tag *tag)
+{
+	return arm_add_memory(tag->u.mem.start, tag->u.mem.size);
+}
+
+__tagtable(ATAG_MEM, parse_tag_mem32);
+
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
+struct screen_info screen_info = {
+ .orig_video_lines	= 30,
+ .orig_video_cols	= 80,
+ .orig_video_mode	= 0,
+ .orig_video_ega_bx	= 0,
+ .orig_video_isVGA	= 1,
+ .orig_video_points	= 8
+};
+
+static int __init parse_tag_videotext(const struct tag *tag)
+{
+	screen_info.orig_x            = tag->u.videotext.x;
+	screen_info.orig_y            = tag->u.videotext.y;
+	screen_info.orig_video_page   = tag->u.videotext.video_page;
+	screen_info.orig_video_mode   = tag->u.videotext.video_mode;
+	screen_info.orig_video_cols   = tag->u.videotext.video_cols;
+	screen_info.orig_video_ega_bx = tag->u.videotext.video_ega_bx;
+	screen_info.orig_video_lines  = tag->u.videotext.video_lines;
+	screen_info.orig_video_isVGA  = tag->u.videotext.video_isvga;
+	screen_info.orig_video_points = tag->u.videotext.video_points;
+	return 0;
+}
+
+__tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
+#endif
+
+static int __init parse_tag_ramdisk(const struct tag *tag)
+{
+	arm_setup_ramdisk((tag->u.ramdisk.flags & 1) == 0,
+			  (tag->u.ramdisk.flags & 2) == 0,
+			  tag->u.ramdisk.start, tag->u.ramdisk.size);
+	return 0;
+}
+
+__tagtable(ATAG_RAMDISK, parse_tag_ramdisk);
+
+static int __init parse_tag_serialnr(const struct tag *tag)
+{
+	system_serial_low = tag->u.serialnr.low;
+	system_serial_high = tag->u.serialnr.high;
+	return 0;
+}
+
+__tagtable(ATAG_SERIAL, parse_tag_serialnr);
+
+static int __init parse_tag_revision(const struct tag *tag)
+{
+	system_rev = tag->u.revision.rev;
+	return 0;
+}
+
+__tagtable(ATAG_REVISION, parse_tag_revision);
+
+#ifndef CONFIG_CMDLINE_FORCE
+static int __init parse_tag_cmdline(const struct tag *tag)
+{
+	arm_kernel_cmdline(tag->u.cmdline.cmdline);
+	return 0;
+}
+
+__tagtable(ATAG_CMDLINE, parse_tag_cmdline);
+#endif /* CONFIG_CMDLINE_FORCE */
+
+/*
+ * Scan the tag table for this tag, and call its parse function.
+ * The tag table is built by the linker from all the __tagtable
+ * declarations.
+ */
+static int __init parse_tag(const struct tag *tag)
+{
+	extern struct tagtable __tagtable_begin, __tagtable_end;
+	struct tagtable *t;
+
+	for (t = &__tagtable_begin; t < &__tagtable_end; t++)
+		if (tag->hdr.tag == t->tag) {
+			t->parse(tag);
+			break;
+		}
+
+	return t < &__tagtable_end;
+}
+
+/*
+ * Parse all tags in the list, checking both the global and architecture
+ * specific tag tables.
+ */
+static void __init parse_tags(const struct tag *t)
+{
+	for (; t->hdr.size; t = tag_next(t))
+		if (!parse_tag(t))
+			printk(KERN_WARNING
+				"Ignoring unrecognised tag 0x%08x\n",
+				t->hdr.tag);
+}
+
+static void __init squash_mem_tags(struct tag *tag)
+{
+	for (; tag->hdr.size; tag = tag_next(tag))
+		if (tag->hdr.tag == ATAG_MEM)
+			tag->hdr.tag = ATAG_NONE;
+}
+
+void __init atags_init(struct machine_desc *mdesc, char **cmdline_p)
+{
+	struct tag *tags = (struct tag *)&default_tags;
+
+	if (__atags_pointer)
+		tags = phys_to_virt(__atags_pointer);
+	else if (mdesc->boot_params)
+		tags = phys_to_virt(mdesc->boot_params);
+
+#if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
+	/*
+	 * If we have the old style parameters, convert them to
+	 * a tag list.
+	 */
+	if (tags->hdr.tag != ATAG_CORE)
+		convert_to_tag_list(tags);
+#endif
+	if (tags->hdr.tag != ATAG_CORE)
+		tags = (struct tag *)&default_tags;
+
+	if (mdesc->fixup)
+		mdesc->fixup(mdesc, tags, cmdline_p, &meminfo);
+
+	if (tags->hdr.tag == ATAG_CORE) {
+		if (meminfo.nr_banks != 0)
+			squash_mem_tags(tags);
+		save_atags(tags);
+		parse_tags(tags);
+	}
+}
diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
new file mode 100644
index 0000000..42a1a14
--- /dev/null
+++ b/arch/arm/kernel/atags_proc.c
@@ -0,0 +1,83 @@
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+#include <asm/setup.h>
+#include <asm/types.h>
+#include <asm/page.h>
+
+struct buffer {
+	size_t size;
+	char data[];
+};
+
+static int
+read_buffer(char* page, char** start, off_t off, int count,
+	int* eof, void* data)
+{
+	struct buffer *buffer = (struct buffer *)data;
+
+	if (off >= buffer->size) {
+		*eof = 1;
+		return 0;
+	}
+
+	count = min((int) (buffer->size - off), count);
+
+	memcpy(page, &buffer->data[off], count);
+
+	return count;
+}
+
+#define BOOT_PARAMS_SIZE 1536
+static char __initdata atags_copy[BOOT_PARAMS_SIZE];
+
+void __init save_atags(const struct tag *tags)
+{
+	memcpy(atags_copy, tags, sizeof(atags_copy));
+}
+
+static int __init init_atags_procfs(void)
+{
+	/*
+	 * This cannot go into save_atags() because kmalloc and proc don't work
+	 * yet when it is called.
+	 */
+	struct proc_dir_entry *tags_entry;
+	struct tag *tag = (struct tag *)atags_copy;
+	struct buffer *b;
+	size_t size;
+
+	if (tag->hdr.tag != ATAG_CORE) {
+		printk(KERN_INFO "No ATAGs?");
+		return -EINVAL;
+	}
+
+	for (; tag->hdr.size; tag = tag_next(tag))
+		;
+
+	/* include the terminating ATAG_NONE */
+	size = (char *)tag - atags_copy + sizeof(struct tag_header);
+
+	WARN_ON(tag->hdr.tag != ATAG_NONE);
+
+	b = kmalloc(sizeof(*b) + size, GFP_KERNEL);
+	if (!b)
+		goto nomem;
+
+	b->size = size;
+	memcpy(b->data, atags_copy, size);
+
+	tags_entry = create_proc_read_entry("atags", 0400,
+			NULL, read_buffer, b);
+
+	if (!tags_entry)
+		goto nomem;
+
+	return 0;
+
+nomem:
+	kfree(b);
+	printk(KERN_ERR "Exporting ATAGs: not enough memory\n");
+
+	return -ENOMEM;
+}
+arch_initcall(init_atags_procfs);
diff --git a/arch/arm/kernel/compat.c b/arch/arm/kernel/compat.c
deleted file mode 100644
index 9256523..0000000
--- a/arch/arm/kernel/compat.c
+++ /dev/null
@@ -1,219 +0,0 @@
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
diff --git a/arch/arm/kernel/compat.h b/arch/arm/kernel/compat.h
deleted file mode 100644
index 39264ab..0000000
--- a/arch/arm/kernel/compat.h
+++ /dev/null
@@ -1,11 +0,0 @@
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
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d5231ae..ae0a8d3 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -17,15 +17,12 @@
 #include <linux/console.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
-#include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
-#include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
-#include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
 
@@ -47,15 +44,10 @@
 #include <asm/traps.h>
 #include <asm/unwind.h>
 
-#if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
-#include "compat.h"
-#endif
+#include "setup.h"
 #include "atags.h"
 #include "tcm.h"
 
-#ifndef MEM_SIZE
-#define MEM_SIZE	(16*1024*1024)
-#endif
 
 #if defined(CONFIG_FPE_NWFPE) || defined(CONFIG_FPE_FASTFPE)
 char fpe_type[8];
@@ -79,8 +71,6 @@ EXPORT_SYMBOL(__machine_arch_type);
 unsigned int cacheid;
 EXPORT_SYMBOL(cacheid);
 
-unsigned int __atags_pointer __initdata;
-
 unsigned int system_rev;
 EXPORT_SYMBOL(system_rev);
 
@@ -124,9 +114,10 @@ EXPORT_SYMBOL(elf_platform);
 
 static const char *cpu_name;
 static const char *machine_name;
-static char __initdata cmd_line[COMMAND_LINE_SIZE];
 
+static char __initdata cmd_line[COMMAND_LINE_SIZE];
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
+
 static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
 #define ENDIANNESS ((char)endian_test.l)
 
@@ -407,7 +398,12 @@ static struct machine_desc * __init setup_machine(unsigned int nr)
 	return list;
 }
 
-static int __init arm_add_memory(unsigned long start, unsigned long size)
+void __init arm_kernel_cmdline(const char *cmdline)
+{
+	strlcpy(default_command_line, cmdline, COMMAND_LINE_SIZE);
+}
+
+int __init arm_add_memory(unsigned long start, unsigned long size)
 {
 	struct membank *bank = &meminfo.bank[meminfo.nr_banks];
 
@@ -467,8 +463,8 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
-static void __init
-setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
+void __init
+arm_setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
 {
 #ifdef CONFIG_BLK_DEV_RAM
 	extern int rd_size, rd_image_start, rd_prompt, rd_doload;
@@ -531,148 +527,6 @@ request_standard_resources(struct meminfo *mi, struct machine_desc *mdesc)
 		request_resource(&ioport_resource, &lp2);
 }
 
-/*
- *  Tag parsing.
- *
- * This is the new way of passing data to the kernel at boot time.  Rather
- * than passing a fixed inflexible structure to the kernel, we pass a list
- * of variable-sized tags to the kernel.  The first tag must be a ATAG_CORE
- * tag for the list to be recognised (to distinguish the tagged list from
- * a param_struct).  The list is terminated with a zero-length tag (this tag
- * is not parsed in any way).
- */
-static int __init parse_tag_core(const struct tag *tag)
-{
-	if (tag->hdr.size > 2) {
-		if ((tag->u.core.flags & 1) == 0)
-			root_mountflags &= ~MS_RDONLY;
-		ROOT_DEV = old_decode_dev(tag->u.core.rootdev);
-	}
-	return 0;
-}
-
-__tagtable(ATAG_CORE, parse_tag_core);
-
-static int __init parse_tag_mem32(const struct tag *tag)
-{
-	return arm_add_memory(tag->u.mem.start, tag->u.mem.size);
-}
-
-__tagtable(ATAG_MEM, parse_tag_mem32);
-
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
-struct screen_info screen_info = {
- .orig_video_lines	= 30,
- .orig_video_cols	= 80,
- .orig_video_mode	= 0,
- .orig_video_ega_bx	= 0,
- .orig_video_isVGA	= 1,
- .orig_video_points	= 8
-};
-
-static int __init parse_tag_videotext(const struct tag *tag)
-{
-	screen_info.orig_x            = tag->u.videotext.x;
-	screen_info.orig_y            = tag->u.videotext.y;
-	screen_info.orig_video_page   = tag->u.videotext.video_page;
-	screen_info.orig_video_mode   = tag->u.videotext.video_mode;
-	screen_info.orig_video_cols   = tag->u.videotext.video_cols;
-	screen_info.orig_video_ega_bx = tag->u.videotext.video_ega_bx;
-	screen_info.orig_video_lines  = tag->u.videotext.video_lines;
-	screen_info.orig_video_isVGA  = tag->u.videotext.video_isvga;
-	screen_info.orig_video_points = tag->u.videotext.video_points;
-	return 0;
-}
-
-__tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
-#endif
-
-static int __init parse_tag_ramdisk(const struct tag *tag)
-{
-	setup_ramdisk((tag->u.ramdisk.flags & 1) == 0,
-		      (tag->u.ramdisk.flags & 2) == 0,
-		      tag->u.ramdisk.start, tag->u.ramdisk.size);
-	return 0;
-}
-
-__tagtable(ATAG_RAMDISK, parse_tag_ramdisk);
-
-static int __init parse_tag_serialnr(const struct tag *tag)
-{
-	system_serial_low = tag->u.serialnr.low;
-	system_serial_high = tag->u.serialnr.high;
-	return 0;
-}
-
-__tagtable(ATAG_SERIAL, parse_tag_serialnr);
-
-static int __init parse_tag_revision(const struct tag *tag)
-{
-	system_rev = tag->u.revision.rev;
-	return 0;
-}
-
-__tagtable(ATAG_REVISION, parse_tag_revision);
-
-#ifndef CONFIG_CMDLINE_FORCE
-static int __init parse_tag_cmdline(const struct tag *tag)
-{
-	strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
-	return 0;
-}
-
-__tagtable(ATAG_CMDLINE, parse_tag_cmdline);
-#endif /* CONFIG_CMDLINE_FORCE */
-
-/*
- * Scan the tag table for this tag, and call its parse function.
- * The tag table is built by the linker from all the __tagtable
- * declarations.
- */
-static int __init parse_tag(const struct tag *tag)
-{
-	extern struct tagtable __tagtable_begin, __tagtable_end;
-	struct tagtable *t;
-
-	for (t = &__tagtable_begin; t < &__tagtable_end; t++)
-		if (tag->hdr.tag == t->tag) {
-			t->parse(tag);
-			break;
-		}
-
-	return t < &__tagtable_end;
-}
-
-/*
- * Parse all tags in the list, checking both the global and architecture
- * specific tag tables.
- */
-static void __init parse_tags(const struct tag *t)
-{
-	for (; t->hdr.size; t = tag_next(t))
-		if (!parse_tag(t))
-			printk(KERN_WARNING
-				"Ignoring unrecognised tag 0x%08x\n",
-				t->hdr.tag);
-}
-
-/*
- * This holds our defaults.
- */
-static struct init_tags {
-	struct tag_header hdr1;
-	struct tag_core   core;
-	struct tag_header hdr2;
-	struct tag_mem32  mem;
-	struct tag_header hdr3;
-} init_tags __initdata = {
-	{ tag_size(tag_core), ATAG_CORE },
-	{ 1, PAGE_SIZE, 0xff },
-	{ tag_size(tag_mem32), ATAG_MEM },
-	{ MEM_SIZE, PHYS_OFFSET },
-	{ 0, ATAG_NONE }
-};
-
 static void (*init_machine)(void) __initdata;
 
 static int __init customize_machine(void)
@@ -757,16 +611,8 @@ static int __init setup_elfcorehdr(char *arg)
 early_param("elfcorehdr", setup_elfcorehdr);
 #endif /* CONFIG_CRASH_DUMP */
 
-static void __init squash_mem_tags(struct tag *tag)
-{
-	for (; tag->hdr.size; tag = tag_next(tag))
-		if (tag->hdr.tag == ATAG_MEM)
-			tag->hdr.tag = ATAG_NONE;
-}
-
 void __init setup_arch(char **cmdline_p)
 {
-	struct tag *tags = (struct tag *)&init_tags;
 	struct machine_desc *mdesc;
 	char *from = default_command_line;
 
@@ -779,31 +625,7 @@ void __init setup_arch(char **cmdline_p)
 	if (mdesc->soft_reboot)
 		reboot_setup("s");
 
-	if (__atags_pointer)
-		tags = phys_to_virt(__atags_pointer);
-	else if (mdesc->boot_params)
-		tags = phys_to_virt(mdesc->boot_params);
-
-#if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
-	/*
-	 * If we have the old style parameters, convert them to
-	 * a tag list.
-	 */
-	if (tags->hdr.tag != ATAG_CORE)
-		convert_to_tag_list(tags);
-#endif
-	if (tags->hdr.tag != ATAG_CORE)
-		tags = (struct tag *)&init_tags;
-
-	if (mdesc->fixup)
-		mdesc->fixup(mdesc, tags, &from, &meminfo);
-
-	if (tags->hdr.tag == ATAG_CORE) {
-		if (meminfo.nr_banks != 0)
-			squash_mem_tags(tags);
-		save_atags(tags);
-		parse_tags(tags);
-	}
+	atags_init(mdesc, &from);
 
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
diff --git a/arch/arm/kernel/setup.h b/arch/arm/kernel/setup.h
new file mode 100644
index 0000000..6abcfea
--- /dev/null
+++ b/arch/arm/kernel/setup.h
@@ -0,0 +1,6 @@
+extern void arm_kernel_cmdline(const char *cmdline);
+extern int arm_add_memory(unsigned long start, unsigned long size);
+extern void arm_setup_ramdisk(int doload, int prompt, int image_start,
+				unsigned int rd_sz);
+
+
