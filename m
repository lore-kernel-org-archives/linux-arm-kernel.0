From: dustinb@codeaurora.org (Dustin Brown)
Date: Wed, 12 Jul 2017 11:06:26 -0700
Subject: [PATCH 1/2] arm: Export save_stack_trace_tsk()
In-Reply-To: <20170613184056.23433-1-dustinb@codeaurora.org>
References: <20170613181603.GE4902@n2100.armlinux.org.uk>
 <20170613184056.23433-1-dustinb@codeaurora.org>
Message-ID: <000001d2fb39$948f1b80$bdad5280$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Everyone,

I just wanted to touch base and see where we are with respect to this one. I
see that the arm64 version of this patch has already landed for 4.13. Is
there anything needed from me for this? I apologize in advance if I am just
being impatient.

Thanks,

-Dustin

-----Original Message-----
From: Dustin Brown [mailto:dustinb at codeaurora.org] 
Sent: Tuesday, June 13, 2017 11:41 AM
To: linux at armlinux.org.uk; catalin.marinas at arm.com; will.deacon at arm.com;
linux-arm-kernel at lists.infradead.org
Cc: Dustin Brown <dustinb@codeaurora.org>
Subject: [PATCH 1/2] arm: Export save_stack_trace_tsk()

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
