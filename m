From: r.sricharan@ti.com (R Sricharan)
Date: Sat, 4 Aug 2012 12:30:22 +0530
Subject: [PATCH 1/1] ARM: Fix mapping in alloc_init_section for unaligned
 addresses.
Message-ID: <1344063622-11021-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When either the start address or end address or physical address
to be mapped is unaligned, alloc_init_section creates
page granularity mappings. alloc_init_section calls
alloc_init_pte which populates one pmd entry and sets up
the ptes. But if the size is greater than what can be mapped
by one pmd entry, then the rest remains unmapped.

The issue becomes visible when LPAE is enabled, where we have
the 3 levels with seperate pgd and pmd's.
When a static mapping for 3MB is requested, only 2MB is mapped
and the remaining 1MB is unmapped. Fixing this here, by looping
in to map the entire unaligned address range.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/mmu.c |   54 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index cf4528d..c8c405f 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -597,34 +597,42 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 				      const struct mem_type *type)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
-
-	/*
-	 * Try a section mapping - end, addr and phys must all be aligned
-	 * to a section boundary.  Note that PMDs refer to the individual
-	 * L1 entries, whereas PGDs refer to a group of L1 entries making
-	 * up one logical pointer to an L2 table.
-	 */
-	if (type->prot_sect && ((addr | end | phys) & ~SECTION_MASK) == 0) {
-		pmd_t *p = pmd;
+	unsigned long next;
 
 #ifndef CONFIG_ARM_LPAE
-		if (addr & SECTION_SIZE)
-			pmd++;
+	if ((addr & SECTION_SIZE) &&
+	      (type->prot_sect && ((addr | next | phys) & ~SECTION_MASK) == 0))
+		pmd++;
 #endif
-
-		do {
-			*pmd = __pmd(phys | type->prot_sect);
-			phys += SECTION_SIZE;
-		} while (pmd++, addr += SECTION_SIZE, addr != end);
-
-		flush_pmd_entry(p);
-	} else {
+	do {
+		if ((end - addr) & SECTION_MASK)
+			next = (addr + SECTION_SIZE) & SECTION_MASK;
+		else
+			next = end;
 		/*
-		 * No need to loop; pte's aren't interested in the
-		 * individual L1 entries.
+		 * Try a section mapping - end, addr and phys must all be
+		 * aligned to a section boundary.  Note that PMDs refer to
+		 * the individual L1 entries, whereas PGDs refer to a group
+		 * of L1 entries making up one logical pointer to an L2 table.
 		 */
-		alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
-	}
+		if (type->prot_sect &&
+				((addr | next | phys) & ~SECTION_MASK) == 0) {
+			*pmd = __pmd(phys | type->prot_sect);
+			flush_pmd_entry(pmd);
+		} else {
+			/*
+			 * when addresses are not aligned,
+			 * we may be required to map address range greater
+			 * than a section size. So loop in here to map the
+			 * complete range.
+			 */
+			alloc_init_pte(pmd, addr, next,
+						__phys_to_pfn(phys), type);
+		}
+
+		phys += next - addr;
+
+	} while (pmd++, addr = next, addr != end);
 }
 
 static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
-- 
1.7.9.5
