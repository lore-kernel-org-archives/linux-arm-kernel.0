From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 30 Aug 2012 17:10:07 -0400
Subject: [PATCH 1/2] ARM: split out ATAGS parsing
Message-ID: <1346361008-7320-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make ATAGS parsing into a source file of its own, namely atags_parse.c.
Also rename compat.c to atags_compat.c to make it clearer what it is
about.  Same for atags.c which is now atags_proc.c. Gather all the atags
function declarations into a common atags.h.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/kernel/Makefile                     |   6 +-
 arch/arm/kernel/atags.h                      |   3 +
 arch/arm/kernel/{compat.c => atags_compat.c} |   4 +-
 arch/arm/kernel/atags_parse.c                | 238 +++++++++++++++++++++++++++
 arch/arm/kernel/{atags.c => atags_proc.c}    |   0
 arch/arm/kernel/compat.h                     |  11 --
 arch/arm/kernel/setup.c                      | 236 +-------------------------
 7 files changed, 247 insertions(+), 251 deletions(-)
 rename arch/arm/kernel/{compat.c => atags_compat.c} (99%)
 create mode 100644 arch/arm/kernel/atags_parse.c
 rename arch/arm/kernel/{atags.c => atags_proc.c} (100%)
 delete mode 100644 arch/arm/kernel/compat.h

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 7ad2d5cf70..086c9d3bc3 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -15,11 +15,11 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 
-obj-y		:= elf.o entry-armv.o entry-common.o irq.o opcodes.o \
+obj-y		:= atags_parse.o elf.o entry-armv.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o return_address.o sched_clock.o \
 		   setup.o signal.o stacktrace.o sys_arm.o time.o traps.o
 
-obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += compat.o
+obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
 
 obj-$(CONFIG_LEDS)		+= leds.o
 obj-$(CONFIG_OC_ETM)		+= etm.o
@@ -52,7 +52,7 @@ test-kprobes-objs		+= kprobes-test-thumb.o
 else
 test-kprobes-objs		+= kprobes-test-arm.o
 endif
-obj-$(CONFIG_ATAGS_PROC)	+= atags.o
+obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
 obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index e5f028d214..a888fdd381 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -3,3 +3,6 @@ extern void save_atags(struct tag *tags);
 #else
 static inline void save_atags(struct tag *tags) { }
 #endif
+
+void convert_to_tag_list(struct tag *tags);
+struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr);
diff --git a/arch/arm/kernel/compat.c b/arch/arm/kernel/atags_compat.c
similarity index 99%
rename from arch/arm/kernel/compat.c
rename to arch/arm/kernel/atags_compat.c
index 925652318b..5236ad38f4 100644
--- a/arch/arm/kernel/compat.c
+++ b/arch/arm/kernel/atags_compat.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/kernel/compat.c
+ *  linux/arch/arm/kernel/atags_compat.c
  *
  *  Copyright (C) 2001 Russell King
  *
@@ -26,7 +26,7 @@
 
 #include <asm/mach/arch.h>
 
