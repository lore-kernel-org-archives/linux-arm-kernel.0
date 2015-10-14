From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 14 Oct 2015 12:20:25 +0100
Subject: [PATCHv3 02/11] arm64: Handle section maps for swapper/idmap
In-Reply-To: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444821634-1689-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use section maps with 4K page size to create the swapper/idmaps.
So far we have used !64K or 4K checks to handle the case where we
use the section maps.
This patch adds a new symbol, ARM64_SWAPPER_USES_SECTION_MAPS, to
handle cases where we use section maps, instead of using the page size
symbols.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/kernel-pgtable.h |   31 ++++++++-----
 arch/arm64/mm/mmu.c                     |   72 ++++++++++++++-----------------
 2 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 622929d..5876a36 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -19,6 +19,13 @@
 #ifndef __ASM_KERNEL_PGTABLE_H
 #define __ASM_KERNEL_PGTABLE_H
 
+/* With 4K pages, we use section maps. */
+#ifdef CONFIG_ARM64_4K_PAGES
+#define ARM64_SWAPPER_USES_SECTION_MAPS 1
+#else
+#define ARM64_SWAPPER_USES_SECTION_MAPS 0
+#endif
+
 /*
  * The idmap and swapper page tables need some space reserved in the kernel
  * image. Both require pgd, pud (4 levels only) and pmd tables to (section)
@@ -28,26 +35,28 @@
  * could be increased on the fly if system RAM is out of reach for the default
  * VA range, so 3 pages are reserved in all cases.
  */
-#ifdef CONFIG_ARM64_64K_PAGES
-#define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS)
-#else
+#if ARM64_SWAPPER_USES_SECTION_MAPS
 #define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS - 1)
+#else
+#define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS)
 #endif
 
 #define SWAPPER_DIR_SIZE	(SWAPPER_PGTABLE_LEVELS * PAGE_SIZE)
 #define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
 
 /* Initial memory map size */
-#ifdef CONFIG_ARM64_64K_PAGES
-#define SWAPPER_BLOCK_SHIFT	PAGE_SHIFT
-#define SWAPPER_BLOCK_SIZE	PAGE_SIZE
-#define SWAPPER_TABLE_SHIFT	PMD_SHIFT
-#else
+#if ARM64_SWAPPER_USES_SECTION_MAPS
 #define SWAPPER_BLOCK_SHIFT	SECTION_SHIFT
 #define SWAPPER_BLOCK_SIZE	SECTION_SIZE
 #define SWAPPER_TABLE_SHIFT	PUD_SHIFT
+#else
+#define SWAPPER_BLOCK_SHIFT	PAGE_SHIFT
+#define SWAPPER_BLOCK_SIZE	PAGE_SIZE
+#define SWAPPER_TABLE_SHIFT	PMD_SHIFT
 #endif
 
+/* The size of the initial kernel direct mapping */
+#define SWAPPER_INIT_MAP_SIZE	(_AC(1, UL) << SWAPPER_TABLE_SHIFT)
 
 /*
  * Initial memory map attributes.
@@ -55,10 +64,10 @@
 #define SWAPPER_PTE_FLAGS	PTE_TYPE_PAGE | PTE_AF | PTE_SHARED
 #define SWAPPER_PMD_FLAGS	PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S
 
-#ifdef CONFIG_ARM64_64K_PAGES
-#define SWAPPER_MM_MMUFLAGS	PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS
-#else
+#if ARM64_SWAPPER_USES_SECTION_MAPS
 #define SWAPPER_MM_MMUFLAGS	PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS
+#else
+#define SWAPPER_MM_MMUFLAGS	PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS
 #endif
 
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index eed6d52..bc4373a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -32,6 +32,7 @@
 
 #include <asm/cputype.h>
 #include <asm/fixmap.h>
+#include <asm/kernel-pgtable.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/sizes.h>
@@ -406,14 +407,11 @@ static void __init map_mem(void)
 	 * memory addressable from the initial direct kernel mapping.
 	 *
 	 * The initial direct kernel mapping, located at swapper_pg_dir, gives
-	 * us PUD_SIZE (4K pages) or PMD_SIZE (64K pages) memory starting from
-	 * PHYS_OFFSET (which must be aligned to 2MB as per
-	 * Documentation/arm64/booting.txt).
+	 * us PUD_SIZE (with SECTION maps, i.e, 4K) or PMD_SIZE (without
+	 * SECTION maps, i.e, 64K pages) memory starting from PHYS_OFFSET
+	 * (which must be aligned to 2MB as per Documentation/arm64/booting.txt).
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
-		limit = PHYS_OFFSET + PMD_SIZE;
-	else
-		limit = PHYS_OFFSET + PUD_SIZE;
+	limit = PHYS_OFFSET + SWAPPER_INIT_MAP_SIZE;
 	memblock_set_current_limit(limit);
 
 	/* map all the memory banks */
