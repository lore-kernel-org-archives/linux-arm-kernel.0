From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:25 +0800
Subject: [PATCH 4/9] arm64: entry: remove the duplicated code for tracing the
 IRQ flags
In-Reply-To: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
References: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464576750-25160-5-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We record the hardirq flags changes in the entry/exit code now,
So the code becomes duplicated, just remove it.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/kernel/entry.S | 12 ------------
 arch/arm64/mm/fault.c     | 10 ----------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 4c67c56..102fd8b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -428,9 +428,6 @@ ENDPROC(el1_sync)
 el1_irq:
 	kernel_entry 1
 	enable_dbg
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
 
 	get_thread_info tsk
 	irq_handler
@@ -443,9 +440,6 @@ el1_irq:
 	bl	el1_preempt
 1:
 #endif
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_on
-#endif
 	kernel_exit 1
 ENDPROC(el1_irq)
 
@@ -632,16 +626,10 @@ el0_irq:
 	kernel_entry 0
 el0_irq_naked:
 	enable_dbg
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
 
 	ct_user_exit
 	irq_handler
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_on
-#endif
 	b	ret_to_user
 ENDPROC(el0_irq)
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5954881..f94e598 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -603,13 +603,6 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	struct siginfo info;
 	int rv;
 
-	/*
-	 * Tell lockdep we disabled irqs in entry.S. Do nothing if they were
-	 * already disabled to preserve the last enabled/disabled addresses.
-	 */
-	if (interrupts_enabled(regs))
-		trace_hardirqs_off();
-
 	if (!inf->fn(addr, esr, regs)) {
 		rv = 1;
 	} else {
@@ -624,9 +617,6 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 		rv = 0;
 	}
 
-	if (interrupts_enabled(regs))
-		trace_hardirqs_on();
-
 	return rv;
 }
 
-- 
2.5.5
