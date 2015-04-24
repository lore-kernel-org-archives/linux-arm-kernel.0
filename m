From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 24 Apr 2015 16:53:04 +0900
Subject: [v2 1/5] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On system kernel, the memory region used by crash dump kernel must be
specified by "crashkernel=X at Y" boot parameter. reserve_crashkernel()
will allocate the region in "System RAM" and reserve it for later use.

On crash dump kernel, memory region information in system kernel is
described in a specific region specified by "elfcorehdr=X at Y" boot parameter.
reserve_elfcorehdr() will set aside the region to avoid data destruction
by the kernel.

Crash dump kernel will access memory regions in system kernel via
copy_oldmem_page(), which reads a page by ioremap'ing it assuming that
such pages are not part of main memory of crash dump kernel.
This is true under non-UEFI environment because kexec-tools modifies
a device tree adding "usablemem" attributes to memory sections.
Under UEFI, however, this is not true because UEFI remove memory sections
in a device tree and export all the memory regions, even though they belong
to system kernel.

So we should add "mem=X[MG]" boot parameter to limit the memory size and
avoid hitting the following assertion in ioremap():
	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
		return NULL;

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/Makefile     |    1 +
 arch/arm64/kernel/crash_dump.c |   71 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c      |    8 +++-
 arch/arm64/mm/init.c           |   84 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/crash_dump.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ac3c2e2..6fcc602 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -36,6 +36,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
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
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 51ef972..7932bd0 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -31,7 +31,6 @@
 #include <linux/screen_info.h>
 #include <linux/init.h>
 #include <linux/kexec.h>
-#include <linux/crash_dump.h>
 #include <linux/root_dev.h>
 #include <linux/clk-provider.h>
 #include <linux/cpu.h>
@@ -364,6 +363,12 @@ static void __init request_standard_resources(void)
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
 	}
+
+#ifdef CONFIG_KEXEC
+	/* User space tools will detect the region with /proc/iomem */
+	if (crashk_res.end)
+		insert_resource(&iomem_resource, &crashk_res);
+#endif
 }
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
@@ -393,6 +398,7 @@ void __init setup_arch(char **cmdline_p)
 	local_async_enable();
 
 	efi_init();
+
 	arm64_memblock_init();
 
 	paging_init();
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ae85da6..ea70d41 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -34,6 +34,8 @@
 #include <linux/dma-contiguous.h>
 #include <linux/efi.h>
 #include <linux/swiotlb.h>
+#include <linux/kexec.h>
+#include <linux/crash_dump.h>
 
 #include <asm/fixmap.h>
 #include <asm/memory.h>
@@ -66,6 +68,81 @@ static int __init early_initrd(char *p)
 early_param("initrd", early_initrd);
 #endif
 
+#ifdef CONFIG_KEXEC
+/*
+ * reserve_crashkernel() - reserves memory for crash kernel
+ *
+ * This function reserves memory area given in "crashkernel=" kernel command
+ * line parameter. The memory reserved is used by a dump capture kernel when
+ * primary kernel is crashing.
+ */
+static void __init reserve_crashkernel(phys_addr_t limit)
+{
+	unsigned long long crash_size = 0, crash_base = 0;
+	int ret;
+
+	ret = parse_crashkernel(boot_command_line, limit,
+				&crash_size, &crash_base);
+	if (ret)
+		return;
+
+	if (crash_base == 0) {
+		crash_base = memblock_alloc(crash_size, 1 << 20);
+		if (crash_base == 0) {
+			pr_warn("crashkernel allocation failed (size:%llx)\n",
+				crash_size);
+			return;
+		}
+	} else {
+		/* User specifies base address explicitly. Sanity check */
+		if (!memblock_is_region_memory(crash_base, crash_size) ||
+			memblock_is_region_reserved(crash_base, crash_size)) {
+			pr_warn("crashkernel= has wrong address or size\n");
+			return;
+		}
+
+		if (memblock_reserve(crash_base, crash_size)) {
+			pr_warn("crashkernel reservation failed - out of memory\n");
+			return;
+		}
+	}
+
+	pr_info("Reserving %lldMB of memory@%lldMB for crashkernel\n",
+		crash_size >> 20, crash_base >> 20);
+
+	crashk_res.start = crash_base;
+	crashk_res.end = crash_base + crash_size - 1;
+}
+#endif /* CONFIG_KEXEC */
+
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * reserve_elfcorehdr() - reserves memory for elf core header
+ *
+ * This function reserves memory area given in "elfcorehdr=" kernel command
+ * line parameter. The memory reserved is used by a dump capture kernel to
+ * identify the memory used by primary kernel.
+ */
+static void __init reserve_elfcorehdr(void)
+{
+	if (!elfcorehdr_size)
+		return;
+
+	if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
+		pr_warn("elfcorehdr reservation failed - memory is in use (0x%llx)\n",
+			elfcorehdr_addr);
+		return;
+	}
+
+	if (memblock_reserve(elfcorehdr_addr, elfcorehdr_size)) {
+		pr_warn("elfcorehdr reservation failed - out of memory\n");
+		return;
+	}
+
+	pr_info("Reserving %lldKB of memory at %lldMB for elfcorehdr\n",
+		elfcorehdr_size >> 10, elfcorehdr_addr >> 20);
+}
+#endif /* CONFIG_CRASH_DUMP */
 /*
  * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
  * currently assumes that for memory starting above 4G, 32-bit devices will
@@ -170,6 +247,13 @@ void __init arm64_memblock_init(void)
 		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
 #endif
 
+#ifdef CONFIG_KEXEC
+	reserve_crashkernel(memory_limit);
+#endif
+#ifdef CONFIG_CRASH_DUMP
+	reserve_elfcorehdr();
+#endif
+
 	early_init_fdt_scan_reserved_mem();
 
 	/* 4GB maximum for 32-bit only capable devices */
-- 
1.7.9.5
