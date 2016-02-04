From: labbott@fedoraproject.org (Laura Abbott)
Date: Thu,  4 Feb 2016 11:43:35 -0800
Subject: [PATCHv3 1/3] arm64: Drop alloc function from create_mapping
In-Reply-To: <1454615017-24672-1-git-send-email-labbott@fedoraproject.org>
References: <1454615017-24672-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <1454615017-24672-2-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


create_mapping is only used in fixmap_remap_fdt. All the create_mapping
calls need to happen on existing translation table pages without
additional allocations. Rather than have an alloc function be called
and fail, just set it to NULL and catch its use. Also change
the name to create_mapping_noalloc to better capture what exactly is
going on.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
 arch/arm64/mm/mmu.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7711554..ef0d66c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -116,7 +116,9 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	pte_t *pte;
 
 	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
-		phys_addr_t pte_phys = pgtable_alloc();
+		phys_addr_t pte_phys;
+		BUG_ON(!pgtable_alloc);
+		pte_phys = pgtable_alloc();
 		pte = pte_set_fixmap(pte_phys);
 		if (pmd_sect(*pmd))
 			split_pmd(pmd, pte);
@@ -158,7 +160,9 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	 * Check for initial section mappings in the pgd/pud and remove them.
 	 */
 	if (pud_none(*pud) || pud_sect(*pud)) {
-		phys_addr_t pmd_phys = pgtable_alloc();
+		phys_addr_t pmd_phys;
+		BUG_ON(!pgtable_alloc);
+		pmd_phys = pgtable_alloc();
 		pmd = pmd_set_fixmap(pmd_phys);
 		if (pud_sect(*pud)) {
 			/*
@@ -223,7 +227,9 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 	unsigned long next;
 
 	if (pgd_none(*pgd)) {
-		phys_addr_t pud_phys = pgtable_alloc();
+		phys_addr_t pud_phys;
+		BUG_ON(!pgtable_alloc);
+		pud_phys = pgtable_alloc();
 		__pgd_populate(pgd, pud_phys, PUD_TYPE_TABLE);
 	}
 	BUG_ON(pgd_bad(*pgd));
@@ -312,7 +318,12 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	init_pgd(pgd_offset_raw(pgdir, virt), phys, virt, size, prot, alloc);
 }
 
-static void __init create_mapping(phys_addr_t phys, unsigned long virt,
+/*
+ * This function can only be used to modify existing table entries,
+ * without allocating new levels of table. Note that this permits the
+ * creation of new section or page entries.
+ */
+static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
 				  phys_addr_t size, pgprot_t prot)
 {
 	if (virt < VMALLOC_START) {
@@ -321,7 +332,7 @@ static void __init create_mapping(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
-			     early_pgtable_alloc);
+			     NULL);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
@@ -680,7 +691,7 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 	/*
 	 * Make sure that the FDT region can be mapped without the need to
 	 * allocate additional translation table pages, so that it is safe
-	 * to call create_mapping() this early.
+	 * to call create_mapping_noalloc() this early.
 	 *
 	 * On 64k pages, the FDT will be mapped using PTEs, so we need to
 	 * be in the same PMD as the rest of the fixmap.
@@ -696,8 +707,8 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 	dt_virt = (void *)dt_virt_base + offset;
 
 	/* map the first chunk so we can read the size from the header */
-	create_mapping(round_down(dt_phys, SWAPPER_BLOCK_SIZE), dt_virt_base,
-		       SWAPPER_BLOCK_SIZE, prot);
+	create_mapping_noalloc(round_down(dt_phys, SWAPPER_BLOCK_SIZE),
+			dt_virt_base, SWAPPER_BLOCK_SIZE, prot);
 
 	if (fdt_check_header(dt_virt) != 0)
 		return NULL;
@@ -707,7 +718,7 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
 		return NULL;
 
 	if (offset + size > SWAPPER_BLOCK_SIZE)
-		create_mapping(round_down(dt_phys, SWAPPER_BLOCK_SIZE), dt_virt_base,
+		create_mapping_noalloc(round_down(dt_phys, SWAPPER_BLOCK_SIZE), dt_virt_base,
 			       round_up(offset + size, SWAPPER_BLOCK_SIZE), prot);
 
 	memblock_reserve(dt_phys, size);
-- 
2.5.0
