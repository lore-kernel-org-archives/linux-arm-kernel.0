From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:32 +0300
Subject: [RFC 06/10] arm: kdump: implement copy_oldmem_page()
In-Reply-To: <f05417b66eedd3c1fe32b433dcdae71a2a151da5.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<0f8c479602b8957c49db7ac56b8f90ac6f4da5dc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<5d4c557a427346c129c8f6cc43c5819177c05ff5.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<f05417b66eedd3c1fe32b433dcdae71a2a151da5.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <49c5365fe4f794390ca2a4de75365953e211ab3f.1269854500.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is used by vmcore code to read a page from the old kernel memory.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/Makefile     |    1 +
 arch/arm/kernel/crash_dump.c |   82 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/crash_dump.c

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 26d302c..ea023c6 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
diff --git a/arch/arm/kernel/crash_dump.c b/arch/arm/kernel/crash_dump.c
new file mode 100644
index 0000000..84382d3
--- /dev/null
+++ b/arch/arm/kernel/crash_dump.c
@@ -0,0 +1,82 @@
+/*
+ * arch/arm/kernel/crash_dump.c
+ *
+ * Copyright (C) 2010 Nokia Corporation.
+ *
+ * This code is heavily based on x86 version found in
+ * arch/x86/kernel/crash_dump_32.c.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Author: Mika Westerberg
+ */
+#include <linux/errno.h>
+#include <linux/crash_dump.h>
+#include <linux/uaccess.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+
+/* buffer used when copying an old page to userspace */
+static void *kdump_buf_page;
+
+/* stores the physical address of elf header of crash image */
+unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
+
+/**
+ * copy_oldmem_page() - copy one page from old kernel memory
+ * @pfn: page frame number to be copied
+ * @buf: buffer where the copied page is placed
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page
+ * @userbuf: if set, @buf is int he user address space
+ *
+ * This function copies one page from old kernel memory into buffer pointed by
+ * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
+ * copied or negative error in case of failure.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
+			 size_t csize, unsigned long offset,
+			 int userbuf)
+{
+	void *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
+
+	if (userbuf) {
+		if (!kdump_buf_page) {
+			printk(KERN_WARNING "Kdump: kdump buffer page not "
+				"allocated\n");
+			kunmap_atomic(vaddr, KM_PTE0);
+			return -EFAULT;
+		}
+
+		copy_page(kdump_buf_page, vaddr);
+		kunmap_atomic(vaddr, KM_PTE0);
+
+		if (copy_to_user(buf, vaddr + offset, csize))
+			return -EFAULT;
+	} else {
+		memcpy(buf, vaddr + offset, csize);
+		kunmap_atomic(vaddr, KM_PTE0);
+	}
+
+	return csize;
+}
+
+static int __init kdump_buf_page_init(void)
+{
+	kdump_buf_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!kdump_buf_page) {
+		printk(KERN_WARNING "Kdump: failed to allocate kdump buffer "
+			"page\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+arch_initcall(kdump_buf_page_init);
-- 
1.5.6.5
