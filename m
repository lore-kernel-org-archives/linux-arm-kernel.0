From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:55 +0100
Subject: [PATCH 37/37] KVM: arm/arm64: Skip updating PTE entry if no change
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-38-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Punit Agrawal <punit.agrawal@arm.com>

When there is contention on faulting in a particular page table entry
at stage 2, the break-before-make requirement of the architecture can
lead to additional refaulting due to TLB invalidation.

Avoid this by skipping a page table update if the new value of the PTE
matches the previous value.

Cc: stable at vger.kernel.org
Fixes: d5d8184d35c9 ("KVM: ARM: Memory virtualization setup")
Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 13dfe36501aa..91aaf73b00df 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1147,6 +1147,10 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 	/* Create 2nd stage page table mapping - Level 3 */
 	old_pte = *pte;
 	if (pte_present(old_pte)) {
+		/* Skip page table update if there is no change */
+		if (pte_val(old_pte) == pte_val(*new_pte))
+			return 0;
+
 		kvm_set_pte(pte, __pte(0));
 		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	} else {
-- 
2.18.0
