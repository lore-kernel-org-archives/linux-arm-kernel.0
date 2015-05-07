From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu,  7 May 2015 10:07:13 +0100
Subject: [PATCH v3 10/12] KVM: arm64: trap nested debug register access
In-Reply-To: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
References: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1430989647-22501-3-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we are using the hardware registers for guest debug we need to deal
with the guests access to them. There is already a mechanism for dealing
with these accesses so we build on top of that.

  - any access to mdscr_el1 is now stored in the mirror location
  - access to DBG[WB][CV]R continues to go to guest's context

There is one register (MDCCINT_EL1) which guest debug doesn't care about
so this behaves as before.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v3
  - re-factor for better flow and fall through.
  - much simpler with debug_ptr (use the guest area as before)
  - tweak shadow fn to avoid multi-line if

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a44fb32..7aa3b3a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -132,7 +132,13 @@ struct kvm_vcpu_arch {
 	 * here.
 	 */
 
-	/* Guest registers we preserve during guest debugging */
+	/*
+	 * Guest registers we preserve during guest debugging.
+	 *
+	 * These shadow registers are updated by the kvm_handle_sys_reg
+	 * trap handler if the guest accesses or updates them while we
+	 * are using guest debug.
+	 */
 	struct {
 		u32	pstate;
 		u32	mdscr_el1;
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 1ab63dd..dc8bca8 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -50,8 +50,7 @@ static void restore_guest_debug_regs(struct kvm_vcpu *vcpu)
 {
 	*vcpu_cpsr(vcpu) |=
 		(vcpu->arch.guest_debug_state.pstate & SPSR_DEBUG_MASK);
-	vcpu_sys_reg(vcpu, MDSCR_EL1) |=
-		(vcpu->arch.guest_debug_state.mdscr_el1 & MDSCR_EL1_DEBUG_MASK);
+	vcpu_sys_reg(vcpu, MDSCR_EL1) = vcpu->arch.guest_debug_state.mdscr_el1;
 }
 
 /**
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c370b40..95f422f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -196,11 +196,40 @@ static bool trap_dbgauthstatus_el1(struct kvm_vcpu *vcpu,
  * - If the dirty bit is set, save guest registers, restore host
  *   registers and clear the dirty bit. This ensure that the host can
  *   now use the debug registers.
+ *
+ * We also use this mechanism to set-up the debug registers for guest
+ * debugging. If this is the case we want to ensure the guest sees
+ * the right versions of the registers - even if they are not going to
+ * be effective while guest debug is using HW debug.
+ *
  */
+
+static bool shadow_debug_reg(struct kvm_vcpu *vcpu,
+			     const struct sys_reg_params *p,
+			     const struct sys_reg_desc *r)
+{
+	/* MDSCR_EL1 */
+	if (r->reg == MDSCR_EL1) {
+		u32 *shadow_mdscr_el1 = &vcpu->arch.guest_debug_state.mdscr_el1;
+
+		if (p->is_write)
+			*shadow_mdscr_el1 = *vcpu_reg(vcpu, p->Rt);
+		else
+			*vcpu_reg(vcpu, p->Rt) = *shadow_mdscr_el1;
+
+		return true;
+	}
+
+	return false;
+}
+
 static bool trap_debug_regs(struct kvm_vcpu *vcpu,
 			    const struct sys_reg_params *p,
 			    const struct sys_reg_desc *r)
 {
+	if (vcpu->guest_debug && shadow_debug_reg(vcpu, p, r))
+		return true;
+
 	if (p->is_write) {
 		vcpu_sys_reg(vcpu, r->reg) = *vcpu_reg(vcpu, p->Rt);
 		vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
-- 
2.3.5
