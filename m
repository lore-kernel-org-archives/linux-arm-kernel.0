From: dave.long@linaro.org (David Long)
Date: Tue, 17 Feb 2015 18:11:39 -0500
Subject: [PATCH v5 4/6] arm64: kprobes instruction simulation support
In-Reply-To: <1424214701-4899-1-git-send-email-dave.long@linaro.org>
References: <1424214701-4899-1-git-send-email-dave.long@linaro.org>
Message-ID: <1424214701-4899-5-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>

Kprobes needs simulation of instructions that cannot be stepped
from different memory location, e.g.: those instructions
that uses PC-relative addressing. In simulation, the behaviour
of the instruction is implemented using a copy of pt_regs.

Following instruction catagories are simulated:
 - All branching instructions(conditional, register, and immediate)
 - Literal access instructions(load-literal, adr/adrp)

Conditional execution is limited to branching instructions in
ARM v8. If conditions at PSTATE do not match the condition fields
of opcode, the instruction is effectively NOP. Kprobes considers
this case as 'miss'.

Thanks to Will Cohen for assorted suggested changes.

Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
Signed-off-by: William Cohen <wcohen@redhat.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm64/kernel/Makefile        |  4 +-
 arch/arm64/kernel/kprobes-arm64.c | 98 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/kprobes-arm64.h |  2 +
 arch/arm64/kernel/kprobes.c       | 35 ++++++++++++--
 4 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 6ca9fc0..6e4dcde 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -31,7 +31,9 @@ arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
 arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
-arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o
+arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o		\
+					   probes-simulate-insn.o		\
+					   probes-condn-check.o
 arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
diff --git a/arch/arm64/kernel/kprobes-arm64.c b/arch/arm64/kernel/kprobes-arm64.c
index f958c52..8a7e6b0 100644
--- a/arch/arm64/kernel/kprobes-arm64.c
+++ b/arch/arm64/kernel/kprobes-arm64.c
@@ -20,6 +20,76 @@
 #include <asm/insn.h>
 
 #include "kprobes-arm64.h"
+#include "probes-simulate-insn.h"
+
+/*
+ * condition check functions for kprobes simulation
+ */
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
+	return check_cbz((u32)p->opcode, regs);
+}
+
+static unsigned long __kprobes
+__check_cbnz(struct kprobe *p, struct pt_regs *regs)
+{
+	return check_cbnz((u32)p->opcode, regs);
+}
+
+static unsigned long __kprobes
+__check_tbz(struct kprobe *p, struct pt_regs *regs)
+{
+	return check_tbz((u32)p->opcode, regs);
+}
+
+static unsigned long __kprobes
+__check_tbnz(struct kprobe *p, struct pt_regs *regs)
+{
+	return check_tbnz((u32)p->opcode, regs);
+}
+
+/*
+ * prepare functions for instruction simulation
+ */
+static void __kprobes
+prepare_none(struct kprobe *p, struct arch_specific_insn *asi)
+{
+}
+
+static void __kprobes
+prepare_bcond(struct kprobe *p, struct arch_specific_insn *asi)
+{
+	kprobe_opcode_t insn = p->opcode;
+
+	asi->check_condn = __check_pstate;
+	asi->pstate_cc = kprobe_condition_checks[insn & 0xf];
+}
+
+static void __kprobes
+prepare_cbz_cbnz(struct kprobe *p, struct arch_specific_insn *asi)
+{
+	kprobe_opcode_t insn = p->opcode;
+
+	asi->check_condn = (insn & (1 << 24)) ? __check_cbnz : __check_cbz;
+}
+
+static void __kprobes
+prepare_tbz_tbnz(struct kprobe *p, struct arch_specific_insn *asi)
+{
+	kprobe_opcode_t insn = p->opcode;
+
+	asi->check_condn = (insn & (1 << 24)) ? __check_tbnz : __check_tbz;
+}
 
 static bool __kprobes aarch64_insn_is_steppable(u32 insn)
 {
@@ -63,6 +133,34 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	 */
 	if (aarch64_insn_is_steppable(insn))
 		return INSN_GOOD;
+
+	asi->prepare = prepare_none;
+
+	if (aarch64_insn_is_bcond(insn)) {
+		asi->prepare = prepare_bcond;
+		asi->handler = simulate_b_cond;
+	} else if (aarch64_insn_is_cb(insn)) {
+		asi->prepare = prepare_cbz_cbnz;
+		asi->handler = simulate_cbz_cbnz;
+	} else if (aarch64_insn_is_tb(insn)) {
+		asi->prepare = prepare_tbz_tbnz;
+		asi->handler = simulate_tbz_tbnz;
+	} else if (aarch64_insn_is_adr_adrp(insn))
+		asi->handler = simulate_adr_adrp;
+	else if (aarch64_insn_is_b_bl(insn))
+		asi->handler = simulate_b_bl;
+	else if (aarch64_insn_is_br_blr(insn) || aarch64_insn_is_ret(insn))
+		asi->handler = simulate_br_blr_ret;
+	else if (aarch64_insn_is_ldr_lit(insn))
+		asi->handler = simulate_ldr_literal;
+	else if (aarch64_insn_is_ldrsw_lit(insn))
+		asi->handler = simulate_ldrsw_literal;
 	else
+		/*
+		 * Instruction cannot be stepped out-of-line and we don't
+		 * (yet) simulate it.
+		 */
 		return INSN_REJECTED;
+
+	return INSN_GOOD_NO_SLOT;
 }
