From: alexinbeijing@gmail.com (Alex Dowad)
Date: Fri, 13 Mar 2015 20:04:20 +0200
Subject: [PATCH 05/32] arm64: copy_thread(): rename 'stk_sz' argument to
 'kthread_arg'
In-Reply-To: <1426269888-25600-1-git-send-email-alexinbeijing@gmail.com>
References: <1426269888-25600-1-git-send-email-alexinbeijing@gmail.com>
Message-ID: <1426269888-25600-5-git-send-email-alexinbeijing@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'stk_sz' is a misnomer: it is never used for a stack size. Rather, it is an
argument which is passed to the main function executed by a kernel thread, when
forking a new kthread. The most appropriate name is 'kthread_arg'.

Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
---
 arch/arm64/kernel/process.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index fde9923..734e2b6 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -242,8 +242,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 asmlinkage void ret_from_fork(void) asm("ret_from_fork");
 
+/*
+ * Copy architecture-specific thread state
+ */
 int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p)
+		unsigned long kthread_arg, struct task_struct *p)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 	unsigned long tls = p->thread.tp_value;
@@ -251,6 +254,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
 	if (likely(!(p->flags & PF_KTHREAD))) {
+		/* user thread */
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 		if (is_compat_thread(task_thread_info(p))) {
@@ -276,10 +280,11 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		if (clone_flags & CLONE_SETTLS)
 			tls = childregs->regs[3];
 	} else {
+		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
 		p->thread.cpu_context.x19 = stack_start;
-		p->thread.cpu_context.x20 = stk_sz;
+		p->thread.cpu_context.x20 = kthread_arg;
 	}
 	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
 	p->thread.cpu_context.sp = (unsigned long)childregs;
-- 
2.0.0.GIT
