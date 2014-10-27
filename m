From: zhichang.yuan@linaro.org (zhichang.yuan at linaro.org)
Date: Mon, 27 Oct 2014 12:01:28 +0800
Subject: [PATCH v0] ARMv8:mm:Support the DEBUG_PAGEALLOC
Message-ID: <1414382488-916-1-git-send-email-zhichang.yuan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "zhichang.yuan" <zhichang.yuan@linaro.org>

This patch targets to support DEBUG_PAGEALLOC on ARMv8.

Meanwhile, it adds the processing to free some unused
page tables created in direct kernel mapping.

The patch was tested based on the following code @:
https://git.linaro.org/people/zhichang.yuan/pgalloc.git/shortlog/refs/heads/test_pgalloc_v1

Signed-off-by: Zhichang Yuan <zhichang.yuan@linaro.org>
---
 arch/arm64/Kconfig                     |    3 +
 arch/arm64/include/asm/pgtable-hwdef.h |    6 +
 arch/arm64/include/asm/pgtable.h       |   21 +++
 arch/arm64/mm/mmu.c                    |  263 +++++++++++++++++++++++++++++++-
 4 files changed, 288 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd4e81a..da072d4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -128,6 +128,9 @@ config KERNEL_MODE_NEON
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 88174e0..0a62e9a 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -65,6 +65,12 @@
 #define PUD_TYPE_SECT		(_AT(pgdval_t, 1) << 0)
 
 /*
+ * Section
+ */
+#define PUD_SECT_VALID		(_AT(pmdval_t, 1) << 0)
+#define PUD_SECT_PROT_NONE	(_AT(pmdval_t, 1) << 58)
+
+/*
  * Level 2 descriptor (PMD).
  */
 #define PMD_TYPE_MASK		(_AT(pmdval_t, 3) << 0)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ffe1ba0..4246f3b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -313,9 +313,12 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 #ifdef CONFIG_ARM64_64K_PAGES
 #define pud_sect(pud)		(0)
+#define pud_table(pud)		(1)
 #else
 #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
 				 PUD_TYPE_SECT)
+#define pud_table(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
+					 PUD_TYPE_TABLE)
 #endif
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
@@ -422,6 +425,14 @@ static inline pud_t *pud_offset(pgd_t *pgd, unsigned long addr)
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
+
+#define PHYSICAL_PAGE_MASK	(((signed long)PAGE_MASK) & PHYS_MASK)
+/* PTE_PFN_MASK extracts the PFN from a (pte|pmd|pud|pgd)val_t */
+#define PTE_PFN_MASK		((pteval_t)PHYSICAL_PAGE_MASK)
+
+/* PTE_FLAGS_MASK extracts the flags from a (pte|pmd|pud|pgd)val_t */
+#define PTE_FLAGS_MASK		(~PTE_PFN_MASK)
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
@@ -477,6 +488,16 @@ extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 
 #define PTE_FILE_MAX_BITS	55
 
+extern pte_t *lookup_kaddress(unsigned long address, unsigned int *level);
+
+enum pg_level {
+	PG_LEVEL_NONE,
+	PG_LEVEL_PAGE,
+	PG_LEVEL_PMD,
+	PG_LEVEL_PUD,
+	PG_LEVEL_NUM
+};
+
 extern int kern_addr_valid(unsigned long addr);
 
 #include <asm-generic/pgtable.h>
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c555672..6bc5f70 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -132,10 +132,21 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 static void __init *early_alloc(unsigned long sz)
 {
 	void *ptr = __va(memblock_alloc(sz, sz));
+
 	memset(ptr, 0, sz);
 	return ptr;
 }
 
+/*Free the page used as pmd table entry in direct mapping*/
+static inline void __init pmd_table_free(pmd_t *pmd, unsigned long addr)
+{
+	if (pmd_table(*pmd)) {
+		phys_addr_t table = __pa(pte_offset_kernel(pmd, 0));
+
+		memblock_free(table, PAGE_SIZE);
+	}
+}
+
 static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  pgprot_t prot)
@@ -185,14 +196,16 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
 		next = pmd_addr_end(addr, end);
 		/* try section mapping first */
 		if (((addr | next | phys) & ~SECTION_MASK) == 0) {
-			pmd_t old_pmd =*pmd;
+			pmd_t old_pmd = *pmd;
+
 			set_pmd(pmd, __pmd(phys | prot_sect));
 			/*
 			 * Check for previous table entries created during
 			 * boot (__create_page_tables) and flush them.
 			 */
 			if (!pmd_none(old_pmd))
-				flush_tlb_all();
+				flush_tlb_kernel_range(addr, next);
+			pmd_table_free(&old_pmd, addr);
 		} else {
 			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
 				       prot_pte);
