From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:20 -0500
Subject: [RFC 24/55] KVM: arm64: Forward FP exceptions to the guest hypervisor
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-25-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward exceptions due to floating-point register accesses to the guest
hypervisor if it has set CPTR_EL2.TFP bit.

Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/include/asm/kvm_nested.h |  1 +
 arch/arm64/kernel/asm-offsets.c     |  1 +
 arch/arm64/kvm/handle_exit.c        |  3 +++
 arch/arm64/kvm/handle_exit_nested.c |  6 ++++++
 arch/arm64/kvm/hyp/entry.S          | 14 ++++++++++++++
 arch/arm64/kvm/hyp/hyp-entry.S      |  2 +-
 6 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 8d36935..54c5ce5 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -3,4 +3,5 @@
 
 int handle_hvc_nested(struct kvm_vcpu *vcpu);
 int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe);
+int kvm_handle_fp_asimd(struct kvm_vcpu *vcpu, struct kvm_run *run);
 #endif
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 4a2f0f0..b635f1a 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -131,6 +131,7 @@ int main(void)
   DEFINE(CPU_FP_REGS,		offsetof(struct kvm_regs, fp_regs));
   DEFINE(VCPU_FPEXC32_EL2,	offsetof(struct kvm_vcpu, arch.ctxt.sys_regs[FPEXC32_EL2]));
   DEFINE(VCPU_HOST_CONTEXT,	offsetof(struct kvm_vcpu, arch.host_cpu_context));
+  DEFINE(VIRTUAL_CPTR_EL2,	offsetof(struct kvm_vcpu, arch.ctxt.el2_regs[CPTR_EL2]));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_SUSPEND_SZ,	sizeof(struct cpu_suspend_ctx));
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 046fdf8..308f5c5 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -195,6 +195,9 @@ static int kvm_handle_eret(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	[ESR_ELx_EC_BREAKPT_LOW]= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BKPT32]	= kvm_handle_guest_debug,
 	[ESR_ELx_EC_BRK64]	= kvm_handle_guest_debug,
+#ifdef CONFIG_KVM_ARM_NESTED_HYP
+	[ESR_ELx_EC_FP_ASIMD]	= kvm_handle_fp_asimd,
+#endif
 };
 
 static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/handle_exit_nested.c b/arch/arm64/kvm/handle_exit_nested.c
index 871ecfc..7544c6d 100644
--- a/arch/arm64/kvm/handle_exit_nested.c
+++ b/arch/arm64/kvm/handle_exit_nested.c
@@ -43,3 +43,9 @@ int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe)
 
 	return -EINVAL;
 }
+
+/* This is only called when virtual CPTR_EL2.TFP bit is set. */
+int kvm_handle_fp_asimd(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
+}
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 12ee62d..a76f102 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -158,6 +158,20 @@ abort_guest_exit_end:
 1:	ret
 ENDPROC(__guest_exit)
 
+ENTRY(__fpsimd_guest_trap)
+#ifdef CONFIG_KVM_ARM_NESTED_HYP
+// If virtual CPTR_EL2.TFP is set, then foward it to the nested hyp.
+	mrs	x1, tpidr_el2
+	ldr	x0, [x1, #VIRTUAL_CPTR_EL2]
+	and 	x0, x0, #CPTR_EL2_TFP
+	cbnz	x0, 1f
+#endif
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
index 4e92399..d83494b 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -108,7 +108,7 @@ el1_trap:
 
 	/* Guest accessed VFP/SIMD registers, save host, restore Guest */
 	cmp	x0, #ESR_ELx_EC_FP_ASIMD
-	b.eq	__fpsimd_guest_restore
+	b.eq	__fpsimd_guest_trap
 
 	mrs	x1, tpidr_el2
 	mov	x0, #ARM_EXCEPTION_TRAP
-- 
1.9.1
