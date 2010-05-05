From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed,  5 May 2010 09:54:17 +0300
Subject: [PATCH v2 5/8] arm: kdump: implement copy_oldmem_page()
In-Reply-To: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <00e55f1fef09064ce54a0b44ff2492d6d4629045.1273041358.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is used by vmcore code to read a page from the old kernel memory.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/Makefile     |    1 +
 arch/arm/kernel/crash_dump.c |   60 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)
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
index 0000000..cd3b853
--- /dev/null
+++ b/arch/arm/kernel/crash_dump.c
@@ -0,0 +1,60 @@
+/*
+ * arch/arm/kernel/crash_dump.c
+ *
+ * Copyright (C) 2010 Nokia Corporation.
+ * Author: Mika Westerberg
+ *
+ * This code is taken from arch/x86/kernel/crash_dump_64.c
+ *   Created by: Hariprasad Nellitheertha (hari at in.ibm.com)
+ *   Copyright (C) IBM Corporation, 2004. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include <linux/crash_dump.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
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
+	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
+	if (!vaddr)
+		return -ENOMEM;
+
+	if (userbuf) {
+		if (copy_to_user(buf, vaddr + offset, csize)) {
+			iounmap(vaddr);
+			return -EFAULT;
+		}
+	} else {
+		memcpy(buf, vaddr + offset, csize);
+	}
+
+	iounmap(vaddr);
+	return csize;
+}
-- 
1.5.6.5
