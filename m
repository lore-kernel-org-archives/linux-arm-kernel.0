From: joelaf@google.com (Joel Fernandes)
Date: Wed, 21 Dec 2016 14:44:46 -0800
Subject: [PATCH] arm64: Don't trace __switch_to if function graph tracer is
 enabled
Message-ID: <1482360288-124624-1-git-send-email-joelaf@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function graph tracer shows negative time (wrap around) when tracing
__switch_to if the nosleep-time trace option is enabled.

Time compensation for nosleep-time is done by an ftrace probe on
sched_switch. This doesn't work well for the following events (with
letters representing timestamps):
A - sched switch probe called for task T switch out
B - __switch_to calltime is recorded
C - sched_switch probe called for task T switch in
D - __switch_to rettime is recorded

If C - A > D - B, then we end up over compensating for the time spent in
__switch_to giving rise to negative times in the trace output.

On x86, __switch_to is not traced if function graph tracer is enabled.
Do the same for arm64 as well.

Cc: Todd Kjos <tkjos@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 01753cd..e84ee27 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -324,7 +324,7 @@ void uao_thread_switch(struct task_struct *next)
 /*
  * Thread switching.
  */
-struct task_struct *__switch_to(struct task_struct *prev,
+__notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 				struct task_struct *next)
 {
 	struct task_struct *last;
-- 
2.8.0.rc3.226.g39d4020
