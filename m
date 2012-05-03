From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 May 2012 18:43:00 +0100
Subject: [PATCH 6/6] ARM: ptrace: provide separate functions for tracing
 syscall {entry, exit}
In-Reply-To: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
References: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
Message-ID: <1336066980-24000-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The syscall_trace on ARM takes a `why' parameter to indicate whether or
not we are entering or exiting a system call. This can be confusing for
people looking at the code since (a) it conflicts with the why register
alias in the entry assembly code and (b) it is not immediately clear
what it represents.

This patch splits up the syscall_trace function into separate wrappers
for syscall entry and exit, allowing the low-level syscall handling
code to branch to the appropriate function.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/entry-common.S |   14 ++++++--------
 arch/arm/kernel/ptrace.c       |   37 +++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 93962cc..d0b97ec 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -466,10 +466,9 @@ ENDPROC(vector_swi)
 	 * context switches, and waiting for our parent to respond.
 	 */
 __sys_trace:
-	mov	r2, scno
-	add	r1, sp, #S_OFF
-	mov	r0, #0				@ trace entry [IP = 0]
-	bl	syscall_trace
+	mov	r1, scno
+	add	r0, sp, #S_OFF
+	bl	syscall_trace_enter
 
 	adr	lr, BSYM(__sys_trace_return)	@ return address
 	mov	scno, r0			@ syscall number (possibly new)
@@ -481,10 +480,9 @@ __sys_trace:
 
 __sys_trace_return:
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
-	mov	r2, scno
-	mov	r1, sp
-	mov	r0, #1				@ trace exit [IP = 1]
-	bl	syscall_trace
+	mov	r1, scno
+	mov	r0, sp
+	bl	syscall_trace_exit
 	b	ret_slow_syscall
 
 	.align	5
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index e7d687e..3fa40c3 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -906,14 +906,20 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
+enum ptrace_syscall_dir {
+	PTRACE_SYSCALL_ENTER = 0,
+	PTRACE_SYSCALL_EXIT,
+};
+
+static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
+				enum ptrace_syscall_dir dir)
 {
 	unsigned long ip;
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		goto out_no_trace;
+		return scno;
 	if (!(current->ptrace & PT_PTRACED))
-		goto out_no_trace;
+		return scno;
 
 	current_thread_info()->syscall = scno;
 
@@ -922,7 +928,7 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 	 * IP = 0 -> entry, =1 -> exit
 	 */
 	ip = regs->ARM_ip;
-	regs->ARM_ip = why;
+	regs->ARM_ip = dir;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
@@ -939,13 +945,20 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 	}
 
 	regs->ARM_ip = ip;
-	scno = current_thread_info()->syscall;
+	return current_thread_info()->syscall;
+}
 
-out_no_trace:
-	if (why)
-		audit_syscall_exit(regs);
-	else
-		audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0,
-				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
-	return scno;
+asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
+{
+	int ret = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_ENTER);
+	audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0, regs->ARM_r1,
+			    regs->ARM_r2, regs->ARM_r3);
+	return ret;
+}
+
+asmlinkage int syscall_trace_exit(struct pt_regs *regs, int scno)
+{
+	int ret = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_EXIT);
+	audit_syscall_exit(regs);
+	return ret;
 }
-- 
1.7.4.1
