From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Tue, 21 Nov 2017 11:58:02 +0000
Subject: [RFC 6/9] arm64: handle 52-bit physical addresses in page table
 entries
In-Reply-To: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
References: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1511265485-27163-7-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The top 4 bits of a 52-bit physical address are positioned at bits
12..15 of a page table entry. Introduce macros to convert between a
physical address and its placement in a table entry, and change all
macros/functions that access PTEs to use them.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h       |  3 +-
 arch/arm64/include/asm/pgalloc.h       |  6 ++--
 arch/arm64/include/asm/pgtable-hwdef.h |  3 ++
 arch/arm64/include/asm/pgtable.h       | 57 +++++++++++++++++++++++++++-------
 4 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 5a11af32d1ff..2705f5bd9abe 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -281,7 +281,8 @@ static inline bool __kvm_cpu_uses_extended_idmap(void)
  * above CONFIG_PGTABLE_LEVELS (which is 2 or 3 if we're using the extended
  * idmap), and pgd_populate is only available if CONFIG_PGTABLE_LEVELS = 4.
  */
-#define kvm_extended_idmap_pgd(phys)	__pgd((phys) | PMD_TYPE_TABLE)
+#define kvm_extended_idmap_pgd(phys) \
+	__pgd(pgd_val(__phys_to_pgd(phys)) | PMD_TYPE_TABLE)
 
 static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
 				       pgd_t *hyp_pgd,
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index d25f4f137c2a..b57b83c34fbf 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -44,7 +44,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 
 static inline void __pud_populate(pud_t *pud, phys_addr_t pmd, pudval_t prot)
 {
-	set_pud(pud, __pud(pmd | prot));
+	set_pud(pud, __pud(pud_val(__phys_to_pud(pmd)) | prot));
 }
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
@@ -73,7 +73,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pud, pgdval_t prot)
 {
-	set_pgd(pgdp, __pgd(pud | prot));
+	set_pgd(pgdp, __pgd(pgd_val(__phys_to_pgd(pud)) | prot));
 }
 
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
@@ -129,7 +129,7 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
 static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,
 				  pmdval_t prot)
 {
-	set_pmd(pmdp, __pmd(pte | prot));
+	set_pmd(pmdp, __pmd(pmd_val(__phys_to_pmd(pte)) | prot));
 }
 
 /*
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index eb0c2bd90de9..69cc40695164 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -166,6 +166,9 @@
 #define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
 #define PTE_HYP_XN		(_AT(pteval_t, 1) << 54)	/* HYP XN */
 
+#define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
+#define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
+
 /*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
  */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index dcca52feaea2..558838624445 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -57,9 +57,20 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
 
-#define pte_pfn(pte)		((pte_val(pte) & PHYS_MASK) >> PAGE_SHIFT)
+/*
+ * Macros to convert between a physical address and its placement in a
+ * page table entry, taking care of 52-bit addresses.
+ */
+#ifdef CONFIG_ARM64_PA_BITS_52
+#define __pte_to_phys(pte)	((pte_val(pte) & PTE_ADDR_LOW) | ((pte_val(pte) & PTE_ADDR_HIGH) << 36))
+#define __phys_to_pte(phys)	__pte(((phys) & PTE_ADDR_LOW) | (((phys) & GENMASK(51, 48)) >> 36))
+#else
+#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_LOW)
+#define __phys_to_pte(phys)	__pte(phys)
+#endif
 
-#define pfn_pte(pfn,prot)	(__pte(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
+#define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
+#define pfn_pte(pfn,prot)	__pte(pte_val(__phys_to_pte((phys_addr_t)(pfn) << PAGE_SHIFT)) | pgprot_val(prot))
 
 #define pte_none(pte)		(!pte_val(pte))
 #define pte_clear(mm,addr,ptep)	set_pte(ptep, __pte(0))
@@ -270,11 +281,26 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
 
 #define __HAVE_ARCH_PTE_SPECIAL
 
+static inline pte_t pgd_pte(pgd_t pgd)
+{
+	return __pte(pgd_val(pgd));
+}
+
+static inline pgd_t pte_pgd(pte_t pte)
+{
+	return __pgd(pte_val(pte));
+}
+
 static inline pte_t pud_pte(pud_t pud)
 {
 	return __pte(pud_val(pud));
 }
 
