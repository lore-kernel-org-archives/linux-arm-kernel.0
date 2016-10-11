From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Oct 2016 13:39:47 +0100
Subject: [PATCH v2 1/3] arm64: mm: BUG on unsupported manipulations of live
 kernel mappings
In-Reply-To: <1476189589-1443-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476189589-1443-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1476189589-1443-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we take care not manipulate the live kernel page tables in a
way that may lead to TLB conflicts, the case where a table mapping is
replaced by a block mapping can no longer occur. So remove the handling
of this at the PUD and PMD levels, and instead, BUG() on any occurrence
of live kernel page table manipulations that modify anything other than
the permission bits.

Since mark_rodata_ro() is the only caller where the kernel mappings that
are being manipulated are actually live, drop the various conditional
flush_tlb_all() invocations, and add a single call to mark_rodata_ro()
instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/mmu.c | 68 ++++++++++++--------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 05615a3fdc6f..1cbadd20e741 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -28,8 +28,6 @@
 #include <linux/memblock.h>
 #include <linux/fs.h>
 #include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/stop_machine.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -95,6 +93,12 @@ static phys_addr_t __init early_pgtable_alloc(void)
 	return phys;
 }
 
+/*
+ * The following mapping attributes may be updated in live
+ * kernel mappings without the need for break-before-make.
+ */
+static const pteval_t modifiable_attr_mask = PTE_PXN | PTE_RDONLY | PTE_WRITE;
+
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  pgprot_t prot,
@@ -115,8 +119,18 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 
 	pte = pte_set_fixmap_offset(pmd, addr);
 	do {
+		pte_t old_pte = *pte;
+
 		set_pte(pte, pfn_pte(pfn, prot));
 		pfn++;
+
+		/*
+		 * After the PTE entry has been populated once, we
+		 * only allow updates to the permission attributes.
+		 */
+		BUG_ON(!pte_none(old_pte) &&
+		       ((pte_val(old_pte) ^ pte_val(*pte)) &
+			~modifiable_attr_mask) != 0);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	pte_clear_fixmap();
@@ -146,27 +160,28 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 
 	pmd = pmd_set_fixmap_offset(pud, addr);
 	do {
+		pmd_t old_pmd = *pmd;
+
 		next = pmd_addr_end(addr, end);
+
 		/* try section mapping first */
 		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
 		      allow_block_mappings) {
-			pmd_t old_pmd =*pmd;
 			pmd_set_huge(pmd, phys, prot);
+
 			/*
-			 * Check for previous table entries created during
-			 * boot (__create_page_tables) and flush them.
+			 * After the PMD entry has been populated once, we
+			 * only allow updates to the permission attributes.
 			 */
-			if (!pmd_none(old_pmd)) {
-				flush_tlb_all();
-				if (pmd_table(old_pmd)) {
-					phys_addr_t table = pmd_page_paddr(old_pmd);
-					if (!WARN_ON_ONCE(slab_is_available()))
-						memblock_free(table, PAGE_SIZE);
-				}
-			}
+			BUG_ON(!pmd_none(old_pmd) &&
+			       ((pmd_val(old_pmd) ^ pmd_val(*pmd)) &
+				~modifiable_attr_mask) != 0);
 		} else {
 			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
 				       prot, pgtable_alloc);
+
+			BUG_ON(!pmd_none(old_pmd) &&
+			       pmd_val(old_pmd) != pmd_val(*pmd));
 		}
 		phys += next - addr;
 	} while (pmd++, addr = next, addr != end);
@@ -204,33 +219,29 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 
 	pud = pud_set_fixmap_offset(pgd, addr);
 	do {
+		pud_t old_pud = *pud;
+
 		next = pud_addr_end(addr, end);
 
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
 		if (use_1G_block(addr, next, phys) && allow_block_mappings) {
-			pud_t old_pud = *pud;
 			pud_set_huge(pud, phys, prot);
 
 			/*
-			 * If we have an old value for a pud, it will
-			 * be pointing to a pmd table that we no longer
-			 * need (from swapper_pg_dir).
-			 *
-			 * Look up the old pmd table and free it.
+			 * After the PUD entry has been populated once, we
+			 * only allow updates to the permission attributes.
 			 */
-			if (!pud_none(old_pud)) {
-				flush_tlb_all();
-				if (pud_table(old_pud)) {
-					phys_addr_t table = pud_page_paddr(old_pud);
-					if (!WARN_ON_ONCE(slab_is_available()))
-						memblock_free(table, PAGE_SIZE);
-				}
-			}
+			BUG_ON(!pud_none(old_pud) &&
+			       ((pud_val(old_pud) ^ pud_val(*pud)) &
+				~modifiable_attr_mask) != 0);
 		} else {
 			alloc_init_pmd(pud, addr, next, phys, prot,
 				       pgtable_alloc, allow_block_mappings);
+
+			BUG_ON(!pud_none(old_pud) &&
+			       pud_val(old_pud) != pud_val(*pud));
 		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
@@ -396,6 +407,9 @@ void mark_rodata_ro(void)
 	section_size = (unsigned long)__init_begin - (unsigned long)__start_rodata;
 	create_mapping_late(__pa(__start_rodata), (unsigned long)__start_rodata,
 			    section_size, PAGE_KERNEL_RO);
+
+	/* flush the TLBs after updating live kernel mappings */
+	flush_tlb_all();
 }
 
 static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
-- 
2.7.4
