From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:39 +0000
Subject: [RFC PATCH 04/20] arm64: mm: assume PAGE SIZE for page table allocator
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We pass a size parameter to early_alloc and late_alloc, but these are
only ever used to allocate single pages. In late_alloc we always
allocate a single page.

Remove the redundant size parameter.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7dfb4a9..304ff23 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -62,15 +62,15 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
-static void __init *early_alloc(unsigned long sz)
+static void __init *early_alloc(void)
 {
 	phys_addr_t phys;
 	void *ptr;
 
-	phys = memblock_alloc(sz, sz);
+	phys = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	BUG_ON(!phys);
 	ptr = __va(phys);
-	memset(ptr, 0, sz);
+	memset(ptr, 0, PAGE_SIZE);
 	return ptr;
 }
 
@@ -95,12 +95,12 @@ static void split_pmd(pmd_t *pmd, pte_t *pte)
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  pgprot_t prot,
-				  void *(*alloc)(unsigned long size))
+				  void *(*alloc)(void))
 {
 	pte_t *pte;
 
 	if (pmd_none(*pmd) || pmd_sect(*pmd)) {
-		pte = alloc(PTRS_PER_PTE * sizeof(pte_t));
+		pte = alloc();
 		if (pmd_sect(*pmd))
 			split_pmd(pmd, pte);
 		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
@@ -130,7 +130,7 @@ static void split_pud(pud_t *old_pud, pmd_t *pmd)
 static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 				  unsigned long addr, unsigned long end,
 				  phys_addr_t phys, pgprot_t prot,
-				  void *(*alloc)(unsigned long size))
+				  void *(*alloc)(void))
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -139,7 +139,7 @@ static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
 	 * Check for initial section mappings in the pgd/pud and remove them.
 	 */
 	if (pud_none(*pud) || pud_sect(*pud)) {
-		pmd = alloc(PTRS_PER_PMD * sizeof(pmd_t));
+		pmd = alloc();
 		if (pud_sect(*pud)) {
 			/*
 			 * need to have the 1G of mappings continue to be
@@ -195,13 +195,13 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 				  unsigned long addr, unsigned long end,
 				  phys_addr_t phys, pgprot_t prot,
-				  void *(*alloc)(unsigned long size))
+				  void *(*alloc)(void))
 {
 	pud_t *pud;
 	unsigned long next;
 
 	if (pgd_none(*pgd)) {
-		pud = alloc(PTRS_PER_PUD * sizeof(pud_t));
+		pud = alloc();
 		pgd_populate(mm, pgd, pud);
 	}
 	BUG_ON(pgd_bad(*pgd));
@@ -247,7 +247,7 @@ static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
 static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 				    phys_addr_t phys, unsigned long virt,
 				    phys_addr_t size, pgprot_t prot,
-				    void *(*alloc)(unsigned long size))
+				    void *(*alloc)(void))
 {
 	unsigned long addr, length, end, next;
 
@@ -262,12 +262,9 @@ static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
 	} while (pgd++, addr = next, addr != end);
 }
 
-static void *late_alloc(unsigned long size)
+static void *late_alloc(void)
 {
-	void *ptr;
-
-	BUG_ON(size > PAGE_SIZE);
-	ptr = (void *)__get_free_page(PGALLOC_GFP);
+	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
 	BUG_ON(!ptr);
 	return ptr;
 }
-- 
1.9.1
