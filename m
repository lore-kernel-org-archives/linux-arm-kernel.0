From: alexinbeijing@gmail.com (Alex Dowad)
Date: Fri, 13 Mar 2015 20:04:19 +0200
Subject: [PATCH 04/32] arm: copy_thread(): rename 'stk_sz' argument to
 'kthread_arg'
In-Reply-To: <1426269888-25600-1-git-send-email-alexinbeijing@gmail.com>
References: <1426269888-25600-1-git-send-email-alexinbeijing@gmail.com>
Message-ID: <1426269888-25600-4-git-send-email-alexinbeijing@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'stk_sz' is a misnomer: it is never used for a stack size. Rather, it is an
argument which is passed to the main function executed by a kernel thread, when
forking a new kthread. The most appropriate name is 'kthread_arg'.

Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
---
 arch/arm/kernel/process.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fdfa3a7..4183ebd 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -342,9 +342,12 @@ void release_thread(struct task_struct *dead_task)
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
+/*
+ * Copy architecture-specific thread state
+ */
 int
 copy_thread(unsigned long clone_flags, unsigned long stack_start,
-	    unsigned long stk_sz, struct task_struct *p)
+	    unsigned long kthread_arg, struct task_struct *p)
 {
 	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs = task_pt_regs(p);
@@ -352,13 +355,15 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	memset(&thread->cpu_context, 0, sizeof(struct cpu_context_save));
 
 	if (likely(!(p->flags & PF_KTHREAD))) {
+		/* user thread */
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
 			childregs->ARM_sp = stack_start;
 	} else {
+		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
-		thread->cpu_context.r4 = stk_sz;
+		thread->cpu_context.r4 = kthread_arg;
 		thread->cpu_context.r5 = stack_start;
 		childregs->ARM_cpsr = SVC_MODE;
 	}
-- 
2.0.0.GIT
