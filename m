From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:53 +0000
Subject: [RFC PATCH 18/20] arm64: mm: allow passing a pgdir to alloc_init_*
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-19-git-send-email-mark.rutland@arm.com>
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 27dd475..c20a1ce 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -139,10 +139,9 @@ static void split_pud(pud_t *old_pud, pmd_t *pmd)
 	} while (pmd++, i++, i < PTRS_PER_PMD);
 }
 
-static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
-				  unsigned long addr, unsigned long end,
-				  phys_addr_t phys, pgprot_t prot,
-				  phys_addr_t (*alloc)(void))
+static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
+			   phys_addr_t phys, pgprot_t prot,
+			   phys_addr_t (*alloc)(void))
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -208,10 +207,9 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 	return true;
 }
 
-static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
-				  unsigned long addr, unsigned long end,
-				  phys_addr_t phys, pgprot_t prot,
-				  phys_addr_t (*alloc)(void))
+static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
+			   phys_addr_t phys, pgprot_t prot,
+			   phys_addr_t (*alloc)(void))
 {
 	pud_t *pud;
 	unsigned long next;
@@ -250,7 +248,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 				}
 			}
 		} else {
-			alloc_init_pmd(mm, pud, addr, next, phys, prot, alloc);
+			alloc_init_pmd(pud, addr, next, phys, prot, alloc);
 		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
@@ -262,10 +260,9 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
  * Create the page directory entries and any necessary page tables for the
  * mapping specified by 'md'.
  */
-static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
-				    phys_addr_t phys, unsigned long virt,
-				    phys_addr_t size, pgprot_t prot,
-				    phys_addr_t (*alloc)(void))
+static void init_pgd(pgd_t *pgd, phys_addr_t phys, unsigned long virt,
+		     phys_addr_t size, pgprot_t prot,
+		     phys_addr_t (*alloc)(void))
 {
 	unsigned long addr, length, end, next;
 
@@ -275,7 +272,7 @@ static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 	end = addr + length;
 	do {
 		next = pgd_addr_end(addr, end);
-		alloc_init_pud(mm, pgd, addr, next, phys, prot, alloc);
+		alloc_init_pud(pgd, addr, next, phys, prot, alloc);
 		phys += next - addr;
 	} while (pgd++, addr = next, addr != end);
 }
@@ -287,6 +284,14 @@ static phys_addr_t late_alloc(void)
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
@@ -295,16 +300,14 @@ static void __init create_mapping(phys_addr_t phys, unsigned long virt,
 			&phys, virt);
 		return;
 	}
-	__create_mapping(&init_mm, pgd_offset_k(virt), phys, virt,
-			 size, prot, early_alloc);
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, early_alloc);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       unsigned long virt, phys_addr_t size,
 			       pgprot_t prot)
 {
-	__create_mapping(mm, pgd_offset(mm, virt), phys, virt, size, prot,
-				late_alloc);
+	__create_pgd_mapping(mm->pgd, phys, virt, size, prot, late_alloc);
 }
 
 static void create_mapping_late(phys_addr_t phys, unsigned long virt,
@@ -316,8 +319,7 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 		return;
 	}
 
-	return __create_mapping(&init_mm, pgd_offset_k(virt),
-				phys, virt, size, prot, late_alloc);
+	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, late_alloc);
 }
 
 #ifdef CONFIG_DEBUG_RODATA
-- 
1.9.1
