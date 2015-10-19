From: geoff@infradead.org (Geoff Levand)
Date: Mon, 19 Oct 2015 23:38:54 +0000
Subject: [PATCH 13/16] arm64: kdump: add kdump support
In-Reply-To: <cover.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
Message-ID: <ef50b13d545f37a9fa95c5e6856e35f324798d00.1445297709.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

On crash dump kernel, all the information about primary kernel's core
image is available in elf core header specified by "elfcorehdr=" boot
parameter. reserve_elfcorehdr() will set aside the region to avoid any
corruption by crash dump kernel.

Crash dump kernel will access the system memory of primary kernel via
copy_oldmem_page(), which reads one page by ioremap'ing it since it does
not reside in linear mapping on crash dump kernel.
Please note that we should add "mem=X[MG]" boot parameter to limit the
memory size and avoid the following assertion at ioremap():
	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
		return NULL;
when accessing any pages beyond the usable memories of crash dump kernel.

We also need our own elfcorehdr_read() here since the weak definition of
elfcorehdr_read() utilizes copy_oldmem_page() and will hit the assertion
above on arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Kconfig             | 12 +++++++
 arch/arm64/kernel/Makefile     |  1 +
 arch/arm64/kernel/crash_dump.c | 71 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/init.c           | 29 +++++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 arch/arm64/kernel/crash_dump.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 73e8e31..262bd49 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -501,6 +501,18 @@ config KEXEC
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel"
+	help
+	  Generate crash dump after being started by kexec. This should
+	  be normally only set in special crash dump kernels which are
+	  loaded in the main kernel with kexec-tools into a specially
+	  reserved region and then later executed after a crash by
+	  kdump/kexec. The crash dump kernel must be compiled to a
+	  memory address not used by the main kernel.
+
+	  For more details see Documentation/kdump/kdump.txt
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 989ccd7..7ef9fa4 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -38,6 +38,7 @@ arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
 arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
+arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
new file mode 100644
index 0000000..3d86c0a
--- /dev/null
+++ b/arch/arm64/kernel/crash_dump.c
@@ -0,0 +1,71 @@
+/*
+ * Routines for doing kexec-based kdump
+ *
+ * Copyright (C) 2014 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/crash_dump.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/memblock.h>
+#include <linux/uaccess.h>
+#include <asm/memory.h>
+
+/**
+ * copy_oldmem_page() - copy one page from old kernel memory
+ * @pfn: page frame number to be copied
+ * @buf: buffer where the copied page is placed
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page
+ * @userbuf: if set, @buf is in a user address space
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
+	vaddr = ioremap_cache(pfn << PAGE_SHIFT, PAGE_SIZE);
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
+
+	return csize;
+}
+
+/**
+ * elfcorehdr_read - read from ELF core header
+ * @buf: buffer where the data is placed
+ * @csize: number of bytes to read
+ * @ppos: address in the memory
+ *
+ * This function reads @count bytes from elf core header which exists
+ * on crash dump kernel's memory.
+ */
+ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
+{
+	memcpy(buf, phys_to_virt((phys_addr_t)*ppos), count);
+	return count;
+}
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f33f201..ff8eeb4 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -35,6 +35,7 @@
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
 #include <linux/kexec.h>
+#include <linux/crash_dump.h>
 
 #include <asm/fixmap.h>
 #include <asm/memory.h>
@@ -116,6 +117,31 @@ static void __init reserve_crashkernel(void)
 }
 #endif /* CONFIG_KEXEC */
 
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * reserve_elfcorehdr() - reserves memory for elf core header
+ *
+ * This function reserves elf core header given in "elfcorehdr=" kernel
+ * command line parameter. This region contains all the information about
+ * primary kernel's core image and is used by a dump capture kernel to
+ * access the system memory on primary kernel.
+ */
+static void __init reserve_elfcorehdr(void)
+{
+	if (!elfcorehdr_size)
+		return;
+
+	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
+		pr_warn("elfcorehdr is overlapped\n");
+		return;
+	}
+
+	memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
+
+	pr_info("Reserving %lldKB of memory at %lldMB for elfcorehdr\n",
+		elfcorehdr_size >> 10, elfcorehdr_addr >> 20);
+}
+#endif /* CONFIG_CRASH_DUMP */
 /*
  * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
  * currently assumes that for memory starting above 4G, 32-bit devices will
@@ -223,6 +249,9 @@ void __init arm64_memblock_init(void)
 #ifdef CONFIG_KEXEC
 	reserve_crashkernel();
 #endif
+#ifdef CONFIG_CRASH_DUMP
+	reserve_elfcorehdr();
+#endif
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.5.0
