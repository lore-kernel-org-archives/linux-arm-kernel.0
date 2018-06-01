From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:34 +0100
Subject: [PATCH 20/33] KVM: arm64: Invoke FPSIMD context switch trap from C
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-21-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

The conversion of the FPSIMD context switch trap code to C has added
some overhead to calling it, due to the need to save registers that
the procedure call standard defines as caller-saved.

So, perhaps it is no longer worth invoking this trap handler quite
so early.

Instead, we can invoke it from fixup_guest_exit(), with little
likelihood of increasing the overhead much further.

As a convenience, this patch gives __hyp_switch_fpsimd() the same
return semantics fixup_guest_exit().  For now there is no
possibility of a spurious FPSIMD trap, so the function always
returns true, but this allows it to be tail-called with a single
return statement.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/entry.S     | 30 ------------------------------
 arch/arm64/kvm/hyp/hyp-entry.S | 19 -------------------
 arch/arm64/kvm/hyp/switch.c    | 15 +++++++++++++--
 3 files changed, 13 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 40f349bc1079..fad1e164fe48 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -166,33 +166,3 @@ abort_guest_exit_end:
 	orr	x0, x0, x5
 1:	ret
 ENDPROC(__guest_exit)
-
-ENTRY(__fpsimd_guest_restore)
-	// x0: esr
-	// x1: vcpu
-	// x2-x29,lr: vcpu regs
-	// vcpu x0-x1 on the stack
-	stp	x2, x3, [sp, #-144]!
-	stp	x4, x5, [sp, #16]
-	stp	x6, x7, [sp, #32]
-	stp	x8, x9, [sp, #48]
-	stp	x10, x11, [sp, #64]
-	stp	x12, x13, [sp, #80]
-	stp	x14, x15, [sp, #96]
-	stp	x16, x17, [sp, #112]
-	stp	x18, lr, [sp, #128]
-
-	bl	__hyp_switch_fpsimd
-
-	ldp	x4, x5, [sp, #16]
-	ldp	x6, x7, [sp, #32]
-	ldp	x8, x9, [sp, #48]
-	ldp	x10, x11, [sp, #64]
-	ldp	x12, x13, [sp, #80]
-	ldp	x14, x15, [sp, #96]
-	ldp	x16, x17, [sp, #112]
-	ldp	x18, lr, [sp, #128]
-	ldp	x0, x1, [sp, #144]
-	ldp	x2, x3, [sp], #160
-	eret
-ENDPROC(__fpsimd_guest_restore)
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index bffece27b5c1..753b9d213651 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -113,25 +113,6 @@ el1_hvc_guest:
 
 el1_trap:
 	get_vcpu_ptr	x1, x0
-
-	mrs		x0, esr_el2
-	lsr		x0, x0, #ESR_ELx_EC_SHIFT
-	/*
-	 * x0: ESR_EC
-	 * x1: vcpu pointer
-	 */
-
-	/*
-	 * We trap the first access to the FP/SIMD to save the host context
-	 * and restore the guest context lazily.
-	 * If FP/SIMD is not implemented, handle the trap and inject an
-	 * undefined instruction exception to the guest.
-	 */
-alternative_if_not ARM64_HAS_NO_FPSIMD
-	cmp	x0, #ESR_ELx_EC_FP_ASIMD
-	b.eq	__fpsimd_guest_restore
-alternative_else_nop_endif
-
 	mov	x0, #ARM_EXCEPTION_TRAP
 	b	__guest_exit
 
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 4fbee9502162..2d45bd719a5d 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -328,8 +328,7 @@ static bool __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
 	}
 }
 
-void __hyp_text __hyp_switch_fpsimd(u64 esr __always_unused,
-				    struct kvm_vcpu *vcpu)
+static bool __hyp_text __hyp_switch_fpsimd(struct kvm_vcpu *vcpu)
 {
 	struct user_fpsimd_state *host_fpsimd = vcpu->arch.host_fpsimd_state;
 
@@ -369,6 +368,8 @@ void __hyp_text __hyp_switch_fpsimd(u64 esr __always_unused,
 			     fpexc32_el2);
 
 	vcpu->arch.flags |= KVM_ARM64_FP_ENABLED;
+
+	return true;
 }
 
 /*
@@ -390,6 +391,16 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (*exit_code != ARM_EXCEPTION_TRAP)
 		goto exit;
 
+	/*
+	 * We trap the first access to the FP/SIMD to save the host context
+	 * and restore the guest context lazily.
+	 * If FP/SIMD is not implemented, handle the trap and inject an
+	 * undefined instruction exception to the guest.
+	 */
+	if (system_supports_fpsimd() &&
+	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_FP_ASIMD)
+		return __hyp_switch_fpsimd(vcpu);
+
 	if (!__populate_fault_info(vcpu))
 		return true;
 
-- 
2.17.1
