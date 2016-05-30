From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:27 +0800
Subject: [PATCH 6/9] arm64: entry: adjust el1_sync so that a function can be
 called
In-Reply-To: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
References: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464576750-25160-7-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To implement the hardirq flag tracing properly on arm64,
the trace_hardirqs_on() should be called before interrupts are turned on.
But the trace_hardirqs_on() may clobber the registers, such as x0 ~ 18.

Just as the el0_sync does, this patch uses the callee-saved registers:
   1.) uses x25 to save the esr_el1,
   2.) uses the x26 to save the far_el1.

And copy x25/x26 back to x1/x0 in the proper places, such as
el1_da/el1_dbg/el1_sp_pc.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/kernel/entry.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 98d8dd1..63bf7ad 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -355,8 +355,8 @@ ENDPROC(el1_error_invalid)
 	.align	6
 el1_sync:
 	kernel_entry 1
-	mrs	x1, esr_el1			// read the syndrome register
-	lsr	x24, x1, #ESR_ELx_EC_SHIFT	// exception class
+	mrs	x25, esr_el1			// read the syndrome register
+	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
 	cmp	x24, #ESR_ELx_EC_DABT_CUR	// data abort in EL1
 	b.eq	el1_da
 	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
@@ -374,12 +374,14 @@ el1_da:
 	/*
 	 * Data abort handling
 	 */
-	mrs	x0, far_el1
+	mrs	x26, far_el1
 	enable_dbg
 	// re-enable interrupts if they were enabled in the aborted context
 	tbnz	x23, #7, 1f			// PSR_I_BIT
 	enable_irq
 1:
+	mov	x0, x26
+	mov	x1, x25
 	mov	x2, sp				// struct pt_regs
 	bl	do_mem_abort
 
@@ -392,6 +394,7 @@ el1_sp_pc:
 	 */
 	mrs	x0, far_el1
 	enable_dbg
+	mov	x1, x25
 	mov	x2, sp
 	b	do_sp_pc_abort
 el1_undef:
@@ -409,6 +412,7 @@ el1_dbg:
 	cinc	x24, x24, eq			// set bit '0'
 	tbz	x24, #0, el1_inv		// EL1 only
 	mrs	x0, far_el1
+	mov	x1, x25
 	mov	x2, sp				// struct pt_regs
 	bl	do_debug_exception
 	kernel_exit 1
-- 
2.5.5
