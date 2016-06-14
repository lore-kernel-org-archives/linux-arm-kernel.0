From: labbott@redhat.com (Laura Abbott)
Date: Tue, 14 Jun 2016 11:00:35 -0700
Subject: [PATCHv2] arm64: Handle el1 synchronous instruction aborts cleanly
Message-ID: <1465927235-8163-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Executing from a non-executable area gives an ugly message:

lkdtm: Performing direct entry EXEC_RODATA
lkdtm: attempting ok execution at ffff0000084c0e08
lkdtm: attempting bad execution at ffff000008880700
Bad mode in Synchronous Abort handler detected on CPU2, code 0x8400000e -- IABT (current EL)
CPU: 2 PID: 998 Comm: sh Not tainted 4.7.0-rc2+ #13
Hardware name: linux,dummy-virt (DT)
task: ffff800077e35780 ti: ffff800077970000 task.ti: ffff800077970000
PC is at lkdtm_rodata_do_nothing+0x0/0x8
LR is at execute_location+0x74/0x88

The 'IABT (current EL)' indicates the error but it's a bit cryptic
without knowledge of the ARM ARM. There is also no indication of the
specific address which triggered the fault. The increase in kernel
page permissions makes hitting this case more likely as well.
Handling the case in the vectors gives a much more familiar looking
error message:

lkdtm: Performing direct entry EXEC_RODATA
lkdtm: attempting ok execution at ffff0000084c0840
lkdtm: attempting bad execution at ffff000008880680
Unable to handle kernel paging request at virtual address ffff000008880680
pgd = ffff8000089b2000
[ffff000008880680] *pgd=00000000489b4003, *pud=0000000048904003, *pmd=0000000000000000
Internal error: Oops: 8400000e [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 997 Comm: sh Not tainted 4.7.0-rc1+ #24
Hardware name: linux,dummy-virt (DT)
task: ffff800077f9f080 ti: ffff800008a1c000 task.ti: ffff800008a1c000
PC is at lkdtm_rodata_do_nothing+0x0/0x8
LR is at execute_location+0x74/0x88

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Clarified the messages we got a bit. Verified this applies cleanly
on top of Mark Rutland's kill-esr-lnx-exec series
---
 arch/arm64/kernel/entry.S | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index eefffa8..6c6cec9 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -336,6 +336,8 @@ el1_sync:
 	lsr	x24, x1, #ESR_ELx_EC_SHIFT	// exception class
 	cmp	x24, #ESR_ELx_EC_DABT_CUR	// data abort in EL1
 	b.eq	el1_da
+	cmp	x24, #ESR_ELx_EC_IABT_CUR	// instruction abort in EL1
+	b.eq	el1_ia
 	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
 	b.eq	el1_undef
 	cmp	x24, #ESR_ELx_EC_SP_ALIGN	// stack alignment exception
@@ -347,6 +349,23 @@ el1_sync:
 	cmp	x24, #ESR_ELx_EC_BREAKPT_CUR	// debug exception in EL1
 	b.ge	el1_dbg
 	b	el1_inv
+el1_ia:
+	/*
+	 * Instruction abort handling
+	 */
+	mrs	x0, far_el1
+	enable_dbg
+	// re-enable interrupts if they were enabled in the aborted context
+	tbnz	x23, #7, 1f			// PSR_I_BIT
+	enable_irq
+	orr	x1, x1, #1 << 24		// use reserved ISS bit for instruction aborts
+1:
+	mov	x2, sp				// struct pt_regs
+	bl	do_mem_abort
+
+	// disable interrupts before pulling preserved data off the stack
+	disable_irq
+	kernel_exit 1
 el1_da:
 	/*
 	 * Data abort handling
-- 
2.5.5
