From: shijie.huang@arm.com (Huang Shijie)
Date: Thu, 3 Nov 2016 10:27:38 +0800
Subject: [PATCH 1/2] arm64: hugetlb: remove the wrong pmd check in
 find_num_contig()
In-Reply-To: <1478140059-13829-1-git-send-email-shijie.huang@arm.com>
References: <1478140059-13829-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1478140059-13829-2-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The find_num_contig() will return 1 when the pmd is not present.
It will cause a kernel dead loop in the following scenaro:

   1.) pmd entry is not present.

   2.) the page fault occurs:
       ... hugetlb_fault() --> hugetlb_no_page() --> set_huge_pte_at()

   3.) set_huge_pte_at() will only set the first PMD entry, since the
       find_num_contig just return 1 in this case. So the PMD entries
       are all empty except the first one.

   4.) when kernel accesses the address mapped by the second PMD entry,
       a new page fault occurs:
       ... hugetlb_fault() --> huge_ptep_set_access_flags()

       The second PMD entry is still empty now.

   5.) When the kernel returns, the access will cause a page fault again.
       The kernel will run like the "4)" above.
       We will see a dead loop since here.

The dead loop is caught in the 32M hugetlb page (2M PMD + Contiguous bit).

This patch removes wrong pmd check, and fixes this dead loop.

Acked-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 2e49bd2..4811ef1 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -61,10 +61,6 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 		return 1;
 	}
 	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd)) {
-		VM_BUG_ON(!pmd_present(*pmd));
-		return 1;
-	}
 	if ((pte_t *)pmd == ptep) {
 		*pgsize = PMD_SIZE;
 		return CONT_PMDS;
-- 
2.5.5
