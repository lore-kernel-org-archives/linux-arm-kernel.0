From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Tue,  1 Oct 2013 21:27:59 +0530
Subject: [PATCH RFC v1 4/5] AArch64: Add Kprobes support for ARM v8 kernel
In-Reply-To: <1380643080-8984-1-git-send-email-sandeepa.prabhu@linaro.org>
References: <1380643080-8984-1-git-send-email-sandeepa.prabhu@linaro.org>
Message-ID: <1380643080-8984-5-git-send-email-sandeepa.prabhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for basic kernel probes(kprobes), jump probes (jprobes) and
kprobes instruction decode tables for ARM64 kernel.

Kprobes makes use of software breakpoint to trap the
kernel execution and then use single stepping feature of the
ARM v8 debug architecture.

ARM v8 supports single stepping to be enabled while returning from the
debug execption(ERET). Kprobes prepares a executable memory slot for
XOL(execute-out-of-line) with the copy of the original instruction
under probe, and update exception return address to the prepared slot
with single stepping enabled. With this scheme, the instruction
is executed with the same register context except for the different
PC that is pointing to the prepared slot.

Stepping from slot puts limitation on the PC-relative and
symbolic literal access instructions (branching, load literal) that
the offset from new PC may not be ensured to fit in immediate value of
opcode,(usually +/-1MB range). So these instructions are
simulated in C code.

Instructions generating exceptions or cpu mode change are rejected, and
not allowed to insert probe for such instructions.

Instructions using Exclusive Monitor are rejected in this version, as
there are limitations on single-stepping when exclusive monitor is
enabled, and cannot simulate atomic instructions(LDREX/STREX) in C code.

System instructions are mostly stepped, except MSR immeidate that updates
"daif" flags in PSTATE, which are not safe for probing(rejected)

Load FP/ASIMD registers from literals (PC-relative) are not implemented
in this version, since NEON/FP register context are not saved while entering
debug exception.

TODO:
 - stepping or emulation support for exclusive load/store in safe way.
 - Emulate FP/AdvSIMD literal load/store if require support.

Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
---
 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/kprobes.h  |  57 ++++
 arch/arm64/include/asm/ptrace.h   |   6 +
 arch/arm64/kernel/Makefile        |   2 +
 arch/arm64/kernel/kprobes-arm64.c | 245 ++++++++++++++++++
 arch/arm64/kernel/kprobes-arm64.h |  26 ++
 arch/arm64/kernel/kprobes.c       | 529 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/kprobes.h       |  28 ++
 arch/arm64/kernel/vmlinux.lds.S   |   1 +
 9 files changed, 895 insertions(+)
 create mode 100644 arch/arm64/include/asm/kprobes.h
 create mode 100644 arch/arm64/kernel/kprobes-arm64.c
 create mode 100644 arch/arm64/kernel/kprobes-arm64.h
 create mode 100644 arch/arm64/kernel/kprobes.c
 create mode 100644 arch/arm64/kernel/kprobes.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c044548..8cf5cde 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -24,6 +24,7 @@ config ARM64
 	select HAVE_DMA_ATTRS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_MEMBLOCK
 	select HAVE_PERF_EVENTS
 	select IRQ_DOMAIN
diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
new file mode 100644
index 0000000..a43f74f
--- /dev/null
+++ b/arch/arm64/include/asm/kprobes.h
@@ -0,0 +1,57 @@
+/*
+ * arch/arm64/include/asm/kprobes.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _ARM_KPROBES_H
+#define _ARM_KPROBES_H
+
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/percpu.h>
+
+#define __ARCH_WANT_KPROBES_INSN_SLOT
+#define MAX_INSN_SIZE			2
+#define MAX_STACK_SIZE			128
+
+#define flush_insn_slot(p)		do { } while (0)
+#define kretprobe_blacklist_size	0
+
+#include <asm/probes.h>
+
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned int status;
+};
+
+/* Single step context for kprobe */
+struct kprobe_step_ctx {
+#define KPROBES_STEP_NONE	0x0
+#define KPROBES_STEP_PENDING	0x1
+	unsigned long ss_status;
+	unsigned long match_addr;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned int kprobe_status;
+	struct prev_kprobe prev_kprobe;
+	struct kprobe_step_ctx ss_ctx;
+	struct pt_regs jprobe_saved_regs;
+	char jprobes_stack[MAX_STACK_SIZE];
+};
+
+void arch_remove_kprobe(struct kprobe *);
+int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
+int kprobe_exceptions_notify(struct notifier_block *self,
+			     unsigned long val, void *data);
+
+#endif /* _ARM_KPROBES_H */
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 0dacbbf..58b2589 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -164,6 +164,12 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
 }
 
 #define instruction_pointer(regs)	(regs)->pc
