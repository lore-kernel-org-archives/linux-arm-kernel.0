From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed,  5 May 2010 09:58:33 +0300
Subject: [PATCH v2 2/2] kexec: implement ARM crashdump support
In-Reply-To: <cover.1273041787.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041787.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <870a1e66a4745ab4db7c2d0d79114084c1a05242.1273041787.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement support for loading dump capture kernels for ARM architecture. ARM
doesn't need any backup memory regions so only elfcore header is allocated from
the top of the reserved memory region. Only zImages are supported.

The dump capture kernel needs to be loaded to physical address corresponding to
the memory region reserved with 'crashkernel=size at start' kernel command line
parameter.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 kexec/arch/arm/Makefile           |    3 +
 kexec/arch/arm/crashdump-arm.c    |  320 +++++++++++++++++++++++++++++++++++++
 kexec/arch/arm/crashdump-arm.h    |   21 +++
 kexec/arch/arm/kexec-arm.c        |    5 -
 kexec/arch/arm/kexec-zImage-arm.c |   47 +++++-
 kexec/arch/arm/phys_to_virt.c     |   20 +++
 6 files changed, 409 insertions(+), 7 deletions(-)
 create mode 100644 kexec/arch/arm/crashdump-arm.c
 create mode 100644 kexec/arch/arm/crashdump-arm.h
 create mode 100644 kexec/arch/arm/phys_to_virt.c

diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 2ecdb66..7419621 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -5,8 +5,11 @@ arm_KEXEC_SRCS=  kexec/arch/arm/kexec-elf-rel-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-zImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-uImage-arm.c
 arm_KEXEC_SRCS+= kexec/arch/arm/kexec-arm.c
+arm_KEXEC_SRCS+= kexec/arch/arm/crashdump-arm.c
 arm_KEXEC_SRCS+= kexec/kexec-uImage.c
 
+arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
+
 dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS)			\
 	kexec/arch/arm/kexec-arm.h					\
 	kexec/arch/arm/include/arch/options.h
diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
new file mode 100644
index 0000000..e9b22bf
--- /dev/null
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -0,0 +1,320 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Copyright (C) Nokia Corporation, 2010.
+ * Author: Mika Westerberg
+ *
+ * Based on x86 implementation
+ * Copyright (C) IBM Corporation, 2005. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <elf.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "../../crashdump.h"
+#include "crashdump-arm.h"
+
+static struct memory_range crash_memory_ranges[CRASH_MAX_MEMORY_RANGES];
+static int crash_memory_nr_ranges;
+
+/* memory range reserved for crashkernel */
+static struct memory_range crash_reserved_mem;
+
+static struct crash_elf_info elf_info = {
+	.class		= ELFCLASS32,
+	.data		= ELFDATA2LSB,
+	.machine	= EM_ARM,
+	.page_offset	= PAGE_OFFSET,
+};
+
+unsigned long phys_offset;
+
+/**
+ * crash_range_callback() - callback called for each iomem region
+ * @data: not used
+ * @nr: not used
+ * @str: name of the memory region
+ * @base: start address of the memory region
+ * @length: size of the memory region
+ *
+ * This function is called once for each memory region found in /proc/iomem. It
+ * locates system RAM and crashkernel reserved memory and places these to
+ * variables: @crash_memory_ranges and @crash_reserved_mem. Number of memory
+ * regions is placed in @crash_memory_nr_ranges.
+ */
+static int crash_range_callback(void *UNUSED(data), int UNUSED(nr),
+				char *str, unsigned long base,
+				unsigned long length)
+{
+	struct memory_range *range;
+
+	if (crash_memory_nr_ranges >= CRASH_MAX_MEMORY_RANGES)
+		return 1;
+
+	range = &crash_memory_ranges[crash_memory_nr_ranges];
+
+	if (strncmp(str, "System RAM\n", 11) == 0) {
+		range->start = base;
+		range->end = base + length - 1;
+		range->type = RANGE_RAM;
+		crash_memory_nr_ranges++;
+	} else if (strncmp(str, "Crash kernel\n", 13) == 0) {
+		crash_reserved_mem.start = base;
+		crash_reserved_mem.end = base + length - 1;
+		crash_reserved_mem.type = RANGE_RAM;
+	}
+
+	return 0;
+}
+
+/**
+ * crash_exclude_range() - excludes memory region reserved for crashkernel
+ *
+ * Function locates where crashkernel reserved memory is and removes that region
+ * from the available memory regions.
+ */
+static void crash_exclude_range(void)
+{
+	const struct memory_range *range = &crash_reserved_mem;
+	int i;
+
+	for (i = 0; i < crash_memory_nr_ranges; i++) {
+		struct memory_range *r = &crash_memory_ranges[i];
+
+		/*
+		 * We assume that crash area is fully contained in
+		 * some larger memory area.
+		 */
+		if (r->start <= range->start && r->end >= range->end) {
+			/*
+			 * Let's split this area into 2 smaller ones and
+			 * remove excluded range from between. First create
+			 * new entry for the remaining area.
+			 */
+			crash_memory_ranges[crash_memory_nr_ranges].start = range->end + 1;
+			crash_memory_ranges[crash_memory_nr_ranges].end = r->end;
+			crash_memory_nr_ranges++;
+			/*
+			 * Next update this area to end before excluded range.
+			 */
+			r->end = range->start - 1;
+			break;
+		}
+	}
+}
+
+static int range_cmp(const void *a1, const void *a2)
+{
+	const struct memory_range *r1 = a1;
+	const struct memory_range *r2 = a2;
+
+	if (r1->start > r2->start)
+		return 1;
+	if (r1->start < r2->start)
+		return -1;
+
+	return 0;
+}
+
+/**
+ * crash_get_memory_ranges() - read system physical memory
+ *
+ * Function reads through system physical memory and stores found memory regions
+ * in @crash_memory_ranges. Number of memory regions found is placed in
+ * @crash_memory_nr_ranges. Regions are sorted in ascending order.
+ *
+ * Returns %0 in case of success and %-1 otherwise (errno is set).
+ */
+static int crash_get_memory_ranges(void)
+{
+	/*
+	 * First read all memory regions that can be considered as
+	 * system memory including the crash area.
+	 */
+	kexec_iomem_for_each_line(NULL, crash_range_callback, NULL);
+
+	if (crash_memory_nr_ranges < 1) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/*
+	 * Exclude memory reserved for crashkernel (this may result a split memory
+	 * region).
+	 */
+	crash_exclude_range();
+
+	/*
+	 * Make sure that the memory regions are sorted.
+	 */
+	qsort(crash_memory_ranges, crash_memory_nr_ranges,
+	      sizeof(crash_memory_ranges[0]), range_cmp);
+
+	return 0;
+}
+
+/**
+ * cmdline_add_elfcorehdr() - adds elfcorehdr= to @cmdline
+ * @cmdline: buffer where parameter is placed
+ * @elfcorehdr: physical address of elfcorehdr
+ *
+ * Function appends 'elfcorehdr=start' at the end of the command line given in
+ * @cmdline. Note that @cmdline must be@least %COMMAND_LINE_SIZE bytes long
+ * (inclunding %NUL).
+ */
+static void cmdline_add_elfcorehdr(char *cmdline, unsigned long elfcorehdr)
+{
+	char buf[COMMAND_LINE_SIZE];
+	int buflen;
+
+	buflen = snprintf(buf, sizeof(buf), "%s elfcorehdr=%#lx",
+			  cmdline, elfcorehdr);
+	if (buflen < 0)
+		die("Failed to construct elfcorehdr= command line parameter\n");
+	if (buflen >= sizeof(buf))
+		die("Command line overflow\n");
+
+	(void) strncpy(cmdline, buf, COMMAND_LINE_SIZE);
+	cmdline[COMMAND_LINE_SIZE - 1] = '\0';
+}
+
+/**
+ * cmdline_add_mem() - adds mem= parameter to kernel command line
+ * @cmdline: buffer where parameter is placed
+ * @size: size of the kernel reserved memory (in bytes)
+ *
+ * This function appends 'mem=size' at the end of the command line given in
+ * @cmdline. Note that @cmdline must be at least %COMMAND_LINE_SIZE bytes long
+ * (including %NUL).
+ */
+static void cmdline_add_mem(char *cmdline, unsigned long size)
+{
+	char buf[COMMAND_LINE_SIZE];
+	int buflen;
+
+	buflen = snprintf(buf, sizeof(buf), "%s mem=%ldK", cmdline, size >> 10);
+	if (buflen < 0)
+		die("Failed to construct mem= command line parameter\n");
+	if (buflen >= sizeof(buf))
+		die("Command line overflow\n");
+
+	(void) strncpy(cmdline, buf, COMMAND_LINE_SIZE);
+	cmdline[COMMAND_LINE_SIZE - 1] = '\0';
+}
+
+#ifdef DEBUG
+static unsigned long long range_size(const struct memory_range *r)
+{
+	return r->end - r->start + 1;
+}
+
+static void dump_memory_ranges(void)
+{
+	int i;
+
+	dbgprintf("crashkernel: [%#llx - %#llx] (%ldM)\n",
+		  crash_reserved_mem.start, crash_reserved_mem.end,
+		  (unsigned long)range_size(&crash_reserved_mem) >> 20);
+
+	for (i = 0; i < crash_memory_nr_ranges; i++) {
+		struct memory_range *r = &crash_memory_ranges[i];
+		dbgprintf("memory range: [%#llx - %#llx] (%ldM)\n",
+			  r->start, r->end, (unsigned long)range_size(r) >> 20);
+	}
+}
+#else
+static inline void dump_memory_ranges(void) {}
+#endif
+
+/**
+ * load_crashdump_segments() - loads additional segments needed for kdump
+ * @info: kexec info structure
+ * @mod_cmdline: kernel command line
+ *
+ * This function loads additional segments which are needed for the dump capture
+ * kernel. It also updates kernel command line passed in @mod_cmdline to have
+ * right parameters for the dump capture kernel.
+ *
+ * Return %0 in case of success and %-1 in case of error.
+ */
+int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
+{
+	unsigned long elfcorehdr;
+	unsigned long bufsz;
+	void *buf;
+	int err;
+
+	/*
+	 * First fetch all the memory (RAM) ranges that we are going to pass to
+	 * the crashdump kernel during panic.
+	 */
+	err = crash_get_memory_ranges();
+	if (err)
+		return err;
+
+	/*
+	 * Now that we have memory regions sorted, we can use first memory
+	 * region as PHYS_OFFSET.
+	 */
+	phys_offset = crash_memory_ranges[0].start;
+	dbgprintf("phys_offset: %#lx\n", phys_offset);
+
+	err = crash_create_elf32_headers(info, &elf_info, crash_memory_ranges,
+					 crash_memory_nr_ranges, &buf, &bufsz,
+					 ELF_CORE_HEADER_ALIGN);
+	if (err)
+		return err;
+
+	/*
+	 * We allocate ELF core header from the end of the memory area reserved
+	 * for the crashkernel. We align the header to SECTION_SIZE (which is
+	 * 1MB) so that available memory passed in kernel command line will be
+	 * aligned to 1MB. This is because kernel create_mapping() wants memory
+	 * regions to be aligned to SECTION_SIZE.
+	 */
+	elfcorehdr = add_buffer_phys_virt(info, buf, bufsz, bufsz, 1 << 20,
+					  crash_reserved_mem.start,
+					  crash_reserved_mem.end, -1, 0);
+
+	dbgprintf("elfcorehdr: %#lx\n", elfcorehdr);
+	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
+
+	/*
+	 * Add 'mem=size' parameter to dump capture kernel command line. This
+	 * prevents the dump capture kernel from using any other memory regions
+	 * which belong to the primary kernel.
+	 */
+	cmdline_add_mem(mod_cmdline, elfcorehdr - crash_reserved_mem.start);
+
+	dump_memory_ranges();
+	dbgprintf("kernel command line: \"%s\"\n", mod_cmdline);
+
+	return 0;
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+	uint64_t start, end;
+
+	if (parse_iomem_single("Crash kernel\n", &start, &end) == 0)
+		return start != end;
+
+	return 0;
+}
diff --git a/kexec/arch/arm/crashdump-arm.h b/kexec/arch/arm/crashdump-arm.h
new file mode 100644
index 0000000..a2e7824
--- /dev/null
+++ b/kexec/arch/arm/crashdump-arm.h
@@ -0,0 +1,21 @@
+#ifndef CRASHDUMP_ARM_H
+#define CRASHDUMP_ARM_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define COMMAND_LINE_SIZE	1024
+#define PAGE_OFFSET		0xc0000000
+#define CRASH_MAX_MEMORY_RANGES	32
+
+struct kexec_info;
+
+extern unsigned long phys_offset;
+extern int load_crashdump_segments(struct kexec_info *, char *);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* CRASHDUMP_ARM_H */
diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 06ed8fd..55c76a6 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -121,8 +121,3 @@ int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
-
-int is_crashkernel_mem_reserved(void)
-{
-	return 0; /* kdump is not supported on this platform (yet) */
-}
diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 72fcdd8..ed54bbc 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -12,10 +12,12 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <getopt.h>
+#include <unistd.h>
 #include <arch/options.h>
 #include "../../kexec.h"