@@ -424,21 +422,24 @@ static void __init map_mem(void)
 		if (start >= end)
 			break;
 
-#ifndef CONFIG_ARM64_64K_PAGES
-		/*
-		 * For the first memory bank align the start address and
-		 * current memblock limit to prevent create_mapping() from
-		 * allocating pte page tables from unmapped memory.
-		 * When 64K pages are enabled, the pte page table for the
-		 * first PGDIR_SIZE is already present in swapper_pg_dir.
-		 */
-		if (start < limit)
-			start = ALIGN(start, PMD_SIZE);
-		if (end < limit) {
-			limit = end & PMD_MASK;
-			memblock_set_current_limit(limit);
+		if (ARM64_SWAPPER_USES_SECTION_MAPS) {
+			/*
+			 * For the first memory bank align the start address and
+			 * current memblock limit to prevent create_mapping() from
+			 * allocating pte page tables from unmapped memory. With
+			 * the section maps, if the first block doesn't end on section
+			 * size boundary, create_mapping() will try to allocate a pte
+			 * page, which may be returned from an unmapped area.
+			 * When section maps are not used, the pte page table for the
+			 * current limit is already present in swapper_pg_dir.
+			 */
+			if (start < limit)
+				start = ALIGN(start, SECTION_SIZE);
+			if (end < limit) {
+				limit = end & SECTION_MASK;
+				memblock_set_current_limit(limit);
+			}
 		}
-#endif
 		__map_memblock(start, end);
 	}
 
@@ -551,7 +552,7 @@ int kern_addr_valid(unsigned long addr)
 	return pfn_valid(pte_pfn(*pte));
 }
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-#ifdef CONFIG_ARM64_64K_PAGES
+#if !ARM64_SWAPPER_USES_SECTION_MAPS
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 {
 	return vmemmap_populate_basepages(start, end, node);
@@ -691,7 +692,7 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 {
 	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
 	pgprot_t prot = PAGE_KERNEL | PTE_RDONLY;
-	int granularity, size, offset;
+	int size, offset;
 	void *dt_virt;
 
 	/*
@@ -717,24 +718,15 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 	 */
 	BUILD_BUG_ON(dt_virt_base % SZ_2M);
 
-	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES)) {
-		BUILD_BUG_ON(__fix_to_virt(FIX_FDT_END) >> PMD_SHIFT !=
-			     __fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT);
-
-		granularity = PAGE_SIZE;
-	} else {
-		BUILD_BUG_ON(__fix_to_virt(FIX_FDT_END) >> PUD_SHIFT !=
-			     __fix_to_virt(FIX_BTMAP_BEGIN) >> PUD_SHIFT);
-
-		granularity = PMD_SIZE;
-	}
+	BUILD_BUG_ON(__fix_to_virt(FIX_FDT_END) >> SWAPPER_TABLE_SHIFT !=
+		     __fix_to_virt(FIX_BTMAP_BEGIN) >> SWAPPER_TABLE_SHIFT);
 
-	offset = dt_phys % granularity;
+	offset = dt_phys % SWAPPER_BLOCK_SIZE;
 	dt_virt = (void *)dt_virt_base + offset;
 
 	/* map the first chunk so we can read the size from the header */
-	create_mapping(round_down(dt_phys, granularity), dt_virt_base,
-		       granularity, prot);
+	create_mapping(round_down(dt_phys, SWAPPER_BLOCK_SIZE), dt_virt_base,
+		       SWAPPER_BLOCK_SIZE, prot);
 
 	if (fdt_check_header(dt_virt) != 0)
 		return NULL;
@@ -743,9 +735,9 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 	if (size > MAX_FDT_SIZE)
 		return NULL;
 
-	if (offset + size > granularity)
-		create_mapping(round_down(dt_phys, granularity), dt_virt_base,
-			       round_up(offset + size, granularity), prot);
+	if (offset + size > SWAPPER_BLOCK_SIZE)
+		create_mapping(round_down(dt_phys, SWAPPER_BLOCK_SIZE), dt_virt_base,
+			       round_up(offset + size, SWAPPER_BLOCK_SIZE), prot);
 
 	memblock_reserve(dt_phys, size);
 
-- 
1.7.9.5
