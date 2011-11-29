From: stevenrwalter@gmail.com (Steven Walter)
Date: Tue, 29 Nov 2011 11:28:13 -0500
Subject: [PATCH 1/3] ARM: add support for the generic syscall.h interface
In-Reply-To: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
References: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
Message-ID: <1322584095-30439-2-git-send-email-stevenrwalter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Supplying the asm-generic/syscall.h interface is a pre-requisite for
HAVE_ARCH_TRACEHOOK

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 arch/arm/include/asm/syscall.h |   78 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/syscall.h

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
new file mode 100644
index 0000000..f104339
--- /dev/null
+++ b/arch/arm/include/asm/syscall.h
@@ -0,0 +1,78 @@
+/*
+ * Access to user system call parameters and results
+ *
+ * See asm-generic/syscall.h for descriptions of what we must do here.
+ */
+
+#ifndef _ASM_ARM_SYSCALL_H
+#define _ASM_ARM_SYSCALL_H
+
+#include <linux/err.h>
+
+extern const unsigned long sys_call_table[];
+
+static inline int syscall_get_nr(struct task_struct *task,
+				 struct pt_regs *regs)
+{
+	return task_thread_info(task)->syscall;
+}
+
+static inline void syscall_rollback(struct task_struct *task,
+				    struct pt_regs *regs)
+{
+	regs->ARM_r0 = regs->ARM_ORIG_r0;
+}
+
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	unsigned long error = regs->ARM_r0;
+	return IS_ERR_VALUE(error) ? error : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->ARM_r0;
+}
+
+static inline void syscall_set_return_value(struct task_struct *task,
+					    struct pt_regs *regs,
+					    int error, long val)
+{
+	regs->ARM_r0 = (long) error ?: val;
+}
+
+static inline void syscall_get_arguments(struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned int i, unsigned int n,
+					 unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+	if (i == 0) {
+		args[0] = regs->ARM_ORIG_r0;
+		args++;
+		i++;
+		n--;
+	}
+
+	memcpy(args, &regs->ARM_r1 + (i - 1), n * sizeof(args[0]));
+}
+
+static inline void syscall_set_arguments(struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned int i, unsigned int n,
+					 const unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+	if (i == 0) {
+		regs->ARM_ORIG_r0 = args[0];
+		args++;
+		i++;
+		n--;
+	}
+
+	memcpy(&regs->ARM_r1 + (i - 1), args, n * sizeof(args[0]));
+}
+
+#endif	/* _ASM_ARM_SYSCALL_H */
-- 
1.7.5.4.2.g81f75
