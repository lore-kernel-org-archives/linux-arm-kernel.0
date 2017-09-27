From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 27 Sep 2017 20:50:18 +0800
Subject: [PATCH v4 2/4] arm64/ras: support sea error recovery
In-Reply-To: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
References: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <1506516620-20033-3-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
are consumed. According to the existing process, errors occurred in the
kernel, leading to direct panic, if it occurred the user-space, we should
just kill process.

But there is a class of error, in fact, is not necessary to kill
process, you can recover and continue to run the process. Such as
the instruction data corrupted, where the memory page might be
read-only, which is has not been modified, the disk might have the
correct data, so you can directly drop the page, ant reload it when
necessary.

So this patchset is just try to solve such problem: if the error is
consumed in user-space and the error occurs on a clean page, you can
directly drop the memory page without killing process.

If the corrupted page is clean, just dropped it and return to user-space
without side effects. And if corrupted page is dirty, memory_failure()
will send SIGBUS with code=BUS_MCEERR_AR. While without this patchset,
do_sea() will just send SIGBUS, so the process was killed in the same place.

Because memory_failure() may sleep, we can not call it directly in SEA
exception context. So we saved faulting physical address associated with
a process in the ghes handler and set __TIF_SEA_NOTIFY. When we return
from SEA exception context and get into do_notify_resume() before the
process running, we could check it and call memory_failure() to do
recovery. It's safe, because we are in process context.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Tested-by: Wang Xiongfeng <wangxiongfeng2@huawei.com>
Cc: James Morse <james.morse@arm.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Kconfig                   |  11 +++
 arch/arm64/include/asm/ras.h         |  23 ++++++
 arch/arm64/include/asm/thread_info.h |   4 +-
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/ras.c              | 142 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c           |   7 ++
 arch/arm64/mm/fault.c                |  27 +++++--
 drivers/acpi/apei/ghes.c             |   8 +-
 include/acpi/ghes.h                  |   3 +
 9 files changed, 216 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 arch/arm64/kernel/ras.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6..0c2d0a0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -641,6 +641,17 @@ config HOTPLUG_CPU
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
 
+config ARM64_ERR_RECOV
+	bool "Support arm64 RAS error recovery"
+	depends on ACPI_APEI_SEA && MEMORY_FAILURE
+	help
+	  With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
+	  are consumed. In some cases, if the error address is in a clean page or a
+	  read-only page, there is a chance to recover. Such as error occurs in a
+	  instruction page, we can reread this page from disk instead of killing process.
+
+	  Say Y if unsure.
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
new file mode 100644
index 0000000..f0f18da
--- /dev/null
+++ b/arch/arm64/include/asm/ras.h
@@ -0,0 +1,23 @@
+/*
+ * ARM64 SEA error recoery support
+ *
+ * Copyright 2017 Huawei Technologies Co., Ltd.
+ *   Author: Xie XiuQi <xiexiuqi@huawei.com>
+ *   Author: Wang Xiongfeng <wangxiongfeng2@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation;
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RAS_H
+#define _ASM_RAS_H
+
+extern void sea_notify_process(void);
+
+#endif /*_ASM_RAS_H*/
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index ddded64..b31b308 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -82,6 +82,7 @@ struct thread_info {
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
+#define TIF_SEA_NOTIFY          6       /* notify to do an error recovery */
 #define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
@@ -98,6 +99,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
+#define _TIF_SEA_NOTIFY         (1 << TIF_SEA_NOTIFY)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
@@ -108,7 +110,7 @@ struct thread_info {
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-				 _TIF_UPROBE | _TIF_FSCHECK)
+				 _TIF_UPROBE | _TIF_FSCHECK | _TIF_SEA_NOTIFY)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index f2b4e81..ba3abf8 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -43,6 +43,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
+arm64-obj-$(CONFIG_ARM64_ERR_RECOV)	+= ras.o
 arm64-obj-$(CONFIG_ACPI_NUMA)		+= acpi_numa.o
 arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
