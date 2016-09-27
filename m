From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:14 +0200
Subject: [PULL 06/50] arm/kvm: excise redundant cache maintenance
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-7-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

When modifying Stage-2 page tables, we perform cache maintenance to
account for non-coherent page table walks. However, this is unnecessary,
as page table walks are guaranteed to be coherent in the presence of the
virtualization extensions.

Per ARM DDI 0406C.c, section B1.7 ("The Virtualization Extensions"), the
virtualization extensions mandate the multiprocessing extensions.

Per ARM DDI 0406C.c, section B3.10.1 ("General TLB maintenance
requirements"), as described in the sub-section titled "TLB maintenance
operations and the memory order model", this maintenance is not required
in the presence of the multiprocessing extensions.

Hence, we need not perform this cache maintenance when modifying Stage-2
entries.

This patch removes the logic for performing the redundant maintenance.
To ensure visibility and ordering of updates, a dsb(ishst) that was
otherwise implicit in the maintenance is folded into kvm_set_pmd() and
kvm_set_pte().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h | 28 ++--------------------------
 arch/arm/kvm/mmu.c             |  2 --
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 3bb803d..74a44727 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -63,37 +63,13 @@ void kvm_clear_hyp_idmap(void);
 static inline void kvm_set_pmd(pmd_t *pmd, pmd_t new_pmd)
 {
 	*pmd = new_pmd;
-	flush_pmd_entry(pmd);
+	dsb(ishst);
 }
 
 static inline void kvm_set_pte(pte_t *pte, pte_t new_pte)
 {
 	*pte = new_pte;
-	/*
-	 * flush_pmd_entry just takes a void pointer and cleans the necessary
-	 * cache entries, so we can reuse the function for ptes.
-	 */
-	flush_pmd_entry(pte);
-}
-
-static inline void kvm_clean_pgd(pgd_t *pgd)
-{
-	clean_dcache_area(pgd, PTRS_PER_S2_PGD * sizeof(pgd_t));
-}
-
-static inline void kvm_clean_pmd(pmd_t *pmd)
-{
-	clean_dcache_area(pmd, PTRS_PER_PMD * sizeof(pmd_t));
-}
-
-static inline void kvm_clean_pmd_entry(pmd_t *pmd)
-{
-	clean_pmd_entry(pmd);
-}
-
-static inline void kvm_clean_pte(pte_t *pte)
-{
-	clean_pte_table(pte);
+	dsb(ishst);
 }
 
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 29d0b23..344755d 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -744,7 +744,6 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 	if (!pgd)
 		return -ENOMEM;
 
-	kvm_clean_pgd(pgd);
 	kvm->arch.pgd = pgd;
 	return 0;
 }
@@ -936,7 +935,6 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 		if (!cache)
 			return 0; /* ignore calls from kvm_set_spte_hva */
 		pte = mmu_memory_cache_alloc(cache);
-		kvm_clean_pte(pte);
 		pmd_populate_kernel(NULL, pmd, pte);
 		get_page(virt_to_page(pmd));
 	}
-- 
2.9.0
