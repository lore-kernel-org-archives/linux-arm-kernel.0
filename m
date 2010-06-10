From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Jun 2010 15:59:56 +0100
Subject: [PATCH 3/4] ARM: hw-breakpoint: add new ptrace requests for
	hw-breakpoint interaction
In-Reply-To: <1276181997-20677-3-git-send-email-will.deacon@arm.com>
References: <1276181997-20677-1-git-send-email-will.deacon@arm.com>
	<1276181997-20677-2-git-send-email-will.deacon@arm.com>
	<1276181997-20677-3-git-send-email-will.deacon@arm.com>
Message-ID: <1276181997-20677-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For debuggers to take advantage of the hw-breakpoint framework in the kernel,
it is necessary to expose the API calls via a ptrace interface.

This patch exposes the hardware breakpoints framework as a collection of
virtual registers, accesible using PTRACE_SETHBPREGS and PTRACE_GETHBPREGS
requests. The breakpoints are stored in the debug_info struct of the running
thread.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: S. Karthikeyan <informkarthik@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/processor.h |    4 +
 arch/arm/include/asm/ptrace.h    |    2 +
 arch/arm/kernel/hw_breakpoint.c  |   13 +++
 arch/arm/kernel/ptrace.c         |  196 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 215 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 6a89567..dbd33c3 100644
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
index 9dcb11e..21560e4 100644
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
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b249cd7..5d5faec 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -647,6 +647,19 @@ out:
 	return ret;
 }
 
+static int hw_breakpoint_thread_notify(struct notifier_block *self,
+				       unsigned long cmd, void *t)
+{
+	if (cmd == THREAD_NOTIFY_FLUSH)
+		flush_ptrace_hw_breakpoint(current);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block hw_breakpoint_thread_notifier_block = {
+	.notifier_call = hw_breakpoint_thread_notify,
+};
+
 /*
  * One-time initialisation.
  */
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3f562a7..51b9931 100644
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
@@ -751,6 +753,189 @@ static int ptrace_setvfpregs(struct task_struct *tsk, void __user *data)
 }
 #endif
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+/*
+ * Handle hitting a HW-breakpoint.
+ */
+static void ptrace_hbptriggered(struct perf_event *bp, int unused,
+				     struct perf_sample_data *data,
+				     struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
+	siginfo_t info;
+
+	info.si_signo	= SIGTRAP;
+	info.si_errno	= bkpt->ctrl.type;
+	info.si_code	= TRAP_HWBKPT;
+	info.si_addr	= (void __user *)(bkpt->trigger);
+
+	force_sig_info(SIGTRAP, &info, current);
+}
+
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	int i;
+	struct thread_struct *t = &tsk->thread;
+
+	for (i = 0; i < ARM_MAX_HBP_SLOTS; i++) {
+		unregister_hw_breakpoint(t->debug.hbp[i]);
+		t->debug.hbp[i] = NULL;
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
+static struct perf_event *ptrace_hbp_create(struct task_struct *tsk, int type)
+{
+	struct perf_event_attr attr;
+
+	hw_breakpoint_init(&attr);
+
+	/* Initialise fields to sane defaults. */
+	attr.bp_addr	= 0;
+	attr.bp_len	= HW_BREAKPOINT_LEN_4;
+	attr.type	= type;
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
+	struct arch_hw_breakpoint *arch_bp;
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
+		arch_bp = counter_arch_bp(bp);
+		if (idx & 0x1)
+			reg = encode_ctrl_reg(arch_bp->ctrl);
+		else
+			reg = arch_bp->address;
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
+	if (idx & 0x1) {
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
+		attr.disabled	= ~ctrl.enabled;
+	} else {
+		/* Address */
+		attr.bp_addr	= user_val;
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
@@ -820,6 +1005,17 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
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
