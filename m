From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 26 Mar 2015 17:28:49 +0900
Subject: [PATCH 1/5] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427358533-3754-2-git-send-email-takahiro.akashi@linaro.org>
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
copy_oldmem_page(), which reads a page with ioremap'ing it assuming that
such pages are not part of main memory of crash dump kernel.
This is true under non-UEFI environment because kexec-tools modifies
a device tree adding "usablemem" attributes to memory sections.
Under UEFI, however, this is not true because UEFI remove memory sections
in a device tree and export all the memory regions, even though they belong
to system kernel.

So we should add "mem=X[MG]" boot parameter to limit the meory size and
avoid hitting the following assertion in ioremap():
	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
		return NULL;

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/Makefile     |    1 +
 arch/arm64/kernel/crash_dump.c |   71 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c      |   78 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 arch/arm64/kernel/crash_dump.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index da9a7ee..3c24d4e 100644
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
index 0000000..dd31b2e
--- /dev/null
+++ b/arch/arm64/kernel/crash_dump.c
@@ -0,0 +1,71 @@
+/*
+ * arch/arm64/kernel/crash_dump.c
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
index e8420f6..daaed93 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -323,6 +323,69 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
 }
 
+#ifdef CONFIG_KEXEC
+/*
+ * reserve_crashkernel() - reserves memory for crash kernel
+ *
+ * This function reserves memory area given in "crashkernel=" kernel command
+ * line parameter. The memory reserved is used by a dump capture kernel when
+ * primary kernel is crashing.
+ */
+static void __init reserve_crashkernel(void)
+{
+	unsigned long long crash_size, crash_base;
+	int ret;
+
+	/* use ULONG_MAX since we don't know system memory size here. */
+	ret = parse_crashkernel(boot_command_line, ULONG_MAX,
+				&crash_size, &crash_base);
+	if (ret)
+		return;
+
+	ret = memblock_reserve(crash_base, crash_size);
+	if (ret < 0) {
+		pr_warn("crashkernel reservation failed - memory is in use (0x%lx)\n",
+			(unsigned long)crash_base);
+		return;
+	}
+
+	pr_info("Reserving %ldMB of memory@%ldMB for crashkernel\n",
+		(unsigned long)(crash_size >> 20),
+		(unsigned long)(crash_base >> 20));
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
+	int ret;
+
+	if (!elfcorehdr_size)
+		return;
+
+	ret = memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
+	if (ret < 0) {
+		pr_warn("elfcorehdr reservation failed - memory is in use (0x%lx)\n",
+			(unsigned long)elfcorehdr_addr);
+		return;
+	}
+
+	pr_info("Reserving %ldKB of memory@%ldMB for elfcorehdr\n",
+		(unsigned long)(elfcorehdr_size >> 10),
+		(unsigned long)(elfcorehdr_addr >> 20));
+}
+#endif /* CONFIG_CRASH_DUMP */
+
 static void __init request_standard_resources(void)
 {
 	struct memblock_region *region;
@@ -378,10 +441,25 @@ void __init setup_arch(char **cmdline_p)
 	local_async_enable();
 
 	efi_init();
+	/*
+	 * reserve_crashkernel() and reserver_elfcorehdr() must be called
+	 * before arm64_bootmem_init() because dma_contiguous_reserve()
+	 * may conflict with those regions.
+	 */
+#ifdef CONFIG_KEXEC
+	reserve_crashkernel();
+#endif
+#ifdef CONFIG_CRASH_DUMP
+	reserve_elfcorehdr();
+#endif
 	arm64_memblock_init();
 
 	paging_init();
 	request_standard_resources();
+#ifdef CONFIG_KEXEC
+	/* kexec-tool will detect the region with /proc/iomem */
+	insert_resource(&iomem_resource, &crashk_res);
+#endif
 
 	early_ioremap_reset();
 
-- 
1.7.9.5
