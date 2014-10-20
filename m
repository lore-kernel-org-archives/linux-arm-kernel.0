From: js07.lee@gmail.com (Jungseung Lee)
Date: Mon, 20 Oct 2014 19:24:38 +0900
Subject: [PATCH] ARM: mm: Refine set_memory_* functions
Message-ID: <1413800678-6794-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_memory_* functions have same implementation
without memory attribute.

This is a change to reduce code size and enhance
the readability

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/mm/mmu.c | 70 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f98cec..34a64b3 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -364,33 +364,59 @@ static int pte_set_##_name(pte_t *ptep, pgtable_t token, unsigned long addr, \
 	return 0; \
 } \
 
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
 PTE_SET_FN(ro, pte_wrprotect)
 PTE_SET_FN(rw, pte_mkwrite)
 PTE_SET_FN(x, pte_mkexec)
 PTE_SET_FN(nx, pte_mknexec)
 
-SET_MEMORY_FN(ro, pte_set_ro)
-SET_MEMORY_FN(rw, pte_set_rw)
-SET_MEMORY_FN(x, pte_set_x)
-SET_MEMORY_FN(nx, pte_set_nx)
+static int set_memory_attr(unsigned long addr, pte_fn_t fn, int numpages)
+{
+	unsigned long start = addr;
+	unsigned long size = PAGE_SIZE*numpages;
+	unsigned end = start + size;
+
+	if (start < MODULES_VADDR || start >= MODULES_END)
+		return -EINVAL;
+
+	if (end < MODULES_VADDR || end >= MODULES_END)
+		return -EINVAL;
+
+	apply_to_page_range(&init_mm, start, size, fn, NULL);
+	flush_tlb_kernel_range(start, end);
+	return 0;
+}
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	int ret;
+
+	ret = set_memory_attr(addr, pte_set_ro, numpages);
+	return ret;
+}
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	int ret;
+
+	ret = set_memory_attr(addr, pte_set_rw, numpages);
+	return ret;
+}
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	int ret;
+
+	ret = set_memory_attr(addr, pte_set_x, numpages);
+	return ret;
+}
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	int ret;
+
+	ret = set_memory_attr(addr, pte_set_nx, numpages);
+	return ret;
+}
 
 /*
  * Adjust the PMD section entries according to the CPU in use.
-- 
1.9.1
