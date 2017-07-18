From: jintack.lim@linaro.org (Jintack Lim)
Date: Tue, 18 Jul 2017 11:58:51 -0500
Subject: [RFC PATCH v2 25/38] KVM: arm64: Respect virtual CPTR_EL2.TFP setting
In-Reply-To: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
Message-ID: <1500397144-16232-26-git-send-email-jintack.lim@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward traps due to FP/ASIMD register accesses to the virtual EL2 if
virtual CPTR_EL2.TFP is set. Note that if TFP bit is set, then even
accesses to FP/ASIMD register from EL2 as well as NS EL0/1 will trap to
EL2. So, we don't check the VM's exception level.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
---
 arch/arm64/kernel/asm-offsets.c |  1 +
 arch/arm64/kvm/handle_exit.c    | 15 +++++++++++----
 arch/arm64/kvm/hyp/entry.S      | 13 +++++++++++++
 arch/arm64/kvm/hyp/hyp-entry.S  |  2 +-
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index b3bb7ef..f5117a3 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -134,6 +134,7 @@ int main(void)
   DEFINE(CPU_FP_REGS,		offsetof(struct kvm_regs, fp_regs));
   DEFINE(VCPU_FPEXC32_EL2,	offsetof(struct kvm_vcpu, arch.ctxt.sys_regs[FPEXC32_EL2]));
   DEFINE(VCPU_HOST_CONTEXT,	offsetof(struct kvm_vcpu, arch.host_cpu_context));
+  DEFINE(VIRTUAL_CPTR_EL2,	offsetof(struct kvm_vcpu, arch.ctxt.sys_regs[CPTR_EL2]));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_SUSPEND_SZ,	sizeof(struct cpu_suspend_ctx));
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 25ec824..d4e7b2b 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -84,11 +84,18 @@ static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 }
 
 /*
- * Guest access to FP/ASIMD registers are routed to this handler only
- * when the system doesn't support FP/ASIMD.
+ * When the system supports FP/ASMID and we are NOT running nested
+ * virtualization, FP/ASMID traps are handled in EL2 directly.
+ * This handler handles the cases those are not belong to the above case.
  */
-static int handle_no_fpsimd(struct kvm_vcpu *vcpu, struct kvm_run *run)
+static int kvm_handle_fpasimd(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
+
+	/* This is for nested virtualization */
+	if (vcpu_sys_reg(vcpu, CPTR_EL2) & CPTR_EL2_TFP)
+		return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
+
+	/* This is the case when the system doesn't support FP/ASIMD. */
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
@@ -220,7 +227,7 @@ static int kvm_handle_eret(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	[ESR_ELx_EC_BREAKPT_LOW]= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BKPT32]	= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BRK64]	= kvm_handle_guest_debug,
-	[ESR_ELx_EC_FP_ASIMD]	= handle_no_fpsimd,
+	[ESR_ELx_EC_FP_ASIMD]	= kvm_handle_fpasimd,
 };
 
 static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 12ee62d..95af673 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -158,6 +158,19 @@ abort_guest_exit_end:
 1:	ret
 ENDPROC(__guest_exit)
 
+ENTRY(__fpsimd_guest_trap)
+	// If virtual CPTR_EL2.TFP is set, then forward the trap to the
+	// virtual EL2. For the non-nested case, this bit is always 0.
+	mrs	x1, tpidr_el2
+	ldr	x0, [x1, #VIRTUAL_CPTR_EL2]
+	and 	x0, x0, #CPTR_EL2_TFP
+	cbnz	x0, 1f
+	b	__fpsimd_guest_restore
+1:
+	mov	x0, #ARM_EXCEPTION_TRAP
+	b	__guest_exit
+ENDPROC(__fpsimd_guest_trap)
+
 ENTRY(__fpsimd_guest_restore)
 	stp	x2, x3, [sp, #-16]!
 	stp	x4, lr, [sp, #-16]!
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 5170ce1..ab169fd 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -113,7 +113,7 @@ el1_trap:
 	 */
 alternative_if_not ARM64_HAS_NO_FPSIMD
 	cmp	x0, #ESR_ELx_EC_FP_ASIMD
-	b.eq	__fpsimd_guest_restore
+	b.eq	__fpsimd_guest_trap
 alternative_else_nop_endif
 
 	mrs	x1, tpidr_el2
-- 
1.9.1
