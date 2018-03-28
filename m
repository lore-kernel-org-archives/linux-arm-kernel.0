From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Mar 2018 13:51:33 +0100
Subject: [PATCH 04/85] arm64: KVM: Move CPU ID reg trap setup off the world
 switch path
In-Reply-To: <20180328125254.31380-1-marc.zyngier@arm.com>
References: <20180328125254.31380-1-marc.zyngier@arm.com>
Message-ID: <20180328125254.31380-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

The HCR_EL2.TID3 flag needs to be set when trapping guest access to
the CPU ID registers is required.  However, the decision about
whether to set this bit does not need to be repeated at every
switch to the guest.

Instead, it's sufficient to make this decision once and record the
outcome.

This patch moves the decision to vcpu_reset_hcr() and records the
choice made in vcpu->arch.hcr_el2.  The world switch code can then
load this directly when switching to the guest without the need for
conditional logic on the critical path.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Suggested-by: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 8 ++++++++
 arch/arm64/kvm/hyp/switch.c          | 4 ----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 413dc82b1e89..4610bc818097 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -59,6 +59,14 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 
 	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
 		vcpu->arch.hcr_el2 &= ~HCR_RW;
+
+	/*
+	 * TID3: trap feature register accesses that we virtualise.
+	 * For now this is conditional, since no AArch32 feature regs
+	 * are currently virtualised.
+	 */
+	if (vcpu->arch.hcr_el2 & HCR_RW)
+		vcpu->arch.hcr_el2 |= HCR_TID3;
 }
 
 static inline unsigned long vcpu_get_hcr(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 870f4b1587f9..24f52fedfb9e 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -91,10 +91,6 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 		write_sysreg(1 << 30, fpexc32_el2);
 		isb();
 	}
-
-	if (val & HCR_RW) /* for AArch64 only: */
-		val |= HCR_TID3; /* TID3: trap feature register accesses */
-
 	write_sysreg(val, hcr_el2);
 
 	if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN) && (val & HCR_VSE))
-- 
2.14.2