+static inline pud_t pte_pud(pte_t pte)
+{
+	return __pud(pte_val(pte));
+}
+
 static inline pmd_t pud_pmd(pud_t pud)
 {
 	return __pmd(pud_val(pud));
@@ -336,15 +362,24 @@ static inline int pmd_protnone(pmd_t pmd)
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
 
-#define pmd_pfn(pmd)		(((pmd_val(pmd) & PMD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
-#define pfn_pmd(pfn,prot)	(__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
+#define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
+#define __phys_to_pmd(phys)	pte_pmd(__phys_to_pte(phys))
+#define pmd_pfn(pmd)		((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT)
+#define pfn_pmd(pfn,prot)	__pmd(pmd_val(__phys_to_pmd((phys_addr_t)(pfn) << PAGE_SHIFT)) | pgprot_val(prot))
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
 #define pud_write(pud)		pte_write(pud_pte(pud))
-#define pud_pfn(pud)		(((pud_val(pud) & PUD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
+
+#define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
+#define __phys_to_pud(phys)	pte_pud(__phys_to_pte(phys))
+#define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
+#define pfn_pud(pfn,prot)	__pud(pud_val(__phys_to_pud((phys_addr_t)(pfn) << PAGE_SHIFT)) | pgprot_val(prot))
 
 #define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
 
+#define __pgd_to_phys(pgd)	__pte_to_phys(pgd_pte(pgd))
+#define __phys_to_pgd(phys)	pte_pgd(__phys_to_pte(phys))
+
 #define __pgprot_modify(prot,mask,bits) \
 	__pgprot((pgprot_val(prot) & ~(mask)) | (bits))
 
@@ -395,7 +430,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 {
-	return pmd_val(pmd) & PHYS_MASK & (s32)PAGE_MASK;
+	return __pmd_to_phys(pmd);
 }
 
 /* Find an entry in the third-level page table. */
@@ -413,7 +448,7 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 #define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(pmd, addr))
 #define pte_clear_fixmap()		clear_fixmap(FIX_PTE)
 
-#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
+#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(__pmd_to_phys(pmd)))
 
 /* use ONLY for statically allocated translation tables */
 #define pte_offset_kimg(dir,addr)	((pte_t *)__phys_to_kimg(pte_offset_phys((dir), (addr))))
@@ -446,7 +481,7 @@ static inline void pud_clear(pud_t *pudp)
 
 static inline phys_addr_t pud_page_paddr(pud_t pud)
 {
-	return pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK;
+	return __pud_to_phys(pud);
 }
 
 /* Find an entry in the second-level page table. */
@@ -459,7 +494,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 #define pmd_set_fixmap_offset(pud, addr)	pmd_set_fixmap(pmd_offset_phys(pud, addr))
 #define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
 
-#define pud_page(pud)		pfn_to_page(__phys_to_pfn(pud_val(pud) & PHYS_MASK))
+#define pud_page(pud)		pfn_to_page(__phys_to_pfn(__pud_to_phys(pud)))
 
 /* use ONLY for statically allocated translation tables */
 #define pmd_offset_kimg(dir,addr)	((pmd_t *)__phys_to_kimg(pmd_offset_phys((dir), (addr))))
@@ -498,7 +533,7 @@ static inline void pgd_clear(pgd_t *pgdp)
 
 static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 {
-	return pgd_val(pgd) & PHYS_MASK & (s32)PAGE_MASK;
+	return __pgd_to_phys(pgd);
 }
 
 /* Find an entry in the frst-level page table. */
@@ -511,7 +546,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 #define pud_set_fixmap_offset(pgd, addr)	pud_set_fixmap(pud_offset_phys(pgd, addr))
 #define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
 
-#define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(pgd_val(pgd) & PHYS_MASK))
+#define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(__pgd_to_phys(pgd)))
 
 /* use ONLY for statically allocated translation tables */
 #define pud_offset_kimg(dir,addr)	((pud_t *)__phys_to_kimg(pud_offset_phys((dir), (addr))))
-- 
2.1.4
