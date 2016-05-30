From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:22 +0800
Subject: [PATCH 1/9] arm64: entry: use the callee-saved registers to save some
 registers
In-Reply-To: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
References: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464576750-25160-2-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the callee-saved registers x19/x20/scno to save the
x0/x7/x8 which will be used in the syscall path.

This patch makes preparation for the trace code.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/kernel/entry.S | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index d70a9e4..7dcfd49 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -119,6 +119,16 @@
 	.endif
 
 	/*
+	 * Save the x0/x7/x8 in the Callee-saved registers.
+	 * We will use them in the syscall path.
+	 */
+	.if	\el == 0
+	mov	x19, x0
+	mov	x20, x7
+	mov	scno, x8
+	.endif
+
+	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
 	 * x21 - aborted SP
@@ -500,7 +510,7 @@ el0_svc_compat:
 	 * AArch32 syscall handling
 	 */
 	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
-	uxtw	scno, w7			// syscall number in w7 (r7)
+	uxtw	scno, w20			// syscall number in w7 (r7)
 	mov     sc_nr, #__NR_compat_syscalls
 	b	el0_svc_naked
 
@@ -712,10 +722,10 @@ ENDPROC(ret_from_fork)
 	.align	6
 el0_svc:
 	adrp	stbl, sys_call_table		// load syscall table pointer
-	uxtw	scno, w8			// syscall number in w8
+	uxtw	scno, w26			// syscall number in w8
 	mov	sc_nr, #__NR_syscalls
 el0_svc_naked:					// compat entry point
-	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
+	stp	x19, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_dbg_and_irq
 	ct_user_exit 1
 
-- 
2.5.5
