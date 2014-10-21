From: js07.lee@gmail.com (Jungseung Lee)
Date: Tue, 21 Oct 2014 20:00:37 +0900
Subject: [PATCH 2/2] arm: mm: Refine set_memory_* functions
In-Reply-To: <1413889237-6933-1-git-send-email-js07.lee@gmail.com>
References: <1413889237-6933-1-git-send-email-js07.lee@gmail.com>
Message-ID: <1413889237-6933-2-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_memory_* functions have same implementation
except memory attribute.

This patch makes to use common function for these, and pull out
the functions into arch/arm/mm/pageattr.c like arm64 did.
It will reduce code size and enhance the readability.

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/mm/Makefile   |  2 +-
 arch/arm/mm/mmu.c      | 38 ---------------------
 arch/arm/mm/pageattr.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/mm/pageattr.c

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 91da64d..d3afdf9 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -6,7 +6,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   iomap.o
 
 obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
-				   mmap.o pgd.o mmu.o
+				   mmap.o pgd.o mmu.o pageattr.o
 
 ifneq ($(CONFIG_MMU),y)
 obj-y				+= nommu.o
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f98cec..06817e1 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -354,44 +354,6 @@ const struct mem_type *get_mem_type(unsigned int type)
 }
 EXPORT_SYMBOL(get_mem_type);
 
-#define PTE_SET_FN(_name, pteop) \
-static int pte_set_##_name(pte_t *ptep, pgtable_t token, unsigned long addr, \
-			void *data) \
-{ \
-	pte_t pte = pteop(*ptep); \
-\
-	set_pte_ext(ptep, pte, 0); \
-	return 0; \
-} \
-
-#define SET_MEMORY_FN(_name, callback) \
-int set_memory_##_name(unsigned long addr, int numpages) \
-{ \
-	unsigned long start = addr; \
-	unsigned long size = PAGE_SIZE*numpages; \
-	unsigned end = start + size; \
-\
-	if (start < MODULES_VADDR || start >= MODULES_END) \
-		return -EINVAL;\
-\
-	if (end < MODULES_VADDR || end >= MODULES_END) \
-		return -EINVAL; \
-\
-	apply_to_page_range(&init_mm, start, size, callback, NULL); \
-	flush_tlb_kernel_range(start, end); \
-	return 0;\
-}
-
-PTE_SET_FN(ro, pte_wrprotect)
-PTE_SET_FN(rw, pte_mkwrite)
-PTE_SET_FN(x, pte_mkexec)
-PTE_SET_FN(nx, pte_mknexec)
-
-SET_MEMORY_FN(ro, pte_set_ro)
-SET_MEMORY_FN(rw, pte_set_rw)
-SET_MEMORY_FN(x, pte_set_x)
-SET_MEMORY_FN(nx, pte_set_nx)
-
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
new file mode 100644
index 0000000..004e35c
--- /dev/null
+++ b/arch/arm/mm/pageattr.c
@@ -0,0 +1,91 @@
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
+#include <linux/mm.h>
+#include <linux/module.h>
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
+	set_pte_ext(ptep, pte, 0);
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
+		start &= PAGE_MASK;
+		end = start + size;
+		WARN_ON_ONCE(1);
+	}
+
+	if (!is_module_address(start) || !is_module_address(end - 1))
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
+					__pgprot(L_PTE_RDONLY),
+					__pgprot(0));
+}
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					__pgprot(0),
+					__pgprot(L_PTE_RDONLY));
+}
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					__pgprot(L_PTE_XN),
+					__pgprot(0));
+}
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	return change_memory_common(addr, numpages,
+					__pgprot(0),
+					__pgprot(L_PTE_XN));
+}
-- 
1.9.1
