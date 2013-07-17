From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 17 Jul 2013 14:26:13 +0100
Subject: [PATCH 1/2] ARM: mm: Remove general hugetlb code from ARM.
In-Reply-To: <1374067574-32034-1-git-send-email-steve.capper@linaro.org>
References: <1374067574-32034-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1374067574-32034-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

General forms of huge_pte_alloc, huge_pte_offset and follow_huge_pmd
are now available in mm/hugetlb.c.

This patch removes the ARM copies of these functions and activates
the general ones by enabling:
CONFIG_ARCH_WANT_GENERAL_HUGETLB

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/Kconfig          |  3 +++
 arch/arm/mm/hugetlbpage.c | 43 -------------------------------------------
 2 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba412e0..d0fd5bf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1757,6 +1757,9 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE
        def_bool y
        depends on ARM_LPAE
 
+config ARCH_WANT_GENERAL_HUGETLB
+	def_bool y
+
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index 3d1e4a2..66781bf 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -36,22 +36,6 @@
  * of type casting from pmd_t * to pte_t *.
  */
 
-pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd = NULL;
-
-	pgd = pgd_offset(mm, addr);
-	if (pgd_present(*pgd)) {
-		pud = pud_offset(pgd, addr);
-		if (pud_present(*pud))
-			pmd = pmd_offset(pud, addr);
-	}
-
-	return (pte_t *)pmd;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 			      int write)
 {
@@ -68,33 +52,6 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 	return 0;
 }
 
-pte_t *huge_pte_alloc(struct mm_struct *mm,
-			unsigned long addr, unsigned long sz)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pte_t *pte = NULL;
-
-	pgd = pgd_offset(mm, addr);
-	pud = pud_alloc(mm, pgd, addr);
-	if (pud)
-		pte = (pte_t *)pmd_alloc(mm, pud, addr);
-
-	return pte;
-}
-
-struct page *
-follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-		pmd_t *pmd, int write)
-{
-	struct page *page;
-
-	page = pte_page(*(pte_t *)pmd);
-	if (page)
-		page += ((address & ~PMD_MASK) >> PAGE_SHIFT);
-	return page;
-}
-
 int pmd_huge(pmd_t pmd)
 {
 	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
-- 
1.8.1.4
