From: tixy@yxit.co.uk (Tixy)
Date: Wed,  6 Apr 2011 11:17:11 +0100
Subject: [PATCH v2 3/4] ARM: kprobes: Fix emulation of CMP, CMN,
	TST and TEQ instructions.
In-Reply-To: <1302085032-30415-1-git-send-email-tixy@yxit.co.uk>
References: <1302085032-30415-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302085032-30415-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Probing these instructions was corrupting R0 because the emulation code
didn't account for the fact that they don't write a result to a
register.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   55 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index faa976c..98d2f87 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -808,6 +808,17 @@ emulate_alu_imm_rwflags(struct kprobe *p, struct pt_regs *regs)
 }
 
 static void __kprobes
+emulate_alu_tests_imm(struct kprobe *p, struct pt_regs *regs)
+{
+	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
+	kprobe_opcode_t insn = p->opcode;
+	int rn = (insn >> 16) & 0xf;
+	long rnv = (rn == 15) ? (long)p->addr + 8 : regs->uregs[rn];
+
+	insnslot_1arg_rwflags(rnv, &regs->ARM_cpsr, i_fn);
+}
+
+static void __kprobes
 emulate_alu_rflags(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_3arg_fn_t *i_fn = (insn_3arg_fn_t *)&p->ainsn.insn[0];
@@ -843,6 +854,22 @@ emulate_alu_rwflags(struct kprobe *p, struct pt_regs *regs)
 		insnslot_3arg_rwflags(rnv, rmv, rsv, &regs->ARM_cpsr, i_fn);
 }
 
+static void __kprobes
+emulate_alu_tests(struct kprobe *p, struct pt_regs *regs)
+{
+	insn_3arg_fn_t *i_fn = (insn_3arg_fn_t *)&p->ainsn.insn[0];
+	kprobe_opcode_t insn = p->opcode;
+	long ppc = (long)p->addr + 8;
+	int rn = (insn >> 16) & 0xf;
+	int rs = (insn >> 8) & 0xf;	/* rs/rsv may be invalid, don't care. */
+	int rm = insn & 0xf;
+	long rnv = (rn == 15) ? ppc : regs->uregs[rn];
+	long rmv = (rm == 15) ? ppc : regs->uregs[rm];
+	long rsv = regs->uregs[rs];
+
+	insnslot_3arg_rwflags(rnv, rmv, rsv, &regs->ARM_cpsr, i_fn);
+}
+
 static enum kprobe_insn __kprobes
 prep_emulate_ldr_str(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
@@ -1142,8 +1169,20 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		insn |= 0x00000200;     /* Rs = r2 */
 	}
 	asi->insn[0] = insn;
-	asi->insn_handler = (insn & (1 << 20)) ?  /* S-bit */
+
+	if ((insn & 0x0f900000) == 0x01100000) {
+		/*
+		 * TST : cccc 0001 0001 xxxx xxxx xxxx xxxx xxxx
+		 * TEQ : cccc 0001 0011 xxxx xxxx xxxx xxxx xxxx
+		 * CMP : cccc 0001 0101 xxxx xxxx xxxx xxxx xxxx
+		 * CMN : cccc 0001 0111 xxxx xxxx xxxx xxxx xxxx
+		 */
+		asi->insn_handler = emulate_alu_tests;
+	} else {
+		/* ALU ops which write to Rd */
+		asi->insn_handler = (insn & (1 << 20)) ?  /* S-bit */
 				emulate_alu_rwflags : emulate_alu_rflags;
+	}
 	return INSN_GOOD;
 }
 
@@ -1170,8 +1209,20 @@ space_cccc_001x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	 */
 	insn &= 0xffff0fff;	/* Rd = r0 */
 	asi->insn[0] = insn;
-	asi->insn_handler = (insn & (1 << 20)) ?  /* S-bit */
+
+	if ((insn & 0x0f900000) == 0x03100000) {
+		/*
+		 * TST : cccc 0011 0001 xxxx xxxx xxxx xxxx xxxx
+		 * TEQ : cccc 0011 0011 xxxx xxxx xxxx xxxx xxxx
+		 * CMP : cccc 0011 0101 xxxx xxxx xxxx xxxx xxxx
+		 * CMN : cccc 0011 0111 xxxx xxxx xxxx xxxx xxxx
+		 */
+		asi->insn_handler = emulate_alu_tests_imm;
+	} else {
+		/* ALU ops which write to Rd */
+		asi->insn_handler = (insn & (1 << 20)) ?  /* S-bit */
 			emulate_alu_imm_rwflags : emulate_alu_imm_rflags;
+	}
 	return INSN_GOOD;
 }
 
-- 
1.7.2.5
