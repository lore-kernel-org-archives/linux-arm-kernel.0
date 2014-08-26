From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 26 Aug 2014 11:28:49 +0100
Subject: [PATCH 5/6] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1409048930-21598-6-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SWP instruction was deprecated in the ARMv6 architecture,
superseded by the LDREX/STREX family of instructions for
load-linked/store-conditional operations. The ARMv7 multiprocessing
extensions mandate that SWP/SWPB instructions are treated as undefined
from reset, with the ability to enable them through the System Control
Register SW bit. With ARMv8, the option to enable these instructions
through System Control Register was dropped as well.

This patch ports the alternative solution to emulate the SWP and SWPB
instructions using LDXR/STXR sequences from the arm port to
arm64. Additionaly, the patch also proivdes support to log the
emulation statistics via debugfs.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/Kconfig              |   41 +++++++
 arch/arm64/include/asm/insn.h   |    9 ++
 arch/arm64/kernel/Makefile      |    1 +
 arch/arm64/kernel/insn.c        |   11 ++
 arch/arm64/kernel/v7_obsolete.c |  241 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 303 insertions(+)
 create mode 100644 arch/arm64/kernel/v7_obsolete.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c52894e..ba780b1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -142,6 +142,47 @@ config ARCH_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
+comment "Processor Features"
+
+config V7_OBSOLETE
+	bool "Emulate obsolete ARMv7 instructions"
+	depends on COMPAT
+	help
+	  AArch32 legacy software support may require certain
+	  instructions that have been deprecated or obsoleted in the
+	  architecture.
+
+	  Enable this config to enable selective emulation of these
+	  features.
+
+	  If unsure, say N
+
+if V7_OBSOLETE
+
+config SWP_EMULATION
+	bool "Emulate SWP/SWPB instructions"
+	help
+	  ARMv8 obsoletes the use of SWP/SWPB instructions such that
+	  they are always undefined. Say Y here to enable software
+	  emulation of these instructions for userspace (not kernel)
+	  using LDXR/STXR.
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
index dc1f73b..2861cc6 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -105,6 +105,15 @@ bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
+
+#ifdef CONFIG_V7_OBSOLETE
+#define RN_OFFSET	16
+#define RT_OFFSET	12
+#define RT2_OFFSET	 0
+
+u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
+#endif /* CONFIG_V7_OBSOLETE */
+
 #endif /* __ASSEMBLY__ */
 
 #endif	/* __ASM_INSN_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index eee33a0..2a35a73 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -30,6 +30,7 @@ arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
+arm64-obj-$(CONFIG_V7_OBSOLETE)		+= v7_obsolete.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 92f3683..5db9d35 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -302,3 +302,14 @@ u32 __kprobes aarch64_insn_gen_nop(void)
 {
 	return aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
 }
+
+#ifdef CONFIG_V7_OBSOLETE
+/*
+ * Macros/defines for extracting register numbers from instruction.
+ */
+u32 aarch32_insn_extract_reg_num(u32 insn, int offset)
+{
+	return (insn & (0xf << offset)) >> offset;
+}
+
+#endif /* CONFIG_V7_OBSOLETE */
diff --git a/arch/arm64/kernel/v7_obsolete.c b/arch/arm64/kernel/v7_obsolete.c
new file mode 100644
index 0000000..e9427cb
--- /dev/null
+++ b/arch/arm64/kernel/v7_obsolete.c
@@ -0,0 +1,241 @@
+/*
+ *  arch/arm64/kernel/v7_obsolete.c
+ *
+ *  Copied from arch/arm/kernel/swp_emulate.c and modified for ARMv8
+ *
+ *  Copyright (C) 2009,2012,2014 ARM Limited
+ *  __user_* functions adapted from include/asm/uaccess.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/perf_event.h>
+
+#include <asm/insn.h>
+#include <asm/opcodes.h>
+#include <asm/system_misc.h>
+#include <asm/traps.h>
+#include <asm/uaccess.h>
+
+/*
+ *  Implements emulation of the SWP/SWPB instructions using load-exclusive and
+ *  store-exclusive.
+ *
+ *  Syntax of SWP{B} instruction: SWP{B}<c> <Rt>, <Rt2>, [<Rn>]
+ *  Where: Rt  = destination
+ *	   Rt2 = source
+ *	   Rn  = address
+ */
+
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
+static atomic_t swp_counter;
+static atomic_t swpb_counter;
+static u32 swp_enabled = 1;
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
+	u32 address, destreg, data, type;
+	int rn, rt2, res = 0;
+
+	if (!swp_enabled)
+		return -EFAULT;
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
+	rn = aarch32_insn_extract_reg_num(instr, RN_OFFSET);
+	rt2 = aarch32_insn_extract_reg_num(instr, RT2_OFFSET);
+
+	address = (u32)regs->user_regs.regs[rn];
+	data	= (u32)regs->user_regs.regs[rt2];
+	destreg = aarch32_insn_extract_reg_num(instr, RT_OFFSET);
+
+	pr_debug("addr in r%d->0x%08x, dest is r%d, source in r%d->0x%08x)\n",
+		rn, address, destreg,
+		aarch32_insn_extract_reg_num(instr, RT2_OFFSET), data);
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
+	if (type == TYPE_SWPB)
+		atomic_inc(&swpb_counter);
+	else
+		atomic_inc(&swp_counter);
+
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
+static struct undef_hook swp_hook = {
+	.instr_mask	= 0x0fb00ff0,
+	.instr_val	= 0x01000090,
+	.pstate_mask	= COMPAT_PSR_MODE_MASK,
+	.pstate_val	= COMPAT_PSR_MODE_USR,
+	.fn		= swp_handler
+};
+
+static void __init swp_emulation_init(void)
+{
+	struct dentry *swp_d;
+
+	atomic_set(&swp_counter, 0);
+	atomic_set(&swpb_counter, 0);
+
+	swp_d = debugfs_create_dir("swp_emulation", arch_debugfs_dir);
+	if (!IS_ERR_OR_NULL(swp_d)) {
+		debugfs_create_atomic_t("swp_count", S_IRUGO, swp_d, &swp_counter);
+		debugfs_create_atomic_t("swpb_count", S_IRUGO, swp_d, &swpb_counter);
+		debugfs_create_bool("enabled", S_IRUGO | S_IWUSR, swp_d,
+				&swp_enabled);
+	}
+
+	if (register_undef_hook(&swp_hook) == 0)
+		pr_notice("Registered SWP/SWPB emulation handler\n");
+}
+
+/*
+ * Invoked as late_initcall, since not needed before init spawned.
+ */
+static int __init v7_obsolete_init(void)
+{
+	if (IS_ENABLED(CONFIG_SWP_EMULATION))
+		swp_emulation_init();
+
+	return 0;
+}
+
+late_initcall(v7_obsolete_init);
-- 
1.7.10.4
