From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:54 +0100
Subject: [PATCH 36/37] KVM: arm/arm64: Skip updating PMD entry if no change
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-37-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Punit Agrawal <punit.agrawal@arm.com>

Contention on updating a PMD entry by a large number of vcpus can lead
to duplicate work when handling stage 2 page faults. As the page table
update follows the break-before-make requirement of the architecture,
it can lead to repeated refaults due to clearing the entry and
flushing the tlbs.

This problem is more likely when -

* there are large number of vcpus
* the mapping is large block mapping

such as when using PMD hugepages (512MB) with 64k pages.

Fix this by skipping the page table update if there is no change in
the entry being updated.

Cc: stable at vger.kernel.org
Fixes: ad361f093c1e ("KVM: ARM: Support hugetlbfs backed huge pages")
Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 97d27cd9c654..13dfe36501aa 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1044,19 +1044,35 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 	pmd = stage2_get_pmd(kvm, cache, addr);
 	VM_BUG_ON(!pmd);
 
-	/*
-	 * Mapping in huge pages should only happen through a fault.  If a
-	 * page is merged into a transparent huge page, the individual
-	 * subpages of that huge page should be unmapped through MMU
-	 * notifiers before we get here.
-	 *
-	 * Merging of CompoundPages is not supported; they should become
-	 * splitting first, unmapped, merged, and mapped back in on-demand.
-	 */
-	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
-
 	old_pmd = *pmd;
 	if (pmd_present(old_pmd)) {
+		/*
+		 * Multiple vcpus faulting on the same PMD entry, can
+		 * lead to them sequentially updating the PMD with the
+		 * same value. Following the break-before-make
+		 * (pmd_clear() followed by tlb_flush()) process can
+		 * hinder forward progress due to refaults generated
+		 * on missing translations.
+		 *
+		 * Skip updating the page table if the entry is
+		 * unchanged.
+		 */
+		if (pmd_val(old_pmd) == pmd_val(*new_pmd))
+			return 0;
+
+		/*
+		 * Mapping in huge pages should only happen through a
+		 * fault.  If a page is merged into a transparent huge
+		 * page, the individual subpages of that huge page
+		 * should be unmapped through MMU notifiers before we
+		 * get here.
+		 *
+		 * Merging of CompoundPages is not supported; they
+		 * should become splitting first, unmapped, merged,
+		 * and mapped back in on-demand.
+		 */
+		VM_BUG_ON(pmd_pfn(old_pmd) != pmd_pfn(*new_pmd));
+
 		pmd_clear(pmd);
 		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	} else {
-- 
2.18.0