+#define stack_pointer(regs)		((regs)->sp)
+
+static inline long regs_return_value(struct pt_regs *regs)
+{
+	return regs->regs[0];
+}
 
 #ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7b4b564..6c4e541 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,6 +18,8 @@ arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o smp_psci.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o patch.o	\
+					   probes-aarch64.o probes-common.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/kprobes-arm64.c b/arch/arm64/kernel/kprobes-arm64.c
new file mode 100644
index 0000000..e269e24
--- /dev/null
+++ b/arch/arm64/kernel/kprobes-arm64.c
@@ -0,0 +1,245 @@
+/*
+ * arch/arm64/kernel/kprobes-arm64.c
+ *
+ * Copyright (C) 2013 Linaro Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+#include <linux/module.h>
+
+#include "probes-aarch64.h"
+#include "kprobes-arm64.h"
+
+/* Load literal (PC-relative) instructions
+ * Encoding:  xx01 1x00 xxxx xxxx xxxx xxxx xxxx xxxx
+ *
+ * opcode[26]: V=0, Load GP registers, simulate them.
+ * Encoding: xx01 1000 xxxx xxxx xxxx xxxx xxxx xxxx
+ *	opcode[31:30]: op = 00, 01 - LDR literal
+ *	opcode[31:30]: op = 10,    - LDRSW literal
+ *
+ * 1.   V=1 -Load FP/AdvSIMD registers
+ *	Encoding: xx01 1100 xxxx xxxx xxxx xxxx xxxx xxxx
+ * 2.   V=0,opc=11 -PRFM(Prefetch literal)
+ *	Encoding: 1101 1000 xxxx xxxx xxxx xxxx xxxx xxxx
+ *
+ * TODO:
+ * -Rejecting FP/AdvSIMD load & PRFM literal in this version,
+ *  needs revisit this for possible emulation/simulation.
+ */
+static const struct aarch64_decode_item load_literal_subtable[] = {
+	DECODE_REJECT(0x1C000000, 0x3F000000),
+	DECODE_REJECT(0xD8000000, 0xFF000000),
+	DECODE_LITERAL(0x18000000, 0xBF000000, prepare_none,
+		       simulate_ldr_literal),
+	DECODE_LITERAL(0x98000000, 0xFF000000, prepare_none,
+		       simulate_ldrsw_literal),
+	DECODE_END,
+};
+
+/* AArch64 instruction decode table for kprobes:
+ * The instruction will fall into one of the 3 groups:
+ *  1. Single stepped out-of-the-line slot.
+ *     -Most instructions fall in this group, those does not
+ *      depend on PC address.
+ *
+ *  2. Should be simulated because of PC-relative/literal access.
+ *     -All branching and PC-relative insrtcutions are simulated
+ *      in C code, making use of saved pt_regs
+ *      Catch: SIMD/NEON register context are not saved while
+ *      entering debug exception, so are rejected for now.
+ *
+ *  3. Cannot be probed(not safe) so are rejected.
+ *     - Exception generation and exception return instructions
+ *     - Exclusive monitor(LDREX/STREX family)
+ *
+ */
+static const struct aarch64_decode_item aarch64_decode_table[] = {
+	/*
+	 * Data processing - PC relative(literal) addressing:
+	 * Encoding: xxx1 0000 xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_LITERAL(0x10000000, 0x1F000000, prepare_none,
+			simulate_adr_adrp),
+
+	/*
+	 * Data processing - Add/Substract Immediate:
+	 * Encoding: xxx1 0001 xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_SINGLESTEP(0x11000000, 0x1F000000),
+
+	/*
+	 * Data processing
+	 * Encoding:
+	 *      xxx1 0010 0xxx xxxx xxxx xxxx xxxx xxxx (Logical)
+	 *      xxx1 0010 1xxx xxxx xxxx xxxx xxxx xxxx (Move wide)
+	 *      xxx1 0011 0xxx xxxx xxxx xxxx xxxx xxxx (Bitfield)
+	 *      xxx1 0011 1xxx xxxx xxxx xxxx xxxx xxxx (Extract)
+	 */
+	DECODE_SINGLESTEP(0x12000000, 0x1E000000),
+
+	/*
+	 * Data processing - SIMD/FP/AdvSIMD/Crypto-AES/SHA
+	 * Encoding: xxx0 111x xxxx xxxx xxxx xxxx xxxx xxxx
+	 * Encoding: xxx1 111x xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_SINGLESTEP(0x0E000000, 0x0E000000),
+
+	/*
+	 * Data processing - Register
+	 * Encoding: xxxx 101x xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_SINGLESTEP(0x0A000000, 0x0E000000),
+
+	/* Branching Instructions
+	 *
+	 * Encoding:
+	 *  x001 01xx xxxx xxxx xxxx xxxx xxxx xxxx (uncondtional Branch)
+	 *  x011 010x xxxx xxxx xxxx xxxx xxxx xxxx (compare & branch)
+	 *  x011 011x xxxx xxxx xxxx xxxx xxxx xxxx (Test & Branch)
+	 *  0101 010x xxxx xxxx xxxx xxxx xxxx xxxx (Conditional, immediate)
+	 *  1101 011x xxxx xxxx xxxx xxxx xxxx xxxx (Unconditional,register)
+	 */
+	DECODE_BRANCH(0x14000000, 0x7C000000, prepare_none,
+			simulate_b_bl),
+	DECODE_BRANCH(0x34000000, 0x7E000000, prepare_cbz_cbnz,
+		      simulate_cbz_cbnz),
+	DECODE_BRANCH(0x36000000, 0x7E000000, prepare_tbz_tbnz,
+		      simulate_tbz_tbnz),
+	DECODE_BRANCH(0x54000000, 0xFE000000, prepare_bcond,
+			simulate_b_cond),
+	DECODE_BRANCH(0xD6000000, 0xFE000000, prepare_none,
+		      simulate_br_blr_ret),
+
+	/* System insn:
+	 * Encoding: 1101 0101 00xx xxxx xxxx xxxx xxxx xxxx
+	 *
+	 * Note: MSR immediate (update PSTATE daif) is not safe handling
+	 * within kprobes, so rejecting.
+	 * Don't re-arrange the decode table entries below here.
+	 */
+	DECODE_REJECT(0xD500401F, 0xFFF8F01F),
+	DECODE_SINGLESTEP(0xD5000000, 0xFFC00000),
+
+	/* Exception Generation:
+	 * Encoding:  1101 0100 xxxx xxxx xxxx xxxx xxxx xxxx
+	 * Instructions: SVC, HVC, SMC, BRK, HLT, DCPS1, DCPS2, DCPS3
+	 */
+	DECODE_REJECT(0xD4000000, 0xFF000000),
+
+	/*
+	 * Load/Store - Exclusive monitor
+	 * Encoding: xx00 1000 xxxx xxxx xxxx xxxx xxxx xxxx
+	 *
+	 * - Rejecting exlusive monitor'ed instructions
+	 * TODO: needs revisit to check if there a way to safely
+	 *       step or emulate these instructions.
+	 */
+	DECODE_REJECT(0x08000000, 0x3F000000),
+
+	/*
+	 * Load/Store - PC relative(literal):
+	 * Encoding:  xx01 1x00 xxxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_TABLE(0x18000000, 0x3B000000, load_literal_subtable),
+
+	/*
+	 * Load/Store - Register Pair
+	 * Encoding:
+	 *      xx10 1x00 0xxx xxxx xxxx xxxx xxxx xxxx
+	 *      xx10 1x00 1xxx xxxx xxxx xxxx xxxx xxxx
+	 *      xx10 1x01 0xxx xxxx xxxx xxxx xxxx xxxx
+	 *      xx10 1x01 1xxx xxxx xxxx xxxx xxxx xxxx
+	 */
+	DECODE_SINGLESTEP(0x28000000, 0x3A000000),
+
+	/*
+	 * Load/Store - Register
+	 * Encoding:
+	 *      xx11 1x00 xx0x xxxx xxxx 00xx xxxx xxxx (unscaled imm)
+	 *      xx11 1x00 xx0x xxxx xxxx 01xx xxxx xxxx (imm post-indexed)
+	 *      xx11 1x00 xx0x xxxx xxxx 10xx xxxx xxxx (unpriviledged)
+	 *      xx11 1x00 xx0x xxxx xxxx 11xx xxxx xxxx (imm pre-indexed)
+	 *
+	 *      xx11 1x00 xx10 xxxx xxxx xx10 xxxx xxxx (register offset)
+	 *
+	 *      xx11 1x01 xxxx xxxx xxxx xxxx xxxx xxxx (unsigned imm)
+	 */
+	DECODE_SINGLESTEP(0x38000000, 0x3B200000),
+	DECODE_SINGLESTEP(0x38200200, 0x38300300),
+	DECODE_SINGLESTEP(0x39000000, 0x3B000000),
+
+	/*
+	 * Load/Store - AdvSIMD
+	 * Encoding:
+	 *  0x00 1100 0x00 0000 xxxx xxxx xxxx xxxx (Multiple-structure)
+	 *  0x00 1100 1x0x xxxx xxxx xxxx xxxx xxxx (Multi-struct post-indexed)
+	 *  0x00 1101 0xx0 0000 xxxx xxxx xxxx xxxx (Single-structure))
+	 *  0x00 1101 1xxx xxxx xxxx xxxx xxxx xxxx (Single-struct post-index)
+	 */
+	DECODE_SINGLESTEP(0x0C000000, 0xBFBF0000),
+	DECODE_SINGLESTEP(0x0C800000, 0xBFA00000),
+	DECODE_SINGLESTEP(0x0D000000, 0xBF9F0000),
+	DECODE_SINGLESTEP(0x0D800000, 0xBF800000),
+
+	/* Unallocated:         xxx0 0xxx xxxx xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT(0x00000000, 0x18000000),
+	DECODE_END,
+};
+
+static int __kprobes
+kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
+		   const struct aarch64_decode_item *tbl)
+{
+	unsigned int entry, ret = INSN_REJECTED;
+
+	for (entry = 0; !decode_table_end(tbl[entry]); entry++) {
+		if (decode_table_hit(tbl[entry], insn))
+			break;
+	}
+
+	switch (decode_get_type(tbl[entry])) {
+	case DECODE_TYPE_END:
+	case DECODE_TYPE_REJECT:
+	default:
+		ret = INSN_REJECTED;
+		break;
+
+	case DECODE_TYPE_SINGLESTEP:
+		ret = INSN_GOOD;
+		break;
+
+	case DECODE_TYPE_SIMULATE:
+		asi->prepare = decode_prepare_fn(tbl[entry]);
+		asi->handler = decode_handler_fn(tbl[entry]);
+		ret = INSN_GOOD_NO_SLOT;
+		break;
+
+	case DECODE_TYPE_TABLE:
+		/* recurse with next level decode table */
+		ret = kprobe_decode_insn(insn, asi,
+					 decode_sub_table(tbl[entry]));
+	};
+	return ret;
+}
+
+/* Return:
+ *   INSN_REJECTED     If instruction is one not allowed to kprobe,
+ *   INSN_GOOD         If instruction is supported and uses instruction slot,
+ *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
+ */
+enum kprobe_insn __kprobes
+arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	return kprobe_decode_insn(insn, asi, aarch64_decode_table);
+}
diff --git a/arch/arm64/kernel/kprobes-arm64.h b/arch/arm64/kernel/kprobes-arm64.h
new file mode 100644
index 0000000..d0cc616
--- /dev/null
+++ b/arch/arm64/kernel/kprobes-arm64.h
@@ -0,0 +1,26 @@
+/*
+ * arch/arm64/kernel/kprobes-arm64.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _ARM_KERNEL_KPROBES_ARM64_H
+#define _ARM_KERNEL_KPROBES_ARM64_H
+
+enum kprobe_insn {
+	INSN_REJECTED,
+	INSN_GOOD_NO_SLOT,
+	INSN_GOOD,
+};
+
+enum kprobe_insn __kprobes
+arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi);
+
+#endif /* _ARM_KERNEL_KPROBES_ARM64_H */
diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
new file mode 100644
index 0000000..4840433
--- /dev/null
+++ b/arch/arm64/kernel/kprobes.c
@@ -0,0 +1,529 @@
+/*
+ * arch/arm64/kernel/kprobes.c
+ *
+ * Kprobes support for AArch64
+ *
+ * Copyright (C) 2013 Linaro Limited.
+ * Author: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/stop_machine.h>
+#include <linux/stringify.h>
+#include <asm/traps.h>
+#include <asm/cacheflush.h>
+#include <asm/debug-monitors.h>
+#include <asm/system_misc.h>
+
+#include "patch.h"
+#include "kprobes.h"
+#include "kprobes-arm64.h"
+
+#define MIN_STACK_SIZE(addr)	min((unsigned long)MAX_STACK_SIZE,	\
+	(unsigned long)current_thread_info() + THREAD_START_SP - (addr))
+
+DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
+static int __kprobes
+post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs);
+
+static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
+{
+	int i;
+	/* prepare insn slot */
+	p->ainsn.insn[0] = p->opcode;
+	/* NOP for superscalar uArch decode */
+	for (i = 1; i < MAX_INSN_SIZE; i++)
+		p->ainsn.insn[i] = ARCH64_NOP_OPCODE;
+
+	flush_icache_range((uintptr_t) (p->ainsn.insn),
+			   (uintptr_t) (p->ainsn.insn) + MAX_INSN_SIZE);
+}
+
+static void __kprobes arch_prepare_insn(struct kprobe *p)
+{
+	if (p->ainsn.prepare)
+		p->ainsn.prepare(p, &p->ainsn);
+}
+
+static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (p->ainsn.handler)
+		p->ainsn.handler(p, regs);
+
+	/* single step simulated, now go for post processing */
+	post_kprobe_handler(kcb, regs);
+}
+
+int __kprobes arch_prepare_kprobe(struct kprobe *p)
+{
+	kprobe_opcode_t insn;
+	unsigned long probe_addr = (unsigned long)p->addr;
+
+	/* copy instruction */
+	insn = *p->addr;
+	p->opcode = insn;
+
+	if (in_exception_text(probe_addr))
+		return -EINVAL;
+
+	/* decode instruction */
+	switch (arm_kprobe_decode_insn(insn, &p->ainsn)) {
+	case INSN_REJECTED:	/* insn not supported */
+		return -EINVAL;
+
+		break;
+	case INSN_GOOD_NO_SLOT:	/* doesn't need insn slot */
+		p->ainsn.insn = NULL;
+		break;
+
+	case INSN_GOOD:	/* instruction uses slot */
+		p->ainsn.insn = get_insn_slot();
+		if (!p->ainsn.insn)
+			return -ENOMEM;
+		break;
+	};
+
+	/* prepare the instruction */
+	if (p->ainsn.insn)
+		arch_prepare_ss_slot(p);
+	else
+		arch_prepare_insn(p);
+
+	return 0;
+}
+
+/* arm kprobe: install breakpoint in text */
+void __kprobes arch_arm_kprobe(struct kprobe *p)
+{
+	void *addr = p->addr;
+
+	patch_text((u32 *) addr, BRK64_OPCODE_KPROBES);
+}
+
+/* disarm kprobe: remove breakpoint from text */
+void __kprobes arch_disarm_kprobe(struct kprobe *p)
+{
+	void *addr = p->addr;
+
+	patch_text((u32 *) addr, p->opcode);
+}
+
+void __kprobes arch_remove_kprobe(struct kprobe *p)
+{
+	if (p->ainsn.insn) {
+		free_insn_slot(p->ainsn.insn, 0);
+		p->ainsn.insn = NULL;
+	}
+}
+
+static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+}
+
+static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+}
+
+static void __kprobes set_current_kprobe(struct kprobe *p)
+{
+	__get_cpu_var(current_kprobe) = p;
+}
+
+static void __kprobes
+set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr)
+{
+	kcb->ss_ctx.ss_status = KPROBES_STEP_PENDING;
+	kcb->ss_ctx.match_addr = addr + sizeof(kprobe_opcode_t);
+}
+
+static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
+{
+	kcb->ss_ctx.ss_status = KPROBES_STEP_NONE;
+	kcb->ss_ctx.match_addr = 0;
+}
+
+static void __kprobes setup_singlestep(struct kprobe *p,
+				       struct pt_regs *regs,
+				       struct kprobe_ctlblk *kcb, int reenter)
+{
+	unsigned long slot;
+
+	if (reenter) {
+		save_previous_kprobe(kcb);
+		set_current_kprobe(p);
+		kcb->kprobe_status = KPROBE_REENTER;
+	} else {
+		kcb->kprobe_status = KPROBE_HIT_SS;
+	}
+
+	if (p->ainsn.insn) {
+		/* prepare for single stepping */
+		slot = (unsigned long)p->ainsn.insn;
+
+		/*
+		 * Needs restoring of return address after stepping xol.
+		 * If this happens to be a return probe, the exception
+		 * return address would have been hacked by the pre_handler
+		 * to point to trampoline, so we shall restore trampoline
+		 * address after stepping. Other cases, it is just next pc.
+		 */
+		if ((long)p->addr == instruction_pointer(regs))
+			p->ainsn.restore.addr = regs->pc +
+				sizeof(kprobe_opcode_t); /*next pc*/
+		else	/* hacked ret addr!, could be kretprobe */
+			p->ainsn.restore.addr = regs->pc; /* trampoline */
+
+		p->ainsn.restore.type = RESTORE_PC;
+
+		set_ss_context(kcb, slot);	/* mark pending ss */
+		kernel_enable_single_step(regs);
+		instruction_pointer(regs) = slot;
+	} else {
+		/* insn simulation */
+		arch_simulate_insn(p, regs);
+	}
+}
+
+static int __kprobes reenter_kprobe(struct kprobe *p,
+				    struct pt_regs *regs,
+				    struct kprobe_ctlblk *kcb)
+{
+	switch (kcb->kprobe_status) {
+	case KPROBE_HIT_SSDONE:
+	case KPROBE_HIT_ACTIVE:
+		kprobes_inc_nmissed_count(p);
+		setup_singlestep(p, regs, kcb, 1);
+		break;
+	case KPROBE_HIT_SS:
+		pr_warn("Unrecoverable kprobe detected at %p.\n", p->addr);
+		dump_kprobe(p);
+		BUG();
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int __kprobes
+post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
+{
+	struct kprobe *cur = kprobe_running();
+
+	if (!cur)
+		return 0;
+
+	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		cur->post_handler(cur, regs, 0);
+	}
+
+	/* restore back original saved kprobe variables and continue */
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
+		goto out;
+	}
+	reset_current_kprobe();
+out:
+	/* If single step done, disable it now */
+	if (cur->ainsn.insn)
+		kernel_disable_single_step();
+
+	/* return addr restore if non-branching insn & not return probe */
+	if (cur->ainsn.restore.type == RESTORE_PC) {
+		instruction_pointer(regs) = cur->ainsn.restore.addr;
+		cur->ainsn.restore.addr = 0;
+		cur->ainsn.restore.type = NO_RESTORE;
+	}
+
+	return 1;
+}
+
+int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	switch (kcb->kprobe_status) {
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		/*
+		 * We are here because the instruction being single
+		 * stepped caused a page fault. We reset the current
+		 * kprobe and the ip points back to the probe address
+		 * and allow the page fault handler to continue as a
+		 * normal page fault.
+		 */
+		instruction_pointer(regs) = (unsigned long)cur->addr;
+		if (kcb->kprobe_status == KPROBE_REENTER)
+			restore_previous_kprobe(kcb);
+		else
+			reset_current_kprobe();
+
+		break;
+	case KPROBE_HIT_ACTIVE:
+	case KPROBE_HIT_SSDONE:
+		/*
+		 * We increment the nmissed count for accounting,
+		 * we can also use npre/npostfault count for accounting
+		 * these specific fault cases.
+		 */
+		kprobes_inc_nmissed_count(cur);
+
+		/*
+		 * We come here because instructions in the pre/post
+		 * handler caused the page_fault, this could happen
+		 * if handler tries to access user space by
+		 * copy_from_user(), get_user() etc. Let the
+		 * user-specified handler try to fix it first.
+		 */
+		if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
+			return 1;
+
+		/*
+		 * In case the user-specified fault handler returned
+		 * zero, try to fix up.
+		 */
+		if (fixup_exception(regs))
+			return 1;
+
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
+				       unsigned long val, void *data)
+{
+	return NOTIFY_DONE;
+}
+
+/* Exception return should resume the kernel code execution */
+static void __kprobes singlestep_skip(struct kprobe *p, struct pt_regs *regs)
+{
+	return;
+}
+
+void __kprobes kprobe_handler(struct pt_regs *regs)
+{
+	struct kprobe *p, *cur;
+	struct kprobe_ctlblk *kcb;
+	unsigned long addr = instruction_pointer(regs);
+
+	kcb = get_kprobe_ctlblk();
+	cur = kprobe_running();
+
+	p = get_kprobe((kprobe_opcode_t *) addr);
+
+	if (p) {
+		if (cur) {
+			if (reenter_kprobe(p, regs, kcb))
+				return;
+		} else if (!p->ainsn.check_condn ||
+			   p->ainsn.check_condn(p, regs)) {
+			/* Probe hit and conditional execution check ok. */
+			set_current_kprobe(p);
+			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+
+			/*
+			 * If we have no pre-handler or it returned 0, we
+			 * continue with normal processing.  If we have a
+			 * pre-handler and it returned non-zero, it prepped
+			 * for calling the break_handler below on re-entry,
+			 * so get out doing nothing more here.
+			 */
+			if (!p->pre_handler || !p->pre_handler(p, regs)) {
+				kcb->kprobe_status = KPROBE_HIT_SS;
+				setup_singlestep(p, regs, kcb, 0);
+				return;
+			}
+		} else {
+			/*
+			 * Probe hit but conditional execution check failed,
+			 * so just skip the instruction and continue as if
+			 * nothing had happened.
+			 */
+			singlestep_skip(p, regs);
+			return;
+		}
+	} else if (*(kprobe_opcode_t *) addr != BRK64_OPCODE_KPROBES) {
+		/*
+		 * The breakpoint instruction was removed right
+		 * after we hit it.  Another cpu has removed
+		 * either a probepoint or a debugger breakpoint
+		 * at this address.  In either case, no further
+		 * handling of this interrupt is appropriate.
+		 * Back up over the (now missing) int3 and run
+		 * the original instruction.
+		 */
+		instruction_pointer(regs) -= 4;
+		preempt_enable_no_resched();
+		return;
+	} else if (cur) {
+		/* We probably hit a jprobe.  Call its break handler. */
+		if (cur->break_handler && cur->break_handler(cur, regs)) {
+			kcb->kprobe_status = KPROBE_HIT_SS;
+			setup_singlestep(cur, regs, kcb, 0);
+			return;
+		}
+		reset_current_kprobe();
+	} else {
+		/* breakpoint is removed, now in a race */
+		instruction_pointer(regs) -= 4;
+		preempt_enable_no_resched();
+	}
+	return;
+}
+
+static int __kprobes
+kprobe_ss_hit(struct kprobe_ctlblk *kcb, unsigned long addr)
+{
+	if ((kcb->ss_ctx.ss_status == KPROBES_STEP_PENDING)
+	    && (kcb->ss_ctx.match_addr == addr)) {
+		clear_ss_context(kcb);	/* clear pending ss */
+		return DEBUG_HOOK_HANDLED;
+	} else {
+		/* not ours, kprobes should ignore it */
+		return DEBUG_HOOK_ERROR;
+	}
+}
+
+static int __kprobes
+kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	unsigned long flags;
+	int retval;
+
+	/* check, and return error if this is not our step */
+	retval = kprobe_ss_hit(kcb, instruction_pointer(regs));
+
+	if (retval == DEBUG_HOOK_HANDLED) {
+		/* single step is complete, call post handlers */
+		local_irq_save(flags);
+		post_kprobe_handler(kcb, regs);
+		local_irq_restore(flags);
+	}
+
+	return retval;
+}
+
+static int __kprobes
+kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	kprobe_handler(regs);
+	local_irq_restore(flags);
+
+	return DEBUG_HOOK_HANDLED;
+}
+
+int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	long stack_ptr = stack_pointer(regs);
+
+	kcb->jprobe_saved_regs = *regs;
+	memcpy(kcb->jprobes_stack, (void *)stack_ptr,
+	       MIN_STACK_SIZE(stack_ptr));
+
+	instruction_pointer(regs) = (long)jp->entry;
+	regs->pstate |= PSR_I_BIT;
+
+	preempt_disable();
+	return 1;
+}
+
+void __kprobes jprobe_return(void)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	/*
+	 * Jprobe handler return by entering break exception,
+	 * encoded same as kprobe, but with following conditions
+	 * -a magic number in x0 to identify from rest of other kprobes.
+	 * -restore stack addr to original saved pt_regs
+	 */
+	asm volatile ("ldr x0, [%0]\n\t"
+		      "mov sp, x0\n\t"
+		      "ldr x0, =" __stringify(JPROBES_MAGIC_NUM) "\n\t"
+		      "BRK %1\n\t"
+		      "NOP\n\t"
+		      :
+		      : "r"(&kcb->jprobe_saved_regs.sp),
+		      "I"(BRK64_ESR_KPROBES)
+		      : "memory");
+}
+
+int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	long stack_addr = kcb->jprobe_saved_regs.sp;
+	long orig_sp = stack_pointer(regs);
+	struct jprobe *jp = container_of(p, struct jprobe, kp);
+
+	if (regs->regs[0] == JPROBES_MAGIC_NUM) {
+		if (orig_sp != stack_addr) {
+			struct pt_regs *saved_regs =
+			    (struct pt_regs *)kcb->jprobe_saved_regs.sp;
+			pr_err("current sp %lx does not match saved sp %lx\n",
+			       orig_sp, stack_addr);
+			pr_err("Saved registers for jprobe %p\n", jp);
+			show_regs(saved_regs);
+			pr_err("Current registers\n");
+			show_regs(regs);
+			BUG();
+		}
+		*regs = kcb->jprobe_saved_regs;
+		memcpy((void *)stack_addr, kcb->jprobes_stack,
+		       MIN_STACK_SIZE(stack_addr));
+		preempt_enable_no_resched();
+		return 1;
+	}
+	return 0;
+}
+
+/* Break Handler hook */
+static struct break_hook kprobes_break_hook = {
+	.esr_mask = BRK64_ESR_MASK,
+	.esr_val = BRK64_ESR_KPROBES,
+	.fn = kprobe_breakpoint_handler,
+};
+
+/* Single Step handler hook */
+static struct step_hook kprobes_step_hook = {
+	.fn = kprobe_single_step_handler,
+};
+
+int __init arch_init_kprobes()
+{
+	register_break_hook(&kprobes_break_hook);
+	register_step_hook(&kprobes_step_hook);
+
+	return 0;
+}
diff --git a/arch/arm64/kernel/kprobes.h b/arch/arm64/kernel/kprobes.h
new file mode 100644
index 0000000..0c78e18
--- /dev/null
+++ b/arch/arm64/kernel/kprobes.h
@@ -0,0 +1,28 @@
+/*
+ * arch/arm64/kernel/kprobes.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _ARM_KERNEL_KPROBES_H
+#define _ARM_KERNEL_KPROBES_H
+
+/* BRK opcodes with ESR encoding  */
+#define BRK64_ESR_MASK		0xFFFF
+#define BRK64_ESR_KPROBES	0x0001
+#define BRK64_OPCODE_KPROBES	0xD4200020	/* "brk 0x1" */
+#define ARCH64_NOP_OPCODE	0xD503201F
+
+#define JPROBES_MAGIC_NUM	0xa5a5a5a5a5a5a5a5
+
+/* Move this out to appropriate header file */
+int fixup_exception(struct pt_regs *regs);
+
+#endif /* _ARM_KERNEL_KPROBES_H */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f8ab9d8..40951b1 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -62,6 +62,7 @@ SECTIONS
 			TEXT_TEXT
 			SCHED_TEXT
 			LOCK_TEXT
+			KPROBES_TEXT
 			HYPERVISOR_TEXT
 			*(.fixup)
 			*(.gnu.warning)
-- 
1.8.1.2
