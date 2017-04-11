From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Tue, 11 Apr 2017 15:55:42 +0100
Subject: [PATCH 4/5] Hot-remove implementation for arm64
In-Reply-To: <cover.1491920513.git.ar@linux.vnet.ibm.com>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
Message-ID: <897973dd5d3fc91c70aba4b44350099a61c3a12c.1491920513.git.ar@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- arch_remove_memory interface
- kernel page tables cleanup
- vmemmap_free implementation for arm64

Signed-off-by: Andrea Reale <ar@linux.vnet.ibm.com>
Signed-off-by: Maciej Bielski <m.bielski@virtualopensystems.com>
---
 arch/arm64/Kconfig               |   3 +
 arch/arm64/include/asm/mmu.h     |   4 +
 arch/arm64/include/asm/pgtable.h |  15 ++
 arch/arm64/mm/init.c             |  32 +++-
 arch/arm64/mm/mmu.c              | 390 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 438 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fa71d94..83b8bb5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -624,6 +624,9 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
     depends on !NUMA
 	def_bool y
 
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	def_bool y
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 8eb31db..2cf2115 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -39,6 +39,10 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void hotplug_paging(phys_addr_t start, phys_addr_t size);
+#ifdef CONFIG_MEMORY_HOTREMOVE
+extern void remove_pagetable(unsigned long start,
+	unsigned long end, bool direct);
+#endif
 #endif
 
 #endif
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0eef606..194cb3e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -399,6 +399,11 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 	return pmd_val(pmd) & PHYS_MASK & (s32)PAGE_MASK;
 }
 
+static inline unsigned long pmd_page_vaddr(pmd_t pmd)
+{
+	return (unsigned long) __va(pmd_page_paddr(pmd));
+}
+
 /* Find an entry in the third-level page table. */
 #define pte_index(addr)		(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 
@@ -450,6 +455,11 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 	return pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK;
 }
 
+static inline unsigned long pud_page_vaddr(pud_t pud)
+{
+	return (unsigned long) __va(pud_page_paddr(pud));
+}
+
 /* Find an entry in the second-level page table. */
 #define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
 
@@ -502,6 +512,11 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 	return pgd_val(pgd) & PHYS_MASK & (s32)PAGE_MASK;
 }
 
+static inline unsigned long pgd_page_vaddr(pgd_t pgd)
+{
+	return (unsigned long) __va(pgd_page_paddr(pgd));
+}
+
 /* Find an entry in the frst-level page table. */
 #define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 259bb6e..c12983b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -551,7 +551,6 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
-	unsigned long pfn;
 	int ret;
 
 	if (end_pfn > max_sparsemem_pfn) {
@@ -624,5 +623,34 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 
 	return ret;
 }