-#include "compat.h"
+#include "atags.h"
 
 /*
  * Usage:
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
new file mode 100644
index 0000000000..18f13be99e
--- /dev/null
+++ b/arch/arm/kernel/atags_parse.c
@@ -0,0 +1,238 @@
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
+#include <asm/system_info.h>
+#include <asm/page.h>
+#include <asm/mach/arch.h>
+
+#include "atags.h"
+
+static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
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
+	{ MEM_SIZE },
+	{ 0, ATAG_NONE }
+};
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
+#ifdef CONFIG_BLK_DEV_RAM
+static int __init parse_tag_ramdisk(const struct tag *tag)
+{
+	extern int rd_size, rd_image_start, rd_prompt, rd_doload;
+
+	rd_image_start = tag->u.ramdisk.start;
+	rd_doload = (tag->u.ramdisk.flags & 1) == 0;
+	rd_prompt = (tag->u.ramdisk.flags & 2) == 0;
+
+	if (tag->u.ramdisk.size)
+		rd_size = tag->u.ramdisk.size;
+
+	return 0;
+}
+
+__tagtable(ATAG_RAMDISK, parse_tag_ramdisk);
+#endif
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
+static int __init parse_tag_cmdline(const struct tag *tag)
+{
+#if defined(CONFIG_CMDLINE_EXTEND)
+	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
+	strlcat(default_command_line, tag->u.cmdline.cmdline,
+		COMMAND_LINE_SIZE);
+#elif defined(CONFIG_CMDLINE_FORCE)
+	pr_warning("Ignoring tag cmdline (using the default kernel command line)\n");
+#else
+	strlcpy(default_command_line, tag->u.cmdline.cmdline,
+		COMMAND_LINE_SIZE);
+#endif
+	return 0;
+}
+
+__tagtable(ATAG_CMDLINE, parse_tag_cmdline);
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
+struct machine_desc * __init setup_machine_tags(phys_addr_t __atags_pointer,
+						unsigned int machine_nr)
+{
+	struct tag *tags = (struct tag *)&default_tags;
+	struct machine_desc *mdesc = NULL, *p;
+	char *from = default_command_line;
+
+	default_tags.mem.start = PHYS_OFFSET;
+
+	/*
+	 * locate machine in the list of supported machines.
+	 */
+	for_each_machine_desc(p)
+		if (machine_nr == p->nr) {
+			printk("Machine: %s\n", p->name);
+			mdesc = p;
+			break;
+		}
+
+	if (!mdesc) {
+		early_print("\nError: unrecognized/unsupported machine ID"
+			    " (r1 = 0x%08x).\n\n", machine_nr);
+		dump_machine_table(); /* does not return */
+	}
+	
+	if (__atags_pointer)
+		tags = phys_to_virt(__atags_pointer);
+	else if (mdesc->atag_offset)
+		tags = (void *)(PAGE_OFFSET + mdesc->atag_offset);
+
+#if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
+	/*
+	 * If we have the old style parameters, convert them to
+	 * a tag list.
+	 */
+	if (tags->hdr.tag != ATAG_CORE)
+		convert_to_tag_list(tags);
+#endif
+	if (tags->hdr.tag != ATAG_CORE) {
+		early_print("Warning: Neither atags nor dtb found\n");
+		tags = (struct tag *)&default_tags;
+	}
+
+	if (mdesc->fixup)
+		mdesc->fixup(tags, &from, &meminfo);
+
+	if (tags->hdr.tag == ATAG_CORE) {
+		if (meminfo.nr_banks != 0)
+			squash_mem_tags(tags);
+		save_atags(tags);
+		parse_tags(tags);
+	}
+
+	/* parse_early_param needs a boot_command_line */
+	strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
+
+	return mdesc;
+}
diff --git a/arch/arm/kernel/atags.c b/arch/arm/kernel/atags_proc.c
similarity index 100%
rename from arch/arm/kernel/atags.c
rename to arch/arm/kernel/atags_proc.c
diff --git a/arch/arm/kernel/compat.h b/arch/arm/kernel/compat.h
deleted file mode 100644
index 39264ab1b9..0000000000
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
index a81dcecc73..0785472460 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -21,11 +21,9 @@
 #include <linux/init.h>
 #include <linux/kexec.h>
 #include <linux/of_fdt.h>
-#include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
-#include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
 #include <linux/bug.h>
@@ -56,15 +54,9 @@
 #include <asm/unwind.h>
 #include <asm/memblock.h>
 
-#if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
-#include "compat.h"
-#endif
 #include "atags.h"
 #include "tcm.h"
 
-#ifndef MEM_SIZE
-#define MEM_SIZE	(16*1024*1024)
-#endif
 
 #if defined(CONFIG_FPE_NWFPE) || defined(CONFIG_FPE_FASTFPE)
 char fpe_type[8];
@@ -145,7 +137,6 @@ static const char *machine_name;
 static char __initdata cmd_line[COMMAND_LINE_SIZE];
 struct machine_desc *machine_desc __initdata;
 
-static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
 #define ENDIANNESS ((char)endian_test.l)
 
