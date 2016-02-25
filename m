From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 25 Feb 2016 15:33:05 +0000
Subject: [PATCH -next] mm: fix build for arm64 hugetlbpage
Message-ID: <1456414385-13775-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ("mm: cleanup *pte_alloc* interfaces") redefined pte_alloc_map()
using pte_alloc() and fixed all the callsites. However arm64 callsite
seem to have got missed. This patch fixes the same and thereby fixing
the following build error.

arch/arm64/mm/hugetlbpage.c: In function 'huge_pte_alloc':
arch/arm64/mm/hugetlbpage.c:127:42: error: macro "pte_alloc_map" passed 4 arguments, but takes just 3
   pte = pte_alloc_map(mm, NULL, pmd, addr);
                                          ^
arch/arm64/mm/hugetlbpage.c:127:9: error: 'pte_alloc_map' undeclared (first use in this function)
   pte = pte_alloc_map(mm, NULL, pmd, addr);
         ^
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

Since it's from -mm tree, I have not put the commit id causing the
breakage. Also since I don't have the original patch in my inbox, I am
posting this separately. It would be good to squash this into original
commit.

Regards,
Sudeep

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 82d607c3614e..bb6b4c7bfab3 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -124,7 +124,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 		 * will be no pte_unmap() to correspond with this
 		 * pte_alloc_map().
 		 */
-		pte = pte_alloc_map(mm, NULL, pmd, addr);
+		pte = pte_alloc_map(mm, pmd, addr);
 	} else if (sz == PMD_SIZE) {
 		if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
 		    pud_none(*pud))
-- 
1.9.1
