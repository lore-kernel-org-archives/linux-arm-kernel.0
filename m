From: will.deacon@arm.com (Will Deacon)
Date: Fri,  7 Nov 2014 13:32:22 +0000
Subject: [PATCH 2/2] arm64: entry: use ldp/stp instead of push/pop when
 saving/restoring regs
In-Reply-To: <1415367142-5005-1-git-send-email-will.deacon@arm.com>
References: <1415367142-5005-1-git-send-email-will.deacon@arm.com>
Message-ID: <1415367142-5005-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The push/pop instructions can be suboptimal when saving/restoring large
amounts of data to/from the stack, for example on entry/exit from the
kernel. This is because:

  (1) They act on descending addresses (i.e. the newly decremented sp),
      which may defeat some hardware prefetchers

  (2) They introduce an implicit dependency between each instruction, as
      the sp has to be updated in order to resolve the address of the
      next access.

This patch removes the push/pop instructions from our kernel entry/exit
macros in favour of ldp/stp plus offset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 75 +++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 2cebe56d650c..622a409916f3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -64,25 +64,26 @@
 #define BAD_ERROR	3
 
 	.macro	kernel_entry, el, regsize = 64
-	sub	sp, sp, #S_FRAME_SIZE - S_LR	// room for LR, SP, SPSR, ELR
+	sub	sp, sp, #S_FRAME_SIZE
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
 	.endif
-	push	x28, x29
-	push	x26, x27
-	push	x24, x25
-	push	x22, x23
-	push	x20, x21
-	push	x18, x19
-	push	x16, x17
-	push	x14, x15
-	push	x12, x13
-	push	x10, x11
-	push	x8, x9
-	push	x6, x7
-	push	x4, x5
-	push	x2, x3
-	push	x0, x1
+	stp	x0, x1, [sp, #16 * 0]
+	stp	x2, x3, [sp, #16 * 1]
+	stp	x4, x5, [sp, #16 * 2]
+	stp	x6, x7, [sp, #16 * 3]
+	stp	x8, x9, [sp, #16 * 4]
+	stp	x10, x11, [sp, #16 * 5]
+	stp	x12, x13, [sp, #16 * 6]
+	stp	x14, x15, [sp, #16 * 7]
+	stp	x16, x17, [sp, #16 * 8]
+	stp	x18, x19, [sp, #16 * 9]
+	stp	x20, x21, [sp, #16 * 10]
+	stp	x22, x23, [sp, #16 * 11]
+	stp	x24, x25, [sp, #16 * 12]
+	stp	x26, x27, [sp, #16 * 13]
+	stp	x28, x29, [sp, #16 * 14]
+
 	.if	\el == 0
 	mrs	x21, sp_el0
 	get_thread_info tsk			// Ensure MDSCR_EL1.SS is clear,
@@ -118,33 +119,31 @@
 	.if	\el == 0
 	ct_user_enter
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
+	msr	sp_el0, x23
 	.endif
+	msr	elr_el1, x21			// set up the return data
+	msr	spsr_el1, x22
 	.if	\ret
 	ldr	x1, [sp, #S_X1]			// preserve x0 (syscall return)
-	add	sp, sp, S_X2
 	.else
-	pop	x0, x1
-	.endif
-	pop	x2, x3				// load the rest of the registers
-	pop	x4, x5
-	pop	x6, x7
-	pop	x8, x9
-	msr	elr_el1, x21			// set up the return data
-	msr	spsr_el1, x22
-	.if	\el == 0
-	msr	sp_el0, x23
+	ldp	x0, x1, [sp, #16 * 0]
 	.endif
-	pop	x10, x11
-	pop	x12, x13
-	pop	x14, x15
-	pop	x16, x17
-	pop	x18, x19
-	pop	x20, x21
-	pop	x22, x23
-	pop	x24, x25
-	pop	x26, x27
-	pop	x28, x29
-	ldr	lr, [sp], #S_FRAME_SIZE - S_LR	// load LR and restore SP
+	ldp	x2, x3, [sp, #16 * 1]
+	ldp	x4, x5, [sp, #16 * 2]
+	ldp	x6, x7, [sp, #16 * 3]
+	ldp	x8, x9, [sp, #16 * 4]
+	ldp	x10, x11, [sp, #16 * 5]
+	ldp	x12, x13, [sp, #16 * 6]
+	ldp	x14, x15, [sp, #16 * 7]
+	ldp	x16, x17, [sp, #16 * 8]
+	ldp	x18, x19, [sp, #16 * 9]
+	ldp	x20, x21, [sp, #16 * 10]
+	ldp	x22, x23, [sp, #16 * 11]
+	ldp	x24, x25, [sp, #16 * 12]
+	ldp	x26, x27, [sp, #16 * 13]
+	ldp	x28, x29, [sp, #16 * 14]
+	ldr	lr, [sp, #S_LR]
+	add	sp, sp, #S_FRAME_SIZE		// restore sp
 	eret					// return to kernel
 	.endm
 
-- 
2.1.1
