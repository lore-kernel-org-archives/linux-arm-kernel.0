From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2018 09:31:16 +0100
Subject: [PATCH v2 2/4] arm64: Remove unnecessary ISBs from set_{pte,pmd,pud}
In-Reply-To: <1529656278-878-1-git-send-email-will.deacon@arm.com>
References: <1529656278-878-1-git-send-email-will.deacon@arm.com>
Message-ID: <1529656278-878-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7f0b1bf04511 ("arm64: Fix barriers used for page table modifications")
fixed a reported issue with fixmap page-table entries not being visible
to the walker due to a missing DSB instruction. At the same time, it added
ISB instructions to the arm64 set_{pte,pmd,pud} functions, which are not
required by the architecture and make little sense in isolation.

Remove the redundant ISBs.

Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Steve Capper <steve.capper@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9f82d6b53851..1bdeca8918a6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -224,10 +224,8 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	 * Only if the new pte is valid and kernel, otherwise TLB maintenance
 	 * or update_mmu_cache() have the necessary barriers.
 	 */
-	if (pte_valid_not_user(pte)) {
+	if (pte_valid_not_user(pte))
 		dsb(ishst);
-		isb();
-	}
 }
 
 extern void __sync_icache_dcache(pte_t pteval);
@@ -434,7 +432,6 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	WRITE_ONCE(*pmdp, pmd);
 	dsb(ishst);
-	isb();
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
@@ -485,7 +482,6 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
 {
 	WRITE_ONCE(*pudp, pud);
 	dsb(ishst);
-	isb();
 }
 
 static inline void pud_clear(pud_t *pudp)
-- 
2.1.4
