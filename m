From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  7 Jan 2015 10:45:03 +0000
Subject: [PATCH] arm64: KVM: Fix HCR setting for 32bit guests
Message-ID: <1420627503-25183-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b856a59141b1 (arm/arm64: KVM: Reset the HCR on each vcpu
when resetting the vcpu) moved the init of the HCR register to
happen later in the init of a vcpu, but left out the fixup
done in kvm_reset_vcpu when preparing for a 32bit guest.

As a result, the 32bit guest is run as a 64bit guest, but the
rest of the kernel still manages it as a 32bit. Fun follows.

Moving the fixup to vcpu_reset_hcr solves the problem for good.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 2 ++
 arch/arm64/kvm/reset.c               | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 8127e45..36dcef6 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -41,6 +41,8 @@ void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
 static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
+	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) 
+		vcpu->arch.hcr_el2 &= ~HCR_RW;
 }
 
 static inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 70a7816..0b43265 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -90,7 +90,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 			if (!cpu_has_32bit_el1())
 				return -EINVAL;
 			cpu_reset = &default_regs_reset32;
-			vcpu->arch.hcr_el2 &= ~HCR_RW;
 		} else {
 			cpu_reset = &default_regs_reset;
 		}
-- 
2.1.4
