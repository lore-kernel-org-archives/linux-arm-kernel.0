From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Oct 2017 12:41:32 +0200
Subject: [PATCH 28/37] KVM: arm64: Move common VHE/non-VHE trap config in
 separate functions
In-Reply-To: <20171012104141.26902-1-christoffer.dall@linaro.org>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
Message-ID: <20171012104141.26902-29-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are about to be more lazy with some of the trap configuration
register read/writes for VHE systems, move the logic that is currently
shared between VHE and non-VHE into a separate function which can be
called from either the world-switch path or from vcpu_load/vcpu_put.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 70 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 6a12504..c587416 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -23,6 +23,43 @@
 #include <asm/kvm_hyp.h>
 #include <asm/fpsimd.h>
 
+static void __hyp_text __activate_traps_common(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * We are about to set CPTR_EL2.TFP to trap all floating point
+	 * register accesses to EL2, however, the ARM ARM clearly states that
+	 * traps are only taken to EL2 if the operation would not otherwise
+	 * trap to EL1.  Therefore, always make sure that for 32-bit guests,
+	 * we set FPEXC.EN to prevent traps to EL1, when setting the TFP bit.
+	 * If FP/ASIMD is not implemented, FPEXC is UNDEFINED and any access to
+	 * it will cause an exception.
+	 */
+	if (vcpu_el1_is_32bit(vcpu) && system_supports_fpsimd() &&
+	    !vcpu->arch.guest_vfp_loaded) {
+		write_sysreg(1 << 30, fpexc32_el2);
+		isb();
+	}
+	write_sysreg(vcpu->arch.hcr_el2, hcr_el2);
+
+	/* Trap on AArch32 cp15 c15 (impdef sysregs) accesses (EL1 or EL0) */
+	write_sysreg(1 << 15, hstr_el2);
+	/*
+	 * Make sure we trap PMU access from EL0 to EL2. Also sanitize
+	 * PMSELR_EL0 to make sure it never contains the cycle
+	 * counter, which could make a PMXEVCNTR_EL0 access UNDEF at
+	 * EL1 instead of being trapped to EL2.
+	 */
+	write_sysreg(0, pmselr_el0);
+	write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
+	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
+}
+
+static void __hyp_text __deactivate_traps_common(void)
+{
+	write_sysreg(0, hstr_el2);
+	write_sysreg(0, pmuserenr_el0);
+}
+
 static void __hyp_text __activate_traps_vhe(struct kvm_vcpu *vcpu)
 {
 	u64 val;
@@ -57,35 +94,7 @@ static hyp_alternate_select(__activate_traps_arch,
 
 static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 {
-	u64 val;
-
-	/*
-	 * We are about to set CPTR_EL2.TFP to trap all floating point
-	 * register accesses to EL2, however, the ARM ARM clearly states that
-	 * traps are only taken to EL2 if the operation would not otherwise
-	 * trap to EL1.  Therefore, always make sure that for 32-bit guests,
-	 * we set FPEXC.EN to prevent traps to EL1, when setting the TFP bit.
-	 * If FP/ASIMD is not implemented, FPEXC is UNDEFINED and any access to
-	 * it will cause an exception.
-	 */
-	val = vcpu->arch.hcr_el2;
-	if (vcpu_el1_is_32bit(vcpu) && system_supports_fpsimd() &&
-	    !vcpu->arch.guest_vfp_loaded) {
-		write_sysreg(1 << 30, fpexc32_el2);
-		isb();
-	}
-	write_sysreg(val, hcr_el2);
-	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
-	write_sysreg(1 << 15, hstr_el2);
-	/*
-	 * Make sure we trap PMU access from EL0 to EL2. Also sanitize
-	 * PMSELR_EL0 to make sure it never contains the cycle
-	 * counter, which could make a PMXEVCNTR_EL0 access UNDEF at
-	 * EL1 instead of being trapped to EL2.
-	 */
-	write_sysreg(0, pmselr_el0);
-	write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
-	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
+	__activate_traps_common(vcpu);
 	__activate_traps_arch()(vcpu);
 }
 
@@ -131,9 +140,8 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.hcr_el2 & HCR_VSE)
 		vcpu->arch.hcr_el2 = read_sysreg(hcr_el2);
 
+	__deactivate_traps_common();
 	__deactivate_traps_arch()();
-	write_sysreg(0, hstr_el2);
-	write_sysreg(0, pmuserenr_el0);
 }
 
 static inline void __hyp_text __activate_vm(struct kvm_vcpu *vcpu)
-- 
2.9.0
