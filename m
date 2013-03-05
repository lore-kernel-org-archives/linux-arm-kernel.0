From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:07 +0000
Subject: [PATCH 13/29] ARM: KVM: abstract HSR_EC_IABT away
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 5 +++++
 arch/arm/kvm/mmu.c                 | 8 +++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 75e54ba..2f5cc48 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -146,6 +146,11 @@ static inline u8 kvm_vcpu_trap_get_class(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_get_hsr(vcpu) >> HSR_EC_SHIFT;
 }
 
+static inline bool kvm_vcpu_trap_is_iabt(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_trap_get_class(vcpu) == HSR_EC_IABT;
+}
+
 static inline u8 kvm_vcpu_trap_get_fault(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_get_hsr(vcpu) & HSR_FSC_TYPE;
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index e00f28d..8e9047a 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -585,7 +585,6 @@ out_unlock:
  */
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	unsigned long hsr_ec;
 	unsigned long fault_status;
 	phys_addr_t fault_ipa;
 	struct kvm_memory_slot *memslot;
@@ -593,8 +592,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	gfn_t gfn;
 	int ret, idx;
 
-	hsr_ec = kvm_vcpu_trap_get_class(vcpu);
-	is_iabt = (hsr_ec == HSR_EC_IABT);
+	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
 	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
 
 	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_hsr(vcpu),
@@ -603,8 +601,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	/* Check the stage-2 fault is trans. fault or write fault */
 	fault_status = kvm_vcpu_trap_get_fault(vcpu);
 	if (fault_status != FSC_FAULT && fault_status != FSC_PERM) {
-		kvm_err("Unsupported fault status: EC=%#lx DFCS=%#lx\n",
-			hsr_ec, fault_status);
+		kvm_err("Unsupported fault status: EC=%#x DFCS=%#lx\n",
+			kvm_vcpu_trap_get_class(vcpu), fault_status);
 		return -EFAULT;
 	}
 
-- 
1.7.12.4
