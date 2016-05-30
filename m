From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:26 +0800
Subject: [PATCH 5/9] arm64: entry: only restore the syscall registers once
In-Reply-To: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
References: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464576750-25160-6-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two pachs which will restore the syscall registers (x0 - x7)
separately: the hardirq trace code and the context tracking code.

This patch makes the code to restore the syscall registers only once.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/kernel/entry.S | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 102fd8b..98d8dd1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -46,12 +46,9 @@
  * Context tracking subsystem.  Used to instrument transitions
  * between user and kernel mode.
  */
-	.macro ct_user_exit, syscall = 0
+	.macro ct_user_exit
 #ifdef CONFIG_CONTEXT_TRACKING
 	bl	context_tracking_user_exit
-	.if \syscall == 1
-	restore_syscall_regs
-	.endif
 #endif
 	.endm
 
@@ -729,12 +726,12 @@ el0_svc:
 	uxtw	scno, w26			// syscall number in w8
 	mov	sc_nr, #__NR_syscalls
 el0_svc_naked:					// compat entry point
-#ifdef CONFIG_TRACE_IRQFLAGS
-	restore_syscall_regs
-#endif
 	stp	x19, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_dbg_and_irq
-	ct_user_exit 1
+	ct_user_exit
+#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING)
+	restore_syscall_regs
+#endif
 
 	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall hooks
 	tst	x16, #_TIF_SYSCALL_WORK
-- 
2.5.5
