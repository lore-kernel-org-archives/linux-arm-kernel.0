From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Oct 2017 12:41:34 +0200
Subject: [PATCH 30/37] KVM: arm64: Configure c15, PMU,
 and debug register traps on cpu load/put for VHE
In-Reply-To: <20171012104141.26902-1-christoffer.dall@linaro.org>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
Message-ID: <20171012104141.26902-31-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do not have to change the c15 trap setting on each switch to/from the
guest on VHE systems, because this setting only affects EL0.

The PMU and debug trap configuration can also be done on vcpu load/put
instead, because they don't affect how the host kernel can access the
debug registers while executing KVM kernel code and KVM doesn't use
floating point itself.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 09be10f..13e137e 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -42,8 +42,6 @@ static void __hyp_text __activate_traps_fpsimd32(struct kvm_vcpu *vcpu)
 
 static void __hyp_text __activate_traps_common(struct kvm_vcpu *vcpu)
 {
-	write_sysreg(vcpu->arch.hcr_el2, hcr_el2);
-
 	/* Trap on AArch32 cp15 c15 (impdef sysregs) accesses (EL1 or EL0) */
 	write_sysreg(1 << 15, hstr_el2);
 	/*
@@ -63,12 +61,15 @@ static void __hyp_text __deactivate_traps_common(void)
 	write_sysreg(0, pmuserenr_el0);
 }
 
+/* Activate the traps we can during vcpu_load with VHE */
 void activate_traps_vhe_load(struct kvm_vcpu *vcpu)
 {
 	u64 val;
 
+	/* Make sure 32-bit guests trap VFP */
 	__activate_traps_fpsimd32(vcpu);
 
+	/* Trap VFP accesses on a VHE system */
 	val = read_sysreg(cpacr_el1);
 	val |= CPACR_EL1_TTA;
 	if (vcpu->arch.guest_vfp_loaded)
@@ -76,11 +77,28 @@ void activate_traps_vhe_load(struct kvm_vcpu *vcpu)
 	else
 		val &= ~CPACR_EL1_FPEN;
 	write_sysreg(val, cpacr_el1);
+
+	/* Activate traps on impdef sysregs, PMU, and debug */
+	__activate_traps_common(vcpu);
 }
 
+/* Deactivate the traps we can during vcpu_put with VHE */
 void deactivate_traps_vhe_put(void)
 {
+	u64 mdcr_el2;
+
+	/* Re-enable host VFP access */
 	write_sysreg(CPACR_EL1_FPEN, cpacr_el1);
+
+	/* Re-enable host access to impdef sysregs and the PMU */
+	__deactivate_traps_common();
+
+	/* Re-enable host access to the debug regs */
+	mdcr_el2 = read_sysreg(mdcr_el2);
+	mdcr_el2 &= MDCR_EL2_HPMN_MASK |
+		    MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT |
+		    MDCR_EL2_TPMS;
+	write_sysreg(mdcr_el2, mdcr_el2);
 }
 
 static void __hyp_text __activate_traps_vhe(struct kvm_vcpu *vcpu)
@@ -92,8 +110,13 @@ static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
 {
 	u64 val;
 
+	/* Activate traps on impdef sysregs, PMU, and debug */
+	__activate_traps_common(vcpu);
+
+	/* Make sure 32-bit guests trap VFP */
 	__activate_traps_fpsimd32(vcpu);
 
+	/* Trap VFP accesses on a non-VHE system */
 	val = CPTR_EL2_DEFAULT;
 	val |= CPTR_EL2_TTA;
 	if (vcpu->arch.guest_vfp_loaded)
@@ -109,20 +132,14 @@ static hyp_alternate_select(__activate_traps_arch,
 
 static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 {
-	__activate_traps_common(vcpu);
 	__activate_traps_arch()(vcpu);
+	write_sysreg(vcpu->arch.hcr_el2, hcr_el2);
 }
 
 static void __hyp_text __deactivate_traps_vhe(void)
 {
 	extern char vectors[];	/* kernel exception vectors */
-	u64 mdcr_el2 = read_sysreg(mdcr_el2);
 
-	mdcr_el2 &= MDCR_EL2_HPMN_MASK |
-		    MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT |
-		    MDCR_EL2_TPMS;
-
-	write_sysreg(mdcr_el2, mdcr_el2);
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 	write_sysreg(vectors, vbar_el1);
 }
-- 
2.9.0
