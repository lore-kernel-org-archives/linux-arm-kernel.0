From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Aug 2010 16:54:56 +0100
Subject: [PATCH 3/4] ARM: hw-breakpoint: add new ptrace requests for
	hw-breakpoint interaction
In-Reply-To: <1282578897-23247-3-git-send-email-will.deacon@arm.com>
References: <1282578897-23247-1-git-send-email-will.deacon@arm.com>
	<1282578897-23247-2-git-send-email-will.deacon@arm.com>
	<1282578897-23247-3-git-send-email-will.deacon@arm.com>
Message-ID: <1282578897-23247-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For debuggers to take advantage of the hw-breakpoint framework in the kernel,
it is necessary to expose the API calls via a ptrace interface.

This patch exposes the hardware breakpoints framework as a collection of
virtual registers, accesible using PTRACE_SETHBPREGS and PTRACE_GETHBPREGS
requests. The breakpoints are stored in the debug_info struct of the running
thread.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: S. Karthikeyan <informkarthik@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hw_breakpoint.h |   12 ++-
 arch/arm/include/asm/processor.h     |    4 +
 arch/arm/include/asm/ptrace.h        |    2 +
 arch/arm/kernel/process.c            |    5 +
 arch/arm/kernel/ptrace.c             |  239 ++++++++++++++++++++++++++++++++++
 5 files changed, 261 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index 576ec04..c197144 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -2,6 +2,11 @@
 #define _ARM_HW_BREAKPOINT_H
 
 #ifdef __KERNEL__
