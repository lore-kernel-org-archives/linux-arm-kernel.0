From: dustinb@codeaurora.org (Dustin Brown)
Date: Mon, 28 Aug 2017 13:53:49 -0700
Subject: arm: Export save_stack_trace_tsk()
Message-ID: <001b01d3203f$c04a4e40$40deeac0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel watchdog is a great debugging tool for finding tasks that
consume a disproportionate amount of CPU time in contiguous chunks. One
can imagine building a similar watchdog for arbitrary driver threads
using save_stack_trace_tsk() and print_stack_trace(). However, this is
not viable for dynamically loaded driver modules on ARM platforms
because save_stack_trace_tsk() is not exported for those architectures.
Export save_stack_trace_tsk() for the ARM architecture to align with x86
and support various debugging use cases such as arbitrary driver thread
watchdog timers.

Signed-off-by: Dustin Brown <dustinb@codeaurora.org>
---
arch/arm/kernel/stacktrace.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 3a2fa203637a..564bb468b7ba 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -171,6 +171,7 @@ void save_stack_trace_tsk(struct task_struct *tsk,
struct stack_trace *trace)
{
              __save_stack_trace(tsk, trace, 1);
}
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);

 void save_stack_trace(struct stack_trace *trace)
{
-- 
2.12.2
