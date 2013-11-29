From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 29 Nov 2013 15:34:21 +0000
Subject: [PATCH] arm64: mm: Avoid set_pte_at with HugeTLB pages
Message-ID: <1385739261-26689-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For huge pages, given newprot a pgprot_t value for a shared writable
VMA, and ptep a pointer to a pte belonging to this VMA; the following
behaviour is assumed by core code:

   hugetlb_change_protection(vma, address, end, newprot);
   ...

   huge_pte_write(huge_ptep_get(ptep)); /* should be true! */

Unfortunately, set_huge_pte_at calls set_pte_at which includes a
side-effect that renders ptes read only if the dirty bit is unset.

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
tests complete successfully.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
I operated under the deluded notion that set_pte_at on arm64 had no
side effects when I originally sent out:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/212475.html

As this is patch is more or less self-contained for arm64, I am sending
this out on its own rather than merging with the above series.

Apologies for not catching this sooner.
---
 arch/arm64/include/asm/hugetlb.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 5b7ca8a..32b042f 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -33,7 +33,10 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 				   pte_t *ptep, pte_t pte)
 {
-	set_pte_at(mm, addr, ptep, pte);
+	if (pte_exec(pte))
+		__sync_icache_dcache(pte, addr);
+
+	*ptep = pte;
 }
 
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
-- 
1.8.1.4
