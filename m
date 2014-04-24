From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 24 Apr 2014 13:23:38 +0100
Subject: [PATCH] arm64: mm: Add THP TLB entries to general mmu_gather
Message-ID: <1398342218-31830-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When arm64 moved over to the core mmu_gather, it lost the logic to
flush THP TLB entries (tlb_remove_pmd_tlb_entry was removed and the
core implementation only signals that the mmu_gather needs a flush).

This patch ensures that tlb_add_flush is called for THP TLB entries.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 arch/arm64/include/asm/tlb.h     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index aa3917c..9886368 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -434,6 +434,8 @@ extern int kern_addr_valid(unsigned long addr);
 
 #define pgtable_cache_init() do { } while (0)
 
+#define  __tlb_remove_pmd_tlb_entry __tlb_remove_pmd_tlb_entry
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 72cadf5..fa2255e 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -99,5 +99,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
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
