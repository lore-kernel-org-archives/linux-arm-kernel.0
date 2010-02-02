From: will.deacon@arm.com (Will Deacon)
Date: Tue,  2 Feb 2010 16:22:27 +0000
Subject: [RFC PATCH 3/4] ARM: hw-breakpoint: add new ptrace requests for
	hw-breakpoint interaction
In-Reply-To: <1265127748-4587-3-git-send-email-will.deacon@arm.com>
References: <1265127748-4587-1-git-send-email-will.deacon@arm.com>
	<1265127748-4587-2-git-send-email-will.deacon@arm.com>
	<1265127748-4587-3-git-send-email-will.deacon@arm.com>
Message-ID: <1265127748-4587-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For debuggers to take advantage of the hw-breakpoint framework in the kernel,
it is necessary to expose the API calls via a ptrace interface.

This patch adds support for a debugger to insert, modify and remove hardware
breakpoints using PTRACE_SET_HWBKPT requests. The breakpoints are stored in
the debug_info struct of the running thread. A further request,
PTRACE_GET_HWBKPT can be used to query the number of hardware resources
available.

The ptrace interaction is controlled using a 32-bit word, as described in
arch/arm/include/asm/hw_breakpoint.h.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/processor.h |    4 +
 arch/arm/include/asm/ptrace.h    |    2 +
 arch/arm/kernel/ptrace.c         |  158 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 6a89567..ddb0953 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -19,6 +19,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/hw_breakpoint.h>
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
@@ -41,6 +42,9 @@ struct debug_entry {
 struct debug_info {
 	int			nsaved;
 	struct debug_entry	bp[2];
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	struct perf_event	*hbp[HBP_NUM];
+#endif
 };
 
 struct thread_struct {
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index eec6e89..ea35e4e 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -29,6 +29,8 @@
 #define PTRACE_SETCRUNCHREGS	26
 #define PTRACE_GETVFPREGS	27
 #define PTRACE_SETVFPREGS	28
+#define PTRACE_GET_HWBKPT	29
+#define PTRACE_SET_HWBKPT	30
 
 /*
  * PSR bits
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index a2ea385..1e02bc5 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -19,6 +19,8 @@
 #include <linux/init.h>
 #include <linux/signal.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
+#include <linux/hw_breakpoint.h>
 
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -707,6 +709,152 @@ static int ptrace_setvfpregs(struct task_struct *tsk, void __user *data)
 }
 #endif
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+/*
+ * Handle hitting a HW-breakpoint.
+ */
+static void ptrace_hwbreak_triggered(struct perf_event *bp, int unused,
+					struct perf_sample_data *data,
+					struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
+	siginfo_t info;
+
+	info.si_signo	= SIGTRAP;
+	info.si_errno	= bp->attr.bp_type;
+	info.si_code	= TRAP_HWBKPT;
+	info.si_addr	= (void __user *)(bkpt->trigger);
+
+	force_sig_info(SIGTRAP, &info, current);
+}
+
+static int ptrace_insert_hwbkpt(struct task_struct *tsk, unsigned long addr,
+				u8 n, u8 len, u8 type)
+{
+	struct perf_event *bp;
+	struct thread_struct *t = &tsk->thread;
+	struct perf_event_attr attr;
+	int ret = 0;
+
+	/* Watchpoints live in the upper indices. */
+	if ((type & HW_BREAKPOINT_X) == 0)
+		n += ARM_MAX_BRP;
+
+	if (n >= HBP_NUM) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	if (!t->debug.hbp[n]) {
+		/* New breakpoint. */
+		hw_breakpoint_init(&attr);
+		attr.bp_addr = addr;
+		attr.bp_len = len;
+		attr.bp_type = type;
+
+		bp = register_user_hw_breakpoint(&attr,
+				ptrace_hwbreak_triggered, tsk);
+		if (IS_ERR(bp))
+			ret = PTR_ERR(bp);
+		else
+			t->debug.hbp[n] = bp;
+	} else {
+		/* Existing breakpoint. */
+		bp = t->debug.hbp[n];
+		attr = bp->attr;
+		attr.bp_addr = addr;
+		attr.bp_len = len;
+		attr.disabled = 0;
+		ret = modify_user_hw_breakpoint(bp, &attr);
+	}
+
+out:
+	return ret;
+}
+
+static int ptrace_remove_hwbkpt(struct task_struct *tsk, u8 n, u8 type)
+{
+	struct perf_event *bp;
+	struct thread_struct *t = &tsk->thread;
+	struct perf_event_attr attr;
+	int ret = -EINVAL;
+
+	if ((type & HW_BREAKPOINT_X) == 0)
+		n += ARM_MAX_BRP;
+
+	if (n < HBP_NUM) {
+		bp = t->debug.hbp[n];
+		if (bp == NULL)
+			goto out;
+		attr = bp->attr;
+		attr.disabled = 1;
+		ret = modify_user_hw_breakpoint(bp, &attr);
+	} else {
+		ret = -ENOSPC;
+	}
+
+out:
+	return ret;
+}
+
+static int ptrace_get_hwbkpt(struct task_struct *tsk, long addr,
+				unsigned long __user *data)
+{
+	unsigned long num;
+	int ret = 0;
+
+	switch (addr) {
+	case PTRACE_HWBREAK_GET_NUM_BRPS:
+		num = ptrace_get_num_brps();
+		break;
+	case PTRACE_HWBREAK_GET_NUM_WRPS:
+		num = ptrace_get_num_wrps();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (!ret && put_user(num, data))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+static int ptrace_set_hwbkpt(struct task_struct *tsk, long addr,
+				unsigned long data)
+{
+	int ret;
+	u8 num, len, type;
+
+	/* Check version field. */
+	if (PTRACE_HWBREAK_VER(data) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Extract data fields. */
+	num = PTRACE_HWBREAK_NUM(data);
+	len = PTRACE_HWBREAK_LEN(data);
+	type = PTRACE_HWBREAK_TYPE(data);
+
+	/* Insert or remove the breakpoint. */
+	switch (PTRACE_HWBREAK_OP(data)) {
+	case PTRACE_HWBREAK_OP_REMOVE:
+		ret = ptrace_remove_hwbkpt(tsk, num, type);
+		break;
+	case PTRACE_HWBREAK_OP_INSERT:
+		ret = ptrace_insert_hwbkpt(tsk, addr, num, len, type);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+out:
+	return ret;
+}
+
+#endif
+
 long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
 	int ret;
@@ -839,6 +987,16 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 			break;
 #endif
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+		case PTRACE_GET_HWBKPT:
+			ret = ptrace_get_hwbkpt(child, addr,
+						(unsigned long __user *)data);
+			break;
+		case PTRACE_SET_HWBKPT:
+			ret = ptrace_set_hwbkpt(child, addr, data);
+			break;
+#endif
+
 		default:
 			ret = ptrace_request(child, request, addr, data);
 			break;
-- 
1.6.5.7
