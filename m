From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 12 Oct 2016 12:23:43 +0100
Subject: [PATCH v3 3/5] arm64: mm: set the contiguous bit for kernel mappings
 where appropriate
In-Reply-To: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476271425-19401-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1476271425-19401-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we no longer allow live kernel PMDs to be split, it is safe to
start using the contiguous bit for kernel mappings. So set the contiguous
bit in the kernel page mappings for regions whose size and alignment are
suitable for this.

This enables the following contiguous range sizes for the virtual mapping
of the kernel image, and for the linear mapping:

          granule size |  cont PTE  |  cont PMD  |
          -------------+------------+------------+
               4 KB    |    64 KB   |   32 MB    |
              16 KB    |     2 MB   |    1 GB*   |
              64 KB    |     2 MB   |   16 GB*   |

* only when built for 3 or more levels of translation

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 35 +++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index bf1d71b62c4f..40be4979102d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -102,8 +102,10 @@ static const pteval_t modifiable_attr_mask = PTE_PXN | PTE_RDONLY | PTE_WRITE;
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  pgprot_t prot,
-				  phys_addr_t (*pgtable_alloc)(void))
+				  phys_addr_t (*pgtable_alloc)(void),
+				  bool page_mappings_only)
 {
+	pgprot_t __prot = prot;
 	pte_t *pte;
 
 	BUG_ON(pmd_sect(*pmd));
@@ -121,7 +123,18 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 	do {
 		pte_t old_pte = *pte;
 
-		set_pte(pte, pfn_pte(pfn, prot));
+		/*
+		 * Set the contiguous bit for the subsequent group of PTEs if
+		 * its size and alignment are appropriate.
+		 */
+		if (((addr | PFN_PHYS(pfn)) & ~CONT_PTE_MASK) == 0) {
+			if (end - addr >= CONT_PTE_SIZE && !page_mappings_only)
+				__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+			else
+				__prot = prot;
+		}
+
+		set_pte(pte, pfn_pte(pfn, __prot));
 		pfn++;
 
 		/*
@@ -141,6 +154,7 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 				  phys_addr_t (*pgtable_alloc)(void),
 				  bool page_mappings_only)
 {
+	pgprot_t __prot = prot;
 	pmd_t *pmd;
 	unsigned long next;
 
@@ -167,7 +181,19 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 		/* try section mapping first */
 		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
 		      !page_mappings_only) {
-			pmd_set_huge(pmd, phys, prot);
+			/*
+			 * Set the contiguous bit for the subsequent group of
+			 * PMDs if its size and alignment are appropriate.
+			 */
+			if (((addr | phys) & ~CONT_PMD_MASK) == 0) {
+				if (end - addr >= CONT_PMD_SIZE)
+					__prot = __pgprot(pgprot_val(prot) |
+							  PTE_CONT);
+				else
+					__prot = prot;
+			}
+
+			pmd_set_huge(pmd, phys, __prot);
 
 			/*
 			 * After the PMD entry has been populated once, we
@@ -178,7 +204,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 				~modifiable_attr_mask) != 0);
 		} else {
 			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
-				       prot, pgtable_alloc);
+				       prot, pgtable_alloc,
+				       page_mappings_only);
 
 			BUG_ON(pmd_val(old_pmd) != 0 &&
 			       pmd_val(old_pmd) != pmd_val(*pmd));
-- 
2.7.4
