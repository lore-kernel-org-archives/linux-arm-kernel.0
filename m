From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:32 -0500
Subject: [RFC 36/55] KVM: arm64: Invalidate virtual EL2 TLB entries when needed
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-37-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Sometimes when we are invalidating the TLB for a certain S2 MMU
context, this context can also have EL2 context associated with it and
we have to invalidate this too.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm/kvm/arm.c |  6 ++++++
 arch/arm/kvm/mmu.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index aa8771d..371b38e7 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -350,6 +350,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		u64 vttbr = kvm_get_vttbr(&mmu->vmid, mmu);
 
 		kvm_call_hyp(__kvm_tlb_flush_local_vmid, vttbr);
+#ifndef CONFIG_KVM_ARM_NESTED_HYP
+		if (mmu->el2_vmid.vmid) {
+			vttbr = kvm_get_vttbr(&mmu->el2_vmid, mmu);
+			kvm_call_hyp(__kvm_tlb_flush_local_vmid, vttbr);
+		}
+#endif
 		*last_ran = vcpu->vcpu_id;
 	}
 
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 5ca3a04..56358fa 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -60,10 +60,20 @@ static bool memslot_is_logging(struct kvm_memory_slot *memslot)
  */
 void kvm_flush_remote_tlbs(struct kvm *kvm)
 {
+#ifndef CONFIG_KVM_ARM_NESTED_HYP
 	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
 	u64 vttbr = kvm_get_vttbr(&mmu->vmid, mmu);
 
 	kvm_call_hyp(__kvm_tlb_flush_vmid, vttbr);
+#else
+	/*
+	 * When supporting nested virtualization, we can have multiple VMIDs
+	 * in play for each VCPU in the VM, so it's really not worth it to try
+	 * to quiesce the system and flush all the VMIDs that may be in use,
+	 * instead just nuke the whole thing.
+	 */
+	kvm_call_hyp(__kvm_flush_vm_context);
+#endif
 }
 
 static void kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu, phys_addr_t ipa)
@@ -71,6 +81,12 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu, phys_addr_t ipa)
 	u64 vttbr = kvm_get_vttbr(&mmu->vmid, mmu);
 
 	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, vttbr, ipa);
+#ifdef CONFIG_KVM_ARM_NESTED_HYP
+	if (!mmu->el2_vmid.vmid)
+		return; /* only if this mmu has el2 context */
+	vttbr = kvm_get_vttbr(&mmu->el2_vmid, mmu);
+	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, vttbr, ipa);
+#endif
 }
 
 /*
-- 
1.9.1