@@ -224,6 +237,7 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
 		if (!map_io && (PAGE_SHIFT == 12) &&
 		    ((addr | next | phys) & ~PUD_MASK) == 0) {
 			pud_t old_pud = *pud;
+
 			set_pud(pud, __pud(phys | PROT_SECT_NORMAL_EXEC));
 
 			/*
@@ -234,9 +248,15 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
 			 * Look up the old pmd table and free it.
 			 */
 			if (!pud_none(old_pud)) {
-				phys_addr_t table = __pa(pmd_offset(&old_pud, 0));
-				memblock_free(table, PAGE_SIZE);
-				flush_tlb_all();
+				flush_tlb_kernel_range(addr, next);
+				if (pud_table(old_pud)) {
+					phys_addr_t table =
+						__pa(pmd_offset(&old_pud, 0));
+					pmd_t *pmd = pmd_offset(pud, addr);
+
+					pmd_table_free(pmd, addr);
+					memblock_free(table, PAGE_SIZE);
+				}
 			}
 		} else {
 			alloc_init_pmd(pud, addr, next, phys, map_io);
@@ -287,6 +307,219 @@ void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
 			 addr, addr, size, map_io);
 }
 
+static inline pte_t *lookup_kaddress_in_pgd(pgd_t *pgd,
+			unsigned long address,
+			unsigned int *level)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+
+	*level = PG_LEVEL_NONE;
+
+	if (pgd_none(*pgd))
+		return NULL;
+
+	pud = pud_offset(pgd, address);
+	if (pud_none(*pud))
+		return NULL;
+
+	*level = PG_LEVEL_PUD;
+	if (pud_sect(*pud) || !(pud_val(*pud) & PUD_SECT_VALID))
+		return (pte_t *)pud;
+
+	pmd = pmd_offset(pud, address);
+	if (pmd_none(*pmd))
+		return NULL;
+
+	/*
+	* !(pmd_val(*pmd) & PMD_SECT_VALID) means PMD_TYPE_MASK &(*pmd)
+	* is 0, but *pmd is non-zero.
+	* For Huge page split.
+	*/
+	*level = PG_LEVEL_PMD;
+	if (pmd_sect(*pmd) || !(pmd_val(*pmd) & PMD_SECT_VALID))
+		return (pte_t *)pmd;
+
+	*level = PG_LEVEL_PAGE;
+
+	return pte_offset_kernel(pmd, address);
+}
+
+
+pte_t *lookup_kaddress(unsigned long address, unsigned int *level)
+{
+	return lookup_kaddress_in_pgd(pgd_offset_k(address), address, level);
+}
+EXPORT_SYMBOL_GPL(lookup_kaddress);
+
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+
+static void __split_pmd_page_mapping(pmd_t *pmd,
+			unsigned long addr,
+			void *p_base)
+{
+	pte_t *pte_base;
+	int i;
+
+	pgprot_t prot_val;
+
+	unsigned long pfn;
+
+	pte_base = (pte_t *)p_base;
+
+	/*get the original pgprot value.*/
+	prot_val = pmd_val(*pmd) & PTE_FLAGS_MASK;
+	prot_val &= ~PTE_TYPE_MASK;
+	prot_val |= PTE_TYPE_PAGE;
+
+	pfn = pmd_pfn(*pmd);
+	for (i = 0; i < PTRS_PER_PTE; i++, pfn += 1)
+		set_pte(pte_base + i, pfn_pte(pfn, prot_val));
+
+	__pmd_populate(pmd, __pa(pte_base), PMD_TYPE_TABLE);
+	flush_tlb_kernel_range((addr & PMD_MASK),
+			((addr + PMD_SIZE) & PMD_MASK));
+}
+
+
+static void __split_pud_page_mapping(pud_t *pud,
+			unsigned long addr,
+			void *p_base)
+{
+	int i;
+
+	pgprot_t old_prot;
+
+	unsigned long pfn, pfn_inc;
+
+	pmd_t *pmd_base = (pmd_t *)p_base;
+
+	/*get the original pgprot value.*/
+	old_prot = pud_val(*pud) & PTE_FLAGS_MASK;
+
+	pfn = pud_pfn(*pud);
+	pfn_inc = PMD_SIZE >> PAGE_SHIFT;
+	for (i = 0; i < PTRS_PER_PMD; i++, pfn += pfn_inc)
+		set_pmd(pmd_base + i, pfn_pmd(pfn, old_prot));
+
+	pud_populate(&init_mm, pud, pmd_base);
+	flush_tlb_all();
+}
+
+void kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	unsigned long start_addr, end_addr, addr;
+	unsigned int level;
+
+	pte_t *kpte;
+	pteval_t old_pval, new_pval;
+
+	int i, counter = 0;
+
+	/*no highmem in ARMv8. */
+	addr = start_addr = (unsigned long)page_address(page);
+	end_addr = start_addr + (numpages << PAGE_SHIFT);
+
+	for (i = 0; i < numpages; addr += PAGE_SIZE, i++) {
+		kpte = lookup_kaddress(addr, &level);
+		/*
+		* skip the memory holes. it is impossible if the input
+		* parameter is valid.
+		*/
+		if (unlikely(!kpte || pte_none(*kpte))) {
+			pr_err("Have no kernel linear mapping for 0x%0lx\n", addr);
+			break;
+		}
+
+		if (level != PG_LEVEL_PAGE) {
+			pr_err("Page entry for 0x%0lx is not PAGE LEVEL(%d)\n",
+				addr, level);
+			break;
+		}
+
+		old_pval = pte_val(*kpte);
+		new_pval = (enable) ? (old_pval | PTE_VALID) :
+			(old_pval & (~PTE_VALID));
+		if (unlikely(new_pval == old_pval)) {
+			pr_warn("Page %s: same pte value@0x%llx",
+				(enable) ? "alloc" : "free", old_pval);
+			continue;
+		}
+
+		set_pte(kpte, __pte(new_pval));
+		counter++;
+	}
+
+	if (counter)
+		flush_tlb_kernel_range(start_addr, end_addr);
+}
+
+
+static int __init early_split_large_page_mapping(unsigned long virt,
+			phys_addr_t phys,
+			phys_addr_t size)
+{
+	pte_t *pte;
+	void *pte_base;
+
+	unsigned long addr, end, next;
+	unsigned int pg_level;
+	unsigned long size_level;
+	unsigned long mask_level;
+
+	/*make the addr aligned to PAGE*/
+	addr = virt & PAGE_MASK;
+	end = addr + PAGE_ALIGN(size + (virt & ~PAGE_MASK));
+
+	for (; addr != end; phys += (next - addr), addr = next) {
+repeat:
+		pte = lookup_kaddress(addr, &pg_level);
+		/*
+		* support the input memory range is a wider range. If we
+		* can not find valid page entry for some addresses, we do
+		* not know the page section size. But we only care the
+		* large page, just move forward in minimal large page size
+		* (PMD size)
+		*/
+		if (!pte || pte_none(*pte)) {
+			next = pmd_addr_end(addr, end);
+			continue;
+		}
+
+		size_level = (_AC(1, UL) <<
+			((PAGE_SHIFT - 3) * pg_level + 3));
+		mask_level = ~(size_level - 1);
+
+		next = (addr + size_level) & mask_level;
+		if (next > end)
+			next = end;
+
+		/*Does it need to split it?*/
+		if (pg_level == PG_LEVEL_PAGE)
+			continue;
+
+		/*start the splitting...*/
+		if (pte_pfn(*pte) != PFN_DOWN(phys & mask_level)) {
+			pr_err("Physical addr 0x%0llx mis-match with virt 0x%0lx\n",
+					pte_pfn(*pte), addr & mask_level);
+			return -1;
+		}
+
+		pte_base = early_alloc(PAGE_SIZE);
+
+		if (pg_level == PG_LEVEL_PUD) {
+			__split_pud_page_mapping((pud_t *)pte, addr, pte_base);
+			goto repeat;
+		}
+		__split_pmd_page_mapping((pmd_t *)pte, addr, pte_base);
+	}
+
+	return 0;
+}
+
+
+#endif
 static void __init map_mem(void)
 {
 	struct memblock_region *reg;
@@ -331,6 +564,26 @@ static void __init map_mem(void)
 		create_mapping(start, __phys_to_virt(start), end - start);
 	}
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	/*
+	* the biggest direct mapping is ready, then start the PTE building.
+	* Now,there are sufficient mapped pages to store the PTE tables.
+	* And more important, doing large page splitting here can dispose
+	* the page tables in contiguous memory area.
+	*/
+	for_each_memblock(memory, reg) {
+		phys_addr_t start = reg->base;
+		phys_addr_t end = start + reg->size;
+
+		if (start >= end || PFN_UP(start) >= PFN_DOWN(end))
+			break;
+
+		if (early_split_large_page_mapping(__phys_to_virt(start),
+				start, end - start))
+			panic("map_mem:Fail to split large page[0x%0llx,0x%0llx)\n",
+				start, end);
+	}
+#endif
 	/* Limit no longer required. */
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 }
-- 
1.7.9.5
