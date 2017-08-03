From: james.morse@arm.com (James Morse)
Date: Thu,  3 Aug 2017 16:15:33 +0100
Subject: [PATCH 3/3] arm64: entry: Exceptions from single-step should leave
 debug masked
In-Reply-To: <20170803151533.29438-1-james.morse@arm.com>
References: <20170803151533.29438-1-james.morse@arm.com>
Message-ID: <20170803151533.29438-4-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we interrupted an instruction being single-stepped we may end up
taking a single-step exception from the interrupt handler. This
confuses single-step users who are typically just waiting for 'the next'
single step exception before re-enabling {break,watch}points.
Returning from the interrupt causes us to hit the {break,watch}point
again.

For the least-surprising results, lets confine single-step to its
intended context.

>From the ARM-ARM DDI 0487B.a, D.12.5 'Behaviour in the active-not-pending
state's 'If the PE takes an exception' section, we enter the inactive
state because the exception sets PSTATE.D.

D2.12.6 'Entering the active-pending state', from the inactive state, we
re-enter active-pending if we clear PSTATE.D. This causes a debug
single step exception and we we step the exception handler.

Change the EL1 entry.S handlers to inherit their debug state if the
SPSR.SS bit is clear, instead of unconditionally unmasking it.

This bit will be set if we took this exception instead of stepping an
instruction.

This isn't needed for the EL0 entry.S handlers as we will have cleared
MDSCR_EL1.SS on entry from EL0.

Signed-off-by: James Morse <james.morse@arm.com>
CC: Pratyush Anand <panand@redhat.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>

---
 arch/arm64/include/asm/assembler.h | 14 ++++++++++++++
 arch/arm64/kernel/entry.S          | 10 +++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 1c490c578a2e..96f01cc33d0e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -25,6 +25,7 @@
 
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
+#include <asm/debug-monitors.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
@@ -66,6 +67,19 @@
 	msr	daifclr, #8
 	.endm
 
+	/*
+	 * If we interrupted single step from EL1 then we may end up stepping
+	 * the exception handler. Leave debug masked. Otherwise inherit
+	 * the value we interrupted.
+	 */
+	.macro	inherit_dbg, pstate, reg
+	mov_q	\reg, (PSR_D_BIT | DBG_SPSR_SS)
+	and	\reg, \reg, \pstate
+	cbnz	\reg, 9998f
+	enable_dbg
+9998:
+	.endm
+
 	.macro	disable_step_tsk, flgs, tmp
 	tbz	\flgs, #TIF_SINGLESTEP, 9990f
 	mrs	\tmp, mdscr_el1
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index eed2d51e16e6..9788bb47a7f7 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -431,7 +431,7 @@ el1_da:
 	 * Data abort handling
 	 */
 	mrs	x3, far_el1
-	enable_dbg
+	inherit_dbg, pstate=x23 reg=x0
 	// re-enable interrupts if they were enabled in the aborted context
 	tbnz	x23, #7, 1f			// PSR_I_BIT
 	enable_irq
@@ -446,14 +446,14 @@ el1_sp_pc:
 	 * Stack or PC alignment exception handling
 	 */
 	mrs	x0, far_el1
-	enable_dbg
+	inherit_dbg, pstate=x23 reg=x2
 	mov	x2, sp
 	b	do_sp_pc_abort
 el1_undef:
 	/*
 	 * Undefined instruction
 	 */
-	enable_dbg
+	inherit_dbg, pstate=x23 reg=x0
 	mov	x0, sp
 	b	do_undefinstr
 el1_dbg:
@@ -469,7 +469,7 @@ el1_dbg:
 	kernel_exit 1
 el1_inv:
 	// TODO: add support for undefined instructions in kernel mode
-	enable_dbg
+	inherit_dbg, pstate=x23 reg=x0
 	mov	x0, sp
 	mov	x2, x1
 	mov	x1, #BAD_SYNC
@@ -479,7 +479,7 @@ ENDPROC(el1_sync)
 	.align	6
 el1_irq:
 	kernel_entry 1
-	enable_dbg
+	inherit_dbg, pstate=x23 reg=x0
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
-- 
2.13.3
