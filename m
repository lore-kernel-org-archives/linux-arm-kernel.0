From: toddpoynor@google.com (Todd Poynor)
Date: Mon, 15 Nov 2010 14:53:19 -0800
Subject: [PATCH] ARM: Stop irqsoff trace on return to user
Message-ID: <1289861599-26494-1-git-send-email-toddpoynor@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the irqsoff tracer is in use, stop tracing the interrupt disable
interval when returning to userspace.  Tracing userspace execution
time as interrupts disabled time is not helpful for kernel
performance analysis purposes.  Only do so if the irqsoff tracer
is enabled, to avoid overhead purely for lockdep, which doesn't
care.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/kernel/entry-common.S |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 8bfa987..80bf8cd 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -29,6 +29,9 @@ ret_fast_syscall:
 	ldr	r1, [tsk, #TI_FLAGS]
 	tst	r1, #_TIF_WORK_MASK
 	bne	fast_work_pending
+#if defined(CONFIG_IRQSOFF_TRACER)
+	asm_trace_hardirqs_on
+#endif
 
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
@@ -65,6 +68,9 @@ ret_slow_syscall:
 	tst	r1, #_TIF_WORK_MASK
 	bne	work_pending
 no_work_pending:
+#if defined(CONFIG_IRQSOFF_TRACER)
+	asm_trace_hardirqs_on
+#endif
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
 
-- 
1.7.3.1
