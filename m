From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 26 Sep 2018 14:56:20 +0100
Subject: [PATCH 3/7] arm64: Align stack when taking exception from EL1
In-Reply-To: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1537970184-44348-4-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arm64 SP needs to be aligned to 16 bytes before being used as base address
for loads and stores. When taking some valid exceptions from EL1 (e.g. irq,
dbg, data abort), there is no guarantee that SP_EL1 was aligned when
taking the exception.

Pad the stack on EL1 entries when misaligned.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm64/include/asm/assembler.h |  9 +++++++++
 arch/arm64/kernel/entry.S          | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98d..a0a5415 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -701,4 +701,13 @@
 .Lyield_out_\@ :
 	.endm
 
+/*
+ * Echange content of register xt with sp.
+ */
+	.macro xchg_sp	xt
+	add	sp, sp, \xt	// sp' = sp + xt
+	sub	\xt, sp, \xt	// xt' = sp' - xt = sp + xt - xt = sp
+	sub	sp, sp, \xt	// sp'' = sp' - xt' = sp + xt - sp = xt
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index fc5842b..8fb66e4 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -59,6 +59,19 @@
 	.endr
 	.endm
 
+	.macro force_stack_align
+	xchg_sp	x0
+	str	x1, [x0] // store x1 far away from S_SP
+
+	// aligned_sp[S_SP] = old_sp
+	bic	x1, x0, #0xf	// align down to 16-byte
+	str	x0, [x1, #S_SP]
+
+	ldr	x1, [x0]
+	bic	x0, x0, #0xf	// x0 = aligned_sp
+	xchg_sp	x0
+	.endm
+
 /*
  * Bad Abort numbers
  *-----------------
@@ -158,6 +171,10 @@ alternative_cb_end
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
 	.endif
+	.if	\el != 0
+	force_stack_align
+	.endif
+
 	stp	x0, x1, [sp, #16 * 0]
 	stp	x2, x3, [sp, #16 * 1]
 	stp	x4, x5, [sp, #16 * 2]
@@ -184,7 +201,8 @@ alternative_cb_end
 	apply_ssbd 1, x22, x23
 
 	.else
-	add	x21, sp, #S_FRAME_SIZE
+	ldr	x21, [sp, #S_SP]
+	add	x21, x21, #S_FRAME_SIZE		// adjust stored sp
 	get_thread_info tsk
 	/* Save the task's original addr_limit and set USER_DS */
 	ldr	x20, [tsk, #TSK_TI_ADDR_LIMIT]
@@ -327,7 +345,6 @@ alternative_else_nop_endif
 
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
-	ldp	x0, x1, [sp, #16 * 0]
 	ldp	x2, x3, [sp, #16 * 1]
 	ldp	x4, x5, [sp, #16 * 2]
 	ldp	x6, x7, [sp, #16 * 3]
@@ -343,7 +360,18 @@ alternative_else_nop_endif
 	ldp	x26, x27, [sp, #16 * 13]
 	ldp	x28, x29, [sp, #16 * 14]
 	ldr	lr, [sp, #S_LR]
+
+	/* Restore x0, x1 and sp */
+	.if	\el != 0
+	mov	x1, sp
+	ldr	x0, [sp, #S_SP]
+	mov	sp, x0
+	ldp	x0, x1, [x1, #16 * 0]
+	.else
+	ldp	x0, x1, [sp, #16 * 0]
 	add	sp, sp, #S_FRAME_SIZE		// restore sp
+	.endif
+
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on eret context synchronization
 	 * when returning from IPI handler, and when returning to user-space.
-- 
1.9.1
