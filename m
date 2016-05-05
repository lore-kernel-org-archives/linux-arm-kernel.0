From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu,  5 May 2016 10:43:59 +0100
Subject: [PATCH 1/4] arm64: Fix typo in the pmdp_huge_get_and_clear()
 definition
In-Reply-To: <1462441442-6996-1-git-send-email-catalin.marinas@arm.com>
References: <1462441442-6996-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1462441442-6996-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With hardware AF/DBM support, pmd modifications (transparent huge pages)
should be performed atomically using load/store exclusive. The initial
patches defined the get-and-clear function and __HAVE_ARCH_* macro
without the "huge" word, leaving the pmdp_huge_get_and_clear() to the
default, non-atomic implementation.

Fixes: 2f4b829c625e ("arm64: Add support for hardware updates of the access and dirty pte bits")
Cc: <stable@vger.kernel.org> # 4.3+
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e021cbf11043..5237331e97f4 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -605,9 +605,9 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define __HAVE_ARCH_PMDP_GET_AND_CLEAR
-static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
-				       unsigned long address, pmd_t *pmdp)
+#define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
+static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
+					    unsigned long address, pmd_t *pmdp)
 {
 	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
 }
