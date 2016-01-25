From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Jan 2016 11:45:10 +0000
Subject: [PATCHv3 16/18] arm64: mm: allow passing a pgdir to alloc_init_*
In-Reply-To: <1453722312-23076-1-git-send-email-mark.rutland@arm.com>
References: <1453722312-23076-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1453722312-23076-17-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow us to initialise pgdirs which are fixmapped, allow explicitly
passing a pgdir rather than an mm. A new __create_pgd_mapping function
is added for this, with existing __create_mapping callers migrated to
this.

The mm argument was previously only used at the top level. Now that it
is redundant at all levels, it is removed. To indicate its new found
similarity to alloc_init_{pud,pmd,pte}, __create_mapping is renamed to
init_pgd.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 55816f6..a530f4f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -146,8 +146,7 @@ static void split_pud(pud_t *old_pud, pmd_t *pmd)
 	} while (pmd++, i++, i < PTRS_PER_PMD);
 }
 
-static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
-				  unsigned long addr, unsigned long end,
+static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 				  phys_addr_t phys, pgprot_t prot,
 				  phys_addr_t (*pgtable_alloc)(void))
 {
@@ -215,8 +214,7 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 	return true;
 }
 
-static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
-				  unsigned long addr, unsigned long end,
+static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 				  phys_addr_t phys, pgprot_t prot,
 				  phys_addr_t (*pgtable_alloc)(void))
 {
@@ -257,7 +255,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 				}
 			}
 		} else {
-			alloc_init_pmd(mm, pud, addr, next, phys, prot,
+			alloc_init_pmd(pud, addr, next, phys, prot,
 				       pgtable_alloc);
 		}
 		phys += next - addr;
@@ -270,8 +268,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
  * Create the page directory entries and any necessary page tables for the
  * mapping specified by 'md'.
  */
-static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
-				    phys_addr_t phys, unsigned long virt,
+static void init_pgd(pgd_t *pgd, phys_addr_t phys, unsigned long virt,
 				    phys_addr_t size, pgprot_t prot,
 				    phys_addr_t (*pgtable_alloc)(void))
 {
@@ -291,7 +288,7 @@ static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 	end = addr + length;
 	do {
 		next = pgd_addr_end(addr, end);
-		alloc_init_pud(mm, pgd, addr, next, phys, prot, pgtable_alloc);
+		alloc_init_pud(pgd, addr, next, phys, prot, pgtable_alloc);
 		phys += next - addr;
 	} while (pgd++, addr = next, addr != end);
 }
@@ -306,6 +303,14 @@ static phys_addr_t late_pgtable_alloc(void)
 	return __pa(ptr);
 }
 
+static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
+				 unsigned long virt, phys_addr_t size,
+				 pgprot_t prot,
+				 phys_addr_t (*alloc)(void))
+{
+	init_pgd(pgd_offset_raw(pgdir, virt), phys, virt, size, prot, alloc);
+}
+
 static void __init create_mapping(phys_addr_t phys, unsigned long virt,
 				  phys_addr_t size, pgprot_t prot)
 {
@@ -314,16 +319,16 @@ static void __init create_mapping(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	__create_mapping(&init_mm, pgd_offset_k(virt), phys, virt,
-			 size, prot, early_pgtable_alloc);
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
+			     early_pgtable_alloc);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot)
 {
-	__create_mapping(mm, pgd_offset(mm, virt), phys, virt, size, prot,
-				late_pgtable_alloc);
+	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
+			     late_pgtable_alloc);
 }
 
 static void create_mapping_late(phys_addr_t phys, unsigned long virt,
@@ -335,8 +340,8 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 
-	return __create_mapping(&init_mm, pgd_offset_k(virt),
-				phys, virt, size, prot, late_pgtable_alloc);
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
+			     late_pgtable_alloc);
 }
 
 #ifdef CONFIG_DEBUG_RODATA
-- 
1.9.1
