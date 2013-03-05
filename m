From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:05 +0000
Subject: [PATCH 11/29] ARM: KVM: abstract exception class decoding away
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h | 5 +++++
 arch/arm/kvm/arm.c                 | 4 ++--
 arch/arm/kvm/mmu.c                 | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index bb1a25c..e3e6135 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -141,4 +141,9 @@ static inline bool kvm_vcpu_trap_il_is32bit(struct kvm_vcpu *vcpu)
 	return !!((kvm_vcpu_get_hsr(vcpu) >> 25) & 1);
 }
 
+static inline u8 kvm_vcpu_trap_get_class(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_hsr(vcpu) >> HSR_EC_SHIFT;
+}
+
 #endif /* __ARM_KVM_EMULATE_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e49a687..4e83d57 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -559,7 +559,7 @@ static bool kvm_condition_valid(struct kvm_vcpu *vcpu)
 	 * catch undefined instructions, and then we won't get past
 	 * the arm_exit_handlers test anyway.
 	 */
-	BUG_ON(((kvm_vcpu_get_hsr(vcpu) & HSR_EC) >> HSR_EC_SHIFT) == 0);
+	BUG_ON(!kvm_vcpu_trap_get_class(vcpu));
 
 	/* Top two bits non-zero?  Unconditional. */
 	if (kvm_vcpu_get_hsr(vcpu) >> 30)
@@ -609,7 +609,7 @@ static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case ARM_EXCEPTION_DATA_ABORT:
 	case ARM_EXCEPTION_PREF_ABORT:
 	case ARM_EXCEPTION_HVC:
-		hsr_ec = (kvm_vcpu_get_hsr(vcpu) & HSR_EC) >> HSR_EC_SHIFT;
+		hsr_ec = kvm_vcpu_trap_get_class(vcpu);
 
 		if (hsr_ec >= ARRAY_SIZE(arm_exit_handlers)
 		    || !arm_exit_handlers[hsr_ec]) {
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index d0f5f52..41fa75d 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -593,7 +593,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	gfn_t gfn;
 	int ret, idx;
 
-	hsr_ec = kvm_vcpu_get_hsr(vcpu) >> HSR_EC_SHIFT;
+	hsr_ec = kvm_vcpu_trap_get_class(vcpu);
 	is_iabt = (hsr_ec == HSR_EC_IABT);
 	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
 
-- 
1.7.12.4
