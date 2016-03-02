From: steve.capper@arm.com (Steve Capper)
Date: Wed,  2 Mar 2016 01:03:00 +0000
Subject: [PATCH] arm: mm: Fix definition of pmd_mknotpresent
Message-ID: <1456880580-22311-1-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently pmd_mknotpresent will use a zero entry to respresent an
invalidated pmd.

Unfortunately this definition clashes with pmd_none, thus it is
possible for a race condition to occur if zap_pmd_range sees pmd_none
whilst __split_huge_pmd_locked is running too with pmdp_invalidate
just called.

This patch fixes the race condition by modifying pmd_mknotpresent to
create non-zero faulting entries (as is done in other architectures),
removing the ambiguity with pmd_none.

Fixes: 8d9625070073 ("ARM: mm: Transparent huge page support for LPAE systems.")
Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>

---

This patch addresses an issue discussed at:
http://lkml.iu.edu/hypermail/linux/kernel/1602.3/01846.html

---
 arch/arm/include/asm/pgtable-3level.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index dc46398..451b6e7 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -249,10 +249,10 @@ PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 #define pfn_pmd(pfn,prot)	(__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
-/* represent a notpresent pmd by zero, this is used by pmdp_invalidate */
+/* represent a notpresent pmd by faulting entry, this is used by pmdp_invalidate */
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
-	return __pmd(0);
+	return __pmd(pmd_val(pmd) & ~PMD_TYPE_MASK);
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
-- 
2.1.0
