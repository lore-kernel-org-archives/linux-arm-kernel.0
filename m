From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed,  6 Nov 2013 19:25:44 +0900
Subject: [PATCH 2/4] arm64: Add audit support
In-Reply-To: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1383733546-2846-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm64/Kconfig               |    3 ++
 arch/arm64/include/asm/ptrace.h  |    5 ++++
 arch/arm64/include/asm/syscall.h |   18 ++++++++++++
 arch/arm64/kernel/Makefile       |    1 +
 arch/arm64/kernel/audit.c        |   59 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+)
 create mode 100644 arch/arm64/kernel/audit.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c044548..263c10b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -46,6 +46,9 @@ config 64BIT
 config ARCH_PHYS_ADDR_T_64BIT
 	def_bool y
 
+config AUDIT_ARCH
+	def_bool y
+
 config MMU
 	def_bool y
 
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 0dacbbf..964f4f6 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -133,6 +133,11 @@ struct pt_regs {
 #define user_stack_pointer(regs) \
 	((regs)->sp)
 
+static inline unsigned long regs_return_value(struct pt_regs *regs)
+{
+	return regs->regs[0];
+}
+
 /*
  * Are the current registers suitable for user mode? (used to maintain
  * security in signal handlers)
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 89c047f..03040ac 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -16,7 +16,10 @@
 #ifndef __ASM_SYSCALL_H
 #define __ASM_SYSCALL_H
 
+#include <linux/audit.h>
 #include <linux/err.h>
+#include <linux/sched.h>
+#include <asm/compat.h>
 
 
 static inline int syscall_get_nr(struct task_struct *task,
@@ -98,4 +101,19 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->regs[i], args, n * sizeof(args[0]));
 }
 
+static inline int syscall_get_arch(struct task_struct *task,
+                                   struct pt_regs *regs)
+{
+#ifdef CONFIG_COMPAT
+        if (is_compat_thread(task_thread_info(task)))
+                return AUDIT_ARCH_ARM; /* FIXME: big endian? */
+#endif
+
+#ifdef __AARCH64EB__
+        return AUDIT_ARCH_AARCH64EB;
+#else
+        return AUDIT_ARCH_AARCH64;
+#endif
+}
+
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7b4b564..3abab29 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -11,6 +11,7 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
 			   hyp-stub.o psci.o
 
+arm64-obj-$(CONFIG_AUDIT)		+= audit.o
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
diff --git a/arch/arm64/kernel/audit.c b/arch/arm64/kernel/audit.c
new file mode 100644
index 0000000..9aab2b3
--- /dev/null
+++ b/arch/arm64/kernel/audit.c
@@ -0,0 +1,59 @@
+#include <linux/audit.h>
+#include <linux/init.h>
+#include <asm/unistd.h>
+
+static unsigned dir_class[] = {
+#include <asm-generic/audit_dir_write.h>
+~0U
+};
+
+static unsigned read_class[] = {
+#include <asm-generic/audit_read.h>
+~0U
+};
+
+static unsigned write_class[] = {
+#include <asm-generic/audit_write.h>
+~0U
+};
+
+static unsigned chattr_class[] = {
+#include <asm-generic/audit_change_attr.h>
+~0U
+};
+
+static unsigned signal_class[] = {
+#include <asm-generic/audit_signal.h>
+~0U
+};
+
+int audit_classify_arch(int arch)
+{
+	return 0; /* native */
+}
+
+/* AUTH_PERM support */
+int audit_classify_syscall(int abi, unsigned syscall)
+{
+	switch(syscall) {
+	case __NR_openat:
+		return 3;
+	case __NR_execve:
+		return 5;
+	default:
+		return 0; /* native */
+	}
+}
+
+static int __init audit_classes_init(void)
+{
+	audit_register_class(AUDIT_CLASS_DIR_WRITE, dir_class);
+	audit_register_class(AUDIT_CLASS_READ, read_class);
+	audit_register_class(AUDIT_CLASS_WRITE, write_class);
+	audit_register_class(AUDIT_CLASS_CHATTR, chattr_class);
+	audit_register_class(AUDIT_CLASS_SIGNAL, signal_class);
+
+	return 0;
+}
+
+__initcall(audit_classes_init);
-- 
1.7.9.5
