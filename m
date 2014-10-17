From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 17 Oct 2014 15:27:38 +0100
Subject: [PATCH] arm64: mm: Correct fixmap pagetable types
Message-ID: <1413556058-27432-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling with STRICT_MM_TYPECHECKS gives the following
arch/arm64/mm/ioremap.c: In function ?early_ioremap_init?:
arch/arm64/mm/ioremap.c:152:2: warning: passing argument 3 of
?pud_populate? from incompatible pointer type
  pud_populate(&init_mm, pud, bm_pmd);

The data types for bm_pmd and bm_pud are incorrectly set to pte_t.
This patch corrects these types.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/mm/ioremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index fa324bd..4a07630 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -105,10 +105,10 @@ EXPORT_SYMBOL(ioremap_cache);
 
 static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
 #if CONFIG_ARM64_PGTABLE_LEVELS > 2
-static pte_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
+static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #endif
 #if CONFIG_ARM64_PGTABLE_LEVELS > 3
-static pte_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
+static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
 #endif
 
 static inline pud_t * __init early_ioremap_pud(unsigned long addr)
-- 
1.9.3