+#include "../../kexec-syscall.h"
+#include "crashdump-arm.h"
 
-#define COMMAND_LINE_SIZE 1024
 #define BOOT_PARAMS_SIZE 1536
 
 struct tag_header {
@@ -215,6 +217,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
 	unsigned int offset = 0x8000;      /* 32k offset from memory start */
 	const char *command_line;
+	char *modified_cmdline = NULL;
 	off_t command_line_len;
 	const char *ramdisk;
 	char *ramdisk_buf;
@@ -267,7 +270,47 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
 	}
 
-	base = locate_hole(info,len+offset,0,0,ULONG_MAX,INT_MAX);
+	/*
+	 * If we are loading a dump capture kernel, we need to update kernel
+	 * command line and also add some additional segments.
+	 */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		uint64_t start, end;
+
+		modified_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		if (!modified_cmdline)
+			return -1;
+
+		if (command_line) {
+			(void) strncpy(modified_cmdline, command_line,
+				       COMMAND_LINE_SIZE);
+			modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
+		}
+
+		if (load_crashdump_segments(info, modified_cmdline) < 0) {
+			free(modified_cmdline);
+			return -1;
+		}
+
+		command_line = modified_cmdline;
+		command_line_len = strlen(command_line) + 1;
+
+		/*
+		 * We put the dump capture kernel@the start of crashkernel
+		 * reserved memory.
+		 */
+		if (parse_iomem_single("Crash kernel\n", &start, &end)) {
+			/*
+			 * No crash kernel memory reserved. We cannot do more
+			 * but just bail out.
+			 */
+			return -1;
+		}
+		base = start;
+	} else {
+		base = locate_hole(info,len+offset,0,0,ULONG_MAX,INT_MAX);
+	}
+
 	if (base == ULONG_MAX)
 		return -1;
 
diff --git a/kexec/arch/arm/phys_to_virt.c b/kexec/arch/arm/phys_to_virt.c
new file mode 100644
index 0000000..bcced52
--- /dev/null
+++ b/kexec/arch/arm/phys_to_virt.c
@@ -0,0 +1,20 @@
+#include "../../kexec.h"
+#include "../../crashdump.h"
+#include "crashdump-arm.h"
+
+/**
+ * phys_to_virt() - translate physical address to virtual address
+ * @paddr: physical address to translate
+ *
+ * For ARM we have following equation to translate from virtual address to
+ * physical:
+ *	paddr = vaddr - PAGE_OFFSET + PHYS_OFFSET
+ *
+ * See also:
+ * http://lists.arm.linux.org.uk/lurker/message/20010723.185051.94ce743c.en.html
+ */
+unsigned long
+phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
+{
+	return paddr + elf_info->page_offset - phys_offset;
+}
-- 
1.5.6.5
