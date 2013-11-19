From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 19 Nov 2013 17:35:27 +0000
Subject: [PATCH 1/3] ARM: mm: Rewire LPAE set_huge_pte_at
In-Reply-To: <1384882529-28104-1-git-send-email-steve.capper@linaro.org>
References: <1384882529-28104-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1384882529-28104-2-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For LPAE, set_huge_pte_at calls set_pte_at which then calls
set_pte_ext, which in turn is wired up to call cpu_v7_set_pte_ext,
which is defined in proc-v7-3level.S.

For huge pages, given newprot a pgprot_t value for a shared writable
VMA, and ptep a pointer to a pte belonging to this VMA; the following
behaviour is assumed by core code:
   hugetlb_change_protection(vma, address, end, newprot);
   ...

   huge_pte_write(huge_ptep_get(ptep)); /* should be true! */

Unfortunately, cpu_v7_set_pte_ext will change the bit layout of the
resultant pte, and will set the read only bit if the dirty bit is not
also enabled.

If one were to allocate a read only shared huge page, then fault it in,
and then mprotect it to be writeable. A subsequent write to that huge
page will result in a spurious call to hugetlb_cow, which causes
corruption. This call is optimised away prior to:
 37a2140 mm, hugetlb: do not use a page in page cache for cow
         optimization

If one runs the libhugetlbfs test suite on v3.12-rc1 upwards, then the
mprotect test will cause the afformentioned corruption and before the
set of tests completes, the system will be left in an unresponsive
state. (calls to fork fail with -ENOMEM).

This patch re-implements set_huge_pte_at to dereference the pte value
explicitly. hugetlb_cow is no longer called spuriously, and the unit
tests complete succesfully.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/hugetlb-3level.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
index d4014fb..211e9a8 100644
--- a/arch/arm/include/asm/hugetlb-3level.h
+++ b/arch/arm/include/asm/hugetlb-3level.h
@@ -40,7 +40,12 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, pte_t pte)
 {
-	set_pte_at(mm, addr, ptep, pte);
+	VM_BUG_ON(addr >= TASK_SIZE);
+
+	if (pte_present_user(pte))
+		__sync_icache_dcache(pte);
+
+	*ptep = pte;
 }
 
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
-- 
1.8.1.4
