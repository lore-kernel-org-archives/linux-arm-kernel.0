From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sat, 20 Dec 2014 09:49:40 +0900
Subject: [PATCH] arm64: mm: Add pgd_page to support RCU fast_gup
Message-ID: <11B98DF8-2B98-414B-88E5-14C97ADAA60E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pgd_page definition in order to keep supporting
HAVE_GENERIC_RCU_GUP configuration. In addition, it changes pud_page
expression to align with pmd_page for readability.

An introduction of pgd_page resolves the following build breakage
under 4KB + 4Level memory management combo.

mm/gup.c: In function 'gup_huge_pgd':
mm/gup.c:889:2: error: implicit declaration of function 'pgd_page' [-Werror=implicit-function-declaration]
  head = pgd_page(orig);
  ^
mm/gup.c:889:7: warning: assignment makes pointer from integer without a cast
  head = pgd_page(orig);

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index df22314..a1fe927 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -401,7 +401,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(addr);
 }
 
-#define pud_page(pud)           pmd_page(pud_pmd(pud))
+#define pud_page(pud)		pfn_to_page(__phys_to_pfn(pud_val(pud) & PHYS_MASK))
 
 #endif	/* CONFIG_ARM64_PGTABLE_LEVELS > 2 */
 
@@ -437,6 +437,8 @@ static inline pud_t *pud_offset(pgd_t *pgd, unsigned long addr)
 	return (pud_t *)pgd_page_vaddr(*pgd) + pud_index(addr);
 }
 
+#define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(pgd_val(pgd) & PHYS_MASK))
+
 #endif  /* CONFIG_ARM64_PGTABLE_LEVELS > 3 */
 
 #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
-- 
1.9.1
