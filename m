From: christofferdall@christofferdall.dk (Christoffer Dall)
Date: Mon, 26 Apr 2010 18:36:32 -0400
Subject: [C/R ARM v2][PATCH] ARM: Rudimentary syscall interfaces
In-Reply-To: <20100429000808.CFFBD7154@magilla.sf.frob.com>
References: <20100429000808.CFFBD7154@magilla.sf.frob.com>
Message-ID: <1272321392-5682-1-git-send-email-christofferdall@christofferdall.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roland.

Thanks for your feedback. The changed patch below should address your
concerns.

Best,
Christoffer

---
 arch/arm/include/asm/syscall.h |   32 ++++++++++++++++++
 arch/arm/kernel/ptrace.c       |   69 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/syscall.h

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
new file mode 100644
index 0000000..1a6ca68
--- /dev/null
+++ b/arch/arm/include/asm/syscall.h
@@ -0,0 +1,32 @@
+/*
+ * syscall.h - Linux syscall interfaces for ARM
+ *
+ * Copyright (c) 2010 Christoffer Dall
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ */
+
+#ifndef _ASM_ARM_SYSCALLS_H
+#define _ASM_ARM_SYSCALLS_H
+
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/memory.h>
+#include <asm/unistd.h>
+
+int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->ARM_r0;
+}
+
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	return regs->ARM_r0;
+}
+
+#endif /* _ASM_ARM_SYSCALLS_H */
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3f562a7..acf9a39 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -23,6 +23,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/traps.h>
+#include <asm/syscall.h>
 
 #include "ptrace.h"
 
@@ -863,3 +864,71 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 
 	return current_thread_info()->syscall;
 }
+
+/*
+ * This function essentially duplicates the logic from vector_swi in
+ * arch/arm/kernel/entry-common.S. However, that code is in the
+ * critical path for system calls and is hard to factor out without
+ * compromising performance. 
+ */
+int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	int ret;
+	int scno;
+	unsigned long instr;
+	bool config_oabi = false;
+	bool config_aeabi = false;
+	bool config_arm_thumb = false;
+	bool config_cpu_endian_be8 = false;
+
+#ifdef CONFIG_OABI_COMPAT
+	config_oabi = true;
+#endif
+#ifdef CONFIG_AEABI
+	config_aeabi = true;
+#endif
+#ifdef CONFIG_ARM_THUMB
+	config_arm_thumb = true;
+#endif
+#ifdef CONFIG_CPU_ENDIAN_BE8
+	config_cpu_endian_be8 = true;
+#endif
+#ifdef CONFIG_CPU_ARM710
+	return -1;
+#endif
+
+	if (config_aeabi && !config_oabi) {
+		/* Pure EABI */
+		return regs->ARM_r7;
+	} else if (config_oabi) {
+		if (config_arm_thumb && (regs->ARM_cpsr & PSR_T_BIT))
+			return -1;
+
+		ret = access_process_vm(task, regs->ARM_pc - 4, &instr,
+					sizeof(unsigned long), 0);
+		if (ret != sizeof(unsigned long))
+			return -1;
+
+		if (config_cpu_endian_be8)
+			asm ("rev %[out], %[in]": [out] "=r" (instr):
+						  [in] "r" (instr));
+
+		if ((instr & 0x00ffffff) == 0)
+			return regs->ARM_r7; /* EABI call */
+		else
+			return (instr & 0x00ffffff) | __NR_OABI_SYSCALL_BASE;
+	} else {
+		 /* Legacy ABI only */
+		if (config_arm_thumb && (regs->ARM_cpsr & PSR_T_BIT)) {
+			/* Thumb mode ABI */
+			scno = regs->ARM_r7 + __NR_SYSCALL_BASE;
+		} else {
+			ret = access_process_vm(task, regs->ARM_pc - 4, &instr,
+						sizeof(unsigned long), 0);
+			if (ret != sizeof(unsigned long))
+				return -1;
+			scno = instr;
+		}
+		return scno & 0x00ffffff;
+	}
+}
-- 
1.5.6.5
