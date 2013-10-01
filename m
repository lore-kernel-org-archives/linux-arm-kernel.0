From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Tue,  1 Oct 2013 21:27:58 +0530
Subject: [PATCH RFC v1 3/5] AArch64: Instruction simulation and decode support
In-Reply-To: <1380643080-8984-1-git-send-email-sandeepa.prabhu@linaro.org>
References: <1380643080-8984-1-git-send-email-sandeepa.prabhu@linaro.org>
Message-ID: <1380643080-8984-4-git-send-email-sandeepa.prabhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for v8 instruction decoding and simulation is implemented,
which are common for use by kprobes as well as uprobes.

Kprobes/uprobes on ARM64 is leveraged on single-stepping of
instruction from a out-of-line memory slot.

The instructions that use PC-relative access can not be stepped from
out-of-line memory slot, so are simulated in C code using the saved
copy of pt_regs.

This patch implements helper macros and data structures for
building instruction decode table, along with handlers for
instruction prepare and simulation.

Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
---
 arch/arm64/include/asm/probes.h    |  48 ++++++++
 arch/arm64/kernel/probes-aarch64.c | 235 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/probes-aarch64.h | 127 ++++++++++++++++++++
 arch/arm64/kernel/probes-common.c  | 117 ++++++++++++++++++
 4 files changed, 527 insertions(+)
 create mode 100644 arch/arm64/include/asm/probes.h
 create mode 100644 arch/arm64/kernel/probes-aarch64.c
 create mode 100644 arch/arm64/kernel/probes-aarch64.h
 create mode 100644 arch/arm64/kernel/probes-common.c

diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
new file mode 100644
index 0000000..8d4355e
--- /dev/null
+++ b/arch/arm64/include/asm/probes.h
@@ -0,0 +1,48 @@
+/*
+ * arch/arm64/include/asm/probes.h
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
+#ifndef _ARM_PROBES_H
+#define _ARM_PROBES_H
+
+struct kprobe;
+struct arch_specific_insn;
+
+typedef u32 kprobe_opcode_t;
+typedef unsigned long (kprobes_pstate_check_t)(unsigned long);
+typedef unsigned long
+(kprobes_condition_check_t)(struct kprobe *, struct pt_regs *);
+typedef void
+(kprobes_prepare_t)(struct kprobe *, struct arch_specific_insn *);
+typedef void (kprobes_handler_t) (struct kprobe *, struct pt_regs *);
+
+typedef enum {
+	NO_RESTORE,
+	RESTORE_PC,
+} pc_restore_t;
+
+struct kprobe_pc_restore {
+	pc_restore_t type;
+	unsigned long addr;
+};
+
+/* architecture specific copy of original instruction */
+struct arch_specific_insn {
+	kprobe_opcode_t *insn;
+	kprobes_pstate_check_t *pstate_cc;
+	kprobes_condition_check_t *check_condn;
+	kprobes_prepare_t *prepare;
+	kprobes_handler_t *handler;
+	/* restore address after step xol */
+	struct kprobe_pc_restore restore;
+};
+
+#endif
diff --git a/arch/arm64/kernel/probes-aarch64.c b/arch/arm64/kernel/probes-aarch64.c
new file mode 100644
index 0000000..0163129
--- /dev/null
+++ b/arch/arm64/kernel/probes-aarch64.c
@@ -0,0 +1,235 @@
+/*
+ * arch/arm64/kernel/probes-aarch64.c
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
+
+#define sign_extend(x, signbit)		\
+	((x) | (0 - ((x) & (1 << (signbit)))))
+
+#define bbl_displacement(insn)		\
+	sign_extend(((insn) & 0x3ffffff) << 2, 27)
+
+#define bcond_displacement(insn)	\
+	sign_extend(((insn >> 5) & 0xfffff) << 2, 21)
+
+#define cbz_displacement(insn)	\
+	sign_extend(((insn >> 5) & 0xfffff) << 2, 21)
+
+#define tbz_displacement(insn)	\
+	sign_extend(((insn >> 5) & 0x3fff) << 2, 15)
+
+#define ldr_displacement(insn)	\
+	sign_extend(((insn >> 5) & 0xfffff) << 2, 21)
+
+/* conditional check functions */
+static unsigned long __kprobes
+__check_pstate(struct kprobe *p, struct pt_regs *regs)
+{
+	struct arch_specific_insn *asi = &p->ainsn;
+	unsigned long pstate = regs->pstate & 0xffffffff;
+
+	return asi->pstate_cc(pstate);
+}
+
+static unsigned long __kprobes
+__check_cbz(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int xn = insn & 0x1f;
+
+	return (insn & (1 << 31)) ?
+	    !(regs->regs[xn]) : !(regs->regs[xn] & 0xffffffff);
+}
+
+static unsigned long __kprobes
+__check_cbnz(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int xn = insn & 0x1f;
+
+	return (insn & (1 << 31)) ?
+	    (regs->regs[xn]) : (regs->regs[xn] & 0xffffffff);
+}
+
+static unsigned long __kprobes
+__check_tbz(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int xn = insn & 0x1f;
+	int bit_pos = ((insn & (1 << 31)) >> 26) | ((insn >> 19) & 0x1f);
+
+	return ~((regs->regs[xn] >> bit_pos) & 0x1);
+}
+
+static unsigned long __kprobes
+__check_tbnz(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int xn = insn & 0x1f;
+	int bit_pos = ((insn & (1 << 31)) >> 26) | ((insn >> 19) & 0x1f);
+
+	return (regs->regs[xn] >> bit_pos) & 0x1;
+}
+
+/* prepare functions */
+void __kprobes prepare_none(struct kprobe *p, struct arch_specific_insn *asi)
+{
+}
+
+void __kprobes prepare_bcond(struct kprobe *p, struct arch_specific_insn *asi)
+{
+	kprobe_opcode_t insn = p->opcode;
+
+	asi->check_condn = __check_pstate;
+	asi->pstate_cc = kprobe_condition_checks[insn & 0xf];
+}
+
+void __kprobes
+prepare_cbz_cbnz(struct kprobe *p, struct arch_specific_insn *asi)
+{
+	kprobe_opcode_t insn = p->opcode;
+
+	asi->check_condn = (insn & (1 << 24)) ? __check_cbnz : __check_cbz;
+}
+
+void __kprobes
+prepare_tbz_tbnz(struct kprobe *p, struct arch_specific_insn *asi)
+{
+	kprobe_opcode_t insn = p->opcode;
+
+	asi->check_condn = (insn & (1 << 24)) ? __check_tbnz : __check_tbz;
+}
+
+/* simulate functions */
+void __kprobes simulate_none(struct kprobe *p, struct pt_regs *regs)
+{
+}
+
+void __kprobes simulate_adr_adrp(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	long iaddr = (long)p->addr;
+	long res, imm, xn;
+
+	xn = insn & 0x1f;
+	imm = ((insn >> 3) & 0xffffc) | ((insn >> 29) & 0x3);
+	res = iaddr + 8 + sign_extend(imm, 20);
+
+	regs->regs[xn] = insn & 0x80000000 ? res & 0xfffffffffffff000 : res;
+	instruction_pointer(regs) += 4;
+
+	return;
+}
+
+void __kprobes simulate_b_bl(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	long iaddr = (long)p->addr;
+	int disp = bbl_displacement(insn);
+
+	/* Link register */
+	if (insn & (1 << 31))
+		regs->regs[30] = iaddr + 4;
+
+	instruction_pointer(regs) = iaddr + disp;
+
+	return;
+}
+
+void __kprobes simulate_b_cond(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	long iaddr = (long)p->addr;
+	int disp = bcond_displacement(insn);
+
+	instruction_pointer(regs) = iaddr + disp;
+
+	return;
+}
+
+void __kprobes simulate_br_blr_ret(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	long iaddr = (long)p->addr;
+	int xn = (insn >> 5) & 0x1f;
+
+	/* BLR */
+	if (((insn >> 21) & 0x3) == 1)
+		regs->regs[30] = iaddr + 4;
+
+	instruction_pointer(regs) = regs->regs[xn];
+
+	return;
+}
+
+void __kprobes simulate_cbz_cbnz(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	long iaddr = (long)p->addr;
+	int disp = cbz_displacement(insn);
+
+	instruction_pointer(regs) = iaddr + disp;
+
+	return;
+}
+
+void __kprobes simulate_tbz_tbnz(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	long iaddr = (long)p->addr;
+	int disp = tbz_displacement(insn);
+
+	instruction_pointer(regs) = iaddr + disp;
+
+	return;
+}
+
+void __kprobes simulate_ldr_literal(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	u64 *load_addr;
+	long iaddr = (long)p->addr;
+	int xn = insn & 0x1f;
+	int disp = ldr_displacement(insn);
+
+	load_addr = (u64 *) (iaddr + disp);
+
+	if (insn & (1 << 30))	/* x0-x31 */
+		regs->regs[xn] = *load_addr;
+	else			/* w0-w31 */
+		*(u32 *) (&regs->regs[xn]) = (*(u32 *) (load_addr));
+
+	return;
+}
+
+void __kprobes simulate_ldrsw_literal(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	u64 *load_addr;
+	long data, iaddr = (long)p->addr;
+	int xn = insn & 0x1f;
+	int disp = ldr_displacement(insn);
+
+	load_addr = (u64 *) (iaddr + disp);
+	data = *load_addr;
+
+	regs->regs[xn] = sign_extend(data, 63);
+
+	return;
+}
diff --git a/arch/arm64/kernel/probes-aarch64.h b/arch/arm64/kernel/probes-aarch64.h
new file mode 100644
index 0000000..fb7475c
--- /dev/null
+++ b/arch/arm64/kernel/probes-aarch64.h
@@ -0,0 +1,127 @@
+/*
+ * arch/arm64/kernel/probes-aarch64.h
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
+#ifndef _ARM_KERNEL_PROBES_AARCH64_H
+#define _ARM_KERNEL_PROBES_AARCH64_H
+
+/*
+ * The following definitions and macros are used to build instruction
+ * decoding tables.
+ */
+enum decode_type {
+	DECODE_TYPE_END,
+	DECODE_TYPE_REJECT,
+	DECODE_TYPE_SINGLESTEP,
+	DECODE_TYPE_SIMULATE,
+	DECODE_TYPE_TABLE,
+	NUM_DECODE_TYPES,	/* Must be last enum */
+};
+
+struct aarch64_decode_item;
+
+struct aarch64_decode_header {
+	enum decode_type type;
+	u32 mask;
+	u32 val;
+};
+
+struct aarch64_decode_actions {
+	kprobes_prepare_t *prepare;
+	kprobes_handler_t *handler;
+};
+
+struct aarch64_decode_table {
+	const struct aarch64_decode_item *tbl;
+};
+
+union aarch64_decode_handler {
+	struct aarch64_decode_actions actions;
+	struct aarch64_decode_table table;
+};
+
+struct aarch64_decode_item {
+	struct aarch64_decode_header header;
+	union aarch64_decode_handler decode;
+};
+
+#define decode_get_type(_entry)	 ((_entry).header.type)
+
+#define decode_table_end(_entry)		\
+	((_entry).header.type == DECODE_TYPE_END)
+
+#define decode_table_hit(_entry, insn)		\
+	((insn & (_entry).header.mask) == (_entry).header.val)
+
+#define decode_prepare_fn(_entry)	((_entry).decode.actions.prepare)
+#define decode_handler_fn(_entry)	((_entry).decode.actions.handler)
+#define decode_sub_table(_entry)	((_entry).decode.table.tbl)
+
+#define DECODE_ADD_HEADER(_type, _val, _mask)	\
+	.header = {				\
+		.type = _type,			\
+		.mask = _mask,			\
+		.val = _val,			\
+	},
+
+#define DECODE_ADD_ACTION(_prepare, _handler)	\
+	.decode = {				\
+		.actions = {			\
+			.prepare = _prepare,	\
+			.handler = _handler,	\
+		}				\
+	},
+
+#define DECODE_ADD_TABLE(_table)		\
+	.decode = {				\
+		.table = {.tbl = _table}	\
+	},
+
+#define DECODE_REJECT(_v, _m)					\
+	{ DECODE_ADD_HEADER(DECODE_TYPE_REJECT, _v, _m) }
+
+#define DECODE_SINGLESTEP(_v, _m)				\
+	{ DECODE_ADD_HEADER(DECODE_TYPE_SINGLESTEP, _v, _m) }
+
+#define DECODE_SIMULATE(_v, _m, _p, _h)				\
+	{ DECODE_ADD_HEADER(DECODE_TYPE_SIMULATE, _v, _m)	\
+	  DECODE_ADD_ACTION(_p, _h) }
+
+#define DECODE_TABLE(_v, _m, _table)				\
+	{ DECODE_ADD_HEADER(DECODE_TYPE_TABLE, _v, _m)		\
+	  DECODE_ADD_TABLE(_table) }
+
+#define DECODE_LITERAL(_v, _m, _p, _h)	DECODE_SIMULATE(_v, _m, _p, _h)
+#define DECODE_BRANCH(_v, _m, _p, _h)	DECODE_SIMULATE(_v, _m, _p, _h)
+
+/* should be the last element in decode structure */
+#define DECODE_END	{ .header = {.type = DECODE_TYPE_END, } }
+
+extern kprobes_pstate_check_t *const kprobe_condition_checks[16];
+
+void __kprobes prepare_none(struct kprobe *p, struct arch_specific_insn *asi);
+void __kprobes prepare_bcond(struct kprobe *p, struct arch_specific_insn *asi);
+void __kprobes prepare_cbz_cbnz(struct kprobe *p,
+				struct arch_specific_insn *asi);
+void __kprobes prepare_tbz_tbnz(struct kprobe *p,
+				struct arch_specific_insn *asi);
+void __kprobes simulate_none(struct kprobe *p, struct pt_regs *regs);
+void __kprobes simulate_adr_adrp(struct kprobe *p, struct pt_regs *regs);
+void __kprobes simulate_b_bl(struct kprobe *p, struct pt_regs *regs);
+void __kprobes simulate_b_cond(struct kprobe *p, struct pt_regs *regs);
+void __kprobes simulate_br_blr_ret(struct kprobe *p, struct pt_regs *regs);
+void __kprobes simulate_cbz_cbnz(struct kprobe *p, struct pt_regs *regs);
+void __kprobes simulate_tbz_tbnz(struct kprobe *p, struct pt_regs *regs);
+void __kprobes simulate_ldr_literal(struct kprobe *p, struct pt_regs *regs);
+void __kprobes simulate_ldrsw_literal(struct kprobe *p, struct pt_regs *regs);
+
+#endif /* _ARM_KERNEL_PROBES_AARCH64_H */
diff --git a/arch/arm64/kernel/probes-common.c b/arch/arm64/kernel/probes-common.c
new file mode 100644
index 0000000..4990940
--- /dev/null
+++ b/arch/arm64/kernel/probes-common.c
@@ -0,0 +1,117 @@
+/*
+ * arch/arm64/kernel/probes-common.c
+ *
+ * copied from arch/arm/kernel/kprobes-common.c
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
+ * Description:
+ * This file is the place for common routines for AArch64 and
+ * AArch32 conditional checks, needed by kprobes-AArch64 and
+ * uprobes-AArch32/AArch64
+ *
+ * AArch64 and AArch32 instrcution decoding differ, and are implemented
+ * in respective probes-*** files, this file is for common code only.
+ */
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+#include <linux/module.h>
+
+static unsigned long __kprobes __check_eq(unsigned long pstate)
+{
+	return pstate & PSR_Z_BIT;
+}
+
+static unsigned long __kprobes __check_ne(unsigned long pstate)
+{
+	return (~pstate) & PSR_Z_BIT;
+}
+
+static unsigned long __kprobes __check_cs(unsigned long pstate)
+{
+	return pstate & PSR_C_BIT;
+}
+
+static unsigned long __kprobes __check_cc(unsigned long pstate)
+{
+	return (~pstate) & PSR_C_BIT;
+}
+
+static unsigned long __kprobes __check_mi(unsigned long pstate)
+{
+	return pstate & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_pl(unsigned long pstate)
+{
+	return (~pstate) & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_vs(unsigned long pstate)
+{
+	return pstate & PSR_V_BIT;
+}
+
+static unsigned long __kprobes __check_vc(unsigned long pstate)
+{
+	return (~pstate) & PSR_V_BIT;
+}
+
+static unsigned long __kprobes __check_hi(unsigned long pstate)
+{
+	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
+	return pstate & PSR_C_BIT;
+}
+
+static unsigned long __kprobes __check_ls(unsigned long pstate)
+{
+	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
+	return (~pstate) & PSR_C_BIT;
+}
+
+static unsigned long __kprobes __check_ge(unsigned long pstate)
+{
+	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
+	return (~pstate) & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_lt(unsigned long pstate)
+{
+	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
+	return pstate & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_gt(unsigned long pstate)
+{
+	/*PSR_N_BIT ^= PSR_V_BIT */
+	unsigned long temp = pstate ^ (pstate << 3);
+	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
+	return (~temp) & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_le(unsigned long pstate)
+{
+	/*PSR_N_BIT ^= PSR_V_BIT */
+	unsigned long temp = pstate ^ (pstate << 3);
+	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
+	return temp & PSR_N_BIT;
+}
+
+static unsigned long __kprobes __check_al(unsigned long pstate)
+{
+	return true;
+}
+
+kprobes_pstate_check_t *const kprobe_condition_checks[16] = {
+	&__check_eq, &__check_ne, &__check_cs, &__check_cc,
+	&__check_mi, &__check_pl, &__check_vs, &__check_vc,
+	&__check_hi, &__check_ls, &__check_ge, &__check_lt,
+	&__check_gt, &__check_le, &__check_al, &__check_al
+};
-- 
1.8.1.2
