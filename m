From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:15 -0500
Subject: [RFC 19/55] KVM: arm64: Trap CPACR_EL1 access in virtual EL2
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-20-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the same reason we trap virtual memory register accesses in virtual
EL2, we trap CPACR_EL1 access too. Basically, we don't want the guest
hypervisor to access the real CPACR_EL1, which is used to emulate
virtual EL2. Instead, we want it to access virtual CPACR_EL1 which is
used to run software in EL0/EL1 from the guest hypervisor's perspective.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/hyp/switch.c | 10 +++++++---
 arch/arm64/kvm/sys_regs.c   | 10 +++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index c05c48f..b7c8c30 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -41,7 +41,8 @@ bool __hyp_text __fpsimd_enabled(void)
 	return __fpsimd_is_enabled()();
 }
 
-static void __hyp_text __activate_traps_vhe(void)
+static void __hyp_text __activate_traps_vhe(struct kvm_vcpu *vcpu)
+
 {
 	u64 val;
 
@@ -53,12 +54,15 @@ static void __hyp_text __activate_traps_vhe(void)
 	write_sysreg(__kvm_hyp_vector, vbar_el1);
 }
 
-static void __hyp_text __activate_traps_nvhe(void)
+static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
+
 {
 	u64 val;
 
 	val = CPTR_EL2_DEFAULT;
 	val |= CPTR_EL2_TTA | CPTR_EL2_TFP;
+	if (vcpu_mode_el2(vcpu))
+		val |= CPTR_EL2_TCPAC;
 	write_sysreg(val, cptr_el2);
 }
 
@@ -90,7 +94,7 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 	/* Make sure we trap PMU access from EL0 to EL2 */
 	write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
 	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
-	__activate_traps_arch()();
+	__activate_traps_arch()(vcpu);
 }
 
 static void __hyp_text __deactivate_traps_vhe(void)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 59f9cc6..321ecbc 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -947,6 +947,14 @@ static bool access_vbar(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool access_cpacr(struct kvm_vcpu *vcpu,
+		struct sys_reg_params *p,
+		const struct sys_reg_desc *r)
+{
+	access_rw(p, &vcpu_sys_reg(vcpu, r->reg));
+	return true;
+}
+
 static bool trap_el2_reg(struct kvm_vcpu *vcpu,
 			 struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
@@ -1051,7 +1059,7 @@ static bool trap_el2_reg(struct kvm_vcpu *vcpu,
 	  access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
 	/* CPACR_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b010),
-	  NULL, reset_val, CPACR_EL1, 0 },
+	  access_cpacr, reset_val, CPACR_EL1, 0 },
 	/* TTBR0_EL1 */
 	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b000),
 	  access_vm_reg, reset_unknown, TTBR0_EL1 },
-- 
1.9.1
