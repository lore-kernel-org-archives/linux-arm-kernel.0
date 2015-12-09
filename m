From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:51 +0000
Subject: [RFC PATCH 16/20] arm64: mm: use fixmap when creating page tables
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-17-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a prepratory step to allow us to allocate early page tables form
unmapped memory using memblock_alloc, modify the __create_mapping
callees to map and unmap the tables they modify using fixmap entries.

All but the top-level pgd initialisation is performed via the fixmap.
Subsequent patches will inject the pgd physical address, and migrate to
using the FIX_PGD slot.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h |  2 +-
 arch/arm64/mm/mmu.c              | 54 ++++++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 8a00a1cb..0664468 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -518,7 +518,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pud_offset(dir, addr)		((pud_t *)__va(pud_offset_phys((dir), (addr))))
 
 #define pud_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
-#define pud_fixmap_offset(pgd, addr)	pud_fixmap(pmd_offset_phys(pgd, addr))
+#define pud_fixmap_offset(pgd, addr)	pud_fixmap(pud_offset_phys(pgd, addr))
 #define pud_fixmap_unmap()		clear_fixmap(FIX_PUD)
 
 #define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(pgd_val(pgd) & PHYS_MASK))
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5ed1623..1a516ac 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -62,16 +62,24 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
-static void __init *early_alloc(void)
+static phys_addr_t __init early_alloc(void)
 {
 	phys_addr_t phys;
 	void *ptr;
 
 	phys = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	BUG_ON(!phys);
-	ptr = __va(phys);
+
+	/*
+	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
+	 * slot will be free, so we can (ab)use the FIX_PTE slot to initialise
+	 * any level of table.
+	 */
+	ptr = pte_fixmap(phys);
 	memset(ptr, 0, PAGE_SIZE);
-	return ptr;
+	pte_fixmap_unmap();
+
+	return phys;
 }
 
 /*
@@ -95,24 +103,28 @@ static void split_pmd(pmd_t *pmd, pte_t *pte)
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  pgprot_t prot,
-				  void *(*alloc)(void))
+				  phys_addr_t (*alloc)(void))
 {
 	pte_t *pte;
 
 	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
-		pte = alloc();
+		phys_addr_t pte_phys = alloc();
+		pte = pte_fixmap(pte_phys);
 		if (pmd_sect(*pmd))
 			split_pmd(pmd, pte);
-		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
+		__pmd_populate(pmd, pte_phys, PMD_TYPE_TABLE);
 		flush_tlb_all();
+		pte_fixmap_unmap();
 	}
 	BUG_ON(pmd_bad(*pmd));
 
-	pte = pte_offset_kernel(pmd, addr);
+	pte = pte_fixmap_offset(pmd, addr);
 	do {
 		set_pte(pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+
+	pte_fixmap_unmap();
 }
 
 static void split_pud(pud_t *old_pud, pmd_t *pmd)
@@ -130,7 +142,7 @@ static void split_pud(pud_t *old_pud, pmd_t *pmd)
 static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 				  unsigned long addr, unsigned long end,
 				  phys_addr_t phys, pgprot_t prot,
-				  void *(*alloc)(void))
+				  phys_addr_t (*alloc)(void))
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -139,7 +151,8 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 	 * Check for initial section mappings in the pgd/pud and remove them.
 	 */
 	if (pud_none(*pud) || pud_sect(*pud)) {
-		pmd = alloc();
+		phys_addr_t pmd_phys = alloc();
+		pmd = pmd_fixmap(pmd_phys);
 		if (pud_sect(*pud)) {
 			/*
 			 * need to have the 1G of mappings continue to be
@@ -147,12 +160,13 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 			 */
 			split_pud(pud, pmd);
 		}
-		pud_populate(mm, pud, pmd);
+		__pud_populate(pud, pmd_phys, PUD_TYPE_TABLE);
 		flush_tlb_all();
+		pmd_fixmap_unmap();
 	}
 	BUG_ON(pud_bad(*pud));
 
-	pmd = pmd_offset(pud, addr);
+	pmd = pmd_fixmap_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
 		/* try section mapping first */
@@ -178,6 +192,8 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 		}
 		phys += next - addr;
 	} while (pmd++, addr = next, addr != end);
+
+	pmd_fixmap_unmap();
 }
 
 static inline bool use_1G_block(unsigned long addr, unsigned long next,
@@ -195,18 +211,18 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 				  unsigned long addr, unsigned long end,
 				  phys_addr_t phys, pgprot_t prot,
-				  void *(*alloc)(void))
+				  phys_addr_t (*alloc)(void))
 {
 	pud_t *pud;
 	unsigned long next;
 
 	if (pgd_none(*pgd)) {
-		pud = alloc();
-		pgd_populate(mm, pgd, pud);
+		phys_addr_t pud_phys = alloc();
+		__pgd_populate(pgd, pud_phys, PUD_TYPE_TABLE);
 	}
 	BUG_ON(pgd_bad(*pgd));
 
-	pud = pud_offset(pgd, addr);
+	pud = pud_fixmap_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
 
@@ -238,6 +254,8 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
+
+	pud_fixmap_unmap();
 }
 
 /*
@@ -247,7 +265,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 				    phys_addr_t phys, unsigned long virt,
 				    phys_addr_t size, pgprot_t prot,
-				    void *(*alloc)(void))
+				    phys_addr_t (*alloc)(void))
 {
 	unsigned long addr, length, end, next;
 
@@ -262,11 +280,11 @@ static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 	} while (pgd++, addr = next, addr != end);
 }
 
-static void *late_alloc(void)
+static phys_addr_t late_alloc(void)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
 	BUG_ON(!ptr);
-	return ptr;
+	return __pa(ptr);
 }
 
 static void __init create_mapping(phys_addr_t phys, unsigned long virt,
-- 
1.9.1
