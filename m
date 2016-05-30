From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:24 +0800
Subject: [PATCH 3/9] arm64: entry: record the hardirq changes on the
 entry/exit code
In-Reply-To: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
References: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464576750-25160-4-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just as the arm32 code does, record the hardirq changes at the entry/exit
code.

The trace code may changes some registers, but the syscall path
needs the x0 ~ x7, we restore them in the el0_svc_naked.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/kernel/entry.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 21b6068..4c67c56 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -132,6 +132,15 @@
 	mov	scno, x8
 	.endif
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/*
+	 * The trace_hardirqs_off may changes some registers, so we should
+	 * restore them back from the stack in the necessary place, such as
+	 * el0_svc_naked.
+	 */
+	bl	trace_hardirqs_off
+#endif
+
 	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
@@ -142,6 +151,9 @@
 	.endm
 
 	.macro	kernel_exit, el
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_on
+#endif
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
 	ct_user_enter
@@ -729,6 +741,9 @@ el0_svc:
 	uxtw	scno, w26			// syscall number in w8
 	mov	sc_nr, #__NR_syscalls
 el0_svc_naked:					// compat entry point
+#ifdef CONFIG_TRACE_IRQFLAGS
+	restore_syscall_regs
+#endif
 	stp	x19, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_dbg_and_irq
 	ct_user_exit 1
-- 
2.5.5
