From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:21:56 +0000
Subject: [PATCH 13/18] arm64: entry: Hook up entry trampoline to exception
 vectors
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1510942921-12564-14-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up the entry trampoline to our exception vectors so that all
exceptions from and returns to EL0 go via the trampoline, which swizzles
the vector base register accordingly. Transitioning to and from the
kernel clobbers x30, so we use tpidrro_el0 and far_el1 as scratch
registers for native tasks.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e98cf3064509..a839b94bba05 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -72,6 +72,16 @@
 
 	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	.if	\el == 0
+	.if	\regsize == 64
+	mrs	x30, tpidrro_el0
+	.else
+	mov	x30, xzr
+	.endif
+	.endif
+#endif
+
 	sub	sp, sp, #S_FRAME_SIZE
 #ifdef CONFIG_VMAP_STACK
 	/*
@@ -118,6 +128,11 @@
 	b	el\()\el\()_\label
 	.endm
 
+	.macro tramp_alias, dst, sym
+	mov_q	\dst, TRAMP_VALIAS
+	add	\dst, \dst, #(\sym - .entry.tramp.text)
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -265,25 +280,39 @@ alternative_else_nop_endif
 2:
 #endif
 
+	msr	elr_el1, x21			// set up the return data
+	msr	spsr_el1, x22
+	ldr	lr, [sp, #S_LR]
+
 	.if	\el == 0
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
+	tbz	x22, #4, 3f
+
 #ifdef CONFIG_ARM64_ERRATUM_845719
 alternative_if ARM64_WORKAROUND_845719
-	tbz	x22, #4, 1f
 #ifdef CONFIG_PID_IN_CONTEXTIDR
 	mrs	x29, contextidr_el1
 	msr	contextidr_el1, x29
 #else
 	msr contextidr_el1, xzr
 #endif
-1:
 alternative_else_nop_endif
 #endif
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	tramp_alias	x30, tramp_exit_compat
+	b	4f
+3:
+	msr	tpidrro_el0, xzr
+	msr	far_el1, x30
+	tramp_alias	x30, tramp_exit_native
+4:
+	prfm	plil1strm, [x30]
+#else
+3:
+#endif
 	.endif
 
-	msr	elr_el1, x21			// set up the return data
-	msr	spsr_el1, x22
 	ldp	x0, x1, [sp, #16 * 0]
 	ldp	x2, x3, [sp, #16 * 1]
 	ldp	x4, x5, [sp, #16 * 2]
@@ -299,9 +328,14 @@ alternative_else_nop_endif
 	ldp	x24, x25, [sp, #16 * 12]
 	ldp	x26, x27, [sp, #16 * 13]
 	ldp	x28, x29, [sp, #16 * 14]
-	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #S_FRAME_SIZE		// restore sp
-	eret					// return to kernel
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	.if	\el == 0
+	br	x30
+	.endif
+#endif
+	eret
 	.endm
 
 	.macro	irq_stack_entry
-- 
2.1.4
