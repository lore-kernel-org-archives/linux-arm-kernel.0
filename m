From: minchan@kernel.org (Minchan Kim)
Date: Wed, 23 May 2012 17:35:42 +0900
Subject: [PATCH] arm: limit memblock base address for early_pte_alloc
Message-ID: <1337762142-17318-1-git-send-email-minchan@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we do arm_memblock_steal with a page which is not aligned with section size,
panic can happen during boot by page fault in map_lowmem.

Detail:

1) mdesc->reserve can steal a page which is allocated at 0x1ffff000 by memblock
   which prefers tail pages of regions.
2) map_lowmem maps 0x00000000 - 0x1fe00000
3) map_lowmem try to map 0x1fe00000 but it's not aligned by section due to 1.
4) calling alloc_init_pte allocates a new page for new pte by memblock_alloc
5) allocated memory for pte is 0x1fffe000 -> it's not mapped yet.
6) memset(ptr, 0, sz) in early_alloc_aligned got PANICed!

This patch fix it by limiting memblock to mapped memory range.

Reported-by: Jongsung Kim <neidhard.kim@lge.com>
Suggested-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
This patch is based on v3.4.

 arch/arm/mm/mmu.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index aa78de8..82820c2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -586,7 +586,7 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 
 static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 				      unsigned long end, phys_addr_t phys,
-				      const struct mem_type *type)
+				      const struct mem_type *type, bool lowmem)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 
@@ -611,6 +611,8 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 
 		flush_pmd_entry(p);
 	} else {
+		if (lowmem)
+			memblock_set_current_limit(__pa(addr));
 		/*
 		 * No need to loop; pte's aren't interested in the
 		 * individual L1 entries.
@@ -620,14 +622,15 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 }
 
 static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
-	unsigned long end, unsigned long phys, const struct mem_type *type)
+				unsigned long end, unsigned long phys,
+				const struct mem_type *type, bool lowmem)
 {
 	pud_t *pud = pud_offset(pgd, addr);
 	unsigned long next;
 
 	do {
 		next = pud_addr_end(addr, end);
-		alloc_init_section(pud, addr, next, phys, type);
+		alloc_init_section(pud, addr, next, phys, type, lowmem);
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
 }
@@ -694,14 +697,7 @@ static void __init create_36bit_mapping(struct map_desc *md,
 }
 #endif	/* !CONFIG_ARM_LPAE */
 
-/*
- * Create the page directory entries and any necessary
- * page tables for the mapping specified by `md'.  We
- * are able to cope here with varying sizes and address
- * offsets, and we take full advantage of sections and
- * supersections.
- */
-static void __init create_mapping(struct map_desc *md)
+static inline void __create_mapping(struct map_desc *md, bool lowmem)
 {
 	unsigned long addr, length, end;
 	phys_addr_t phys;
@@ -751,7 +747,7 @@ static void __init create_mapping(struct map_desc *md)
 	do {
 		unsigned long next = pgd_addr_end(addr, end);
 
-		alloc_init_pud(pgd, addr, next, phys, type);
+		alloc_init_pud(pgd, addr, next, phys, type, lowmem);
 
 		phys += next - addr;
 		addr = next;
@@ -759,6 +755,18 @@ static void __init create_mapping(struct map_desc *md)
 }
 
 /*
+ * Create the page directory entries and any necessary
+ * page tables for the mapping specified by `md'.  We
+ * are able to cope here with varying sizes and address
+ * offsets, and we take full advantage of sections and
+ * supersections.
+ */
+static void __init create_mapping(struct map_desc *md)
+{
+	__create_mapping(md, false);
+}
+
+/*
  * Create the architecture specific mappings
  */
 void __init iotable_init(struct map_desc *io_desc, int nr)
@@ -1103,7 +1111,7 @@ static void __init map_lowmem(void)
 		map.length = end - start;
 		map.type = MT_MEMORY;
 
-		create_mapping(&map);
+		__create_mapping(&map, true);
 	}
 }
 
@@ -1115,11 +1123,10 @@ void __init paging_init(struct machine_desc *mdesc)
 {
 	void *zero_page;
 
-	memblock_set_current_limit(lowmem_limit);
-
 	build_mem_type_table();
 	prepare_page_table();
 	map_lowmem();
+	memblock_set_current_limit(lowmem_limit);
 	devicemaps_init(mdesc);
 	kmap_init();
 
-- 
1.7.9.5
