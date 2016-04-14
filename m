From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 14:20:58 +0100
Subject: [PATCH v2 10/17] kvm-arm: arm64: Introduce hyp page table empty checks
In-Reply-To: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1460640065-27658-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce hyp_pxx_table_empty helpers for checking whether
a given table entry is empty. This will be used explicitly
once we switch to explicit routines for hyp page table walk.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e3f53e3..edf3c62 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -249,6 +249,20 @@ static inline bool kvm_page_empty(void *ptr)
 #endif
 
 
+#define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
+
+#ifdef __PAGETABLE_PMD_FOLDED
+#define hyp_pmd_table_empty(pmdp) (0)
+#else
+#define hyp_pmd_table_empty(pmdp) kvm_page_empty(pmdp)
+#endif
+
+#ifdef __PAGETABLE_PUD_FOLDED
+#define hyp_pud_table_empty(pudp) (0)
+#else
+#define hyp_pud_table_empty(pudp) kvm_page_empty(pudp)
+#endif
+
 struct kvm;
 
 #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
-- 
1.7.9.5
