From: jintack.lim@linaro.org (Jintack Lim)
Date: Tue, 18 Jul 2017 11:58:37 -0500
Subject: [RFC PATCH v2 11/38] KVM: arm64: Set vcpu context depending on the
 guest exception level
In-Reply-To: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1500397144-16232-12-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the guest exception level is EL2, then set up the shadow context of
the virtual EL2 to hardware. Otherwise, set the regular EL0/EL1 context.

Note that the shadow context content will be prepared in subsequent
patches.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/kvm/context.c | 74 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/context.c b/arch/arm64/kvm/context.c
index bc43e66..2645787 100644
--- a/arch/arm64/kvm/context.c
+++ b/arch/arm64/kvm/context.c
@@ -18,11 +18,29 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_emulate.h>
 
-/**
- * kvm_arm_setup_shadow_state -- prepare shadow state based on emulated mode
- * @vcpu: The VCPU pointer
- */
-void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
+static void flush_shadow_special_regs(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
+
+	ctxt->hw_pstate = *vcpu_cpsr(vcpu) & ~PSR_MODE_MASK;
+	/*
+	 * We can emulate the guest's configuration of which
+	 * stack pointer to use when executing in virtual EL2 by
+	 * using the equivalent feature in EL1 to point to
+	 * either the EL1 or EL0 stack pointer.
+	 */
+	if ((*vcpu_cpsr(vcpu) & PSR_MODE_MASK) == PSR_MODE_EL2h)
+		ctxt->hw_pstate |= PSR_MODE_EL1h;
+	else
+		ctxt->hw_pstate |= PSR_MODE_EL1t;
+
+	ctxt->hw_sys_regs = ctxt->shadow_sys_regs;
+	ctxt->hw_sp_el1 = vcpu_el2_sreg(vcpu, SP_EL2);
+	ctxt->hw_elr_el1 = vcpu_el2_sreg(vcpu, ELR_EL2);
+	ctxt->hw_spsr_el1 = vcpu_el2_sreg(vcpu, SPSR_EL2);
+}
+
+static void flush_special_regs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 
@@ -33,11 +51,18 @@ void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
 	ctxt->hw_spsr_el1 = ctxt->gp_regs.spsr[KVM_SPSR_EL1];
 }
 
-/**
- * kvm_arm_restore_shadow_state -- write back shadow state from guest
- * @vcpu: The VCPU pointer
- */
-void kvm_arm_restore_shadow_state(struct kvm_vcpu *vcpu)
+static void sync_shadow_special_regs(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
+
+	*vcpu_cpsr(vcpu) &= PSR_MODE_MASK;
+	*vcpu_cpsr(vcpu) |= ctxt->hw_pstate & ~PSR_MODE_MASK;
+	vcpu_el2_sreg(vcpu, SP_EL2) = ctxt->hw_sp_el1;
+	vcpu_el2_sreg(vcpu, ELR_EL2) = ctxt->hw_elr_el1;
+	vcpu_el2_sreg(vcpu, SPSR_EL2) = ctxt->hw_spsr_el1;
+}
+
+static void sync_special_regs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
 
@@ -47,6 +72,35 @@ void kvm_arm_restore_shadow_state(struct kvm_vcpu *vcpu)
 	ctxt->gp_regs.spsr[KVM_SPSR_EL1] = ctxt->hw_spsr_el1;
 }
 
+/**
+ * kvm_arm_setup_shadow_state -- prepare shadow state based on emulated mode
+ * @vcpu: The VCPU pointer
+ */
+void kvm_arm_setup_shadow_state(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
+
+	if (unlikely(vcpu_mode_el2(vcpu))) {
+		flush_shadow_special_regs(vcpu);
+		ctxt->hw_sys_regs = ctxt->shadow_sys_regs;
+	} else {
+		flush_special_regs(vcpu);
+		ctxt->hw_sys_regs = ctxt->sys_regs;
+	}
+}
+
+/**
+ * kvm_arm_restore_shadow_state -- write back shadow state from guest
+ * @vcpu: The VCPU pointer
+ */
+void kvm_arm_restore_shadow_state(struct kvm_vcpu *vcpu)
+{
+	if (unlikely(vcpu_mode_el2(vcpu)))
+		sync_shadow_special_regs(vcpu);
+	else
+		sync_special_regs(vcpu);
+}
+
 void kvm_arm_init_cpu_context(kvm_cpu_context_t *cpu_ctxt)
 {
 	/* This is to set hw_sys_regs of host_cpu_context */
-- 
1.9.1
