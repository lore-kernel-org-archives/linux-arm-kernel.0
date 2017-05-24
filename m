From: james.morse@arm.com (James Morse)
Date: Wed, 24 May 2017 17:58:04 +0100
Subject: [PATCH 7/9] arm64: entry.S convert el0_sync
In-Reply-To: <20170524165806.29866-1-james.morse@arm.com>
References: <20170524165806.29866-1-james.morse@arm.com>
Message-ID: <20170524165806.29866-8-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

el0_sync also unmasks exceptions on a case-by-case basis, debug exceptions
are unmasked, unless this was a debug exception. Irqs are unmasked for
some exception types but not for others.

el0_dbg should run with everything masked, for the other cases we can
unmask everything. This changes the behaviour of fpsimd_{acc,exc} and
el0_inv, which previously ran with irqs masked.

All of these exception types call ct_user_exit after unmasking interrupts.
Move this into the switch statement. el0_dbg needs to do this itself once
it has finished its work, el0_svc needs to pass a flag to restore the
syscall args.

This patch removed the last user of enable_dbg_and_irq, remove it.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h |  9 --------
 arch/arm64/kernel/entry.S          | 46 +++++++++++++-------------------------
 2 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 187d75f6efd3..f09934ddc13b 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -99,15 +99,6 @@
 	.endm
 
 /*
- * Enable both debug exceptions and interrupts. This is likely to be
- * faster than two daifclr operations, since writes to this register
- * are self-synchronising.
- */
-	.macro	enable_dbg_and_irq
-	msr	daifclr, #(8 | 2)
-	.endm
-
-/*
  * SMP data memory barrier
  */
 	.macro	smp_dmb, opt
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 714e15b1c135..d0befb45aa8f 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -513,9 +513,16 @@ el1_preempt:
 el0_sync:
 	kernel_entry 0
 	mrs	x25, esr_el1			// read the syndrome register
+	mrs	x26, far_el1
 	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
+	cmp	x24, #ESR_ELx_EC_BREAKPT_LOW	// debug exception in EL0
+	b.ge	el0_dbg
+
+	enable_daif
 	cmp	x24, #ESR_ELx_EC_SVC64		// SVC in 64-bit state
 	b.eq	el0_svc
+
+	ct_user_exit
 	cmp	x24, #ESR_ELx_EC_DABT_LOW	// data abort in EL0
 	b.eq	el0_da
 	cmp	x24, #ESR_ELx_EC_IABT_LOW	// instruction abort in EL0
@@ -532,8 +539,6 @@ el0_sync:
 	b.eq	el0_sp_pc
 	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL0
 	b.eq	el0_undef
-	cmp	x24, #ESR_ELx_EC_BREAKPT_LOW	// debug exception in EL0
-	b.ge	el0_dbg
 	b	el0_inv
 
 #ifdef CONFIG_COMPAT
@@ -541,9 +546,16 @@ el0_sync:
 el0_sync_compat:
 	kernel_entry 0, 32
 	mrs	x25, esr_el1			// read the syndrome register
+	mrs	x26, far_el1
 	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
+	cmp	x24, #ESR_ELx_EC_BREAKPT_LOW	// debug exception in EL0
+	b.ge	el0_dbg
+
+	enable_daif
 	cmp	x24, #ESR_ELx_EC_SVC32		// SVC in 32-bit state
 	b.eq	el0_svc_compat
+
+	ct_user_exit
 	cmp	x24, #ESR_ELx_EC_DABT_LOW	// data abort in EL0
 	b.eq	el0_da
 	cmp	x24, #ESR_ELx_EC_IABT_LOW	// instruction abort in EL0
@@ -566,8 +578,6 @@ el0_sync_compat:
 	b.eq	el0_undef
 	cmp	x24, #ESR_ELx_EC_CP14_64	// CP14 MRRC/MCRR trap
 	b.eq	el0_undef
-	cmp	x24, #ESR_ELx_EC_BREAKPT_LOW	// debug exception in EL0
-	b.ge	el0_dbg
 	b	el0_inv
 el0_svc_compat:
 	/*
@@ -588,10 +598,6 @@ el0_da:
 	/*
 	 * Data abort handling
 	 */
-	mrs	x26, far_el1
-	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
-	ct_user_exit
 	clear_address_tag x0, x26
 	mov	x1, x25
 	mov	x2, sp
@@ -601,10 +607,6 @@ el0_ia:
 	/*
 	 * Instruction abort handling
 	 */
-	mrs	x26, far_el1
-	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
-	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
 	mov	x2, sp
@@ -614,8 +616,6 @@ el0_fpsimd_acc:
 	/*
 	 * Floating Point or Advanced SIMD access
 	 */
-	enable_dbg
-	ct_user_exit
 	mov	x0, x25
 	mov	x1, sp
 	bl	do_fpsimd_acc
@@ -624,8 +624,6 @@ el0_fpsimd_exc:
 	/*
 	 * Floating Point or Advanced SIMD exception
 	 */
-	enable_dbg
-	ct_user_exit
 	mov	x0, x25
 	mov	x1, sp
 	bl	do_fpsimd_exc
@@ -634,10 +632,6 @@ el0_sp_pc:
 	/*
 	 * Stack or PC alignment exception handling
 	 */
-	mrs	x26, far_el1
-	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
-	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
 	mov	x2, sp
@@ -647,9 +641,6 @@ el0_undef:
 	/*
 	 * Undefined instruction
 	 */
-	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
-	ct_user_exit
 	mov	x0, sp
 	bl	do_undefinstr
 	b	ret_to_user
@@ -657,8 +648,6 @@ el0_sys:
 	/*
 	 * System instructions, for trapped cache maintenance instructions
 	 */
-	enable_dbg_and_irq
-	ct_user_exit
 	mov	x0, x25
 	mov	x1, sp
 	bl	do_sysinstr
@@ -668,16 +657,14 @@ el0_dbg:
 	 * Debug exception handling
 	 */
 	tbnz	x24, #0, el0_inv		// EL0 only
-	mrs	x0, far_el1
+	mov	x0, x26
 	mov	x1, x25
 	mov	x2, sp
 	bl	do_debug_exception
-	enable_dbg
+	enable_daif
 	ct_user_exit
 	b	ret_to_user
 el0_inv:
-	enable_dbg
-	ct_user_exit
 	mov	x0, sp
 	mov	x1, #BAD_SYNC
 	mov	x2, x25
@@ -796,7 +783,6 @@ el0_svc:
 	mov	sc_nr, #__NR_syscalls
 el0_svc_naked:					// compat entry point
 	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
-	enable_dbg_and_irq
 	ct_user_exit 1
 
 	ldr	x16, [tsk, #TSK_TI_FLAGS]	// check for syscall hooks
-- 
2.11.0
