From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 14 Jan 2016 20:23:14 +0300
Subject: [PATCH v6 17/21] arm64: ilp32: introduce ilp32-specific handlers for
 sigframe
In-Reply-To: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452792198-10718-18-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ILP32 uses AARCH32 compat structures and syscall handlers for signals.
But ILP32 struct rt_sigframe differs from both LP64 and AARCH32. So some
specific mechanism is needed to take care of it.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/signal_ilp32.h |  34 +++++++++
 arch/arm64/kernel/Makefile            |   3 +-
 arch/arm64/kernel/entry_ilp32.S       |  23 ++++++
 arch/arm64/kernel/signal.c            |   3 +
 arch/arm64/kernel/signal_ilp32.c      | 128 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/sys_ilp32.c         |   3 +
 6 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/signal_ilp32.h
 create mode 100644 arch/arm64/kernel/entry_ilp32.S
 create mode 100644 arch/arm64/kernel/signal_ilp32.c

diff --git a/arch/arm64/include/asm/signal_ilp32.h b/arch/arm64/include/asm/signal_ilp32.h
new file mode 100644
index 0000000..30eff23
--- /dev/null
+++ b/arch/arm64/include/asm/signal_ilp32.h
@@ -0,0 +1,34 @@
+/*
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
+#ifndef __ASM_SIGNAL_ILP32_H
+#define __ASM_SIGNAL_ILP32_H
+
+#ifdef CONFIG_ARM64_ILP32
+
+#include <linux/compat.h>
+
+int ilp32_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs);
+
+#else
+
+static inline int ilp32_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_ARM64_ILP32 */
+
+#endif /* __ASM_SIGNAL_ILP32_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 4981933..c846626 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,8 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o binfmt_elf32.o
-arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o 		\
+					   signal_ilp32.o entry_ilp32.o
 arm64-obj-$(CONFIG_COMPAT)		+= signal32_common.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
diff --git a/arch/arm64/kernel/entry_ilp32.S b/arch/arm64/kernel/entry_ilp32.S
new file mode 100644
index 0000000..5063172
--- /dev/null
+++ b/arch/arm64/kernel/entry_ilp32.S
@@ -0,0 +1,23 @@
+/*
+ * ILP32 system call wrappers
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
+#include <linux/linkage.h>
+
+ENTRY(ilp32_sys_rt_sigreturn_wrapper)
+	mov	x0, sp
+	b	ilp32_sys_rt_sigreturn
+ENDPROC(ilp32_sys_rt_sigreturn_wrapper)
+
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index a742a61..f8d4c92 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -35,6 +35,7 @@
 #include <asm/signal32.h>
 #include <asm/vdso.h>
 #include <asm/signal_common.h>
+#include <asm/signal_ilp32.h>
 
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
@@ -300,6 +301,8 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 			ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
 		else
 			ret = compat_setup_frame(usig, ksig, oldset, regs);
+	} else if (is_ilp32_compat_task()) {
+		ret = ilp32_setup_rt_frame(usig, ksig, oldset, regs);
 	} else {
 		ret = setup_rt_frame(usig, ksig, oldset, regs);
 	}
diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
new file mode 100644
index 0000000..b635a21
--- /dev/null
+++ b/arch/arm64/kernel/signal_ilp32.c
@@ -0,0 +1,128 @@
+/*
+ * Based on arch/arm/kernel/signal.c
+ *
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2016 Cavium Networks.
+ * Yury Norov <ynorov@caviumnetworks.com>
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
+#include <linux/compat.h>
+#include <linux/signal.h>
+#include <linux/syscalls.h>
+#include <linux/ratelimit.h>
+
+#include <asm/esr.h>
+#include <asm/fpsimd.h>
+#include <asm/signal32_common.h>
+#include <asm/signal_common.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
+#include <asm/ucontext.h>
+
+struct ilp32_rt_sigframe {
+	struct compat_siginfo info;
+	struct sigframe sig;
+};
+
+asmlinkage int ilp32_sys_rt_sigreturn(struct pt_regs *regs)
+{
+	struct ilp32_rt_sigframe __user *frame;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	/*
+	 * Since we stacked the signal on a 128-bit boundary,
+	 * then 'sp' should be word aligned here.  If it's
+	 * not, then the user is trying to mess with us.
+	 */
+	if (regs->sp & 15)
+		goto badframe;
+
+	frame = (struct ilp32_rt_sigframe __user *)regs->sp;
+
+	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
+		goto badframe;
+
+	if (restore_sigframe(regs, &frame->sig))
+		goto badframe;
+
+	if (restore_altstack(&frame->sig.uc.uc_stack))
+		goto badframe;
+
+	return regs->regs[0];
+
+badframe:
+	if (show_unhandled_signals)
+		pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
+				    current->comm, task_pid_nr(current), __func__,
+				    regs->pc, regs->compat_sp);
+	force_sig(SIGSEGV, current);
+	return 0;
+}
+
+static struct ilp32_rt_sigframe __user *ilp32_get_sigframe(struct ksignal *ksig,
+					       struct pt_regs *regs)
+{
+	unsigned long sp, sp_top;
+	struct ilp32_rt_sigframe __user *frame;
+
+	sp = sp_top = sigsp(regs->sp, ksig);
+
+	sp = (sp - sizeof(struct ilp32_rt_sigframe)) & ~15;
+	frame = (struct ilp32_rt_sigframe __user *)sp;
+
+	/*
+	 * Check that we can actually write to the signal frame.
+	 */
+	if (!access_ok(VERIFY_WRITE, frame, sp_top - sp))
+		frame = NULL;
+
+	return frame;
+}
+
+/*
+ * ILP32 signal handling routines called from signal.c
+ */
+int ilp32_setup_rt_frame(int usig, struct ksignal *ksig,
+			  sigset_t *set, struct pt_regs *regs)
+{
+	struct ilp32_rt_sigframe __user *frame;
+	int err = 0;
+
+	frame = ilp32_get_sigframe(ksig, regs);
+
+	if (!frame)
+		return 1;
+
+	__put_user_error(0, &frame->sig.uc.uc_flags, err);
+	__put_user_error(NULL, &frame->sig.uc.uc_link, err);
+
+	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->sp);
+	err |= setup_sigframe(&frame->sig, regs, set);
+	if (err == 0) {
+		setup_return(regs, &ksig->ka, frame,
+			offsetof(struct ilp32_rt_sigframe, sig), usig);
+		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+			err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
+			regs->regs[1] = (unsigned long)&frame->info;
+			regs->regs[2] = (unsigned long)&frame->sig.uc;
+		}
+	}
+
+	return err;
+}
+
diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index 0659b89..bed308c 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -43,6 +43,9 @@
 #define sys_llseek                     sys_lseek
 #define sys_mmap2		       sys_mmap
 
+asmlinkage long ilp32_sys_rt_sigreturn_wrapper(void);
+#define compat_sys_rt_sigreturn        ilp32_sys_rt_sigreturn_wrapper
+
 #include <asm/syscall.h>
 
 #undef __SYSCALL
-- 
2.5.0