@@ -583,21 +574,6 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
-static void __init
-setup_ramdisk(int doload, int prompt, int image_start, unsigned int rd_sz)
-{
-#ifdef CONFIG_BLK_DEV_RAM
-	extern int rd_size, rd_image_start, rd_prompt, rd_doload;
-
-	rd_image_start = image_start;
-	rd_prompt = prompt;
-	rd_doload = doload;
-
-	if (rd_sz)
-		rd_size = rd_sz;
-#endif
-}
-
 static void __init request_standard_resources(struct machine_desc *mdesc)
 {
 	struct memblock_region *region;
@@ -643,35 +619,6 @@ static void __init request_standard_resources(struct machine_desc *mdesc)
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
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 struct screen_info screen_info = {
  .orig_video_lines	= 30,
@@ -681,117 +628,8 @@ struct screen_info screen_info = {
  .orig_video_isVGA	= 1,
  .orig_video_points	= 8
 };
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
 #endif
 
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
-static int __init parse_tag_cmdline(const struct tag *tag)
-{
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(default_command_line, " ", COMMAND_LINE_SIZE);
-	strlcat(default_command_line, tag->u.cmdline.cmdline,
-		COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	pr_warning("Ignoring tag cmdline (using the default kernel command line)\n");
-#else
-	strlcpy(default_command_line, tag->u.cmdline.cmdline,
-		COMMAND_LINE_SIZE);
-#endif
-	return 0;
-}
-
-__tagtable(ATAG_CMDLINE, parse_tag_cmdline);
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
-	{ MEM_SIZE },
-	{ 0, ATAG_NONE }
-};
-
 static int __init customize_machine(void)
 {
 	/* customizes platform devices, or adds new ones */
@@ -858,78 +696,6 @@ static void __init reserve_crashkernel(void)
 static inline void reserve_crashkernel(void) {}
 #endif /* CONFIG_KEXEC */
 
-static void __init squash_mem_tags(struct tag *tag)
-{
-	for (; tag->hdr.size; tag = tag_next(tag))
-		if (tag->hdr.tag == ATAG_MEM)
-			tag->hdr.tag = ATAG_NONE;
-}
-
-static struct machine_desc * __init setup_machine_tags(unsigned int nr)
-{
-	struct tag *tags = (struct tag *)&init_tags;
-	struct machine_desc *mdesc = NULL, *p;
-	char *from = default_command_line;
-
-	init_tags.mem.start = PHYS_OFFSET;
-
-	/*
-	 * locate machine in the list of supported machines.
-	 */
-	for_each_machine_desc(p)
-		if (nr == p->nr) {
-			printk("Machine: %s\n", p->name);
-			mdesc = p;
-			break;
-		}
-
-	if (!mdesc) {
-		early_print("\nError: unrecognized/unsupported machine ID"
-			" (r1 = 0x%08x).\n\n", nr);
-		dump_machine_table(); /* does not return */
-	}
-
-	if (__atags_pointer)
-		tags = phys_to_virt(__atags_pointer);
-	else if (mdesc->atag_offset)
-		tags = (void *)(PAGE_OFFSET + mdesc->atag_offset);
-
-#if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
-	/*
-	 * If we have the old style parameters, convert them to
-	 * a tag list.
-	 */
-	if (tags->hdr.tag != ATAG_CORE)
-		convert_to_tag_list(tags);
-#endif
-
-	if (tags->hdr.tag != ATAG_CORE) {
-#if defined(CONFIG_OF)
-		/*
-		 * If CONFIG_OF is set, then assume this is a reasonably
-		 * modern system that should pass boot parameters
-		 */
-		early_print("Warning: Neither atags nor dtb found\n");
-#endif
-		tags = (struct tag *)&init_tags;
-	}
-
-	if (mdesc->fixup)
-		mdesc->fixup(tags, &from, &meminfo);
-
-	if (tags->hdr.tag == ATAG_CORE) {
-		if (meminfo.nr_banks != 0)
-			squash_mem_tags(tags);
-		save_atags(tags);
-		parse_tags(tags);
-	}
-
-	/* parse_early_param needs a boot_command_line */
-	strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
-
-	return mdesc;
-}
-
 static int __init meminfo_cmp(const void *_a, const void *_b)
 {
 	const struct membank *a = _a, *b = _b;
@@ -944,7 +710,7 @@ void __init setup_arch(char **cmdline_p)
 	setup_processor();
 	mdesc = setup_machine_fdt(__atags_pointer);
 	if (!mdesc)
-		mdesc = setup_machine_tags(machine_arch_type);
+		mdesc = setup_machine_tags(__atags_pointer, machine_arch_type);
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
 
-- 
1.7.12.84.gefa6462
