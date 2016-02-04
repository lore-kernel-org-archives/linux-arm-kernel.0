From: labbott@fedoraproject.org (Laura Abbott)
Date: Thu,  4 Feb 2016 11:43:36 -0800
Subject: [PATCHv2 2/3] arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
In-Reply-To: <1454615017-24672-1-git-send-email-labbott@fedoraproject.org>
References: <1454615017-24672-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <1454615017-24672-3-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


ARCH_SUPPORTS_DEBUG_PAGEALLOC provides a hook to map and unmap
pages for debugging purposes. This requires memory be mapped
with PAGE_SIZE mappings since breaking down larger mappings
at runtime will lead to TLB conflicts. Check if debug_pagealloc
is enabled at runtime and if so, map everyting with PAGE_SIZE
pages. Implement the functions to actually map/unmap the
pages at runtime.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
 arch/arm64/Kconfig       |  3 +++
 arch/arm64/mm/mmu.c      | 25 +++++++++++++++++++++----
 arch/arm64/mm/pageattr.c | 46 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8cc6228..0f33218 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -537,6 +537,9 @@ config HOTPLUG_CPU
 source kernel/Kconfig.preempt
 source kernel/Kconfig.hz
 
+config ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	def_bool y
+
 config ARCH_HAS_HOLES_MEMORYMODEL
 	def_bool y if SPARSEMEM
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ef0d66c..be81a59 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -180,8 +180,14 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	pmd = pmd_set_fixmap_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		/* try section mapping first */
-		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
+		/*
+		 * try a section mapping first
+		 *
+		 * See comment in use_1G_block for why we need the check
+		 * for !pgtable_alloc with !debug_pagealloc
+		 */
+		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
+		      (!debug_pagealloc_enabled() || !pgtable_alloc)) {
 			pmd_t old_pmd =*pmd;
 			set_pmd(pmd, __pmd(phys |
 					   pgprot_val(mk_sect_prot(prot))));
@@ -208,8 +214,19 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 }
 
 static inline bool use_1G_block(unsigned long addr, unsigned long next,
-			unsigned long phys)
+			unsigned long phys, phys_addr_t (*pgtable_alloc)(void))
 {
+	/*
+	 * If debug_page_alloc is enabled we don't want to be using sections
+	 * since everything needs to be mapped with pages. The catch is
+	 * that we only want to force pages if we can allocate the next
+	 * layer of page tables. If there is no pgtable_alloc function,
+	 * it's too early to allocate another layer and we should use
+	 * section mappings.
+	 */
+	if (pgtable_alloc && debug_pagealloc_enabled())
+		return false;
+
 	if (PAGE_SHIFT != 12)
 		return false;
 
@@ -241,7 +258,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
-		if (use_1G_block(addr, next, phys)) {
+		if (use_1G_block(addr, next, phys, pgtable_alloc)) {
 			pud_t old_pud = *pud;
 			set_pud(pud, __pud(phys |
 					   pgprot_val(mk_sect_prot(prot))));
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 1360a02..57877af 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -37,14 +37,31 @@ static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
 	return 0;
 }
 
+/*
+ * This function assumes that the range is mapped with PAGE_SIZE pages.
+ */
+static int __change_memory_common(unsigned long start, unsigned long size,
+				pgprot_t set_mask, pgprot_t clear_mask)
+{
+	struct page_change_data data;
+	int ret;
+
+	data.set_mask = set_mask;
+	data.clear_mask = clear_mask;
+
+	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
+					&data);
+
+	flush_tlb_kernel_range(start, start+size);
+	return ret;
+}
+
 static int change_memory_common(unsigned long addr, int numpages,
 				pgprot_t set_mask, pgprot_t clear_mask)
 {
 	unsigned long start = addr;
 	unsigned long size = PAGE_SIZE*numpages;
 	unsigned long end = start + size;
-	int ret;
-	struct page_change_data data;
 	struct vm_struct *area;
 
 	if (!PAGE_ALIGNED(addr)) {
@@ -72,14 +89,7 @@ static int change_memory_common(unsigned long addr, int numpages,
 	    !(area->flags & VM_ALLOC))
 		return -EINVAL;
 
-	data.set_mask = set_mask;
-	data.clear_mask = clear_mask;
-
-	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
-					&data);
-
-	flush_tlb_kernel_range(start, end);
-	return ret;
+	return __change_memory_common(start, size, set_mask, clear_mask);
 }
 
 int set_memory_ro(unsigned long addr, int numpages)
@@ -111,3 +121,19 @@ int set_memory_x(unsigned long addr, int numpages)
 					__pgprot(PTE_PXN));
 }
 EXPORT_SYMBOL_GPL(set_memory_x);
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	unsigned long addr = (unsigned long) page_address(page);
+
+	if (enable)
+		__change_memory_common(addr, PAGE_SIZE*numpages,
+					__pgprot(PTE_VALID),
+					__pgprot(0));
+	else
+		__change_memory_common(addr, PAGE_SIZE*numpages,
+					__pgprot(0),
+					__pgprot(PTE_VALID));
+}
+#endif
-- 
2.5.0
