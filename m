From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Jun 2017 16:00:44 +0100
Subject: [PATCH 3/3] arm64: ptrace: Flush user-RW TLS reg to thread_struct
 before reading
In-Reply-To: <1498057010-12028-1-git-send-email-Dave.Martin@arm.com>
References: <1498057010-12028-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1498057264-12211-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When reading current's user-writable TLS register (which occurs
when dumping core for native tasks), it is possible that userspace
has modified it since the time the task was last scheduled out.
The new TLS register value is not guaranteed to have been written
immediately back to thread_struct in this case.

As a result, a coredump can capture stale data for this register.
Reading the register for a stopped task via ptrace is unaffected.

For native tasks, this patch explicitly flushes the TPIDR_EL0
register back to thread_struct before dumping when operating on
current, thus ensuring that coredump contents are up to date.  For
compat tasks, the TLS register is not user-writable and so cannot
be out of sync, so no flush is required in compat_tls_get().

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/processor.h | 3 +++
 arch/arm64/kernel/process.c        | 8 ++++++--
 arch/arm64/kernel/ptrace.c         | 4 ++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 9428b93..64c9e78 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -104,6 +104,9 @@ struct thread_struct {
 #define task_user_tls(t)	(&(t)->thread.tp_value)
 #endif
 
+/* Sync TPIDR_EL0 back to thread_struct for current */
+void tls_preserve_current_state(void);
+
 #define INIT_THREAD  {	}
 
 static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index ae2a835..0ac0159 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -297,12 +297,16 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	return 0;
 }
 
+void tls_preserve_current_state(void)
+{
+	*task_user_tls(current) = read_sysreg(tpidr_el0);
+}
+
 static void tls_thread_switch(struct task_struct *next)
 {
 	unsigned long tpidr, tpidrro;
 
-	tpidr = read_sysreg(tpidr_el0);
-	*task_user_tls(current) = tpidr;
+	tls_preserve_current_state();
 
 	tpidr = *task_user_tls(next);
 	tpidrro = is_compat_thread(task_thread_info(next)) ?
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index eeef01a..35846f1 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -652,6 +652,10 @@ static int tls_get(struct task_struct *target, const struct user_regset *regset,
 		   void *kbuf, void __user *ubuf)
 {
 	unsigned long *tls = &target->thread.tp_value;
+
+	if (target == current)
+		tls_preserve_current_state();
+
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, tls, 0, -1);
 }
 
-- 
2.1.4