diff --git a/arch/arm64/kernel/kprobes-arm64.h b/arch/arm64/kernel/kprobes-arm64.h
index 87e7891..ff8a55f 100644
--- a/arch/arm64/kernel/kprobes-arm64.h
+++ b/arch/arm64/kernel/kprobes-arm64.h
@@ -22,6 +22,8 @@ enum kprobe_insn {
 	INSN_GOOD,
 };
 
+extern kprobes_pstate_check_t * const kprobe_condition_checks[16];
+
 enum kprobe_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi);
 
diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
index 1ead41f..e157877 100644
--- a/arch/arm64/kernel/kprobes.c
+++ b/arch/arm64/kernel/kprobes.c
@@ -38,6 +38,9 @@
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
+static void __kprobes
+post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
+
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	/* prepare insn slot */
@@ -54,6 +57,27 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 	p->ainsn.restore.type = RESTORE_PC;
 }
 
+static void __kprobes arch_prepare_simulate(struct kprobe *p)
+{
+	if (p->ainsn.prepare)
+		p->ainsn.prepare(p, &p->ainsn);
+
+	/* This instructions is not executed xol. No need to adjust the PC */
+	p->ainsn.restore.addr = 0;
+	p->ainsn.restore.type = NO_RESTORE;
+}
+
+static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (p->ainsn.handler)
+		p->ainsn.handler((u32)p->opcode, (long)p->addr, regs);
+
+	/* single step simulated, now go for post processing */
+	post_kprobe_handler(kcb, regs);
+}
+
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	kprobe_opcode_t insn;
@@ -72,7 +96,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		return -EINVAL;
 
 	case INSN_GOOD_NO_SLOT:	/* insn need simulation */
-		return -EINVAL;
+		p->ainsn.insn = NULL;
+		break;
 
 	case INSN_GOOD:	/* instruction uses slot */
 		p->ainsn.insn = get_insn_slot();
@@ -82,7 +107,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	};
 
 	/* prepare the instruction */
-	arch_prepare_ss_slot(p);
+	if (p->ainsn.insn)
+		arch_prepare_ss_slot(p);
+	else
+		arch_prepare_simulate(p);
 
 	return 0;
 }
@@ -231,7 +259,8 @@ static void __kprobes setup_singlestep(struct kprobe *p,
 		kernel_enable_single_step(regs);
 		instruction_pointer(regs) = slot;
 	} else	{
-		BUG();
+		/* insn simulation */
+		arch_simulate_insn(p, regs);
 	}
 }
 
-- 
1.8.1.2
