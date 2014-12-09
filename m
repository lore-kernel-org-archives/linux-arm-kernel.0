From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 12:26:05 +0100
Subject: [GIT PULL 6/9] arm,
 arm64: KVM: handle potential incoherency of readonly memslots
In-Reply-To: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418124368-28418-7-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Readonly memslots are often used to implement emulation of ROMs and
NOR flashes, in which case the guest may legally map these regions as
uncached.
To deal with the incoherency associated with uncached guest mappings,
treat all readonly memslots as incoherent, and ensure that pages that
belong to regions tagged as such are flushed to DRAM before being passed
to the guest.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index cb924c6..f2a9874 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -919,7 +919,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (!hugetlb && !force_pte)
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
-	fault_ipa_uncached = false;
+	fault_ipa_uncached = memslot->flags & KVM_MEMSLOT_INCOHERENT;
 
 	if (hugetlb) {
 		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
@@ -1298,11 +1298,12 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		hva = vm_end;
 	} while (hva < reg_end);
 
-	if (ret) {
-		spin_lock(&kvm->mmu_lock);
+	spin_lock(&kvm->mmu_lock);
+	if (ret)
 		unmap_stage2_range(kvm, mem->guest_phys_addr, mem->memory_size);
-		spin_unlock(&kvm->mmu_lock);
-	}
+	else
+		stage2_flush_memslot(kvm, memslot);
+	spin_unlock(&kvm->mmu_lock);
 	return ret;
 }
 
@@ -1314,6 +1315,15 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 			    unsigned long npages)
 {
+	/*
+	 * Readonly memslots are not incoherent with the caches by definition,
+	 * but in practice, they are used mostly to emulate ROMs or NOR flashes
+	 * that the guest may consider devices and hence map as uncached.
+	 * To prevent incoherency issues in these cases, tag all readonly
+	 * regions as incoherent.
+	 */
+	if (slot->flags & KVM_MEM_READONLY)
+		slot->flags |= KVM_MEMSLOT_INCOHERENT;
 	return 0;
 }
 
-- 
2.1.2.330.g565301e.dirty
