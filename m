From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Tue, 11 Apr 2017 15:55:22 +0100
Subject: [PATCH 3/5] Memory hotplug support for arm64 platform (v2)
In-Reply-To: <cover.1491920513.git.ar@linux.vnet.ibm.com>
References: <cover.1491920513.git.ar@linux.vnet.ibm.com>
Message-ID: <50119579bdbb23a4d888d13b0a46cb2e027839ed.1491920513.git.ar@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maciej Bielski <m.bielski@virtualopensystems.com>

This is a second and improved version of the patch previously released
in [3].

It builds on the work by Scott Branden [2] and, henceforth,
it needs to be applied on top of Scott's patches [2].
Comments are very welcome.

Changes from the original patchset and known issues:

- Compared to Scott's original patchset, this work adds the mapping of
  the new hotplugged pages into the kernel page tables. This is done by
  copying the old swapper_pg_dir over a new page, adding the new mappings,
  and then switching to the newly built pg_dir (see `hotplug_paging` in
  arch/arm64/mmu.c). There might be better ways to to this: suggestions
  are more than welcome.

- The stub function for `arch_remove_memory` has been removed for now; we
  are working in parallel on memory hot remove, and we plan to contribute
  it as a separate patch.

- Corresponding Kconfig flags have been added;

- Note that this patch does not work when NUMA is enabled; in fact,
  the function `memory_add_physaddr_to_nid` does not have an
  implementation when the NUMA flag is on: this function is supposed to
  return the nid the hotplugged memory should be associated with. However
  it is not really clear to us  yet what the semantics of this function
  in the context of a NUMA system should be. A quick and dirty fix would
  be to always attach to the first available NUMA node.

- In arch/arm64/mm/init.c `arch_add_memory`, we are doing a hack with the
  nomap memory block flags to satisfy preconditions and postconditions of
  `__add_pages` and postconditions of `arch_add_memory`. Compared to
  memory hotplug implementation for other architectures, the "issue"
  seems to be in the implemenation of `pfn_valid`. Suggestions on how
  to cleanly avoid this hack are welcome.

This patchset can be tested by starting the kernel with the `mem=X` flag, where
X is less than the total available physical memory and has to be multiple of
MIN_MEMORY_BLOCK_SIZE. We also tested it on a customised version of QEMU
capable to emulate physical hotplug on arm64 platform.

To enable the feature the CONFIG_MEMORY_HOTPLUG compilation flag
needs to be set to true. Then, after memory is physically hotplugged,
the standard two steps to make it available (as also documented in
Documentation/memory-hotplug.txt) are:

(1) Notify memory hot-add
 	echo '0xYY000000' > /sys/devices/system/memory/probe

where 0xYY000000 is the first physical address of the new memory section.

(2) Online new memory block(s)
    echo online > /sys/devices/system/memory/memoryXXX/state
    -- or --
    echo online_movable > /sys/devices/system/memory/memoryXXX/state

where XXX corresponds to the ids of newly added blocks.

Onlining can optionally be automatic at hot-add notification by enabling
the global flag:
	echo online > /sys/devices/system/memory/auto_online_blocks
or by setting the corresponding config flag in the kernel build.

Again, any comment is highly appreciated.

[1] https://lkml.org/lkml/2016/11/17/49
[2] https://lkml.org/lkml/2016/12/1/811
[3] https://lkml.org/lkml/2016/12/14/188

Signed-off-by: Maciej Bielski <m.bielski@virtualopensystems.com>
Signed-off-by: Andrea Reale <ar@linux.vnet.ibm.com>
---
 arch/arm64/Kconfig           |  4 +--
 arch/arm64/include/asm/mmu.h |  3 ++
 arch/arm64/mm/init.c         | 77 ++++++++++++++++++++++++++++++++++----------
 arch/arm64/mm/mmu.c          | 35 ++++++++++++++++++++
 include/linux/memblock.h     |  1 +
 mm/memblock.c                | 10 ++++++
 6 files changed, 110 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d930f73..fa71d94 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -621,9 +621,7 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu.
 
 config ARCH_ENABLE_MEMORY_HOTPLUG
-	def_bool y
-
-config ARCH_ENABLE_MEMORY_HOTREMOVE
+    depends on !NUMA
 	def_bool y
 
 # Common NUMA Features
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 4761941..8eb31db 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -37,5 +37,8 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys);
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern void hotplug_paging(phys_addr_t start, phys_addr_t size);
+#endif
 
 #endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 4dcb8f7..259bb6e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -549,37 +549,80 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 	struct zone *zone;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
+	unsigned long pfn;
 	int ret;
 
+	if (end_pfn > max_sparsemem_pfn) {
+		pr_err("end_pfn too big");
+		return -1;
+	}
+	hotplug_paging(start, size);
+
+	/*
+	 * Mark the first page in the range as unusable. This is needed
+	 * because __add_section (within __add_pages) wants pfn_valid
+	 * of it to be false, and in arm64 pfn falid is implemented by
+	 * just checking at the nomap flag for existing blocks.
+	 *
+	 * A small trick here is that __add_section() requires only
+	 * phys_start_pfn (that is the first pfn of a section) to be
+	 * invalid. Regardless of whether it was assumed (by the function
+	 * author) that all pfns within a section are either all valid
+	 * or all invalid, it allows to avoid looping twice (once here,
+	 * second when memblock_clear_nomap() is called) through all
+	 * pfns of the section and modify only one pfn. Thanks to that,
+	 * further, in __add_zone() only this very first pfn is skipped
+	 * and corresponding page is not flagged reserved. Therefore it
+	 * is enough to correct this setup only for it.
+	 *
+	 * When arch_add_memory() returns the walk_memory_range() function
+	 * is called and passed with online_memory_block() callback,
+	 * which execution finally reaches the memory_block_action()
+	 * function, where also only the first pfn of a memory block is
+	 * checked to be reserved. Above, it was first pfn of a section,
+	 * here it is a block but
+	 * (drivers/base/memory.c):
+	 *     sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
+	 * (include/linux/memory.h):
+	 *     #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
+	 * so we can consider block and section equivalently
+	 */
+	memblock_mark_nomap(start, 1<<PAGE_SHIFT);
+
 	pgdat = NODE_DATA(nid);
 
 	zone = pgdat->node_zones +
 		zone_for_memory(nid, start, size, ZONE_NORMAL, for_device);
 	ret = __add_pages(nid, zone, start_pfn, nr_pages);
 
