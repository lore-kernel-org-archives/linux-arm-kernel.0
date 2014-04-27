From: larry.bassel@linaro.org (Larry Bassel)
Date: Sun, 27 Apr 2014 12:44:14 -0700
Subject: [PATCH 3/3] arm64: enable context tracking
In-Reply-To: <1398627854-9617-1-git-send-email-larry.bassel@linaro.org>
References: <1398627854-9617-1-git-send-email-larry.bassel@linaro.org>
Message-ID: <1398627854-9617-4-git-send-email-larry.bassel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make calls to ct_user_enter when the kernel is exited
and ct_user_exit when the kernel is entered (in el0_da,
el0_ia, el0_svc, el0_irq).

These macros expand to function calls which will only work
properly if el0_sync and related code has been rearranged
(in a previous patch of this series).

The calls to ct_user_exit are made after hw debugging has been
enabled (enable_dbg).

The call to ct_user_enter is made at the end of the kernel_exit
macro.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Larry Bassel <larry.bassel@linaro.org>
---
 arch/arm64/kernel/entry.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 76b09d8..e949435 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -104,6 +104,7 @@
 	.macro	kernel_exit, el, ret = 0
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
+	ct_user_enter
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	.endif
 	.if	\ret
@@ -442,6 +443,7 @@ el0_da:
 	enable_dbg
 	// enable interrupts before calling the main handler
 	enable_irq
+	ct_user_exit
 	mrs	x0, far_el1
 	bic	x0, x0, #(0xff << 56)
 	mov	x1, x25
@@ -457,6 +459,7 @@ el0_ia:
 	enable_dbg
 	// enable interrupts before calling the main handler
 	enable_irq
+	ct_user_exit
 	mrs	x0, far_el1
 	orr	x1, x25, #1 << 24		// use reserved ISS bit for instruction aborts
 	mov	x2, sp
@@ -525,6 +528,7 @@ el0_irq_naked:
 	bl	trace_hardirqs_off
 #endif
 
+	ct_user_exit
 	irq_handler
 	get_thread_info tsk
 
@@ -647,6 +651,7 @@ el0_svc_naked:					// compat entry point
 	isb
 	enable_dbg
 	enable_irq
+	ct_user_exit
 
 	get_thread_info tsk
 	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall tracing
-- 
1.8.3.2