-#endif
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+static void kernel_physical_mapping_remove(unsigned long start,
+	unsigned long end)
+{
+	start = (unsigned long)__va(start);
+	end = (unsigned long)__va(end);
+
+	remove_pagetable(start, end, true);
+
+}
+
+int arch_remove_memory(u64 start, u64 size)
+{
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct page *page = pfn_to_page(start_pfn);
+	struct zone *zone;
+	int ret = 0;
+
+	zone = page_zone(page);
+	ret = __remove_pages(zone, start_pfn, nr_pages);
+	WARN_ON_ONCE(ret);
+
+	kernel_physical_mapping_remove(start, start + size);
+
+	return ret;
+}
+
+#endif /* CONFIG_MEMORY_HOTREMOVE */
+#endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8882187..e129d7c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1,4 +1,3 @@
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 /*
  * Based on arch/arm/mm/mmu.c
  *
@@ -24,6 +23,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/libfdt.h>
+#include <linux/memremap.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
 #include <linux/memblock.h>
@@ -119,7 +119,6 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 		phys_addr_t pte_phys;
 		BUG_ON(!pgtable_alloc);
 		pte_phys = pgtable_alloc();
-		pr_debug("Allocating PTE at %p\n", __va(pte_phys));
 		pte = pte_set_fixmap(pte_phys);
 		__pmd_populate(pmd, pte_phys, PMD_TYPE_TABLE);
 		pte_clear_fixmap();
@@ -160,7 +159,6 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 		phys_addr_t pmd_phys;
 		BUG_ON(!pgtable_alloc);
 		pmd_phys = pgtable_alloc();
-		pr_debug("Allocating PMD at %p\n", __va(pmd_phys));
 		pmd = pmd_set_fixmap(pmd_phys);
 		__pud_populate(pud, pmd_phys, PUD_TYPE_TABLE);
 		pmd_clear_fixmap();
@@ -221,7 +219,6 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 		phys_addr_t pud_phys;
 		BUG_ON(!pgtable_alloc);
 		pud_phys = pgtable_alloc();
-		pr_debug("Allocating PUD at %p\n", __va(pud_phys));
 		__pgd_populate(pgd, pud_phys, PUD_TYPE_TABLE);
 	}
 	BUG_ON(pgd_bad(*pgd));
@@ -546,7 +543,389 @@ void hotplug_paging(phys_addr_t start, phys_addr_t size)
 	__free_pages(pg, 0);
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+#define PAGE_INUSE 0xFD
+
+static void  free_pagetable(struct page *page, int order, bool direct)
+{
+	unsigned long magic;
+	unsigned int nr_pages = 1 << order;
+	struct vmem_altmap *altmap = to_vmem_altmap((unsigned long) page);
+
+	if (altmap) {
+		vmem_altmap_free(altmap, nr_pages);
+		return;
+	}
+
+	/* bootmem page has reserved flag */
+	if (PageReserved(page)) {
+		__ClearPageReserved(page);
+
+		magic = (unsigned long)page->lru.next;
+		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
+			while (nr_pages--)
+				put_page_bootmem(page++);
+		} else {
+			while (nr_pages--)
+				free_reserved_page(page++);
+		}
+	} else {
+		/*
+		 * Only direct pagetable allocation (those allocated via
+		 * hotplug) call the pgtable_page_ctor; vmemmap pgtable
+		 * allocations don't.
+		 */
+		if (direct)
+			pgtable_page_dtor(page);
+
+		free_pages((unsigned long)page_address(page), order);
+	}
+}
+
+static void free_pte_table(pmd_t *pmd, bool direct)
+{
+	pte_t *pte_start, *pte;
+	struct page *page;
+	int i;
+
+	pte_start =  (pte_t *) pmd_page_vaddr(*pmd);
+	/* Check if there is no valid entry in the PMD */
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = pte_start + i;
+		if (!pte_none(*pte))
+			return;
+	}
+
+	page = pmd_page(*pmd);
+
+	free_pagetable(page, 0, direct);
+
+	/*
+	 * This spin lock could be only taken in _pte_aloc_kernel
+	 * in mm/memory.c and nowhere else (for arm64). Not sure if
+	 * the function above can be called concurrently. In doubt,
+	 * I am living it here for now, but it probably can be removed
+	 */
+	spin_lock(&init_mm.page_table_lock);
+	pmd_clear(pmd);
+	spin_unlock(&init_mm.page_table_lock);
+}
+
+static void free_pmd_table(pud_t *pud, bool direct)
+{
+	pmd_t *pmd_start, *pmd;
+	struct page *page;
+	int i;
+
+	pmd_start = (pmd_t *) pud_page_vaddr(*pud);
+	/* Check if there is no valid entry in the PMD */
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd = pmd_start + i;
+		if (!pmd_none(*pmd))
+			return;
+	}
+
+	page = pud_page(*pud);
+
+	free_pagetable(page, 0, direct);
+
+	/*
+	 * This spin lock could be only taken in _pte_aloc_kernel
+	 * in mm/memory.c and nowhere else (for arm64). Not sure if
+	 * the function above can be called concurrently. In doubt,
+	 * I am living it here for now, but it probably can be removed
+	 */
+	spin_lock(&init_mm.page_table_lock);
+	pud_clear(pud);
+	spin_unlock(&init_mm.page_table_lock);
+}
+
+/*
+ * When the PUD is folded on the PGD (three levels of paging),
+ * there's no need to free PUDs
+ */
+#if CONFIG_PGTABLE_LEVELS > 3
+static void free_pud_table(pgd_t *pgd, bool direct)
+{
+	pud_t *pud_start, *pud;
+	struct page *page;
+	int i;
+
+	pud_start = (pud_t *) pgd_page_vaddr(*pgd);
+	/* Check if there is no valid entry in the PUD */
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		pud = pud_start + i;
+		if (!pud_none(*pud))
+			return;
+	}
+
+	page = pgd_page(*pgd);
+
+	free_pagetable(page, 0, direct);
+
+	/*
+	 * This spin lock could be only
+	 * taken in _pte_aloc_kernel in
+	 * mm/memory.c and nowhere else
+	 * (for arm64). Not sure if the
+	 * function above can be called
+	 * concurrently. In doubt,
+	 * I am living it here for now,
+	 * but it probably can be removed.
+	 */
+	spin_lock(&init_mm.page_table_lock);
+	pgd_clear(pgd);
+	spin_unlock(&init_mm.page_table_lock);
+}
+#endif
+
+static void remove_pte_table(pte_t *pte, unsigned long addr,
+	unsigned long end, bool direct)
+{
+	unsigned long next;
+	void *page_addr;
+
+	for (; addr < end; addr = next, pte++) {
+		next = (addr + PAGE_SIZE) & PAGE_MASK;
+		if (next > end)
+			next = end;
+
+		if (!pte_present(*pte))
+			continue;
+
+		if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
+			/*
+			 * Do not free direct mapping pages since they were
+			 * freed when offlining, or simplely not in use.
+			 */
+			if (!direct)
+				free_pagetable(pte_page(*pte), 0, direct);
+
+			/*
+			 * This spin lock could be only
+			 * taken in _pte_aloc_kernel in
+			 * mm/memory.c and nowhere else
+			 * (for arm64). Not sure if the
+			 * function above can be called
+			 * concurrently. In doubt,
+			 * I am living it here for now,
+			 * but it probably can be removed.
+			 */
+			spin_lock(&init_mm.page_table_lock);
+			pte_clear(&init_mm, addr, pte);
+			spin_unlock(&init_mm.page_table_lock);
+		} else {
+			/*
+			 * If we are here, we are freeing vmemmap pages since
+			 * direct mapped memory ranges to be freed are aligned.
+			 *
+			 * If we are not removing the whole page, it means
+			 * other page structs in this page are being used and
+			 * we canot remove them. So fill the unused page_structs
+			 * with 0xFD, and remove the page when it is wholly
+			 * filled with 0xFD.
+			 */
+			memset((void *)addr, PAGE_INUSE, next - addr);
+
+			page_addr = page_address(pte_page(*pte));
+			if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
+				free_pagetable(pte_page(*pte), 0, direct);
+
+				/*
+				 * This spin lock could be only
+				 * taken in _pte_aloc_kernel in
+				 * mm/memory.c and nowhere else
+				 * (for arm64). Not sure if the
+				 * function above can be called
+				 * concurrently. In doubt,
+				 * I am living it here for now,
+				 * but it probably can be removed.
+				 */
+				spin_lock(&init_mm.page_table_lock);
+				pte_clear(&init_mm, addr, pte);
+				spin_unlock(&init_mm.page_table_lock);
+			}
+		}
+	}
+
+	// I am adding this flush here in simmetry to the x86 code.
+	// Why do I need to call it here and not in remove_p[mu]d
+	flush_tlb_all();
+}
+
+static void remove_pmd_table(pmd_t *pmd, unsigned long addr,
+	unsigned long end, bool direct)
+{
+	unsigned long next;
+	void *page_addr;
+	pte_t *pte;
+
+	for (; addr < end; addr = next, pmd++) {
+		next = pmd_addr_end(addr, end);
+
+		if (!pmd_present(*pmd))
+			continue;
+
+		// check if we are using 2MB section mappings
+		if (pmd_sect(*pmd)) {
+			if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
+				if (!direct) {
+					free_pagetable(pmd_page(*pmd),
+						get_order(PMD_SIZE), direct);
+				}
+				/*
+				 * This spin lock could be only
+				 * taken in _pte_aloc_kernel in
+				 * mm/memory.c and nowhere else
+				 * (for arm64). Not sure if the
+				 * function above can be called
+				 * concurrently. In doubt,
+				 * I am living it here for now,
+				 * but it probably can be removed.
+				 */
+				spin_lock(&init_mm.page_table_lock);
+				pmd_clear(pmd);
+				spin_unlock(&init_mm.page_table_lock);
+			} else {
+				/* If here, we are freeing vmemmap pages. */
+				memset((void *)addr, PAGE_INUSE, next - addr);
+
+				page_addr = page_address(pmd_page(*pmd));
+				if (!memchr_inv(page_addr, PAGE_INUSE,
+						PMD_SIZE)) {
+					free_pagetable(pmd_page(*pmd),
+						get_order(PMD_SIZE), direct);
+
+					/*
+					 * This spin lock could be only
+					 * taken in _pte_aloc_kernel in
+					 * mm/memory.c and nowhere else
+					 * (for arm64). Not sure if the
+					 * function above can be called
+					 * concurrently. In doubt,
+					 * I am living it here for now,
+					 * but it probably can be removed.
+					 */
+					spin_lock(&init_mm.page_table_lock);
+					pmd_clear(pmd);
+					spin_unlock(&init_mm.page_table_lock);
+				}
+			}
+			continue;
+		}
+
+		BUG_ON(!pmd_table(*pmd));
+
+		pte = pte_offset_map(pmd, addr);
+		remove_pte_table(pte, addr, next, direct);
+		free_pte_table(pmd, direct);
+	}
+}
+
+static void remove_pud_table(pud_t *pud, unsigned long addr,
+	unsigned long end, bool direct)
+{
+	unsigned long next;
+	pmd_t *pmd;
+	void *page_addr;
+
+	for (; addr < end; addr = next, pud++) {
+		next = pud_addr_end(addr, end);
+		if (!pud_present(*pud))
+			continue;
+		/*
+		 * If we are using 4K granules, check if we are using
+		 * 1GB section mapping.
+		 */
+		if (pud_sect(*pud)) {
+			if (PAGE_ALIGNED(addr) && PAGE_ALIGNED(next)) {
+				if (!direct) {
+					free_pagetable(pud_page(*pud),
+						get_order(PUD_SIZE), direct);
+				}
+
+				/*
+				 * This spin lock could be only
+				 * taken in _pte_aloc_kernel in
+				 * mm/memory.c and nowhere else
+				 * (for arm64). Not sure if the
+				 * function above can be called
+				 * concurrently. In doubt,
+				 * I am living it here for now,
+				 * but it probably can be removed.
+				 */
+				spin_lock(&init_mm.page_table_lock);
+				pud_clear(pud);
+				spin_unlock(&init_mm.page_table_lock);
+			} else {
+				/* If here, we are freeing vmemmap pages. */
+				memset((void *)addr, PAGE_INUSE, next - addr);
+
+				page_addr = page_address(pud_page(*pud));
+				if (!memchr_inv(page_addr, PAGE_INUSE,
+						PUD_SIZE)) {
+
+					free_pagetable(pud_page(*pud),
+						get_order(PUD_SIZE), direct);
+
+					/*
+					 * This spin lock could be only
+					 * taken in _pte_aloc_kernel in
+					 * mm/memory.c and nowhere else
+					 * (for arm64). Not sure if the
+					 * function above can be called
+					 * concurrently. In doubt,
+					 * I am living it here for now,
+					 * but it probably can be removed.
+					 */
+					spin_lock(&init_mm.page_table_lock);
+					pud_clear(pud);
+					spin_unlock(&init_mm.page_table_lock);
+				}
+			}
+			continue;
+		}
+
+		BUG_ON(!pud_table(*pud));
+
+		pmd = pmd_offset(pud, addr);
+		remove_pmd_table(pmd, addr, next, direct);
+		free_pmd_table(pud, direct);
+	}
+}
+
+void remove_pagetable(unsigned long start, unsigned long end, bool direct)
+{
+	unsigned long next;
+	unsigned long addr;
+	pgd_t *pgd;
+	pud_t *pud;
+
+	for (addr = start; addr < end; addr = next) {
+		next = pgd_addr_end(addr, end);
+
+		pgd = pgd_offset_k(addr);
+		if (pgd_none(*pgd))
+			continue;
+
+		pud = pud_offset(pgd, addr);
+		remove_pud_table(pud, addr, next, direct);
+		/*
+		 * When the PUD is folded on the PGD (three levels of paging),
+		 * I did already clear the PMD page in free_pmd_table,
+		 * and reset the corresponding PGD==PUD entry.
+		 */
+#if CONFIG_PGTABLE_LEVELS > 3
+		free_pud_table(pgd, direct);
 #endif
+	}
+
+	flush_tlb_all();
+}
+
+
+#endif /* CONFIG_MEMORY_HOTREMOVE */
+#endif /* CONFIG_MEMORY_HOTPLUG */
 
 /*
  * Check whether a kernel address is valid (derived from arch/x86/).
@@ -629,6 +1008,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 #endif	/* CONFIG_ARM64_64K_PAGES */
 void vmemmap_free(unsigned long start, unsigned long end)
 {
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	remove_pagetable(start, end, false);
+#endif
 }
 #endif	/* CONFIG_SPARSEMEM_VMEMMAP */
 
-- 
1.9.1
