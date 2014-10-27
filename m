From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 27 Oct 2014 18:40:05 +0000
Subject: [PATCHv3 3/5] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1414435207-30240-5-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Typically, providing support for legacy instructions requires
emulating the behaviour of instructions whose encodings have become
undefined. If the instructions haven't been removed from the
architecture, there maybe an option in the implementation to turn
on/off the support for these instructions.

Create common infrastructure to support legacy instruction
emulation. In addition to emulation, also provide an option to support
hardware execution when supported. The default execution mode (one of
undef, emulate, hw exeuction) is dependent on the state of the
instruction (deprecated or obsolete) in the architecture and
can specified at the time of registering the instruction handlers. The
runtime state of the emulation can be controlled by writing to
individual nodes in sysctl. The expected default behaviour is
documented as part of this patch.

Use the new infrastructure to port the emulation of the SWP and SWPB
instructions using LDXR/STXR sequences from the arm port to arm64.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 Documentation/arm64/legacy_instructions.txt |  40 +++
 arch/arm64/Kconfig                          |  39 +++
 arch/arm64/include/asm/insn.h               |   6 +
 arch/arm64/kernel/Makefile                  |   1 +
 arch/arm64/kernel/armv8_deprecated.c        | 402 ++++++++++++++++++++++++++++
 arch/arm64/kernel/insn.c                    |   8 +
 6 files changed, 496 insertions(+)
 create mode 100644 Documentation/arm64/legacy_instructions.txt
 create mode 100644 arch/arm64/kernel/armv8_deprecated.c

diff --git a/Documentation/arm64/legacy_instructions.txt b/Documentation/arm64/legacy_instructions.txt
new file mode 100644
index 0000000..5ab5861
--- /dev/null
+++ b/Documentation/arm64/legacy_instructions.txt
@@ -0,0 +1,40 @@
+The arm64 port of the Linux kernel provides infrastructure to support
+emulation of instructions which have been deprecated, or obsoleted in
+the architecture. The infrastructure code uses undefined instruction
+hooks to support emulation. Where available it also allows turning on
+the instruction execution in hardware.
+
+The emulation mode can be controlled by writing to sysctl nodes
+(/proc/sys/abi). The following explains the different execution
+behaviours and the corresponding values of the sysctl nodes -
+
+* Undef
+  Value: 0
+  Generates undefined instruction abort. Default for instructions that
+  have been obsoleted in the architecture, e.g., SWP
+
+* Emulate
+  Value: 1
+  Uses software emulation. To aid migration of software, in this mode
+  usage of emulated instruction is traced as well as rate limited
+  warnings are issued. This is the default for deprecated
+  instructions, .e.g., CP15 barriers
+
+* Hardware Execution
+  Value: 2
+  Although marked as deprecated, some implementations may support the
+  enabling/disabling of hardware support for the execution of these
+  instructions. Using hardware execution generally provides better
+  performance, but at the loss of ability to gather runtime statistics
+  about the use of the deprecated instructions.
+
+The default mode depends on the status of the instruction in the
+architecture. Deprecated instructions should default to emulation
+while obsolete instructions must be undefined by default.
+
+Supported legacy instructions
+-----------------------------
+* SWP{B}
+Node: /proc/sys/abi/swp
+Status: Obsolete
+Default: Undef (0)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9532f8d..6ae8079 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,6 +162,45 @@ config ARCH_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
+comment "Processor Features"
+
+menuconfig ARMV8_DEPRECATED
+	bool "Emulate deprecated/obsolete ARMv8 instructions"
+	depends on COMPAT
+	help
+	  Legacy software support may require certain instructions
+	  that have been deprecated or obsoleted in the architecture.
+
+	  Enable this config to enable selective emulation of these
+	  features.
+
+	  If unsure, say N
+
+if ARMV8_DEPRECATED
+
+config SWP_EMULATION
+	bool "Emulate SWP/SWPB instructions"
+	help
+	  ARMv8 obsoletes the use of A32 SWP/SWPB instructions such that
+	  they are always undefined. Say Y here to enable software
+	  emulation of these instructions for userspace using LDXR/STXR.
+
+	  In some older versions of glibc [<=2.8] SWP is used during futex
+	  trylock() operations with the assumption that the code will not
+	  be preempted. This invalid assumption may be more likely to fail
+	  with SWP emulation enabled, leading to deadlock of the user
+	  application.
+
+	  NOTE: when accessing uncached shared regions, LDXR/STXR rely
+	  on an external transaction monitoring block called a global
+	  monitor to maintain update atomicity. If your system does not
+	  implement a global monitor, this option can cause programs that
+	  perform SWP operations to uncached memory to deadlock.
+
+	  If unsure, say N
+
+endif
+
 endmenu
 
 menu "Bus support"
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 2bffdc3..6b8fb3b 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -356,6 +356,12 @@ int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
 
 bool aarch32_insn_is_wide_instruction(u32 insn);