+
+struct task_struct;
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+
 struct arch_hw_breakpoint_ctrl {
 		u32 __reserved	: 9,
 		mismatch	: 1,
@@ -101,7 +106,6 @@ static inline void decode_ctrl_reg(u32 reg,
 struct notifier_block;
 struct perf_event;
 struct pmu;
-struct task_struct;
 
 extern struct pmu perf_ops_bp;
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
@@ -110,13 +114,19 @@ extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
+
 extern u8 arch_get_debug_arch(void);
 extern u8 arch_get_max_wp_len(void);
+extern void clear_ptrace_hw_breakpoint(struct task_struct *tsk);
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 int hw_breakpoint_slots(int type);
 
+#else
+static inline void clear_ptrace_hw_breakpoint(struct task_struct *tsk) {}
+
+#endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* __KERNEL__ */
 #endif	/* _ARM_HW_BREAKPOINT_H */
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 7bed3da..67357ba 100644
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
+	struct perf_event	*hbp[ARM_MAX_HBP_SLOTS];
+#endif
 };
 
 struct thread_struct {
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 7ce15eb..783d50f 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -29,6 +29,8 @@
 #define PTRACE_SETCRUNCHREGS	26
 #define PTRACE_GETVFPREGS	27
 #define PTRACE_SETVFPREGS	28
+#define PTRACE_GETHBPREGS	29
+#define PTRACE_SETHBPREGS	30
 
 /*
  * PSR bits
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 401e38b..974af1c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/utsname.h>
 #include <linux/uaccess.h>
 #include <linux/random.h>
+#include <linux/hw_breakpoint.h>
 
 #include <asm/cacheflush.h>
 #include <asm/leds.h>
@@ -317,6 +318,8 @@ void flush_thread(void)
 	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = current;
 
+	flush_ptrace_hw_breakpoint(tsk);
+
 	memset(thread->used_cp, 0, sizeof(thread->used_cp));
 	memset(&tsk->thread.debug, 0, sizeof(struct debug_info));
 	memset(&thread->fpstate, 0, sizeof(union fp_state));
@@ -345,6 +348,8 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	thread->cpu_context.sp = (unsigned long)childregs;
 	thread->cpu_context.pc = (unsigned long)ret_from_fork;
 
+	clear_ptrace_hw_breakpoint(p);
+
 	if (clone_flags & CLONE_SETTLS)
 		thread->tp_value = regs->ARM_r3;
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index f99d489..e0cb637 100644
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
@@ -847,6 +849,232 @@ static int ptrace_setvfpregs(struct task_struct *tsk, void __user *data)
 }
 #endif
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+/*
+ * Convert a virtual register number into an index for a thread_info
+ * breakpoint array. Breakpoints are identified using positive numbers
+ * whilst watchpoints are negative. The registers are laid out as pairs
+ * of (address, control), each pair mapping to a unique hw_breakpoint struct.
+ * Register 0 is reserved for describing resource information.
+ */
+static int ptrace_hbp_num_to_idx(long num)
+{
+	if (num < 0)
+		num = (ARM_MAX_BRP << 1) - num;
+	return (num - 1) >> 1;
+}
+
+/*
+ * Returns the virtual register number for the address of the
+ * breakpoint at index idx.
+ */
+static long ptrace_hbp_idx_to_num(int idx)
+{
+	long mid = ARM_MAX_BRP << 1;
+	long num = (idx << 1) + 1;
+	return num > mid ? mid - num : num;
+}
+
+/*
+ * Handle hitting a HW-breakpoint.
+ */
+static void ptrace_hbptriggered(struct perf_event *bp, int unused,
+				     struct perf_sample_data *data,
+				     struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
+	long num;
+	int i;
+	siginfo_t info;
+
+	for (i = 0; i < ARM_MAX_HBP_SLOTS; ++i)
+		if (current->thread.debug.hbp[i] == bp)
+			break;
+
+	num = (i == ARM_MAX_HBP_SLOTS) ? 0 : ptrace_hbp_idx_to_num(i);
+
+	info.si_signo	= SIGTRAP;
+	info.si_errno	= (int)num;
+	info.si_code	= TRAP_HWBKPT;
+	info.si_addr	= (void __user *)(bkpt->trigger);
+
+	force_sig_info(SIGTRAP, &info, current);
+}
+
+/*
+ * Set ptrace breakpoint pointers to zero for this task.
+ * This is required in order to prevent child processes from unregistering
+ * breakpoints held by their parent.
+ */
+void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	memset(tsk->thread.debug.hbp, 0, sizeof(tsk->thread.debug.hbp));
+}
+
+/*
+ * Unregister breakpoints from this task and reset the pointers in
+ * the thread_struct.
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	int i;
+	struct thread_struct *t = &tsk->thread;
+
+	for (i = 0; i < ARM_MAX_HBP_SLOTS; i++) {
+		if (t->debug.hbp[i]) {
+			unregister_hw_breakpoint(t->debug.hbp[i]);
+			t->debug.hbp[i] = NULL;
+		}
+	}
+}
+
+static u32 ptrace_get_hbp_resource_info(void)
+{
+	u8 num_brps, num_wrps, debug_arch, wp_len;
+	u32 reg = 0;
+
+	num_brps	= hw_breakpoint_slots(TYPE_INST);
+	num_wrps	= hw_breakpoint_slots(TYPE_DATA);
+	debug_arch	= arch_get_debug_arch();
+	wp_len		= arch_get_max_wp_len();
+
+	reg		|= debug_arch;
+	reg		<<= 8;
+	reg		|= wp_len;
+	reg		<<= 8;
+	reg		|= num_wrps;
+	reg		<<= 8;
+	reg		|= num_brps;
+
+	return reg;
+}
+
+static struct perf_event *ptrace_hbp_create(struct task_struct *tsk, int type)
+{
+	struct perf_event_attr attr;
+
+	ptrace_breakpoint_init(&attr);
+
+	/* Initialise fields to sane defaults. */
+	attr.bp_addr	= 0;
+	attr.bp_len	= HW_BREAKPOINT_LEN_4;
+	attr.bp_type	= type;
+	attr.disabled	= 1;
+
+	return register_user_hw_breakpoint(&attr, ptrace_hbptriggered, tsk);
+}
+
+static int ptrace_gethbpregs(struct task_struct *tsk, long num,
+			     unsigned long  __user *data)
+{
+	u32 reg;
+	int idx, ret = 0;
+	struct perf_event *bp;
+	struct arch_hw_breakpoint_ctrl arch_ctrl;
+
+	if (num == 0) {
+		reg = ptrace_get_hbp_resource_info();
+	} else {
+		idx = ptrace_hbp_num_to_idx(num);
+		if (idx < 0 || idx >= ARM_MAX_HBP_SLOTS) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		bp = tsk->thread.debug.hbp[idx];
+		if (!bp) {
+			reg = 0;
+			goto put;
+		}
+
+		arch_ctrl = counter_arch_bp(bp)->ctrl;
+
+		/*
+		 * Fix up the len because we may have adjusted it
+		 * to compensate for an unaligned address.
+		 */
+		while (!(arch_ctrl.len & 0x1))
+			arch_ctrl.len >>= 1;
+
+		if (idx & 0x1)
+			reg = encode_ctrl_reg(arch_ctrl);
+		else
+			reg = bp->attr.bp_addr;
+	}
+
+put:
+	if (put_user(reg, data))
+		ret = -EFAULT;
+
+out:
+	return ret;
+}
+
+static int ptrace_sethbpregs(struct task_struct *tsk, long num,
+			     unsigned long __user *data)
+{
+	int idx, gen_len, gen_type, implied_type, ret = 0;
+	u32 user_val;
+	struct perf_event *bp;
+	struct arch_hw_breakpoint_ctrl ctrl;
+	struct perf_event_attr attr;
+
+	if (num == 0)
+		goto out;
+	else if (num < 0)
+		implied_type = HW_BREAKPOINT_RW;
+	else
+		implied_type = HW_BREAKPOINT_X;
+
+	idx = ptrace_hbp_num_to_idx(num);
+	if (idx < 0 || idx >= ARM_MAX_HBP_SLOTS) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (get_user(user_val, data)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	bp = tsk->thread.debug.hbp[idx];
+	if (!bp) {
+		bp = ptrace_hbp_create(tsk, implied_type);
+		if (IS_ERR(bp)) {
+			ret = PTR_ERR(bp);
+			goto out;
+		}
+		tsk->thread.debug.hbp[idx] = bp;
+	}
+
+	attr = bp->attr;
+
+	if (num & 0x1) {
+		/* Address */
+		attr.bp_addr	= user_val;
+	} else {
+		/* Control */
+		decode_ctrl_reg(user_val, &ctrl);
+		ret = arch_bp_generic_fields(ctrl, &gen_len, &gen_type);
+		if (ret)
+			goto out;
+
+		if ((gen_type & implied_type) != gen_type) {
+				ret = -EINVAL;
+				goto out;
+		}
+
+		attr.bp_len	= gen_len;
+		attr.bp_type	= gen_type;
+		attr.disabled	= !ctrl.enabled;
+	}
+
+	ret = modify_user_hw_breakpoint(bp, &attr);
+out:
+	return ret;
+}
+#endif
+
 long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
 	int ret;
@@ -916,6 +1144,17 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 			break;
 #endif
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+		case PTRACE_GETHBPREGS:
+			ret = ptrace_gethbpregs(child, addr,
+						(unsigned long __user *)data);
+			break;
+		case PTRACE_SETHBPREGS:
+			ret = ptrace_sethbpregs(child, addr,
+						(unsigned long __user *)data);
+			break;
+#endif
+
 		default:
 			ret = ptrace_request(child, request, addr, data);
 			break;
-- 
1.6.3.3
