From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Apr 2016 16:16:31 +0100
Subject: [PATCH] arm/arm64: KVM: Enforce Break-Before-Make on Stage-2 page
 tables
Message-ID: <1461856591-5751-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architecture mandates that when changing a page table entry
from a valid entry to another valid entry, an invalid entry is first
written, TLB invalidated, and only then the new entry being written.

The current code doesn't respect this, directly writing the new
entry and only then invalidating TLBs. Let's fix it up.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 58dbd5c..edf1cd1 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -893,11 +893,14 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
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
 
@@ -946,12 +949,14 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 
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
2.1.4
