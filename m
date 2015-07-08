From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Jul 2015 17:19:11 +0100
Subject: [PATCH 08/13] arm64: KVM: VHE: Preserve VHE config in world switch
In-Reply-To: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436372356-30410-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Running the kernel in HYP mode requires the HCR_E2H bit to be set
at all times, and the HCR_TGE bit to be set when running as a host
(and cleared when running as a guest).

Also add some cryptic macros to deal with cpp macro expansion inside
asm macros...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h     | 1 +
 arch/arm64/include/asm/kvm_emulate.h | 2 ++
 arch/arm64/kvm/hyp.S                 | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index ac6fafb..c8998c0 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -23,6 +23,7 @@
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
+#define HCR_E2H		(UL(1) << 34)
 #define HCR_ID		(UL(1) << 33)
 #define HCR_CD		(UL(1) << 32)
 #define HCR_RW_SHIFT	31
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 17e92f0..c1f29fe 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -44,6 +44,8 @@ void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
 static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
+	if (is_kernel_in_hyp_mode())
+		vcpu->arch.hcr_el2 |= HCR_E2H;
 	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
 		vcpu->arch.hcr_el2 &= ~HCR_RW;
 }
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index a65e053..ad5821b 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -800,7 +800,8 @@
 .endm
 
 .macro deactivate_traps
-	mov	x2, #HCR_RW
+ifnvhe _S_(mov	x2, #HCR_RW),			_S_(mov	x2, #HCR_RW|HCR_TGE)
+ifnvhe 	nop,					_S_(orr	x2, x2, #HCR_E2H)
 	msr	hcr_el2, x2
 	msr	cptr_el2, xzr
 	msr	hstr_el2, xzr
-- 
2.1.4
