From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 Dec 2015 00:42:41 +0300
Subject: [PATCH v6 15/20] arm64: signal: move ilp32 and lp64 common code to
 separated file
In-Reply-To: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1450215766-14765-16-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After that, it will be possible to reuse it in ILP32.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/signal_common.h |  39 ++++++++
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/signal.c             | 154 +----------------------------
 arch/arm64/kernel/signal_common.c      | 174 +++++++++++++++++++++++++++++++++
 4 files changed, 215 insertions(+), 154 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal_common.h
 create mode 100644 arch/arm64/kernel/signal_common.c

diff --git a/arch/arm64/include/asm/signal_common.h b/arch/arm64/include/asm/signal_common.h
new file mode 100644
index 0000000..2fb3997
--- /dev/null
+++ b/arch/arm64/include/asm/signal_common.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Cavium Networks.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_SIGNAL_COMMON_H
+#define __ASM_SIGNAL_COMMON_H
+
+#include <linux/uaccess.h>
+#include <asm/ucontext.h>
+#include <asm/fpsimd.h>
+
+struct sigframe {
+	struct ucontext uc;
+	u64 fp;
+	u64 lr;
+};
+
+int preserve_fpsimd_context(struct fpsimd_context __user *ctx);
+int restore_fpsimd_context(struct fpsimd_context __user *ctx);
+int setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set);
+int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf);
+void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+			void __user *frame, off_t sigframe_off, int usig);
+
+#endif /* __ASM_SIGNAL_COMMON_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 837d730..94b8b84 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,7 +18,7 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o	\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
-			   smp.o smp_spin_table.o topology.o
+			   smp.o smp_spin_table.o topology.o signal_common.o
 
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 20dca65..4b8efe5 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -33,13 +33,7 @@
 #include <asm/unistd.h>
 #include <asm/fpsimd.h>
 #include <asm/signal32.h>
-#include <asm/vdso.h>
-
-struct sigframe {
-	struct ucontext uc;
-	u64 fp;
-	u64 lr;
-};
+#include <asm/signal_common.h>
 
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
@@ -49,87 +43,6 @@ struct rt_sigframe {
 	struct sigframe sig;
 };
 
-static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
-{
-	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
-	int err;
-
-	/* dump the hardware registers to the fpsimd_state structure */
-	fpsimd_preserve_current_state();
-
-	/* copy the FP and status/control registers */
-	err = __copy_to_user(ctx->vregs, fpsimd->vregs, sizeof(fpsimd->vregs));
-	__put_user_error(fpsimd->fpsr, &ctx->fpsr, err);
-	__put_user_error(fpsimd->fpcr, &ctx->fpcr, err);
-
-	/* copy the magic/size information */
-	__put_user_error(FPSIMD_MAGIC, &ctx->head.magic, err);
-	__put_user_error(sizeof(struct fpsimd_context), &ctx->head.size, err);
-
-	return err ? -EFAULT : 0;
-}
-
-static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
-{
-	struct fpsimd_state fpsimd;
-	__u32 magic, size;
-	int err = 0;
-
-	/* check the magic/size information */
-	__get_user_error(magic, &ctx->head.magic, err);
-	__get_user_error(size, &ctx->head.size, err);
-	if (err)
-		return -EFAULT;
-	if (magic != FPSIMD_MAGIC || size != sizeof(struct fpsimd_context))
-		return -EINVAL;
-
-	/* copy the FP and status/control registers */
-	err = __copy_from_user(fpsimd.vregs, ctx->vregs,
-			       sizeof(fpsimd.vregs));
-	__get_user_error(fpsimd.fpsr, &ctx->fpsr, err);
-	__get_user_error(fpsimd.fpcr, &ctx->fpcr, err);
-
-	/* load the hardware registers from the fpsimd_state structure */
-	if (!err)
-		fpsimd_update_current_state(&fpsimd);
-
-	return err ? -EFAULT : 0;
-}
-
-static int restore_sigframe(struct pt_regs *regs,
-			    struct sigframe __user *sf)
-{
-	sigset_t set;
-	int i, err;
-	void *aux = sf->uc.uc_mcontext.__reserved;
-
-	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
-	if (err == 0)
-		set_current_blocked(&set);
-
-	for (i = 0; i < 31; i++)
-		__get_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
-				 err);
-	__get_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
-	__get_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
-	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
-
-	/*
-	 * Avoid sys_rt_sigreturn() restarting.
-	 */
-	regs->syscallno = ~0UL;
-
-	err |= !valid_user_regs(&regs->user_regs);
-
-	if (err == 0) {
-		struct fpsimd_context *fpsimd_ctx =
-			container_of(aux, struct fpsimd_context, head);
-		err |= restore_fpsimd_context(fpsimd_ctx);
-	}
-
-	return err;
-}
-
 asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
