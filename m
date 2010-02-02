From: will.deacon@arm.com (Will Deacon)
Date: Tue,  2 Feb 2010 16:22:26 +0000
Subject: [RFC PATCH 2/4] ARM: hw-breakpoint: add ARM backend for the
	hw-breakpoint framework
In-Reply-To: <1265127748-4587-2-git-send-email-will.deacon@arm.com>
References: <1265127748-4587-1-git-send-email-will.deacon@arm.com>
	<1265127748-4587-2-git-send-email-will.deacon@arm.com>
Message-ID: <1265127748-4587-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hw-breakpoint framework in the kernel requires architecture-specific
support in order to install, remove, validate and manage hardware
breakpoints.

This patch adds preliminary support for this framework to the ARM
architecture, but restricts the number of watchpoints to a single resource
to get around the fact that the Data Fault Address Register is unpredictable
when a watchpoint debug exception is taken.

Additionally, the memory-mapped extended debug interface is unsupported
due to its unreliability in real implementations.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
---
 arch/arm/include/asm/hw_breakpoint.h |  113 ++++++
 arch/arm/kernel/hw_breakpoint.c      |  672 ++++++++++++++++++++++++++++++++++
 2 files changed, 785 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hw_breakpoint.h
 create mode 100644 arch/arm/kernel/hw_breakpoint.c

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
new file mode 100644
index 0000000..525dfcd
--- /dev/null
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -0,0 +1,113 @@
+#ifndef _ARM_HW_BREAKPOINT_H
+#define _ARM_HW_BREAKPOINT_H
+
+#ifdef __KERNEL__
+struct arch_hw_breakpoint {
+	char	*name;
+	u32	address;
+	u32	trigger;
+	u8	len;
+	u8	type;
+	u8	privilege;
+};
+
+/* Debug architecture numbers. */
+#define ARM_DEBUG_ARCH_V6	1
+#define ARM_DEBUG_ARCH_V6_1	2
+#define ARM_DEBUG_ARCH_V7_ECP14	3
+#define ARM_DEBUG_ARCH_V7_MM	4
+
+/* Breakpoint */
+#define ARM_BREAKPOINT_EXECUTE	0
+
+/* Watchpoints */
+#define ARM_BREAKPOINT_LOAD	1
+#define ARM_BREAKPOINT_STORE	2
+
+/* Privilege Levels */
+#define ARM_BREAKPOINT_SUPER	1
+#define ARM_BREAKPOINT_USER	2
+
+/* Lengths */
+#define ARM_BREAKPOINT_LEN_1	0x1
+#define ARM_BREAKPOINT_LEN_2	0x3
+#define ARM_BREAKPOINT_LEN_4	0xf
+#define ARM_BREAKPOINT_LEN_8	0xff
+
+/* Limits */
+#define ARM_MAX_BRP		16
+#define ARM_MAX_WRP		16
+#define HBP_NUM			(ARM_MAX_BRP + ARM_MAX_WRP)
+
+/* DSCR method of entry bits. */
+#define ARM_DSCR_MOE(x)			((x >> 2) & 0xf)
+#define ARM_ENTRY_BREAKPOINT		0x1
+#define ARM_ENTRY_ASYNC_WATCHPOINT	0x2
+#define ARM_ENTRY_SYNC_WATCHPOINT	0xa
+
+/* DSCR monitor/halting bits. */
+#define ARM_DSCR_HDBGEN		(1 << 14)
+#define ARM_DSCR_MDBGEN		(1 << 15)
+
+/* opcode2 numbers for the co-processor instructions. */
+#define ARM_OP2_BVR		4
+#define ARM_OP2_BCR		5
+#define ARM_OP2_WVR		6
+#define ARM_OP2_WCR		7
+
+/* Accessor macros for the debug registers. */
+#define ARM_DBG_READ(M, OP2, VAL) do {\
+	asm volatile("mrc p14, 0, %0, c0," #M ", " #OP2 : "=r" (VAL));\
+} while (0)
+
+#define ARM_DBG_WRITE(M, OP2, VAL) do {\
+	asm volatile("mcr p14, 0, %0, c0," #M ", " #OP2 : : "r" (VAL));\
+} while (0)
+
+/* ptrace interface macros and constants.
+ *
+ * command layout:
+ *
+ * 31    30 29 28   11 10  7 6   3 2  0
+ * +-------+--+-------+-----+-----+----+
+ * |Ver[00]|Op|  SBZ  | Num | Len |Type|
+ * +-------+--+-------+-----+-----+----+
+ *
+ * Op: 1 => insert, 0 => remove.
+ * Num: index into hbp field for thread_struct debug.
+ * Len: HW_BREAKPOINT_LEN_{1,2,4,8}.
+ * Type: HW_BREAKPOINT_{R,W,X}.
+ */
+#define PTRACE_HWBREAK_VER(x)		((x >> 30) & 3)
+#define PTRACE_HWBREAK_OP(x)		((x >> 29) & 1)
+#define PTRACE_HWBREAK_NUM(x)		((x >> 7) & 0xf)
+#define PTRACE_HWBREAK_LEN(x)		((x >> 3) & 0xf)
+#define PTRACE_HWBREAK_TYPE(x)		(x & 7)
+
+#define PTRACE_HWBREAK_OP_REMOVE	0
+#define PTRACE_HWBREAK_OP_INSERT	1
+
+#define PTRACE_HWBREAK_GET_NUM_BRPS	0
+#define PTRACE_HWBREAK_GET_NUM_WRPS	1
+
+struct notifier_block;
+struct perf_event;
+struct pmu;
+struct task_struct;
+
+extern struct pmu perf_ops_bp;
+extern int arch_check_va_in_userspace(unsigned long va, u8 hbp_len);
+extern int arch_validate_hwbkpt_settings(struct perf_event *bp,
+					 struct task_struct *tsk);
+extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+					   unsigned long val, void *data);
+
+int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void hw_breakpoint_pmu_read(struct perf_event *bp);
+void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
+
+unsigned int ptrace_get_num_brps(void);
+unsigned int ptrace_get_num_wrps(void);
+#endif	/* __KERNEL__ */
+#endif	/* _ARM_HW_BREAKPOINT_H */
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
new file mode 100644
index 0000000..1ccba1f
--- /dev/null
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -0,0 +1,672 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) 2009,2010 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+/*
+ * HW_breakpoint: a unified kernel/user-space hardware breakpoint facility,
+ * using the CPU's debug registers.
+ */
+#include <linux/errno.h>
+#include <linux/perf_event.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/kallsyms.h>
+#include <linux/smp.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+#include <asm/current.h>
+#include <asm/hw_breakpoint.h>
+#include <asm/kdebug.h>
+#include <asm/system.h>
+#include <asm/thread_notify.h>
+#include <asm/traps.h>
+
+/* Breakpoint currently in use for each BRP. */
+static DEFINE_PER_CPU(struct perf_event *, bp_on_reg[ARM_MAX_BRP]);
+
+/* Watchpoint currently in use for each WRP. */
+static DEFINE_PER_CPU(struct perf_event *, wp_on_reg[ARM_MAX_WRP]);
+
+/* Number of BRP/WRP registers on this CPU. */
+static int core_num_brps;
+static int core_num_wrps;
+
+/* Debug architecture version. */
+static u8 debug_arch;
+
+/* Maximum supported watchpoint length. */
+static u8 max_watchpoint_len;
+
+/* Determine number of BRP registers available. */
+static int get_num_brps(void)
+{
+	u32 didr;
+	ARM_DBG_READ(c0, 0, didr);
+	return ((didr >> 24) & 0xf) + 1;
+}
+
+/* Determine number of WRP registers available. */
+static int get_num_wrps(void)
+{
+	/*
+	 * FIXME: When a watchpoint fires, the only way to work out which
+	 * watchpoint it was is by disassembling the faulting instruction
+	 * and working out the address of the memory access.
+	 *
+	 * Furthermore, we can only do this if the watchpoint was precise
+	 * since imprecise watchpoints prevent us from calculating register
+	 * based addresses.
+	 *
+	 * For the time being, we only report 1 watchpoint register so we
+	 * always know which watchpoint fired. In the future we can either
+	 * add a disassembler and address generation emulator, or we can
+	 * insert a check to see if the DFAR is set on watchpoint exception
+	 * entry [the ARM ARM states that the DFAR is UNPREDICTABLE, but
+	 * experience shows that it is set on some implementations].
+	 */
+
+	/*
+	u32 didr, wrps;
+	ARM_DBG_READ(c0, 0, didr);
+	return ((didr >> 28) & 0xf) + 1;
+	*/
+
+	return 1;
+}
+
+unsigned int ptrace_get_num_brps(void)
+{
+	return core_num_brps;
+}
+
+unsigned int ptrace_get_num_wrps(void)
+{
+	return core_num_wrps;
+}
+
+/* Determine debug architecture. */
+static u8 get_debug_arch(void)
+{
+	u32 didr;
+
+	/* Do we implement the extended CPUID interface? */
+	if (((read_cpuid_id() >> 16) & 0xf) != 0xf) {
+		pr_warning("hw-breakpoint: CPUID feature registers not"
+				"supported. Assuming v6 debug is present.\n");
+		return ARM_DEBUG_ARCH_V6;
+	}
+
+	ARM_DBG_READ(c0, 0, didr);
+	return ((didr >> 16) & 0xf);
+}
+
+/*
+ * Template functions for accessing value/control registers.
+ * NB: THESE FUNCTIONS MUST NOT BE CALLED DIRECTLY!
+ */
+static DEFINE_PER_CPU(u32, insn_buffer[2]);
+
+static __naked void noinline __read_wb_reg(void)
+{
+	asm volatile("mrc p14, 0, r0, c0, c0, 5\n"
+		     "mov pc, lr");
+}
+
+static __naked void noinline __write_wb_reg(void)
+{
+	asm volatile("mcr p14, 0, r0, c0, c0, 5\n"
+		     "mov pc, lr");
+}
+
+/*
+ * Read a value/control register for a breakpoint/watchpoint.
+ */
+static u32 read_wb_reg(int op2, int n)
+{
+	u32 res, *buf = __get_cpu_var(insn_buffer);
+	u8 fixup = ((op2 << 5) | (1 << 4) | n) & 0xff;
+
+	buf[0] = ((u32 *)__read_wb_reg)[0] & ~0xff;
+	buf[0] |= fixup;
+	buf[1] = ((u32 *)__read_wb_reg)[1];
+
+	flush_icache_range((u32)buf, (u32)(buf + 0x40));
+
+	((void(*)(void))buf)();
+	asm volatile("mov %0, r0" : "=r" (res));
+
+	return res;
+}
+
+/*
+ * Write to the control register for a breakpoint/watchpoint.
+ */
+static void write_wb_reg(int op2, int n, u32 data)
+{
+	u32 *buf = __get_cpu_var(insn_buffer);
+	u8 fixup = ((op2 << 5) | (1 << 4) | n) & 0xff;
+
+	buf[0] = ((u32 *)__write_wb_reg)[0] & ~0xff;
+	buf[0] |= fixup;
+	buf[1] = ((u32 *)__write_wb_reg)[1];
+
+	flush_icache_range((u32)buf, (u32)(buf + 0x40));
+
+	asm volatile("mov r0, %0" :: "r" (data));
+	((void(*)(void))buf)();
+}
+
+/*
+ * In order to access the breakpoint/watchpoint control registers,
+ * we must be running in debug monitor mode. Unfortunately, we can
+ * be put into halting debug mode@any time by an external debugger
+ * but there is nothing we can do to prevent that.
+ */
+static int enable_monitor_mode(void)
+{
+	u32 dscr;
+	int ret = 0;
+
+	ARM_DBG_READ(c1, 0, dscr);
+
+	/* Ensure that halting mode is disabled. */
+	if (dscr & ARM_DSCR_HDBGEN) {
+		pr_info("hw-breakpoint: halting debug mode enabled. "
+			"Unable to access hardware resources.\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+	/* Write to the corresponding DSCR. */
+	switch (debug_arch) {
+	case ARM_DEBUG_ARCH_V6:
+	case ARM_DEBUG_ARCH_V6_1:
+		ARM_DBG_WRITE(c1, 0, (dscr | ARM_DSCR_MDBGEN));
+		break;
+	case ARM_DEBUG_ARCH_V7_ECP14:
+		ARM_DBG_WRITE(c2, 2, (dscr | ARM_DSCR_MDBGEN));
+		break;
+	default:
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* Check that the write made it through. */
+	ARM_DBG_READ(c1, 0, dscr);
+	if (!(dscr & ARM_DSCR_MDBGEN)) {
+		pr_info("hw-breakpoint: failed to enable monitor mode. ");
+		ret = -EPERM;
+	}
+
+out:
+	return ret;
+}
+
+/*
+ * Check if 8-bit byte-address select is available.
+ * This clobbers WRP 0.
+ */
+static u8 get_max_watchpoint_len(void)
+{
+	u32 ctrl;
+	u8 size = 4;
+
+	if (debug_arch < ARM_DEBUG_ARCH_V7_ECP14)
+		goto out;
+
+	if (enable_monitor_mode())
+		goto out;
+
+	ctrl = ARM_BREAKPOINT_LEN_8 << 5;
+	write_wb_reg(ARM_OP2_WVR, 0, 0);
+	write_wb_reg(ARM_OP2_WCR, 0, ctrl);
+	if ((read_wb_reg(ARM_OP2_WCR, 0) & ctrl) == ctrl)
+		size = 8;
+
+out:
+	return size;
+}
+
+/*
+ * Install a perf counter breakpoint.
+ */
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct perf_event **slot, **slots;
+	int i, max_slots, ctrl_op2, val_op2, ret = 0;
+
+	/* Ensure that we are in monitor mode and halting mode is disabled. */
+	ret = enable_monitor_mode();
+	if (ret)
+		goto out;
+
+	if (info->type == ARM_BREAKPOINT_EXECUTE) {
+		/* Breakpoint */
+		ctrl_op2 = ARM_OP2_BCR;
+		val_op2 = ARM_OP2_BVR;
+		slots = __get_cpu_var(bp_on_reg);
+		max_slots = core_num_brps;
+	} else {
+		/* Watchpoint */
+		ctrl_op2 = ARM_OP2_WCR;
+		val_op2 = ARM_OP2_WVR;
+		slots = __get_cpu_var(wp_on_reg);
+		max_slots = core_num_wrps;
+	}
+
+	for (i = 0; i < max_slots; ++i) {
+		slot = &slots[i];
+
+		if (!*slot) {
+			*slot = bp;
+			break;
+		}
+	}
+
+	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot")) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* Setup the address register. */
+	write_wb_reg(val_op2, i, info->address);
+
+	/* Setup the control register. */
+	write_wb_reg(ctrl_op2, i, (info->type << 3) | (info->privilege << 1) |
+			(info->len << 5) | 1);
+
+out:
+	return ret;
+}
+
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct perf_event **slot, **slots;
+	int i, max_slots, op2;
+
+	if (info->type == ARM_BREAKPOINT_EXECUTE) {
+		/* Breakpoint */
+		op2 = ARM_OP2_BCR;
+		slots = __get_cpu_var(bp_on_reg);
+		max_slots = core_num_brps;
+	} else {
+		/* Watchpoint */
+		op2 = ARM_OP2_WCR;
+		slots = __get_cpu_var(wp_on_reg);
+		max_slots = core_num_wrps;
+	}
+
+	/* Remove the breakpoint. */
+	for (i = 0; i < max_slots; ++i) {
+		slot = &slots[i];
+
+		if (*slot == bp) {
+			*slot = NULL;
+			break;
+		}
+	}
+
+	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot"))
+		return;
+
+	/* Reset the control register. */
+	write_wb_reg(op2, i, 0);
+}
+
+static int get_hbp_len(u8 hbp_len)
+{
+	unsigned int len_in_bytes = 0;
+
+	switch (hbp_len) {
+	case ARM_BREAKPOINT_LEN_1:
+		len_in_bytes = 1;
+		break;
+	case ARM_BREAKPOINT_LEN_2:
+		len_in_bytes = 2;
+		break;
+	case ARM_BREAKPOINT_LEN_4:
+		len_in_bytes = 4;
+		break;
+	}
+
+	return len_in_bytes;
+}
+
+/*
+ * Check for virtual address in user space.
+ */
+int arch_check_va_in_userspace(unsigned long va, u8 hbp_len)
+{
+	unsigned int len;
+
+	len = get_hbp_len(hbp_len);
+
+	return (va <= TASK_SIZE - len);
+}
+
+/*
+ * Check for virtual address in kernel space.
+ */
+static int arch_check_va_in_kernelspace(unsigned long va, u8 hbp_len)
+{
+	unsigned int len;
+
+	len = get_hbp_len(hbp_len);
+
+	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
+}
+
+/*
+ * Construct an arch_hw_breakpoint from a perf_event.
+ */
+static int arch_build_bp_info(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+
+	/* Type */
+	switch (bp->attr.bp_type) {
+	case HW_BREAKPOINT_X:
+		info->type = ARM_BREAKPOINT_EXECUTE;
+		break;
+	case HW_BREAKPOINT_R:
+		info->type = ARM_BREAKPOINT_LOAD;
+		break;
+	case HW_BREAKPOINT_W:
+		info->type = ARM_BREAKPOINT_STORE;
+		break;
+	case HW_BREAKPOINT_R | HW_BREAKPOINT_W:
+		info->type = ARM_BREAKPOINT_LOAD | ARM_BREAKPOINT_STORE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Len */
+	switch (bp->attr.bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+		info->len = ARM_BREAKPOINT_LEN_1;
+		break;
+	case HW_BREAKPOINT_LEN_2:
+		info->len = ARM_BREAKPOINT_LEN_2;
+		break;
+	case HW_BREAKPOINT_LEN_4:
+		info->len = ARM_BREAKPOINT_LEN_4;
+		break;
+	case HW_BREAKPOINT_LEN_8:
+		info->len = ARM_BREAKPOINT_LEN_8;
+		if ((info->type != ARM_BREAKPOINT_EXECUTE)
+			&& max_watchpoint_len == 8)
+			break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Privilege */
+	if (arch_check_va_in_userspace(info->address, info->len))
+		info->privilege = ARM_BREAKPOINT_USER;
+	else if (arch_check_va_in_kernelspace(info->address, info->len))
+		info->privilege = ARM_BREAKPOINT_SUPER;
+	else
+		return -EINVAL;
+
+	/* Address */
+	info->address = bp->attr.bp_addr;
+	if (info->name)
+		info->address = (unsigned long)
+				kallsyms_lookup_name(info->name);
+
+	if (!info->address)
+		return -EINVAL;
+
+	/*
+	 * Don't allow kernel watchpoints or kernel breakpoints in the
+	 * exception section.
+	 */
+	if (info->privilege == ARM_BREAKPOINT_SUPER &&
+		(info->type != ARM_BREAKPOINT_EXECUTE ||
+		 in_exception_text(info->address)))
+			return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Validate the arch-specific HW Breakpoint register settings.
+ */
+int arch_validate_hwbkpt_settings(struct perf_event *bp,
+				  struct task_struct *tsk)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	int ret = 0;
+	u32 alignment_mask = 0x3;
+
+	/* Build the arch_hw_breakpoint. */
+	ret = arch_build_bp_info(bp);
+	if (ret)
+		goto out;
+
+	/* Check address alignment. */
+	if (info->len == ARM_BREAKPOINT_LEN_8)
+		alignment_mask = 0x7;
+	if (info->address & alignment_mask) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Check that the virtual address is in the proper range. */
+	if (tsk) {
+		if (!(info->privilege & ARM_BREAKPOINT_USER)) {
+			ret = -EFAULT;
+			goto out;
+		}
+	} else {
+		if (!(info->privilege & ARM_BREAKPOINT_SUPER)) {
+			ret = -EFAULT;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+/*
+ * Release the user breakpoints used by ptrace.
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	int i;
+	struct thread_struct *t = &tsk->thread;
+
+	for (i = 0; i < HBP_NUM; i++) {
+		unregister_hw_breakpoint(t->debug.hbp[i]);
+		t->debug.hbp[i] = NULL;
+	}
+}
+
+static int hw_breakpoint_thread_notify(struct notifier_block *self,
+					unsigned long cmd, void *t)
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
+static void watchpoint_handler(unsigned long unpredictable,
+				struct pt_regs *regs)
+{
+	int i;
+	struct perf_event **slots = __get_cpu_var(wp_on_reg);
+	struct arch_hw_breakpoint *info;
+
+	for (i = 0; i < core_num_wrps; ++i) {
+		rcu_read_lock();
+
+		if (slots[i] == NULL) {
+			rcu_read_unlock();
+			break;
+		}
+
+		/* TODO: Check if this watchpoint actually fired. */
+
+		/*
+		 * The DFAR is unpredictable. Since we only allow a
+		 * single watchpoint, we can set the trigger to the lowest
+		 * possible faulting address.
+		 */
+		info = counter_arch_bp(slots[i]);
+		info->trigger = info->address;
+		perf_bp_event(slots[i], regs);
+
+		rcu_read_unlock();
+	}
+}
+
+static void breakpoint_handler(unsigned long unpredictable,
+				struct pt_regs *regs)
+{
+	int i;
+	u32 ctrl, val, addr;
+	struct perf_event **slots = __get_cpu_var(bp_on_reg);
+	struct arch_hw_breakpoint *info;
+
+	/* The exception entry code places the amended lr in the PC. */
+	addr = regs->ARM_pc;
+
+	for (i = 0; i < core_num_brps; ++i) {
+		rcu_read_lock();
+
+		if (slots[i] == NULL) {
+			rcu_read_unlock();
+			break;
+		}
+
+		/* Check if the breakpoint value matches. */
+		val = read_wb_reg(ARM_OP2_BVR, i);
+		if (val != (addr & ~0x3))
+			continue;
+
+		/* Possible match, check the byte address select to confirm. */
+		ctrl = read_wb_reg(ARM_OP2_BCR, i);
+		if ((1 << (addr & 0x3)) & ((ctrl >> 5) & 0xf)) {
+			info = counter_arch_bp(slots[i]);
+			info->trigger = addr;
+			perf_bp_event(slots[i], regs);
+		}
+
+		rcu_read_unlock();
+	}
+}
+
+/*
+ * Called from either the Data Abort Handler [watchpoint] or the
+ * Prefetch Abort Handler [breakpoint].
+ */
+static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
+					struct pt_regs *regs)
+{
+	int ret = 1; /* Unhandled fault. */
+	u32 dscr;
+
+	/* We only handle watchpoints and hardware breakpoints. */
+	ARM_DBG_READ(c1, 0, dscr);
+
+	/* Perform perf callbacks. */
+	switch (ARM_DSCR_MOE(dscr)) {
+	case ARM_ENTRY_BREAKPOINT:
+		breakpoint_handler(addr, regs);
+		break;
+	case ARM_ENTRY_ASYNC_WATCHPOINT:
+	case ARM_ENTRY_SYNC_WATCHPOINT:
+		watchpoint_handler(addr, regs);
+		break;
+	default:
+		goto out;
+	}
+
+	ret = 0;
+out:
+	return ret;
+}
+
+/*
+ * One-time initialisation.
+ */
+static int __init arch_hw_breakpoint_init(void)
+{
+	int ret = 0;
+
+	debug_arch = get_debug_arch();
+
+	if (debug_arch > ARM_DEBUG_ARCH_V7_ECP14) {
+		pr_info("hw-breakpoint: debug architecture "
+				"0x%x unsupported.\n", debug_arch);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* Determine how many BRPs/WRPs are available. */
+	core_num_brps = get_num_brps();
+	core_num_wrps = get_num_wrps();
+
+	pr_info("hw-breakpoint: found %d breakpoint "
+		"and %d watchpoint registers.\n", core_num_brps, core_num_wrps);
+
+	/* Work out the maximum supported watchpoint length. */
+	max_watchpoint_len = get_max_watchpoint_len();
+	pr_info("hw-breakpoint: maximum watchpoint size is %u bytes.\n",
+			max_watchpoint_len);
+
+	/* Register thread flush notifier. */
+	thread_register_notifier(&hw_breakpoint_thread_notifier_block);
+
+	/* Register debug fault handler. */
+	hook_fault_code(2, hw_breakpoint_pending, SIGTRAP, "debug exception");
+	hook_ifault_code(2, hw_breakpoint_pending, SIGTRAP, "debug exception");
+
+out:
+	return ret;
+}
+arch_initcall(arch_hw_breakpoint_init);
+
+void hw_breakpoint_pmu_read(struct perf_event *bp)
+{
+	/* TODO */
+}
+
+void hw_breakpoint_pmu_unthrottle(struct perf_event *bp)
+{
+	/* TODO */
+}
+
+/*
+ * Dummy function to register with die_notifier.
+ */
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+					unsigned long val, void *data)
+{
+	return NOTIFY_DONE;
+}
-- 
1.6.5.7
