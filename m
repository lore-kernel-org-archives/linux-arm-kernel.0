From: dustinb@codeaurora.org (Dustin Brown)
Date: Tue, 13 Jun 2017 11:40:56 -0700
Subject: [PATCH 2/2] arm64: Export save_stack_trace_tsk()
In-Reply-To: <20170613184056.23433-1-dustinb@codeaurora.org>
References: <20170613181603.GE4902@n2100.armlinux.org.uk>
 <20170613184056.23433-1-dustinb@codeaurora.org>
Message-ID: <20170613184056.23433-2-dustinb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel watchdog is a great debugging tool for finding tasks that
consume a disproportionate amount of CPU time in contiguous chunks. One
can imagine building a similar watchdog for arbitrary driver threads
using save_stack_trace_tsk() and print_stack_trace(). However, this is
not viable for dynamically loaded driver modules on ARM platforms
because save_stack_trace_tsk() is not exported for those architectures.
Export save_stack_trace_tsk() for the ARM64 architecture to align with
x86 and support various debugging use cases such as arbitrary driver
thread watchdog timers.

Signed-off-by: Dustin Brown <dustinb@codeaurora.org>
---
 arch/arm64/kernel/stacktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index feac80c22f61..09d37d66b630 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -210,6 +210,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 
 	put_task_stack(tsk);
 }
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
 void save_stack_trace(struct stack_trace *trace)
 {
-- 
2.12.2