@@ -166,53 +79,6 @@ badframe:
 	return 0;
 }
 
-static int setup_sigframe(struct sigframe __user *sf,
-			  struct pt_regs *regs, sigset_t *set)
-{
-	int i, err = 0;
-	void *aux = sf->uc.uc_mcontext.__reserved;
-	struct _aarch64_ctx *end;
-
-	/* set up the stack frame for unwinding */
-	__put_user_error(regs->regs[29], &sf->fp, err);
-	__put_user_error(regs->regs[30], &sf->lr, err);
-
-	for (i = 0; i < 31; i++)
-		__put_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
-				 err);
-	__put_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
-	__put_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
-	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
-
-	__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fault_address, err);
-
-	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
-
-	if (err == 0) {
-		struct fpsimd_context *fpsimd_ctx =
-			container_of(aux, struct fpsimd_context, head);
-		err |= preserve_fpsimd_context(fpsimd_ctx);
-		aux += sizeof(*fpsimd_ctx);
-	}
-
-	/* fault information, if valid */
-	if (current->thread.fault_code) {
-		struct esr_context *esr_ctx =
-			container_of(aux, struct esr_context, head);
-		__put_user_error(ESR_MAGIC, &esr_ctx->head.magic, err);
-		__put_user_error(sizeof(*esr_ctx), &esr_ctx->head.size, err);
-		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
-		aux += sizeof(*esr_ctx);
-	}
-
-	/* set the "end" magic */
-	end = aux;
-	__put_user_error(0, &end->magic, err);
-	__put_user_error(0, &end->size, err);
-
-	return err;
-}
-
 static struct rt_sigframe __user *get_sigframe(struct ksignal *ksig,
 					       struct pt_regs *regs)
 {
@@ -233,24 +99,6 @@ static struct rt_sigframe __user *get_sigframe(struct ksignal *ksig,
 	return frame;
 }
 
-static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
-			 void __user *frame, off_t sigframe_off, int usig)
-{
-	__sigrestore_t sigtramp;
-
-	regs->regs[0] = usig;
-	regs->sp = (unsigned long)frame;
-	regs->regs[29] = regs->sp + sigframe_off + offsetof(struct sigframe, fp);
-	regs->pc = (unsigned long)ka->sa.sa_handler;
-
-	if (ka->sa.sa_flags & SA_RESTORER)
-		sigtramp = ka->sa.sa_restorer;
-	else
-		sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
-
-	regs->regs[30] = (unsigned long)sigtramp;
-}
-
 static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs)
 {
diff --git a/arch/arm64/kernel/signal_common.c b/arch/arm64/kernel/signal_common.c
new file mode 100644
index 0000000..7043e5c
--- /dev/null
+++ b/arch/arm64/kernel/signal_common.c
@@ -0,0 +1,174 @@
+/*
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Cavium Networks.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/uaccess.h>
+#include <asm/ucontext.h>
+#include <asm/fpsimd.h>
+#include <asm/vdso.h>
+#include <asm/signal_common.h>
+
+int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
+{
+	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
+	int err;
+
+	/* dump the hardware registers to the fpsimd_state structure */
+	fpsimd_preserve_current_state();
+
+	/* copy the FP and status/control registers */
+	err = __copy_to_user(ctx->vregs, fpsimd->vregs, sizeof(fpsimd->vregs));
+	__put_user_error(fpsimd->fpsr, &ctx->fpsr, err);
+	__put_user_error(fpsimd->fpcr, &ctx->fpcr, err);
+
+	/* copy the magic/size information */
+	__put_user_error(FPSIMD_MAGIC, &ctx->head.magic, err);
+	__put_user_error(sizeof(struct fpsimd_context), &ctx->head.size, err);
+
+	return err ? -EFAULT : 0;
+}
+
+int restore_fpsimd_context(struct fpsimd_context __user *ctx)
+{
+	struct fpsimd_state fpsimd;
+	__u32 magic, size;
+	int err = 0;
+
+	/* check the magic/size information */
+	__get_user_error(magic, &ctx->head.magic, err);
+	__get_user_error(size, &ctx->head.size, err);
+	if (err)
+		return -EFAULT;
+	if (magic != FPSIMD_MAGIC || size != sizeof(struct fpsimd_context))
+		return -EINVAL;
+
+	/* copy the FP and status/control registers */
+	err = __copy_from_user(fpsimd.vregs, ctx->vregs,
+			       sizeof(fpsimd.vregs));
+	__get_user_error(fpsimd.fpsr, &ctx->fpsr, err);
+	__get_user_error(fpsimd.fpcr, &ctx->fpcr, err);
+
+	/* load the hardware registers from the fpsimd_state structure */
+	if (!err)
+		fpsimd_update_current_state(&fpsimd);
+
+	return err ? -EFAULT : 0;
+}
+
+int setup_sigframe(struct sigframe __user *sf,
+			  struct pt_regs *regs, sigset_t *set)
+{
+	int i, err = 0;
+	void *aux = sf->uc.uc_mcontext.__reserved;
+	struct _aarch64_ctx *end;
+
+	/* set up the stack frame for unwinding */
+	__put_user_error(regs->regs[29], &sf->fp, err);
+	__put_user_error(regs->regs[30], &sf->lr, err);
+
+	for (i = 0; i < 31; i++)
+		__put_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+				 err);
+	__put_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
+	__put_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
+	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
+
+	__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fault_address, err);
+
+	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
+
+	if (err == 0) {
+		struct fpsimd_context *fpsimd_ctx =
+			container_of(aux, struct fpsimd_context, head);
+		err |= preserve_fpsimd_context(fpsimd_ctx);
+		aux += sizeof(*fpsimd_ctx);
+	}
+
+	/* fault information, if valid */
+	if (current->thread.fault_code) {
+		struct esr_context *esr_ctx =
+			container_of(aux, struct esr_context, head);
+		__put_user_error(ESR_MAGIC, &esr_ctx->head.magic, err);
+		__put_user_error(sizeof(*esr_ctx), &esr_ctx->head.size, err);
+		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
+		aux += sizeof(*esr_ctx);
+	}
+
+	/* set the "end" magic */
+	end = aux;
+	__put_user_error(0, &end->magic, err);
+	__put_user_error(0, &end->size, err);
+
+	return err;
+}
+
+int restore_sigframe(struct pt_regs *regs,
+			    struct sigframe __user *sf)
+{
+	sigset_t set;
+	int i, err;
+	void *aux = sf->uc.uc_mcontext.__reserved;
+
+	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
+	if (err == 0)
+		set_current_blocked(&set);
+
+	for (i = 0; i < 31; i++)
+		__get_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+				 err);
+	__get_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
+	__get_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
+	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
+
+	/*
+	 * Avoid sys_rt_sigreturn() restarting.
+	 */
+	regs->syscallno = ~0UL;
+
+	err |= !valid_user_regs(&regs->user_regs);
+
+	if (err == 0) {
+		struct fpsimd_context *fpsimd_ctx =
+			container_of(aux, struct fpsimd_context, head);
+		err |= restore_fpsimd_context(fpsimd_ctx);
+	}
+
+	return err;
+}
+
+void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+			 void __user *frame, off_t sigframe_off, int usig)
+{
+	__sigrestore_t sigtramp;
+
+	regs->regs[0] = usig;
+	regs->sp = (unsigned long)frame;
+	regs->regs[29] = regs->sp + sigframe_off + offsetof(struct sigframe, fp);
+	regs->pc = (unsigned long)ka->sa.sa_handler;
+
+	if (ka->sa.sa_flags & SA_RESTORER)
+		sigtramp = ka->sa.sa_restorer;
+#ifdef CONFIG_ARM64_ILP32
+	else if (is_ilp32_compat_task())
+		sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp_ilp32);
+#endif
+	else
+		sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
+
+	regs->regs[30] = (unsigned long)sigtramp;
+}
+
-- 
2.5.0
