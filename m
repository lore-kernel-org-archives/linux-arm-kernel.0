From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Jun 2016 14:51:29 +0200
Subject: [PATCH 4/5] arm64: mm: Remove split_p*d() functions
In-Reply-To: <1467204690-10790-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1467204690-10790-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1467204690-10790-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

Since the efi_create_mapping() no longer generates block mappings
and being the last user of the split_p*d code, remove these functions
and the corresponding TLBI.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ardb: replace 'overlapping regions' with 'block mappings' in commit log]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 47 ++------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a86d1acb3a7b..f233c885042d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -97,24 +97,6 @@ static phys_addr_t __init early_pgtable_alloc(void)
 	return phys;
 }
 
-/*
- * remap a PMD into pages
- */
-static void split_pmd(pmd_t *pmd, pte_t *pte)
-{
-	unsigned long pfn = pmd_pfn(*pmd);
-	int i = 0;
-
-	do {
-		/*
-		 * Need to have the least restrictive permissions available
-		 * permissions will be fixed up later
-		 */
-		set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
-		pfn++;
-	} while (pte++, i++, i < PTRS_PER_PTE);
-}
-
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  pgprot_t prot,
@@ -122,15 +104,13 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 {
 	pte_t *pte;
 
-	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
+	BUG_ON(pmd_sect(*pmd));
+	if (pmd_none(*pmd)) {
 		phys_addr_t pte_phys;
 		BUG_ON(!pgtable_alloc);
 		pte_phys = pgtable_alloc();
 		pte = pte_set_fixmap(pte_phys);
-		if (pmd_sect(*pmd))
-			split_pmd(pmd, pte);
 		__pmd_populate(pmd, pte_phys, PMD_TYPE_TABLE);
-		flush_tlb_all();
 		pte_clear_fixmap();
 	}
 	BUG_ON(pmd_bad(*pmd));
@@ -144,18 +124,6 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	pte_clear_fixmap();
 }
 
-static void split_pud(pud_t *old_pud, pmd_t *pmd)
-{
-	unsigned long addr = pud_pfn(*old_pud) << PAGE_SHIFT;
-	pgprot_t prot = __pgprot(pud_val(*old_pud) ^ addr);
-	int i = 0;
-
-	do {
-		set_pmd(pmd, __pmd(addr | pgprot_val(prot)));
-		addr += PMD_SIZE;
-	} while (pmd++, i++, i < PTRS_PER_PMD);
-}
-
 static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 				  phys_addr_t phys, pgprot_t prot,
 				  phys_addr_t (*pgtable_alloc)(void),
@@ -167,20 +135,13 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	/*
 	 * Check for initial section mappings in the pgd/pud and remove them.
 	 */
-	if (pud_none(*pud) || pud_sect(*pud)) {
+	BUG_ON(pud_sect(*pud));
+	if (pud_none(*pud)) {
 		phys_addr_t pmd_phys;
 		BUG_ON(!pgtable_alloc);
 		pmd_phys = pgtable_alloc();
 		pmd = pmd_set_fixmap(pmd_phys);
-		if (pud_sect(*pud)) {
-			/*
-			 * need to have the 1G of mappings continue to be
-			 * present
-			 */
-			split_pud(pud, pmd);
-		}
 		__pud_populate(pud, pmd_phys, PUD_TYPE_TABLE);
-		flush_tlb_all();
 		pmd_clear_fixmap();
 	}
 	BUG_ON(pud_bad(*pud));
-- 
2.7.4
