From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 10 Oct 2016 19:12:44 +0100
Subject: [PATCH] arm64: mmu: set the contiguous for kernel mappings when
 appropriate
Message-ID: <1476123164-10532-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we no longer allow live kernel PMDs to be split, it is safe to
start using the contiguous bit for kernel mappings. So set the contiguous
bit in the kernel page mappings for regions whose size and alignment are
suitable for this.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 05615a3fdc6f..c491025c6a70 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -98,8 +98,11 @@ static phys_addr_t __init early_pgtable_alloc(void)
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  pgprot_t prot,
-				  phys_addr_t (*pgtable_alloc)(void))
+				  phys_addr_t (*pgtable_alloc)(void),
+				  bool allow_block_mappings)
 {
+	pgprot_t prot_cont = __pgprot(pgprot_val(prot) | PTE_CONT);
+	bool cont = false;
 	pte_t *pte;
 
 	BUG_ON(pmd_sect(*pmd));
@@ -115,7 +118,20 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 
 	pte = pte_set_fixmap_offset(pmd, addr);
 	do {
-		set_pte(pte, pfn_pte(pfn, prot));
+		/*
+		 * Set the contiguous bit for the subsequent group of PTEs if
+		 * its size and alignment are suitable.
+		 */
+		if (((addr | PFN_PHYS(pfn)) & ~CONT_MASK) == 0)
+			cont = allow_block_mappings && end - addr >= CONT_SIZE;
+
+		/*
+		 * Ensure that we do not change the contiguous bit once this
+		 * PTE has been assigned.
+		 */
+		BUG_ON(!pte_none(*pte) && (cont ^ !!(pte_val(*pte) & PTE_CONT)));
+
+		set_pte(pte, pfn_pte(pfn, cont ? prot_cont : prot));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
@@ -166,7 +182,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 			}
 		} else {
 			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
-				       prot, pgtable_alloc);
+				       prot, pgtable_alloc,
+				       allow_block_mappings);
 		}
 		phys += next - addr;
 	} while (pmd++, addr = next, addr != end);
-- 
2.7.4
