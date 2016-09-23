From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Sep 2016 15:56:27 +0100
Subject: [PATCH] arm64: fix dump_backtrace with NULL tsk
Message-ID: <1474642587-22416-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some places, dump_backtrace() is called with a NULL tsk parameter,
e.g. in bug_handler() in arch/arm64, or indirectly via show_stack() in
core code. The expectation is that this is treated as if current were
passed instead of NULL.

Commit a80a0eb70c358f8c ("arm64: make irq_stack_ptr more robust") didn't
take this into account, and compares tsk against current *before* we
check if tsk is NULL.

Due to this, we won't initialise irq_stack_ptr, and when we try to dump
the exception regs we may call dump_mem() for memory immediately above
the IRQ stack range, rather than for the relevant range on the task
stack.

This will result in misleading, though should not be otherwise
problematic. The initial percpu areas (including the IRQ stacks) are
allocated in the linear map, and dump_mem uses __get_user(), so we
shouldn't access anything with side-effects, and will handle holes
safely.

This patch fixes the issue by handling the NULL tsk case before we do
anything else with tsk.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: a80a0eb70c358f8c ("arm64: make irq_stack_ptr more robust")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/kernel/traps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e04f838..df06750 100644
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
