From: jintack.lim@linaro.org (Jintack Lim)
Date: Tue, 18 Jul 2017 11:58:55 -0500
Subject: [RFC PATCH v2 29/38] KVM: arm64: Support a VM with VHE considering
 EL0 of the VHE host
In-Reply-To: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1500397144-16232-30-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On VHE systems, EL0 of the host kernel is considered as a part of 'VHE
host'; The execution of EL0 is affected by system registers set by the
VHE kernel including the hypervisor. To emulate this for a VM, we use
the same set of system registers (i.e. shadow registers) for the virtual
EL2 and EL0 execution.

Note that the assumption so far is that a hypervisor in a VM always runs
in the virtual EL2, and the exception level change from/to the virtual
EL2 always goes through the host hypervisor. With VHE support for a VM,
however, the exception level can be changed from EL0 to virtual EL2
without trapping to the host hypervisor. So, when returning from the VHE
host mode, set the vcpu mode depending on the physical exception level.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/kvm/context.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/context.c b/arch/arm64/kvm/context.c
index f3d3398..39bd92d 100644
--- a/arch/arm64/kvm/context.c
+++ b/arch/arm64/kvm/context.c
@@ -150,16 +150,18 @@ static void flush_shadow_special_regs(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 
 	ctxt->hw_pstate = *vcpu_cpsr(vcpu) & ~PSR_MODE_MASK;
-	/*
-	 * We can emulate the guest's configuration of which
-	 * stack pointer to use when executing in virtual EL2 by
-	 * using the equivalent feature in EL1 to point to
-	 * either the EL1 or EL0 stack pointer.
-	 */
-	if ((*vcpu_cpsr(vcpu) & PSR_MODE_MASK) == PSR_MODE_EL2h)
-		ctxt->hw_pstate |= PSR_MODE_EL1h;
-	else
-		ctxt->hw_pstate |= PSR_MODE_EL1t;
+	if (vcpu_mode_el2(vcpu)) {
+		/*
+		 * We can emulate the guest's configuration of which
+		 * stack pointer to use when executing in virtual EL2 by
+		 * using the equivalent feature in EL1 to point to
+		 * either the EL1 or EL0 stack pointer.
+		 */
+		if ((*vcpu_cpsr(vcpu) & PSR_MODE_MASK) == PSR_MODE_EL2h)
+			ctxt->hw_pstate |= PSR_MODE_EL1h;
+		else
+			ctxt->hw_pstate |= PSR_MODE_EL1t;
+	}
 
 	ctxt->hw_sys_regs = ctxt->shadow_sys_regs;
 	ctxt->hw_sp_el1 = vcpu_el2_sreg(vcpu, SP_EL2);
@@ -182,8 +184,14 @@ static void sync_shadow_special_regs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 
-	*vcpu_cpsr(vcpu) &= PSR_MODE_MASK;
-	*vcpu_cpsr(vcpu) |= ctxt->hw_pstate & ~PSR_MODE_MASK;
+	*vcpu_cpsr(vcpu) = ctxt->hw_pstate;
+	*vcpu_cpsr(vcpu) &= ~PSR_MODE_MASK;
+	/* Set vcpu exception level depending on the physical EL */
+	if ((ctxt->hw_pstate & PSR_MODE_MASK) == PSR_MODE_EL0t)
+		*vcpu_cpsr(vcpu) |= PSR_MODE_EL0t;
+	else
+		*vcpu_cpsr(vcpu) |= PSR_MODE_EL2h;
+
 	vcpu_el2_sreg(vcpu, SP_EL2) = ctxt->hw_sp_el1;
 	vcpu_el2_sreg(vcpu, ELR_EL2) = ctxt->hw_elr_el1;
 	vcpu_el2_sreg(vcpu, SPSR_EL2) = ctxt->hw_spsr_el1;
@@ -218,7 +226,7 @@ void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 
-	if (unlikely(vcpu_mode_el2(vcpu))) {
+	if (unlikely(is_hyp_ctxt(vcpu))) {
 		flush_shadow_special_regs(vcpu);
 		flush_shadow_el1_sysregs(vcpu);
 		flush_shadow_non_trap_el1_state(vcpu);
@@ -236,7 +244,7 @@ void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
  */
 void kvm_arm_restore_shadow_state(struct kvm_vcpu *vcpu)
 {
-	if (unlikely(vcpu_mode_el2(vcpu))) {
+	if (unlikely(is_hyp_ctxt(vcpu))) {
 		sync_shadow_special_regs(vcpu);
 		sync_shadow_non_trap_el1_state(vcpu);
 	} else
-- 
1.9.1