-	if (ret)
-		pr_warn("%s: Problem encountered in __add_pages() ret=%d\n",
-			__func__, ret);
-
-	return ret;
-}
+	/*
+	 * Make the pages usable after they have been added.
+	 * This will make pfn_valid return true
+	 */
+	memblock_clear_nomap(start, 1<<PAGE_SHIFT);
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size)
-{
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long nr_pages = size >> PAGE_SHIFT;
-	struct zone *zone;
-	int ret;
+	/*
+	 * This is a hack to avoid having to mix arch specific code
+	 * into arch independent code. SetPageReserved is supposed
+	 * to be called by __add_zone (within __add_section, within
+	 * __add_pages). However, when it is called there, it assumes that
+	 * pfn_valid returns true.  For the way pfn_valid is implemented
+	 * in arm64 (a check on the nomap flag), the only way to make
+	 * this evaluate true inside __add_zone is to clear the nomap
+	 * flags of blocks in architecture independent code.
+	 *
+	 * To avoid this, we set the Reserved flag here after we cleared
+	 * the nomap flag in the line above.
+	 */
+	SetPageReserved(pfn_to_page(start_pfn));
 
-	zone = page_zone(pfn_to_page(start_pfn));
-	ret = __remove_pages(zone, start_pfn, nr_pages);
 	if (ret)
-		pr_warn("%s: Problem encountered in __remove_pages() ret=%d\n",
+		pr_warn("%s: Problem encountered in __add_pages() ret=%d\n",
 			__func__, ret);
 
 	return ret;
 }
 #endif
-#endif
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d28dbcf..8882187 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1,3 +1,4 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 /*
  * Based on arch/arm/mm/mmu.c
  *
@@ -118,6 +119,7 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 		phys_addr_t pte_phys;
 		BUG_ON(!pgtable_alloc);
 		pte_phys = pgtable_alloc();
+		pr_debug("Allocating PTE at %p\n", __va(pte_phys));
 		pte = pte_set_fixmap(pte_phys);
 		__pmd_populate(pmd, pte_phys, PMD_TYPE_TABLE);
 		pte_clear_fixmap();
@@ -158,6 +160,7 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 		phys_addr_t pmd_phys;
 		BUG_ON(!pgtable_alloc);
 		pmd_phys = pgtable_alloc();
+		pr_debug("Allocating PMD at %p\n", __va(pmd_phys));
 		pmd = pmd_set_fixmap(pmd_phys);
 		__pud_populate(pud, pmd_phys, PUD_TYPE_TABLE);
 		pmd_clear_fixmap();
@@ -218,6 +221,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 		phys_addr_t pud_phys;
 		BUG_ON(!pgtable_alloc);
 		pud_phys = pgtable_alloc();
+		pr_debug("Allocating PUD at %p\n", __va(pud_phys));
 		__pgd_populate(pgd, pud_phys, PUD_TYPE_TABLE);
 	}
 	BUG_ON(pgd_bad(*pgd));
@@ -513,6 +517,37 @@ void __init paging_init(void)
 		      SWAPPER_DIR_SIZE - PAGE_SIZE);
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+
+/*
+ * hotplug_paging() is used by memory hotplug to build new page tables
+ * for hot added memory.
+ */
+void hotplug_paging(phys_addr_t start, phys_addr_t size)
+{
+
+	struct page *pg;
+	phys_addr_t pgd_phys = pgd_pgtable_alloc();
+	pgd_t *pgd = pgd_set_fixmap(pgd_phys);
+
+	memcpy(pgd, swapper_pg_dir, PAGE_SIZE);
+
+	__create_pgd_mapping(pgd, start, __phys_to_virt(start), size,
+		PAGE_KERNEL, pgd_pgtable_alloc, false);
+
+	cpu_replace_ttbr1(__va(pgd_phys));
+	memcpy(swapper_pg_dir, pgd, PAGE_SIZE);
+	cpu_replace_ttbr1(swapper_pg_dir);
+
+	pgd_clear_fixmap();
+
+	pg = phys_to_page(pgd_phys);
+	pgtable_page_dtor(pg);
+	__free_pages(pg, 0);
+}
+
+#endif
+
 /*
  * Check whether a kernel address is valid (derived from arch/x86/).
  */
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index bdfc65a..e82daff 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -93,6 +93,7 @@ bool memblock_overlaps_region(struct memblock_type *type,
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 ulong choose_memblock_flags(void);
 
 /* Low level functions */
diff --git a/mm/memblock.c b/mm/memblock.c
index 696f06d..e9b0eaf 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -805,6 +805,16 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 }
 
 /**
+ * memblock_clear_nomap - Clear a flag of MEMBLOCK_NOMAP memory region
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ */
+int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
+}
+
+/**
  * __next_reserved_mem_region - next function for for_each_reserved_region()
  * @idx: pointer to u64 loop variable
  * @out_start: ptr to phys_addr_t for start address of the region, can be %NULL
-- 
1.9.1
