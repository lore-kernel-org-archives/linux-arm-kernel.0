From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:24 +0100
Subject: [PATCH 37/51] ARM: kprobes: Optimise emulation of LDM and STM
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-38-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This patch improves the performance of LDM and STM instruction
emulation. This is desirable because.

- jprobes and kretprobes probe the first instruction in a function and,
  when the frame pointer is omitted, this instruction is often a STM
  used to push registers onto the stack.

- The STM and LDM instructions are common in the body and tail of
  functions.

- At the same time as being a common instruction form, they also have
  one of the slowest and most complicated simulation routines.

The approach taken to optimisation is to use simulation rather than
emulation, that is, a modified form of the instruction is run with
an appropriate register context.

Benchmarking on an OMAP3530 shows the optimised emulation is between 2
and 3 times faster than the simulation routines. On a Kirkwood based
device the relative performance was very significantly better than this.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-common.c |   68 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index 9ac1427..765c682 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -220,13 +220,81 @@ static void __kprobes simulate_ldm1_pc(struct kprobe *p, struct pt_regs *regs)
 	load_write_pc(regs->ARM_pc, regs);
 }
 
+static void __kprobes
+emulate_generic_r0_12_noflags(struct kprobe *p, struct pt_regs *regs)
+{
+	register void *rregs asm("r1") = regs;
+	register void *rfn asm("lr") = p->ainsn.insn_fn;
+
+	__asm__ __volatile__ (
+		"stmdb	sp!, {%[regs], r11}	\n\t"
+		"ldmia	%[regs], {r0-r12}	\n\t"
+#if __LINUX_ARM_ARCH__ >= 6
+		"blx	%[fn]			\n\t"
+#else
+		"str	%[fn], [sp, #-4]!	\n\t"
+		"adr	lr, 1f			\n\t"
+		"ldr	pc, [sp], #4		\n\t"
+		"1:				\n\t"
+#endif
+		"ldr	lr, [sp], #4		\n\t" /* lr = regs */
+		"stmia	lr, {r0-r12}		\n\t"
+		"ldr	r11, [sp], #4		\n\t"
+		: [regs] "=r" (rregs), [fn] "=r" (rfn)
+		: "0" (rregs), "1" (rfn)
+		: "r0", "r2", "r3", "r4", "r5", "r6", "r7",
+		  "r8", "r9", "r10", "r12", "memory", "cc"
+		);
+}
+
+static void __kprobes
+emulate_generic_r2_14_noflags(struct kprobe *p, struct pt_regs *regs)
+{
+	emulate_generic_r0_12_noflags(p, (struct pt_regs *)(regs->uregs+2));
+}
+
+static void __kprobes
+emulate_ldm_r3_15(struct kprobe *p, struct pt_regs *regs)
+{
+	emulate_generic_r0_12_noflags(p, (struct pt_regs *)(regs->uregs+3));
+	load_write_pc(regs->ARM_pc, regs);
+}
+
 enum kprobe_insn __kprobes
 kprobe_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	kprobe_insn_handler_t *handler = 0;
 	unsigned reglist = insn & 0xffff;
 	int is_ldm = insn & 0x100000;
+	int rn = (insn >> 16) & 0xf;
+
+	if (rn <= 12 && (reglist & 0xe000) == 0) {
+		/* Instruction only uses registers in the range R0..R12 */
+		handler = emulate_generic_r0_12_noflags;
+
+	} else if (rn >= 2 && (reglist & 0x8003) == 0) {
+		/* Instruction only uses registers in the range R2..R14 */
+		rn -= 2;
+		reglist >>= 2;
+		handler = emulate_generic_r2_14_noflags;
+
+	} else if (rn >= 3 && (reglist & 0x0007) == 0) {
+		/* Instruction only uses registers in the range R3..R15 */
+		if (is_ldm && (reglist & 0x8000)) {
+			rn -= 3;
+			reglist >>= 3;
+			handler = emulate_ldm_r3_15;
+		}
+	}
+
+	if (handler) {
+		/* We can emulate the instruction in (possibly) modified form */
+		asi->insn[0] = (insn & 0xfff00000) | (rn << 16) | reglist;
+		asi->insn_handler = handler;
+		return INSN_GOOD;
+	}
 
+	/* Fallback to slower simulation... */
 	if (reglist & 0x8000)
 		handler = is_ldm ? simulate_ldm1_pc : simulate_stm1_pc;
 	else
-- 
1.7.2.5
