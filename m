From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 17 Apr 2014 17:47:01 -0700
Subject: [PATCH 1/3] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <1397782023-28114-1-git-send-email-lauraa@codeaurora.org>
References: <1397782023-28114-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1397782023-28114-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a similar fashion to other architecture, add the infrastructure
and Kconfig to enable DEBUG_SET_MODULE_RONX support. When
enabled, module ranges will be marked read-only/no-execute as
appropriate.

Change-Id: I4251a0929b1fe6f43f84b14f0a64fed30769700e
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/Kconfig.debug            |  11 ++++
 arch/arm64/include/asm/cacheflush.h |   4 ++
 arch/arm64/mm/Makefile              |   2 +-
 arch/arm64/mm/pageattr.c            | 120 ++++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/mm/pageattr.c

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index d10ec33..53979ac 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -37,4 +37,15 @@ config PID_IN_CONTEXTIDR
 	  instructions during context switch. Say Y here only if you are
 	  planning to use hardware trace tools with this kernel.
 
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
index 4c60e64..c12f837 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -157,4 +157,8 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 {
 }
 
+int set_memory_ro(unsigned long addr, int numpages);
+int set_memory_rw(unsigned long addr, int numpages);
+int set_memory_x(unsigned long addr, int numpages);
+int set_memory_nx(unsigned long addr, int numpages);
 #endif
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index b51d364..25b1114 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -1,5 +1,5 @@
 obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   cache.o copypage.o flush.o \
 				   ioremap.o mmap.o pgd.o mmu.o \
-				   context.o tlb.o proc.o
+				   context.o tlb.o proc.o pageattr.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
new file mode 100644
index 0000000..e48f980
--- /dev/null
+++ b/arch/arm64/mm/pageattr.c
@@ -0,0 +1,120 @@
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
+#include <linux/sched.h>
+
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+
+static pte_t clear_pte_bit(pte_t pte, pgprot_t prot)
+{
+	pte_val(pte) &= ~pgprot_val(prot);
+	return pte;
+}
+
+static pte_t set_pte_bit(pte_t pte, pgprot_t prot)
+{
+	pte_val(pte) |= pgprot_val(prot);
+	return pte;
+}
+
+static int __change_memory(pte_t *ptep, pgtable_t token, unsigned long addr,
+			pgprot_t prot, bool set)
+{
+	pte_t pte;
+
+	if (set)
+		pte = set_pte_bit(*ptep, prot);
+	else
+		pte = clear_pte_bit(*ptep, prot);
+	set_pte(ptep, pte);
+	return 0;
+}
+
+static int set_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
+			void *data)
+{
+	pgprot_t prot = (pgprot_t)data;
+
+	return __change_memory(ptep, token, addr, prot, true);
+}
+
+static int clear_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
+			void *data)
+{
+	pgprot_t prot = (pgprot_t)data;
+
+	return __change_memory(ptep, token, addr, prot, false);
+}
+
+static int change_memory_common(unsigned long addr, int numpages,
+				pgprot_t prot, bool set)
+{
+	unsigned long start = addr;
+	unsigned long size = PAGE_SIZE*numpages;
+	unsigned long end = start + size;
+	int ret;
+
+	if (start < MODULES_VADDR || start >= MODULES_END)
+		return -EINVAL;
+
+	if (end < MODULES_VADDR || end >= MODULES_END)
+		return -EINVAL;
+
+	if (set)
+		ret = apply_to_page_range(&init_mm, start, size,
+					set_page_range, (void *)prot);
+	else
+		ret = apply_to_page_range(&init_mm, start, size,
+					clear_page_range, (void *)prot);
+
+	flush_tlb_kernel_range(start, end);
+	return ret;
+}
+
+static int change_memory_set_bit(unsigned long addr, int numpages,
+					pgprot_t prot)
+{
+	return change_memory_common(addr, numpages, prot, true);
+}
+
+static int change_memory_clear_bit(unsigned long addr, int numpages,
+					pgprot_t prot)
+{
+	return change_memory_common(addr, numpages, prot, false);
+}
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	return change_memory_set_bit(addr, numpages, __pgprot(PTE_RDONLY));
+}
+EXPORT_SYMBOL_GPL(set_memory_ro);
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	return change_memory_clear_bit(addr, numpages, __pgprot(PTE_RDONLY));
+}
+EXPORT_SYMBOL_GPL(set_memory_rw);
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	return change_memory_set_bit(addr, numpages, __pgprot(PTE_PXN));
+}
+EXPORT_SYMBOL_GPL(set_memory_nx);
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	return change_memory_clear_bit(addr, numpages, __pgprot(PTE_PXN));
+}
+EXPORT_SYMBOL_GPL(set_memory_x);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
