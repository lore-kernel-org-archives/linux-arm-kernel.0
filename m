From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 14:56:47 +0100
Subject: [PATCHv5 12/21] arm64: don't reload GPRs after apply_ssbd
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Message-ID: <20180711135656.20670-13-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all of the syscall logic works on the saved pt_regs, apply_ssbd
can safely corrupt x0-x3 in the entry paths, and we no longer need to
restore them. So let's remove the logic doing so.

With that logic gone, we can fold the branch target into the macro, so
that callers need not deal with this. GAS provides \@, which provides a
unique value per macro invocation, which we can use to create a unique
label.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c41b84d06644..22b240da949b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -130,20 +130,21 @@ alternative_else_nop_endif
 
 	// This macro corrupts x0-x3. It is the caller's duty
 	// to save/restore them if required.
-	.macro	apply_ssbd, state, targ, tmp1, tmp2
+	.macro	apply_ssbd, state, tmp1, tmp2
 #ifdef CONFIG_ARM64_SSBD
 alternative_cb	arm64_enable_wa2_handling
-	b	\targ
+	b	.L__asm_ssbd_skip\@
 alternative_cb_end
 	ldr_this_cpu	\tmp2, arm64_ssbd_callback_required, \tmp1
-	cbz	\tmp2, \targ
+	cbz	\tmp2,	.L__asm_ssbd_skip\@
 	ldr	\tmp2, [tsk, #TSK_TI_FLAGS]
-	tbnz	\tmp2, #TIF_SSBD, \targ
+	tbnz	\tmp2, #TIF_SSBD, .L__asm_ssbd_skip\@
 	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
 	mov	w1, #\state
 alternative_cb	arm64_update_smccc_conduit
 	nop					// Patched to SMC/HVC #0
 alternative_cb_end
+.L__asm_ssbd_skip\@:
 #endif
 	.endm
 
@@ -173,13 +174,7 @@ alternative_cb_end
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 
-	apply_ssbd 1, 1f, x22, x23
-
-#ifdef CONFIG_ARM64_SSBD
-	ldp	x0, x1, [sp, #16 * 0]
-	ldp	x2, x3, [sp, #16 * 1]
-#endif
-1:
+	apply_ssbd 1, x22, x23
 
 	mov	x29, xzr			// fp pointed to user-space
 	.else
@@ -321,8 +316,7 @@ alternative_if ARM64_WORKAROUND_845719
 alternative_else_nop_endif
 #endif
 3:
-	apply_ssbd 0, 5f, x0, x1
-5:
+	apply_ssbd 0, x0, x1
 	.endif
 
 	msr	elr_el1, x21			// set up the return data
-- 
2.11.0
