From: christoffer.dall@arm.com (Christoffer Dall)
Date: Fri,  2 Nov 2018 08:53:52 +0100
Subject: [PATCH] KVM: arm64: Clarify explanation of STAGE2_PGTABLE_LEVELS
Message-ID: <20181102075352.20636-1-christoffer.dall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In attempting to re-construct the logic for our stage 2 page table
layout I found the reaoning in the comment explaining how we calculate
the number of levels used for stage 2 page tables a bit backwards.

This commit attempts to clarify the comment, to make it slightly easier
to read without having the Arm ARM open on the right page.

While we're at it, fixup a typo in a comment that was recently changed.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm64/include/asm/stage2_pgtable.h | 17 ++++++++++-------
 virt/kvm/arm/mmu.c                      |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index d352f6df8d2c..9c387320b28c 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -31,15 +31,18 @@
 
 /*
  * The hardware supports concatenation of up to 16 tables at stage2 entry level
- * and we use the feature whenever possible.
+ * and we use the feature whenever possible, which means we resolve 4 bits of
+ * address at the entry level.
  *
- * Now, the minimum number of bits resolved at any level is (PAGE_SHIFT - 3).
+ * This implies, the total number of page table levels required for
+ * IPA_SHIFT at stage2 expected by the hardware can be calculated using
+ * the same logic used for the (non-collapsable) stage1 page tables but for
+ * (IPA_SHIFT - 4).
+ *
+ * Note, the minimum number of bits resolved at any level is (PAGE_SHIFT - 3).
  * On arm64, the smallest PAGE_SIZE supported is 4k, which means
- *             (PAGE_SHIFT - 3) > 4 holds for all page sizes.
- * This implies, the total number of page table levels at stage2 expected
- * by the hardware is actually the number of levels required for (IPA_SHIFT - 4)
- * in normal translations(e.g, stage1), since we cannot have another level in
- * the range (IPA_SHIFT, IPA_SHIFT - 4).
+ *             (PAGE_SHIFT - 3) > 4 holds for all page sizes
+ * and therefore we will need a minimum of two levels for stage2 in all cases.
  */
 #define stage2_pgtable_levels(ipa)	ARM64_HW_PGTABLE_LEVELS((ipa) - 4)
 #define kvm_stage2_levels(kvm)		VTCR_EL2_LVLS(kvm->arch.vtcr)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 4e7572656b5c..78d8020df4a4 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1234,7 +1234,7 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
 	struct page *page = pfn_to_page(pfn);
 
 	/*
-	 * PageTransCompoungMap() returns true for THP and
+	 * PageTransCompoundMap() returns true for THP and
 	 * hugetlbfs. Make sure the adjustment is done only for THP
 	 * pages.
 	 */
-- 
2.18.0
