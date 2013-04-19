From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 19 Apr 2013 15:49:31 +0100
Subject: [PATCH] ARM64: mm: Correct show_pte behaviour.
Message-ID: <1366382971-12682-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

show_pte makes use of the *_none_or_clear_bad style functions. If a
pgd, pud or pmd is identified as being bad, it will then be cleared.

As show_pte appears to be called from either the user or kernel
fault handlers this side effect can lead to unpredictable behaviour;
especially as TLB entries are not invalidated.

This patch removes the page table sanitisation from show_pte. If a
bad pgd, pud or pmd is encountered it is left unmodified.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/mm/fault.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index afadae6..5263817 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -57,16 +57,16 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 		pmd_t *pmd;
 		pte_t *pte;
 
-		if (pgd_none_or_clear_bad(pgd))
+		if (pgd_none(*pgd) || pgd_bad(*pgd))
 			break;
 
 		pud = pud_offset(pgd, addr);
-		if (pud_none_or_clear_bad(pud))
+		if (pud_none(*pud) || pud_bad(*pud))
 			break;
 
 		pmd = pmd_offset(pud, addr);
 		printk(", *pmd=%016llx", pmd_val(*pmd));
-		if (pmd_none_or_clear_bad(pmd))
+		if (pmd_none(*pmd) || pmd_bad(*pmd))
 			break;
 
 		pte = pte_offset_map(pmd, addr);
-- 
1.8.1.4
