From: tixy@yxit.co.uk (Tixy)
Date: Tue, 19 Apr 2011 10:52:18 +0100
Subject: [PATCH 3/5] ARM: kprobes: Add emulation of SBFX, UBFX,
	BFI and BFC instructions
In-Reply-To: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
References: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303206740-10101-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These bit field manipulation instructions occur several thousand
times in an ARMv7 kernel.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   42 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 51e6957..25d4a04 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -672,6 +672,19 @@ emulate_rd12_modify(struct kprobe *p, struct pt_regs *regs)
 	regs->uregs[rd] = insnslot_1arg_rflags(rdv, regs->ARM_cpsr, i_fn);
 }
 
+static void __kprobes
+emulate_rd12rn0_modify(struct kprobe *p, struct pt_regs *regs)
+{
+	insn_2arg_fn_t *i_fn = (insn_2arg_fn_t *)&p->ainsn.insn[0];
+	kprobe_opcode_t insn = p->opcode;
+	int rd = (insn >> 12) & 0xf;
+	int rn = insn & 0xf;
+	long rdv = regs->uregs[rd];
+	long rnv = regs->uregs[rn];
+
+	regs->uregs[rd] = insnslot_2arg_rflags(rdv, rnv, regs->ARM_cpsr, i_fn);
+}
+
 static void __kprobes emulate_rd12rm0(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
@@ -870,6 +883,20 @@ prep_emulate_rd12_modify(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 }
 
 static enum kprobe_insn __kprobes
+prep_emulate_rd12rn0_modify(kprobe_opcode_t insn,
+			    struct arch_specific_insn *asi)
+{
+	if (is_r15(insn, 12))
+		return INSN_REJECTED;	/* Rd is PC */
+
+	insn &= 0xffff0ff0;	/* Rd = r0 */
+	insn |= 0x00000001;	/* Rn = r1 */
+	asi->insn[0] = insn;
+	asi->insn_handler = emulate_rd12rn0_modify;
+	return INSN_GOOD;
+}
+
+static enum kprobe_insn __kprobes
 prep_emulate_rd12rm0(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	if (is_r15(insn, 12))
@@ -1396,6 +1423,21 @@ space_cccc_0111__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	if ((insn & 0x0ff000d0) == 0x075000d0)
 		return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
 
+	/* SBFX   : cccc 0111 101x xxxx xxxx xxxx x101 xxxx :  */
+	/* UBFX   : cccc 0111 111x xxxx xxxx xxxx x101 xxxx :  */
+	if ((insn & 0x0fa00070) == 0x07a00050)
+		return prep_emulate_rd12rm0(insn, asi);
+
+	/* BFI    : cccc 0111 110x xxxx xxxx xxxx x001 xxxx :  */
+	/* BFC    : cccc 0111 110x xxxx xxxx xxxx x001 1111 :  */
+	if ((insn & 0x0fe00070) == 0x07c00010) {
+
+		if ((insn & 0x0000000f) == 0x0000000f)
+			return prep_emulate_rd12_modify(insn, asi);
+		else
+			return prep_emulate_rd12rn0_modify(insn, asi);
+	}
+
 	return INSN_REJECTED;
 }
 
-- 
1.7.2.5
