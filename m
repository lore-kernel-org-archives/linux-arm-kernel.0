From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 19 Aug 2014 12:41:43 -0700
Subject: [PATCHv4 2/2] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <1408477303-2640-1-git-send-email-lauraa@codeaurora.org>
References: <1408477303-2640-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1408477303-2640-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a similar fashion to other architecture, add the infrastructure
and Kconfig to enable DEBUG_SET_MODULE_RONX support. When
enabled, module ranges will be marked read-only/no-execute as
appropriate.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/Kconfig.debug            | 11 +++++
 arch/arm64/include/asm/cacheflush.h |  4 ++
 arch/arm64/mm/Makefile              |  2 +-
 arch/arm64/mm/pageattr.c            | 96 +++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/mm/pageattr.c

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 4ee8e90..0a12933 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -43,4 +43,15 @@ config ARM64_RANDOMIZE_TEXT_OFFSET
 	  of TEXT_OFFSET and platforms must not require a specific
 	  value.
 
+config DEBUG_SET_MODULE_RONX
+        bool "Set loadable kernel module data as NX and text as RO"
+        depends on MODULES
+        help
+          This option helps catch unintended modifications to loadable
+          kernel module's text and read-only data. It also prevents execution
+          of module data. Such protection may interfere with run-time code
+          patching and dynamic kernel tracing - and they might also protect
+          against certain classes of kernel exploits.
+          If in doubt, say "N".
+
 endmenu
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index f2defe1..689b637 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -148,4 +148,8 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 {
 }
 
+int set_memory_ro(unsigned long addr, int numpages);
+int set_memory_rw(unsigned long addr, int numpages);
+int set_memory_x(unsigned long addr, int numpages);
+int set_memory_nx(unsigned long addr, int numpages);
 #endif
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 3ecb56c..c56179e 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -1,5 +1,5 @@
 obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   cache.o copypage.o flush.o \
 				   ioremap.o mmap.o pgd.o mmu.o \
-				   context.o proc.o
+				   context.o proc.o pageattr.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
new file mode 100644
index 0000000..c66b897
--- /dev/null
+++ b/arch/arm64/mm/pageattr.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+
+struct page_change_data {
+	pgprot_t set_mask;
+	pgprot_t clear_mask;
+};
+
+static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
+			void *data)
+{
+	struct page_change_data *cdata = data;
+	pte_t pte = *ptep;
+
+	pte = clear_pte_bit(pte, cdata->clear_mask);
+	pte = set_pte_bit(pte, cdata->set_mask);
+
+	set_pte(ptep, pte);
+	return 0;
+}
+
+static int change_memory_common(unsigned long addr, int numpages,
+				pgprot_t set_mask, pgprot_t clear_mask)
+{
+	unsigned long start = addr;
+	unsigned long size = PAGE_SIZE*numpages;
+	unsigned long end = start + size;
+	int ret;
+	struct page_change_data data;
+
+	if (!IS_ALIGNED(addr, PAGE_SIZE)) {
+		addr &= PAGE_MASK;
+		WARN_ON_ONCE(1);
+	}
+
+	if (!is_module_address(start) || !is_module_address(end))
+		return -EINVAL;
+
+	data.set_mask = set_mask;
+	data.clear_mask = clear_mask;
+
+	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
+					&data);
+
+	flush_tlb_kernel_range(start, end);
+	return ret;
+}
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					__pgprot(PTE_RDONLY),
+					__pgprot(PTE_WRITE));
+}
+EXPORT_SYMBOL_GPL(set_memory_ro);
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					__pgprot(PTE_WRITE),
+					__pgprot(PTE_RDONLY));
+}
+EXPORT_SYMBOL_GPL(set_memory_rw);
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					__pgprot(PTE_PXN),
+					__pgprot(0));
+}
+EXPORT_SYMBOL_GPL(set_memory_nx);
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					__pgprot(0),
+					__pgprot(PTE_PXN));
+}
+EXPORT_SYMBOL_GPL(set_memory_x);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
