From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 24 Apr 2014 17:57:53 +0100
Subject: [PATCH V2] arm64: mm: Add THP TLB entries to general mmu_gather
Message-ID: <1398358673-8429-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When arm64 moved over to the core mmu_gather, it lost the logic to
flush THP TLB entries (tlb_remove_pmd_tlb_entry was removed and the
core implementation only signals that the mmu_gather needs a flush).

This patch ensures that tlb_add_flush is called for THP TLB entries.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
Change in V2: moved __tlb_remove_pmd_tlb_entry to tlb.h to tidy it up.
---
 arch/arm64/include/asm/tlb.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 72cadf5..80e2c08 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -19,6 +19,7 @@
 #ifndef __ASM_TLB_H
 #define __ASM_TLB_H
 
+#define  __tlb_remove_pmd_tlb_entry __tlb_remove_pmd_tlb_entry
 
 #include <asm-generic/tlb.h>
 
@@ -99,5 +100,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 }
 #endif
 
+static inline void __tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, pmd_t *pmdp,
+						unsigned long address)
+{
+	tlb_add_flush(tlb, address);
+}
 
 #endif
-- 
1.8.1.4