+
+#define A32_RN_OFFSET	16
+#define A32_RT_OFFSET	12
+#define A32_RT2_OFFSET	 0
+
+u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
 #endif /* __ASSEMBLY__ */
 
 #endif	/* __ASM_INSN_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 798f7d7..5362578 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -33,6 +33,7 @@ arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
 arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
+arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
new file mode 100644
index 0000000..6fdacc9
--- /dev/null
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -0,0 +1,402 @@
+/*
+ *  Copyright (C) 2014 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/perf_event.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/sysctl.h>
+
+#include <asm/insn.h>
+#include <asm/opcodes.h>
+#include <asm/system_misc.h>
+#include <asm/traps.h>
+#include <asm/uaccess.h>
+
+/*
+ * The runtime support for deprecated instruction support can be in one of
+ * following three states -
+ *
+ * 0 = undef
+ * 1 = emulate (software emulation)
+ * 2 = hw (supported in hardware)
+ */
+enum insn_emulation_mode {
+	INSN_UNDEF,
+	INSN_EMULATE,
+	INSN_HW,
+};
+
+enum legacy_insn_status {
+	INSN_DEPRECATED,
+	INSN_OBSOLETE,
+};
+
+struct insn_emulation_ops {
+	const char		*name;
+	enum legacy_insn_status	status;
+	struct undef_hook	*hooks;
+	int			(*set_hw_mode)(bool enable);
+};
+
+struct insn_emulation {
+	struct list_head node;
+	struct insn_emulation_ops *ops;
+	int current_mode;
+	int min;
+	int max;
+};
+
+/*
+ *  Implement emulation of the SWP/SWPB instructions using load-exclusive and
+ *  store-exclusive.
+ *
+ *  Syntax of SWP{B} instruction: SWP{B}<c> <Rt>, <Rt2>, [<Rn>]
+ *  Where: Rt  = destination
+ *	   Rt2 = source
+ *	   Rn  = address
+ */
+
+/*
+ * Error-checking SWP macros implemented using ldxr{b}/stxr{b}
+ */
+#define __user_swpX_asm(data, addr, res, temp, B)		\
+	__asm__ __volatile__(					\
+	"	mov		%w2, %w1\n"			\
+	"0:	ldxr"B"		%w1, [%3]\n"			\
+	"1:	stxr"B"		%w0, %w2, [%3]\n"		\
+	"	cbz		%w0, 2f\n"			\
+	"	mov		%w0, %w4\n"			\
+	"2:\n"							\
+	"	.pushsection	 .fixup,\"ax\"\n"		\
+	"	.align		2\n"				\
+	"3:	mov		%w0, %w5\n"			\
+	"	b		2b\n"				\
+	"	.popsection"					\
+	"	.pushsection	 __ex_table,\"a\"\n"		\
+	"	.align		3\n"				\
+	"	.quad		0b, 3b\n"			\
+	"	.quad		1b, 3b\n"			\
+	"	.popsection"					\
+	: "=&r" (res), "+r" (data), "=&r" (temp)		\
+	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT)		\
+	: "memory")
+
+#define __user_swp_asm(data, addr, res, temp) \
+	__user_swpX_asm(data, addr, res, temp, "")
+#define __user_swpb_asm(data, addr, res, temp) \
+	__user_swpX_asm(data, addr, res, temp, "b")
+
+/*
+ * Bit 22 of the instruction encoding distinguishes between
+ * the SWP and SWPB variants (bit set means SWPB).
+ */
+#define TYPE_SWPB (1 << 22)
+
+/*
+ * Set up process info to signal segmentation fault - called on access error.
+ */
+static void set_segfault(struct pt_regs *regs, unsigned long addr)
+{
+	siginfo_t info;
+
+	down_read(&current->mm->mmap_sem);
+	if (find_vma(current->mm, addr) == NULL)
+		info.si_code = SEGV_MAPERR;
+	else
+		info.si_code = SEGV_ACCERR;
+	up_read(&current->mm->mmap_sem);
+
+	info.si_signo = SIGSEGV;
+	info.si_errno = 0;
+	info.si_addr  = (void *) instruction_pointer(regs);
+
+	pr_debug("SWP{B} emulation: access caused memory abort!\n");
+	arm64_notify_die("Illegal memory access", regs, &info, 0);
+}
+
+static int emulate_swpX(unsigned int address, unsigned int *data,
+			unsigned int type)
+{
+	unsigned int res = 0;
+
+	if ((type != TYPE_SWPB) && (address & 0x3)) {
+		/* SWP to unaligned address not permitted */
+		pr_debug("SWP instruction on unaligned pointer!\n");
+		return -EFAULT;
+	}
+
+	while (1) {
+		unsigned long temp;
+
+		if (type == TYPE_SWPB)
+			__user_swpb_asm(*data, address, res, temp);
+		else
+			__user_swp_asm(*data, address, res, temp);
+
+		if (likely(res != -EAGAIN) || signal_pending(current))
+			break;
+
+		cond_resched();
+	}
+
+	return res;
+}
+
+/*
+ * swp_handler logs the id of calling process, dissects the instruction, sanity
+ * checks the memory location, calls emulate_swpX for the actual operation and
+ * deals with fixup/error handling before returning
+ */
+static int swp_handler(struct pt_regs *regs, u32 instr)
+{
+	u32 destreg, data, type, address = 0;
+	int rn, rt2, res = 0;
+
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->pc);
+
+	type = instr & TYPE_SWPB;
+
+	switch (arm_check_condition(instr, regs->pstate)) {
+	case ARM_OPCODE_CONDTEST_PASS:
+		break;
+	case ARM_OPCODE_CONDTEST_FAIL:
+		/* Condition failed - return to next instruction */
+		goto ret;
+	case ARM_OPCODE_CONDTEST_UNCOND:
+		/* If unconditional encoding - not a SWP, undef */
+		return -EFAULT;
+	default:
+		return -EINVAL;
+	}
+
+	rn = aarch32_insn_extract_reg_num(instr, A32_RN_OFFSET);
+	rt2 = aarch32_insn_extract_reg_num(instr, A32_RT2_OFFSET);
+
+	address = (u32)regs->user_regs.regs[rn];
+	data	= (u32)regs->user_regs.regs[rt2];
+	destreg = aarch32_insn_extract_reg_num(instr, A32_RT_OFFSET);
+
+	pr_debug("addr in r%d->0x%08x, dest is r%d, source in r%d->0x%08x)\n",
+		rn, address, destreg,
+		aarch32_insn_extract_reg_num(instr, A32_RT2_OFFSET), data);
+
+	/* Check access in reasonable access range for both SWP and SWPB */
+	if (!access_ok(VERIFY_WRITE, (address & ~3), 4)) {
+		pr_debug("SWP{B} emulation: access to 0x%08x not allowed!\n",
+			address);
+		goto fault;
+	}
+
+	res = emulate_swpX(address, &data, type);
+	if (res == -EFAULT)
+		goto fault;
+	else if (res == 0)
+		regs->user_regs.regs[destreg] = data;
+
+ret:
+	pr_warn_ratelimited("\"%s\" (%ld) uses obsolete SWP{B} instruction at 0x%llx\n",
+			current->comm, (unsigned long)current->pid, regs->pc);
+
+	regs->pc += 4;
+	return 0;
+
+fault:
+	set_segfault(regs, address);
+
+	return 0;
+}
+
+/*
+ * Only emulate SWP/SWPB executed in ARM state/User mode.
+ * The kernel must be SWP free and SWP{B} does not exist in Thumb.
+ */
+static struct undef_hook swp_hooks[] = {
+		{
+			.instr_mask	= 0x0fb00ff0,
+			.instr_val	= 0x01000090,
+			.pstate_mask	= COMPAT_PSR_MODE_MASK,
+			.pstate_val	= COMPAT_PSR_MODE_USR,
+			.fn		= swp_handler
+		},
+		{ }
+};
+
+static struct insn_emulation_ops swp_ops = {
+	.name = "swp",
+	.status = INSN_OBSOLETE,
+	.hooks = swp_hooks,
+	.set_hw_mode = NULL,
+};
+
+static LIST_HEAD(insn_emulation);
+static int nr_insn_emulated;
+static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
+
+static void register_emulation_hooks(struct insn_emulation_ops *ops)
+{
+	int fail = 0;
+	struct undef_hook *hook;
+
+	for (hook = ops->hooks; hook->instr_mask; hook++)
+		if (register_undef_hook(hook)) {
+			pr_notice("Error while registering %s emulation handler\n",
+				ops->name);
+			fail = 1;
+			break;
+		}
+
+	if (!fail)
+		pr_notice("Registered %s emulation handler\n", ops->name);
+}
+
+static void remove_emulation_hooks(struct insn_emulation_ops *ops)
+{
+	struct undef_hook *hook;
+
+	for (hook = ops->hooks; hook->instr_mask; hook++)
+		unregister_undef_hook(hook);
+
+	pr_notice("Removed %s emulation handler\n", ops->name);
+}
+
+static void update_insn_emulation_mode(struct insn_emulation *insn,
+				       enum insn_emulation_mode prev)
+{
+	switch (prev) {
+	case INSN_UNDEF: /* Nothing to be done */
+		break;
+	case INSN_EMULATE:
+		remove_emulation_hooks(insn->ops);
+		break;
+	case INSN_HW:
+		if (insn->ops->set_hw_mode) {
+			insn->ops->set_hw_mode(false);
+			pr_notice("Disabled %s support\n", insn->ops->name);
+		}
+		break;
+	}
+
+	switch (insn->current_mode) {
+	case INSN_UNDEF:
+		break;
+	case INSN_EMULATE:
+		register_emulation_hooks(insn->ops);
+		break;
+	case INSN_HW:
+		if (insn->ops->set_hw_mode) {
+			insn->ops->set_hw_mode(true);
+			pr_notice("Enabled %s support\n", insn->ops->name);
+		}
+		break;
+	}
+}
+
+static void register_insn_emulation(struct insn_emulation_ops *ops)
+{
+	unsigned long flags;
+	struct insn_emulation *insn;
+
+	insn = kzalloc(sizeof(*insn), GFP_KERNEL);
+	insn->ops = ops;
+	insn->min = INSN_UNDEF;
+
+	switch (ops->status) {
+	case INSN_DEPRECATED:
+		insn->current_mode = INSN_EMULATE;
+		insn->max = INSN_HW;
+		break;
+	case INSN_OBSOLETE:
+		insn->current_mode = INSN_UNDEF;
+		insn->max = INSN_EMULATE;
+		break;
+	}
+
+	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
+	list_add(&insn->node, &insn_emulation);
+	nr_insn_emulated++;
+	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
+
+	/* Register any handlers if required */
+	update_insn_emulation_mode(insn, INSN_UNDEF);
+}
+
+static int emulation_proc_handler(struct ctl_table *table, int write,
+				  void __user *buffer, size_t *lenp,
+				  loff_t *ppos)
+{
+	int ret = 0;
+	struct insn_emulation *insn = (struct insn_emulation *) table->data;
+	enum insn_emulation_mode prev_mode = insn->current_mode;
+
+	table->data = &insn->current_mode;
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret || !write || prev_mode == insn->current_mode)
+		goto ret;
+
+	update_insn_emulation_mode(insn, prev_mode);
+ret:
+	table->data = insn;
+	return ret;
+}
+
+static struct ctl_table ctl_abi[] = {
+	{
+		.procname = "abi",
+		.mode = 0555,
+	},
+	{ }
+};
+
+static void register_insn_emulation_sysctl(struct ctl_table *table)
+{
+	unsigned long flags;
+	int i = 0;
+	struct insn_emulation *insn;
+	struct ctl_table *insns_sysctl, *sysctl;
+
+	insns_sysctl = kzalloc(sizeof(*sysctl) * (nr_insn_emulated + 1),
+			      GFP_KERNEL);
+
+	raw_spin_lock_irqsave(&insn_emulation_lock, flags);
+	list_for_each_entry(insn, &insn_emulation, node) {
+		sysctl = &insns_sysctl[i];
+
+		sysctl->mode = 0644;
+		sysctl->maxlen = sizeof(int);
+
+		sysctl->procname = insn->ops->name;
+		sysctl->data = insn;
+		sysctl->extra1 = &insn->min;
+		sysctl->extra2 = &insn->max;
+		sysctl->proc_handler = emulation_proc_handler;
+		i++;
+	}
+	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
+
+	table->child = insns_sysctl;
+	register_sysctl_table(table);
+}
+
+/*
+ * Invoked as late_initcall, since not needed before init spawned.
+ */
+static int __init armv8_deprecated_init(void)
+{
+	if (IS_ENABLED(CONFIG_SWP_EMULATION))
+		register_insn_emulation(&swp_ops);
+
+	register_insn_emulation_sysctl(ctl_abi);
+
+	return 0;
+}
+
+late_initcall(armv8_deprecated_init);
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 9766a56..58574c5 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -964,3 +964,11 @@ bool aarch32_insn_is_wide_instruction(u32 insn)
 {
 	return insn >= 0xe800;
 }
+
+/*
+ * Macros/defines for extracting register numbers from instruction.
+ */
+u32 aarch32_insn_extract_reg_num(u32 insn, int offset)
+{
+	return (insn & (0xf << offset)) >> offset;
+}
-- 
2.1.1