diff --git a/arch/arm64/kernel/ras.c b/arch/arm64/kernel/ras.c
new file mode 100644
index 0000000..c48503c
--- /dev/null
+++ b/arch/arm64/kernel/ras.c
@@ -0,0 +1,142 @@
+/*
+ * ARM64 SEA error recoery support
+ *
+ * Copyright 2017 Huawei Technologies Co., Ltd.
+ *   Author: Xie XiuQi <xiexiuqi@huawei.com>
+ *   Author: Wang Xiongfeng <wangxiongfeng2@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation;
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/cper.h>
+#include <linux/mm.h>
+#include <linux/preempt.h>
+#include <linux/acpi.h>
+#include <linux/sched/signal.h>
+#include <linux/ras.h>
+
+#include <acpi/actbl1.h>
+#include <acpi/ghes.h>
+#include <acpi/apei.h>
+
+#include <asm/thread_info.h>
+#include <asm/atomic.h>
+#include <asm/ras.h>
+
+/*
+ * Need to save faulting physical address associated with a process
+ * in the sea ghes handler some place where we can grab it back
+ * later in sea_notify_process()
+ */
+#define SEA_INFO_MAX    16
+
+struct sea_info {
+	atomic_t                inuse;
+	struct task_struct      *t;
+	__u64                   paddr;
+} sea_info[SEA_INFO_MAX];
+
+static bool sea_save_info(__u64 addr)
+{
+	struct sea_info *si;
+
+	for (si = sea_info; si < &sea_info[SEA_INFO_MAX]; si++) {
+		if (atomic_cmpxchg(&si->inuse, 0, 1) == 0) {
+			si->t = current;
+			si->paddr = addr;
+			return true;
+		}
+	}
+
+	pr_err("Too many concurrent recoverable errors\n");
+	return false;
+}
+
+static struct sea_info *sea_find_info(void)
+{
+	struct sea_info *si;
+
+	for (si = sea_info; si < &sea_info[SEA_INFO_MAX]; si++)
+		if (atomic_read(&si->inuse) && si->t == current)
+			return si;
+	return NULL;
+}
+
+static void sea_clear_info(struct sea_info *si)
+{
+	atomic_set(&si->inuse, 0);
+}
+
+/*
+ * Called in process context that interrupted by SEA and marked with
+ * TIF_SEA_NOTIFY, just before returning to erroneous userland.
+ * This code is allowed to sleep.
+ * Attempt possible recovery such as calling the high level VM handler to
+ * process any corrupted pages, and kill/signal current process if required.
+ * Action required errors are handled here.
+ */
+void sea_notify_process(void)
+{
+	unsigned long pfn;
+	int fail = 0, flags = MF_ACTION_REQUIRED;
+	struct sea_info *si = sea_find_info();
+
+	if (!si)
+		panic("Lost physical address for consumed uncorrectable error");
+
+	clear_thread_flag(TIF_SEA_NOTIFY);
+	do {
+		pfn = si->paddr >> PAGE_SHIFT;
+
+
+		pr_err("Uncorrected hardware memory error in user-access at %llx\n",
+			si->paddr);
+		/*
+		 * We must call memory_failure() here even if the current process is
+		 * doomed. We still need to mark the page as poisoned and alert any
+		 * other users of the page.
+		 */
+		if (memory_failure(pfn, 0, flags) < 0)
+			fail++;
+
+		sea_clear_info(si);
+
+		si = sea_find_info();
+	} while (si);
+
+	if (fail) {
+		pr_err("Memory error not recovered\n");
+		force_sig(SIGBUS, current);
+	}
+}
+
+void ghes_arm_process_error(struct ghes *ghes, struct cper_sec_proc_arm *err)
+{
+	int i;
+	bool info_saved = false;
+	struct cper_arm_err_info *err_info;
+
+	log_arm_hw_error(err);
+
+	if ((ghes->generic->notify.type != ACPI_HEST_NOTIFY_SEA) ||
+	    (ghes->estatus->error_severity != CPER_SEV_RECOVERABLE))
+		return;
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	for (i = 0; i < err->err_info_num; i++, err_info++) {
+		if ((err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR) &&
+		    (err_info->type == CPER_ARM_INFO_TYPE_CACHE))
+			info_saved |= sea_save_info(err_info->physical_fault_addr);
+	}
+
+	if (info_saved)
+		set_thread_flag(TIF_SEA_NOTIFY);
+}
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0bdc96c..f2419af 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -40,6 +40,7 @@
 #include <asm/ptrace.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
+#include <asm/ras.h>
 
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
@@ -751,6 +752,12 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 	 */
 	trace_hardirqs_off();
 
+#ifdef CONFIG_ARM64_ERR_RECOV
+		/* notify userspace of pending SEAs */
+		if (unlikely(thread_flags & _TIF_SEA_NOTIFY))
+			sea_notify_process();
+#endif /* CONFIG_ARM64_ERR_RECOV */
+
 	do {
 		/* Check valid user FS if needed */
 		addr_limit_user_check();
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 89993c4..0fb6991 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -631,14 +631,25 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 			nmi_exit();
 	}
 
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code  = 0;
-	if (esr & ESR_ELx_FnV)
-		info.si_addr = NULL;
-	else
-		info.si_addr  = (void __user *)addr;
-	arm64_notify_die("", regs, &info, esr);
+	if (user_mode(regs)) {
+		if (test_thread_flag(TIF_SEA_NOTIFY))
+			return ret;
+
+		info.si_signo = SIGBUS;
+		info.si_errno = 0;
+		info.si_code  = 0;
+		if (esr & ESR_ELx_FnV)
+			info.si_addr = NULL;
+		else
+			info.si_addr  = (void __user *)addr;
+
+		current->thread.fault_address = 0;
+		current->thread.fault_code = esr;
+		force_sig_info(info.si_signo, &info, current);
+	} else {
+		die("Uncorrected hardware memory error in kernel-access\n",
+		    regs, esr);
+	}
 
 	return ret;
 }
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 077f9ba..2abf673 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -458,6 +458,12 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 #endif
 }
 
+void __weak ghes_arm_process_error(struct ghes *ghes,
+				   struct cper_sec_proc_arm *err)
+{
+	log_arm_hw_error(err);
+}
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -520,7 +526,7 @@ static void ghes_do_proc(struct ghes *ghes,
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 
-			log_arm_hw_error(err);
+			ghes_arm_process_error(ghes, err);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 9061c5c..8bcb8e5 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -120,4 +120,7 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
 
 int ghes_notify_sea(void);
 
+extern void ghes_arm_process_error(struct ghes *ghes,
+				   struct cper_sec_proc_arm *err);
+
 #endif /* GHES_H */
-- 
1.8.3.1
