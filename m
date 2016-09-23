From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Sep 2016 17:55:05 +0100
Subject: [PATCHv2] arm64: fix dump_backtrace/unwind_frame with NULL tsk
Message-ID: <1474649705-29040-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some places, dump_backtrace() is called with a NULL tsk parameter,
e.g. in bug_handler() in arch/arm64, or indirectly via show_stack() in
core code. The expectation is that this is treated as if current were
passed instead of NULL. Similar is true of unwind_frame().

Commit a80a0eb70c358f8c ("arm64: make irq_stack_ptr more robust") didn't
take this into account. In dump_backtrace() it compares tsk against
current *before* we check if tsk is NULL, and in unwind_frame() we never
set tsk if it is NULL.

Due to this, we won't initialise irq_stack_ptr in either function. In
dump_backtrace() this results in calling dump_mem() for memory
immediately above the IRQ stack range, rather than for the relevant
range on the task stack. In unwind_frame we'll reject unwinding frames
on the IRQ stack.

In either case this results in incomplete or misleading backtrace
information, but is not otherwise problematic. The initial percpu areas
(including the IRQ stacks) are allocated in the linear map, and dump_mem
uses __get_user(), so we shouldn't access anything with side-effects,
and will handle holes safely.

This patch fixes the issue by having both functions handle the NULL tsk
case before doing anything else with tsk.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: a80a0eb70c358f8c ("arm64: make irq_stack_ptr more robust")
Acked-by: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/kernel/stacktrace.c |  5 ++++-
 arch/arm64/kernel/traps.c      | 10 +++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

Since v1 [1]:
* Fix up unwind_frame(), too.

James, I've assumed that your ack still applies. Please shout if that is not
the case!

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/458913.html

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d9751a4..d34fd72 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -43,6 +43,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	unsigned long fp = frame->fp;
 	unsigned long irq_stack_ptr;
 
+	if (!tsk)
+		tsk = current;
+
 	/*
 	 * Switching between stacks is valid when tracing current and in
 	 * non-preemptible context.
@@ -67,7 +70,7 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	if (tsk && tsk->ret_stack &&
+	if (tsk->ret_stack &&
 			(frame->pc == (unsigned long)return_to_handler)) {
 		/*
 		 * This is a case where function graph tracer has
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 1584e8a..8b7e596 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -142,6 +142,11 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	unsigned long irq_stack_ptr;
 	int skip;
 
+	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
+
+	if (!tsk)
+		tsk = current;
+
 	/*
 	 * Switching between stacks is valid when tracing current and in
 	 * non-preemptible context.
@@ -151,11 +156,6 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	else
 		irq_stack_ptr = 0;
 
-	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
-
-	if (!tsk)
-		tsk = current;
-
 	if (tsk == current) {
 		frame.fp = (unsigned long)__builtin_frame_address(0);
 		frame.sp = current_stack_pointer;
-- 
1.9.1
