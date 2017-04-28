From: thgarnie@google.com (Thomas Garnier)
Date: Fri, 28 Apr 2017 08:32:12 -0700
Subject: [PATCH v9 3/4] arm/syscalls: Optimize address limit check
In-Reply-To: <20170428153213.137279-1-thgarnie@google.com>
References: <20170428153213.137279-1-thgarnie@google.com>
Message-ID: <20170428153213.137279-3-thgarnie@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the generic address limit check in favor of an architecture
specific optimized implementation.

The address limit is checked on each syscall return path to user-mode
path as well as the irq user-mode return function. If the address limit
was changed, a generic handler is called to stop the kernel on an
explicit check.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
Based on next-20170426
---
 arch/arm/Kconfig               |  1 +
 arch/arm/kernel/entry-common.S | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c1a35f15838..c7322f2bb818 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,6 +1,7 @@
 config ARM
 	bool
 	default y
+	select ADDR_LIMIT_CHECK
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index eb5cd77bf1d8..c83927498f40 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -12,6 +12,7 @@
 #include <asm/unistd.h>
 #include <asm/ftrace.h>
 #include <asm/unwind.h>
+#include <asm/memory.h>
 #ifdef CONFIG_AEABI
 #include <asm/unistd-oabi.h>
 #endif
@@ -27,7 +28,6 @@
 
 #include "entry-header.S"
 
-
 	.align	5
 #if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING))
 /*
@@ -40,9 +40,12 @@ ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	disable_irq_notrace			@ disable interrupts
+	ldr	r2, [tsk, #TI_ADDR_LIMIT]
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
 	bne	fast_work_pending
+	cmp	r2, #TASK_SIZE
+	blne	addr_limit_check_failed
 
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
@@ -66,6 +69,7 @@ ret_fast_syscall:
  UNWIND(.cantunwind	)
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
 	disable_irq_notrace			@ disable interrupts
+	ldr	r2, [tsk, #TI_ADDR_LIMIT]
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
 	beq	no_work_pending
@@ -82,6 +86,7 @@ slow_work_pending:
 	mov	r2, why				@ 'syscall'
 	bl	do_work_pending
 	cmp	r0, #0
+	ldreq   r2, [tsk, #TI_ADDR_LIMIT]
 	beq	no_work_pending
 	movlt	scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
 	ldmia	sp, {r0 - r6}			@ have to reload r0 - r6
@@ -99,9 +104,12 @@ ret_slow_syscall:
 	disable_irq_notrace			@ disable interrupts
 ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
+	ldr	r2, [tsk, #TI_ADDR_LIMIT]
 	tst	r1, #_TIF_WORK_MASK
 	bne	slow_work_pending
 no_work_pending:
+	cmp	r2, #TASK_SIZE
+	blne	addr_limit_check_failed
 	asm_trace_hardirqs_on save = 0
 
 	/* perform architecture specific actions before user return */
-- 
2.13.0.rc0.306.g87b477812d-goog
