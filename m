From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 22 Jul 2016 19:32:25 +0200
Subject: [PATCH 2/2] arm64: mm: run pgtable_page_ctor() on non-swapper
 translation table pages
In-Reply-To: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1469208745-6693-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel page table creation routines are accessible to other subsystems
(e.g., EFI) via the create_pgd_mapping() entry point, which allows mappings
to be created that are not covered by init_mm.

Since generic code such as apply_to_page_range() may expect translation
table pages that are not associated with init_mm to be covered by fully
constructed struct pages, add a call to pgtable_page_ctor() in the alloc
function used by create_pgd_mapping. Since it is no longer used by
create_mapping_late(), also update the name of this function to better
reflect its purpose.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 33f36cede02d..51a558195bb9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -268,10 +268,11 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgd++, addr = next, addr != end);
 }
 
-static phys_addr_t late_pgtable_alloc(void)
+static phys_addr_t pgd_pgtable_alloc(void)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
-	BUG_ON(!ptr);
+	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
+		BUG();
 
 	/* Ensure the zeroed page is visible to the page table walker */
 	dsb(ishst);
@@ -298,8 +299,10 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot, bool allow_block_mappings)
 {
+	BUG_ON(mm == &init_mm);
+
 	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
-			     late_pgtable_alloc, allow_block_mappings);
+			     pgd_pgtable_alloc, allow_block_mappings);
 }
 
 static void create_mapping_late(phys_addr_t phys, unsigned long virt,
-- 
2.7.4
