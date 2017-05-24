From: james.morse@arm.com (James Morse)
Date: Wed, 24 May 2017 17:58:03 +0100
Subject: [PATCH 6/9] arm64: entry.S: convert el1_sync
In-Reply-To: <20170524165806.29866-1-james.morse@arm.com>
References: <20170524165806.29866-1-james.morse@arm.com>
Message-ID: <20170524165806.29866-7-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

el1_sync unmasks exceptions on a case-by-case basis, debug exceptions
are unmasked, unless this was a debug exception. IRQs are unmasked
for instruction and data aborts only if the interupted context had
irqs unmasked.

Following our 'dai' order, el1_dbg should run with everything masked.
For the other cases we can inherit whatever we interrupted.

Add a macro inherit_daif to set daif based on the interrupted pstate.

Signed-off-by: James Morse <james.morse@arm.com>

---
 arch/arm64/include/asm/assembler.h |  6 ++++++
 arch/arm64/kernel/entry.S          | 21 ++++++---------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index c6a0d956db8a..187d75f6efd3 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -50,6 +50,12 @@
 	msr	daif, \flags
 	.endm
 
+	/* Only on aarch64 pstate, PSR_D_BIT is different for aarch32 */
+	.macro	inherit_daif, pstate:req, tmp:req
+	and	\tmp, \pstate, #(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+	msr	daif, \tmp
+	.endm
+
 /*
  * Enable and disable interrupts.
  */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 5fd3d494916d..714e15b1c135 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -408,8 +408,13 @@ ENDPROC(el1_error_invalid)
 	.align	6
 el1_sync:
 	kernel_entry 1
+	mrs	x0, far_el1
 	mrs	x1, esr_el1			// read the syndrome register
 	lsr	x24, x1, #ESR_ELx_EC_SHIFT	// exception class
+	cmp	x24, #ESR_ELx_EC_BREAKPT_CUR	// debug exception in EL1
+	b.ge	el1_dbg
+
+	inherit_daif	pstate=x23, tmp=x2
 	cmp	x24, #ESR_ELx_EC_DABT_CUR	// data abort in EL1
 	b.eq	el1_da
 	cmp	x24, #ESR_ELx_EC_IABT_CUR	// instruction abort in EL1
@@ -422,8 +427,6 @@ el1_sync:
 	b.eq	el1_sp_pc
 	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL1
 	b.eq	el1_undef
-	cmp	x24, #ESR_ELx_EC_BREAKPT_CUR	// debug exception in EL1
-	b.ge	el1_dbg
 	b	el1_inv
 
 el1_ia:
@@ -434,32 +437,22 @@ el1_da:
 	/*
 	 * Data abort handling
 	 */
-	mrs	x3, far_el1
-	enable_dbg
-	// re-enable interrupts if they were enabled in the aborted context
-	tbnz	x23, #7, 1f			// PSR_I_BIT
-	enable_irq
-1:
+	mov	x3, x0
 	clear_address_tag x0, x3
 	mov	x2, sp				// struct pt_regs
 	bl	do_mem_abort
 
-	// disable interrupts before pulling preserved data off the stack
-	disable_irq
 	kernel_exit 1
 el1_sp_pc:
 	/*
 	 * Stack or PC alignment exception handling
 	 */
-	mrs	x0, far_el1
-	enable_dbg
 	mov	x2, sp
 	b	do_sp_pc_abort
 el1_undef:
 	/*
 	 * Undefined instruction
 	 */
-	enable_dbg
 	mov	x0, sp
 	b	do_undefinstr
 el1_dbg:
@@ -469,13 +462,11 @@ el1_dbg:
 	cmp	x24, #ESR_ELx_EC_BRK64		// if BRK64
 	cinc	x24, x24, eq			// set bit '0'
 	tbz	x24, #0, el1_inv		// EL1 only
-	mrs	x0, far_el1
 	mov	x2, sp				// struct pt_regs
 	bl	do_debug_exception
 	kernel_exit 1
 el1_inv:
 	// TODO: add support for undefined instructions in kernel mode
-	enable_dbg
 	mov	x0, sp
 	mov	x2, x1
 	mov	x1, #BAD_SYNC
-- 
2.11.0
