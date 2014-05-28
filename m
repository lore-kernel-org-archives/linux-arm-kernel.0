From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 May 2014 18:07:16 +0100
Subject: [PATCH] arm64: mm: fix pmd_write CoW brokenness
Message-ID: <1401296836-16837-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9c7e535fcc17 ("arm64: mm: Route pmd thp functions through pte
equivalents") changed the pmd manipulator and accessor functions to
convert the target pmd to a pte, process it with the pte functions, then
convert it back. Along the way, we gained support for PTE_WRITE, however
this is completely ignored by set_pmd_at, and so we fail to set the
PMD_SECT_RDONLY for PMDs, resulting in all sorts of lovely failures (like
CoW not working).

Partially reverting the offending commit (by making use of
PMD_SECT_RDONLY explicitly for pmd_{write,wrprotect,mkwrite} functions)
leads to further issues because pmd_write can then return potentially
incorrect values for page table entries marked as RDONLY, leading to
BUG_ON(pmd_write(entry)) tripping under some THP workloads.

This patch fixes the issue by routing set_pmd_at through set_pte_at,
which correctly takes the PTE_WRITE flag into account. Given that
THP mappings are always anonymous, the additional cache-flushing code
in __sync_icache_dcache won't impose any significant overhead as the
flush will be skipped.

Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Whilst this is a fairly scary change at this point in the cycle, I can't get
through an LTP run without it. Furthermore, spurious CoW failures for tasks
that happen to get transparent hugepages are a pretty significant regression.

 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 90c811f05a2e..20785f9da95c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -266,7 +266,7 @@ static inline pmd_t pte_pmd(pte_t pte)
 
 #define pmd_page(pmd)           pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
-#define set_pmd_at(mm, addr, pmdp, pmd)	set_pmd(pmdp, pmd)
+#define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, pmdp, pmd_pte(pmd))
 
 static inline int has_transparent_hugepage(void)
 {
-- 
1.9.2
