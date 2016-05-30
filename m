From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:23 +0800
Subject: [PATCH 2/9] arm64: entry: add a new macro to restore the registers
 for syscall
In-Reply-To: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
References: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464576750-25160-3-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds restore_syscall_regs to restore the x0~x7 arguments from
the stack.
And this patch also uses this macro to simplify the code.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/kernel/entry.S | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7dcfd49..21b6068 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -32,6 +32,17 @@
 #include <asm/unistd.h>
 
 /*
+ * Use this macro to restore the syscall arguments from the
+ * values already saved on the stack during kernel_entry.
+ */
+	.macro restore_syscall_regs
+	ldp	x0, x1, [sp]
+	ldp	x2, x3, [sp, #S_X2]
+	ldp	x4, x5, [sp, #S_X4]
+	ldp	x6, x7, [sp, #S_X6]
+	.endm
+
+/*
  * Context tracking subsystem.  Used to instrument transitions
  * between user and kernel mode.
  */
@@ -39,14 +50,7 @@
 #ifdef CONFIG_CONTEXT_TRACKING
 	bl	context_tracking_user_exit
 	.if \syscall == 1
-	/*
-	 * Save/restore needed during syscalls.  Restore syscall arguments from
-	 * the values already saved on stack during kernel_entry.
-	 */
-	ldp	x0, x1, [sp]
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
+	restore_syscall_regs
 	.endif
 #endif
 	.endm
@@ -761,10 +765,7 @@ __sys_trace:
 	mov	x1, sp				// pointer to regs
 	cmp	scno, sc_nr			// check upper syscall limit
 	b.hs	__ni_sys_trace
-	ldp	x0, x1, [sp]			// restore the syscall args
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
+	restore_syscall_regs
 	ldr	x16, [stbl, scno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 
-- 
2.5.5
