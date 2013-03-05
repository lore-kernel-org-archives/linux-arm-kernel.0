From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:06 +0000
Subject: [PATCH 12/29] ARM: KVM: abstract fault decoding away
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 5 +++++
 arch/arm/kvm/mmu.c                 | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index e3e6135..75e54ba 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -146,4 +146,9 @@ static inline u8 kvm_vcpu_trap_get_class(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) >> HSR_EC_SHIFT;
 }
 
+static inline u8 kvm_vcpu_trap_get_fault(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_hsr(vcpu) & HSR_FSC_TYPE;
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 41fa75d..e00f28d 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -601,7 +601,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			      kvm_vcpu_get_hfar(vcpu), fault_ipa);
 
 	/* Check the stage-2 fault is trans. fault or write fault */
-	fault_status = (kvm_vcpu_get_hsr(vcpu) & HSR_FSC_TYPE);
+	fault_status = kvm_vcpu_trap_get_fault(vcpu);
 	if (fault_status != FSC_FAULT && fault_status != FSC_PERM) {
 		kvm_err("Unsupported fault status: EC=%#lx DFCS=%#lx\n",
 			hsr_ec, fault_status);
-- 
1.7.12.4
