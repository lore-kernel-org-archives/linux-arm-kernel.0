From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 May 2016 15:30:11 +0200
Subject: [PULL 18/29] arm/arm64: KVM: Enforce Break-Before-Make on Stage-2
 page tables
In-Reply-To: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
References: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1462973422-10021-19-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The ARM architecture mandates that when changing a page table entry
from a valid entry to another valid entry, an invalid entry is first
written, TLB invalidated, and only then the new entry being written.

The current code doesn't respect this, directly writing the new
entry and only then invalidating TLBs. Let's fix it up.

Cc: <stable@vger.kernel.org>
Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 42eefab..74b5d19 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -910,11 +910,14 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
 
 	old_pmd = *pmd;
-	kvm_set_pmd(pmd, *new_pmd);
-	if (pmd_present(old_pmd))
+	if (pmd_present(old_pmd)) {
+		pmd_clear(pmd);
 		kvm_tlb_flush_vmid_ipa(kvm, addr);
-	else
+	} else {
 		get_page(virt_to_page(pmd));
+	}
+
+	kvm_set_pmd(pmd, *new_pmd);
 	return 0;
 }
 
@@ -963,12 +966,14 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 
 	/* Create 2nd stage page table mapping - Level 3 */
 	old_pte = *pte;
-	kvm_set_pte(pte, *new_pte);
-	if (pte_present(old_pte))
+	if (pte_present(old_pte)) {
+		kvm_set_pte(pte, __pte(0));
 		kvm_tlb_flush_vmid_ipa(kvm, addr);
-	else
+	} else {
 		get_page(virt_to_page(pte));
+	}
 
+	kvm_set_pte(pte, *new_pte);
 	return 0;
 }
 
-- 
2.1.2.330.g565301e.dirty
