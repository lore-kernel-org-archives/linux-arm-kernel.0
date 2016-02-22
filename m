From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:27 +0100
Subject: [RFC PATCH 05/10] arm64: mm: avoid __pa translations in
 early_fixmap_init
In-Reply-To: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456174472-30028-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid using __pa() translations while populating the fixmap page tables,
by using __pa_symbol to take the physical addresses of bm_pud, bm_pmd and
bm_pte, and move to __pgd_populate/__pmd_populate/__pte_populate, which
takes physical addresses directly. Since the former two are now called
unconditionally, remove the BUILD_BUG()'s that prevent their use in case
their page table level is folded away.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/pgalloc.h | 2 --
 arch/arm64/mm/mmu.c              | 8 ++++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index ff98585d085a..bc01d2b65225 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -54,7 +54,6 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 #else
 static inline void __pud_populate(pud_t *pud, phys_addr_t pmd, pudval_t prot)
 {
-	BUILD_BUG();
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 2 */
 
@@ -83,7 +82,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pud, pgdval_t prot)
 {
-	BUILD_BUG();
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fbba941a6e87..e7340defa085 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -679,7 +679,7 @@ void __init early_fixmap_init(void)
 
 	pgd = pgd_offset_k(addr);
 	if (CONFIG_PGTABLE_LEVELS > 3 &&
-	    !(pgd_none(*pgd) || pgd_page_paddr(*pgd) == __pa(bm_pud))) {
+	    !(pgd_none(*pgd) || pgd_page_paddr(*pgd) == __pa_symbol(bm_pud))) {
 		/*
 		 * We only end up here if the kernel mapping and the fixmap
 		 * share the top level pgd entry, which should only happen on
@@ -688,12 +688,12 @@ void __init early_fixmap_init(void)
 		BUG_ON(!IS_ENABLED(CONFIG_ARM64_16K_PAGES));
 		pud = pud_offset_kimg(pgd, addr);
 	} else {
-		pgd_populate(&init_mm, pgd, bm_pud);
+		__pgd_populate(pgd, __pa_symbol(bm_pud), PUD_TYPE_TABLE);
 		pud = fixmap_pud(addr);
 	}
-	pud_populate(&init_mm, pud, bm_pmd);
+	__pud_populate(pud, __pa_symbol(bm_pmd), PUD_TYPE_TABLE);
 	pmd = fixmap_pmd(addr);
-	pmd_populate_kernel(&init_mm, pmd, bm_pte);
+	__pmd_populate(pmd, __pa_symbol(bm_pte), PMD_TYPE_TABLE);
 
 	/*
 	 * The boot-ioremap range spans multiple pmds, for which
-- 
2.5.0
