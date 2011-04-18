From: tixy@yxit.co.uk (Tixy)
Date: Mon, 18 Apr 2011 08:53:57 +0100
Subject: [PATCH 4/5] ARM: kprobes: Fix emulation of PLD instructions
In-Reply-To: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
References: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303113238-23920-5-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The PLD instructions wasn't being decoded correctly and the emulation
code wasn't adjusting PC correctly.

As the PLD instruction is only a performance hint we emulate it as a
simple nop, and we can broaden the instruction decoding to take into
account newer PLI and PLDW instructions.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index c68b26d..f36dba2 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -657,14 +657,8 @@ static void __kprobes emulate_none(struct kprobe *p, struct pt_regs *regs)
 	insnslot_0arg_rflags(regs->ARM_cpsr, i_fn);
 }
 
-static void __kprobes emulate_rn16(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes emulate_nop(struct kprobe *p, struct pt_regs *regs)
 {
-	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
-	kprobe_opcode_t insn = p->opcode;
-	int rn = (insn >> 16) & 0xf;
-	long rnv = regs->uregs[rn];
-
-	insnslot_1arg_rflags(rnv, regs->ARM_cpsr, i_fn);
 }
 
 static void __kprobes emulate_rd12rm0(struct kprobe *p, struct pt_regs *regs)
@@ -941,12 +935,13 @@ space_1111(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	    (insn & 0xfe5f0f00) == 0xf84d0500)
 		return INSN_REJECTED;
 
-	/* PLD : 1111 01x1 x101 xxxx xxxx xxxx xxxx xxxx : */
-	if ((insn & 0xfd700000) == 0xf4500000) {
-		insn &= 0xfff0ffff;	/* Rn = r0 */
-		asi->insn[0] = insn;
-		asi->insn_handler = emulate_rn16;
-		return INSN_GOOD;
+	/* memory hint : 1111 0100 x001 xxxx xxxx xxxx xxxx xxxx : */
+	/* PLDI        : 1111 0100 x101 xxxx xxxx xxxx xxxx xxxx : */
+	/* PLDW        : 1111 0101 x001 xxxx xxxx xxxx xxxx xxxx : */
+	/* PLD         : 1111 0101 x101 xxxx xxxx xxxx xxxx xxxx : */
+	if ((insn & 0xfe300000) == 0xf4100000) {
+		asi->insn_handler = emulate_nop;
+		return INSN_GOOD_NO_SLOT;
 	}
 
 	/* BLX(1) : 1111 101x xxxx xxxx xxxx xxxx xxxx xxxx : */
-- 
1.7.2.5
