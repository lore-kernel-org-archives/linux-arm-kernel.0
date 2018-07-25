From: zhongjiang@huawei.com (zhong jiang)
Date: Wed, 25 Jul 2018 23:21:59 +0800
Subject: [RFC] mm: Do not look up the next level table when large page exist.
Message-ID: <1532532119-59955-1-git-send-email-zhongjiang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

show_pte can show the kernel page table and user page table. user
page table is totally four level table. but kernel page table can
be a large page. Therefore, it need to check the page table.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm64/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 1b40676..a397a54 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -169,13 +169,13 @@ void show_pte(unsigned long addr)
 		pudp = pud_offset(pgdp, addr);
 		pud = READ_ONCE(*pudp);
 		pr_cont(", pud=%016llx", pud_val(pud));
-		if (pud_none(pud) || pud_bad(pud))
+		if (pud_none(pud) || pud_bad(pud) || pud_sect(pud))
 			break;
 
 		pmdp = pmd_offset(pudp, addr);
 		pmd = READ_ONCE(*pmdp);
 		pr_cont(", pmd=%016llx", pmd_val(pmd));
-		if (pmd_none(pmd) || pmd_bad(pmd))
+		if (pmd_none(pmd) || pmd_bad(pmd) || pmd_sect(pmd))
 			break;
 
 		ptep = pte_offset_map(pmdp, addr);
-- 
1.7.12.4
