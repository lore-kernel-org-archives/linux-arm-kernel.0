From: zhichang.yuan@linaro.org (zhichang.yuan at linaro.org)
Date: Fri, 21 Nov 2014 16:27:40 +0800
Subject: [PATCH] arm64:mm: free the useless initial page table
Message-ID: <1416558460-7257-1-git-send-email-zhichang.yuan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "zhichang.yuan" <zhichang.yuan@linaro.org>

For 64K page system, after mapping a PMD section, the corresponding initial
page table is not needed any more. That page can be freed.

Signed-off-by: Zhichang Yuan <zhichang.yuan@linaro.org>
---
 arch/arm64/mm/mmu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f4f8b50..12a336b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -191,8 +191,11 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
 			 * Check for previous table entries created during
 			 * boot (__create_page_tables) and flush them.
 			 */
-			if (!pmd_none(old_pmd))
+			if (!pmd_none(old_pmd)) {
 				flush_tlb_all();
+				if (pmd_table(old_pmd))
+					memblock_free(pte_pfn(pmd_pte(old_pmd)) << PAGE_SHIFT, PAGE_SIZE);
+			}
 		} else {
 			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys),
 				       prot_pte);
-- 
1.7.9.5
