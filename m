From: nerv@dawncrow.de (=?windows-1252?Q?Andr=E9_Hentschel?=)
Date: Sun, 03 May 2015 18:24:18 +0200
Subject: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on context
 switch and fork in compat mode
Message-ID: <55464BB2.7030401@dawncrow.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andr? Hentschel <nerv@dawncrow.de>

Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writeable TLS
register on ARM is preserved per thread.

This patch does it analogous to the ARM patch, but for compat mode on ARM64.

Signed-off-by: Andr? Hentschel <nerv@dawncrow.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Austin <jonathan.austin@arm.com> 

---
This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa74a031)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 20e9591..cd7b8c9 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -78,7 +78,7 @@ struct cpu_context {
 
 struct thread_struct {
 	struct cpu_context	cpu_context;	/* cpu context */
-	unsigned long		tp_value;
+	unsigned long		tp_value[2];	/* TLS registers */
 	struct fpsimd_state	fpsimd_state;
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c6b1f3b..fc7cc6bc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -218,7 +218,8 @@ static void tls_thread_flush(void)
 	asm ("msr tpidr_el0, xzr");
 
 	if (is_compat_task()) {
-		current->thread.tp_value = 0;
+		current->thread.tp_value[0] = 0;
+		current->thread.tp_value[1] = 0;
 
 		/*
 		 * We need to ensure ordering between the shadow state and the
@@ -254,7 +255,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		unsigned long stk_sz, struct task_struct *p)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
-	unsigned long tls = p->thread.tp_value;
+	unsigned long tls = p->thread.tp_value[0];
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
@@ -283,6 +284,11 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		 */
 		if (clone_flags & CLONE_SETTLS)
 			tls = childregs->regs[3];
+		if (is_compat_thread(task_thread_info(p))) {
+			unsigned long tpuser;
+			asm("mrs %0, tpidr_el0" : "=r" (tpuser));
+			p->thread.tp_value[1] = tpuser;
+		}
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
@@ -291,7 +297,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	}
 	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
 	p->thread.cpu_context.sp = (unsigned long)childregs;
-	p->thread.tp_value = tls;
+	p->thread.tp_value[0] = tls;
 
 	ptrace_hw_copy_thread(p);
 
@@ -302,16 +308,17 @@ static void tls_thread_switch(struct task_struct *next)
 {
 	unsigned long tpidr, tpidrro;
 
-	if (!is_compat_task()) {
-		asm("mrs %0, tpidr_el0" : "=r" (tpidr));
-		current->thread.tp_value = tpidr;
-	}
+	asm("mrs %0, tpidr_el0" : "=r" (tpidr));
+	if (is_compat_task())
+		current->thread.tp_value[1] = tpidr;
+	else
+		current->thread.tp_value[0] = tpidr;
 
 	if (is_compat_thread(task_thread_info(next))) {
-		tpidr = 0;
-		tpidrro = next->thread.tp_value;
+		tpidr = next->thread.tp_value[1];
+		tpidrro = next->thread.tp_value[0];
 	} else {
-		tpidr = next->thread.tp_value;
+		tpidr = next->thread.tp_value[0];
 		tpidrro = 0;
 	}
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d882b83..1eec962 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -533,7 +533,7 @@ static int tls_get(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
 {
-	unsigned long *tls = &target->thread.tp_value;
+	unsigned long *tls = &target->thread.tp_value[0];
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, tls, 0, -1);
 }
 
@@ -548,7 +548,7 @@ static int tls_set(struct task_struct *target, const struct user_regset *regset,
 	if (ret)
 		return ret;
 
-	target->thread.tp_value = tls;
+	target->thread.tp_value[0] = tls;
 	return ret;
 }
 
@@ -1061,7 +1061,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			break;
 
 		case COMPAT_PTRACE_GET_THREAD_AREA:
-			ret = put_user((compat_ulong_t)child->thread.tp_value,
+			ret = put_user((compat_ulong_t)child->thread.tp_value[0],
 				       (compat_ulong_t __user *)datap);
 			break;
 
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 28c511b..fd4330c 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -87,7 +87,7 @@ long compat_arm_syscall(struct pt_regs *regs)
 		return do_compat_cache_op(regs->regs[0], regs->regs[1], regs->regs[2]);
 
 	case __ARM_NR_compat_set_tls:
-		current->thread.tp_value = regs->regs[0];
+		current->thread.tp_value[0] = regs->regs[0];
 
 		/*
 		 * Protect against register corruption from context switch.
