From: jintack.lim@linaro.org (Jintack Lim)
Date: Tue, 18 Jul 2017 11:58:45 -0500
Subject: [RFC PATCH v2 19/38] KVM: arm64: Trap CPACR_EL1 access in virtual EL2
In-Reply-To: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1500397144-16232-20-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the same reason we trap virtual memory register accesses in virtual
EL2, we trap CPACR_EL1 access too; We allow the virtual EL2 mode to
access EL1 system register state instead of the virtual EL2 one.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 10 +++++++---
 arch/arm64/kvm/sys_regs.c   | 10 +++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index ec91cd08..d513da9 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -42,7 +42,8 @@ bool __hyp_text __fpsimd_enabled(void)
 	return __fpsimd_is_enabled()();
 }
 
-static void __hyp_text __activate_traps_vhe(void)
+static void __hyp_text __activate_traps_vhe(struct kvm_vcpu *vcpu)
+
 {
 	u64 val;
 
@@ -54,12 +55,15 @@ static void __hyp_text __activate_traps_vhe(void)
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
 
@@ -99,7 +103,7 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 	write_sysreg(0, pmselr_el0);
 	write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
 	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
-	__activate_traps_arch()();
+	__activate_traps_arch()(vcpu);
 }
 
 static void __hyp_text __deactivate_traps_vhe(void)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b83fef2..7062645 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -960,6 +960,14 @@ static bool access_vbar(struct kvm_vcpu *vcpu,
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
 /*
  * Architected system registers.
  * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
@@ -1013,7 +1021,7 @@ static bool access_vbar(struct kvm_vcpu *vcpu,
 
 	{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
 	{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
-	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
+	{ SYS_DESC(SYS_CPACR_EL1), access_cpacr, reset_val, CPACR_EL1, 0 },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
-- 
1.9.1
