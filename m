From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:07 +0100
Subject: [PATCH 18/24] ARM: kprobes: Add emulate_rd12rm0_noflags_nopc()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-19-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This is the emulation function for the instruction format used by the
ARM bit-field manipulation instructions.

Various other instruction forms can also make use of this and it is used
to replace use of prep_emulate_rd12{rm0}{_modify}

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   41 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 2131506..688101f 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1013,6 +1013,26 @@ emulate_rd16rn12rm0rs8_rwflags_nopc(struct kprobe *p, struct pt_regs *regs)
 	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
 }
 
+static void __kprobes
+emulate_rd12rm0_noflags_nopc(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rd = (insn >> 12) & 0xf;
+	int rm = insn & 0xf;
+
+	register unsigned long rdv asm("r0") = regs->uregs[rd];
+	register unsigned long rmv asm("r3") = regs->uregs[rm];
+
+	__asm__ __volatile__ (
+		BLX("%[fn]")
+		: "=r" (rdv)
+		: "0" (rdv), "r" (rmv), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rd] = rdv;
+}
+
 /*
  * For the instruction masking and comparisons in all the "space_*"
  * functions below, Do _not_ rearrange the order of tests unless
@@ -1068,7 +1088,8 @@ static const union decode_item arm_cccc_0001_0xx0____0xxx_table[] = {
 						 REGS(0, 0, 0, 0, NOPC)),
 
 	/* CLZ			cccc 0001 0110 xxxx xxxx xxxx 0001 xxxx */
-	DECODE_CUSTOM	(0x0ff000f0, 0x01600010, prep_emulate_rd12rm0),
+	DECODE_EMULATEX	(0x0ff000f0, 0x01600010, emulate_rd12rm0_noflags_nopc,
+						 REGS(0, NOPC, 0, 0, NOPC)),
 
 	/* QADD			cccc 0001 0000 xxxx xxxx xxxx 0101 xxxx */
 	/* QSUB			cccc 0001 0010 xxxx xxxx xxxx 0101 xxxx */
@@ -1249,7 +1270,8 @@ static const union decode_item arm_cccc_001x_table[] = {
 
 	/* MOVW			cccc 0011 0000 xxxx xxxx xxxx xxxx xxxx */
 	/* MOVT			cccc 0011 0100 xxxx xxxx xxxx xxxx xxxx */
-	DECODE_CUSTOM	(0x0fb00000, 0x03000000, prep_emulate_rd12_modify),
+	DECODE_EMULATEX	(0x0fb00000, 0x03000000, emulate_rd12rm0_noflags_nopc,
+						 REGS(0, NOPC, 0, 0, 0)),
 
 	/* YIELD		cccc 0011 0010 0000 xxxx xxxx 0000 0001 */
 	DECODE_OR	(0x0fff00ff, 0x03200001),
@@ -1314,7 +1336,8 @@ static const union decode_item arm_cccc_0110_____xxx1_table[] = {
 	/* REV16		cccc 0110 1011 xxxx xxxx xxxx 1011 xxxx */
 	/* RBIT			cccc 0110 1111 xxxx xxxx xxxx 0011 xxxx */
 	/* REVSH		cccc 0110 1111 xxxx xxxx xxxx 1011 xxxx */
-	DECODE_CUSTOM	(0x0fb00070, 0x06b00030, prep_emulate_rd12rm0),
+	DECODE_EMULATEX	(0x0fb00070, 0x06b00030, emulate_rd12rm0_noflags_nopc,
+						 REGS(0, NOPC, 0, 0, NOPC)),
 
 	/* ???			cccc 0110 0x00 xxxx xxxx xxxx xxx1 xxxx */
 	DECODE_REJECT	(0x0fb00010, 0x06000010),
@@ -1376,7 +1399,8 @@ static const union decode_item arm_cccc_0110_____xxx1_table[] = {
 	/* UXTB16		cccc 0110 1100 1111 xxxx xxxx 0111 xxxx */
 	/* UXTB			cccc 0110 1110 1111 xxxx xxxx 0111 xxxx */
 	/* UXTH			cccc 0110 1111 1111 xxxx xxxx 0111 xxxx */
-	DECODE_CUSTOM	(0x0f8f00f0, 0x068f0070, prep_emulate_rd12rm0),
+	DECODE_EMULATEX	(0x0f8f00f0, 0x068f0070, emulate_rd12rm0_noflags_nopc,
+						 REGS(0, NOPC, 0, 0, NOPC)),
 
 	/* SXTAB16		cccc 0110 1000 xxxx xxxx xxxx 0111 xxxx */
 	/* SXTAB		cccc 0110 1010 xxxx xxxx xxxx 0111 xxxx */
@@ -1424,13 +1448,16 @@ static const union decode_item arm_cccc_0111_____xxx1_table[] = {
 
 	/* SBFX			cccc 0111 101x xxxx xxxx xxxx x101 xxxx */
 	/* UBFX			cccc 0111 111x xxxx xxxx xxxx x101 xxxx */
-	DECODE_CUSTOM	(0x0fa00070, 0x07a00050, prep_emulate_rd12rm0),
+	DECODE_EMULATEX	(0x0fa00070, 0x07a00050, emulate_rd12rm0_noflags_nopc,
+						 REGS(0, NOPC, 0, 0, NOPC)),
 
 	/* BFC			cccc 0111 110x xxxx xxxx xxxx x001 1111 */
-	DECODE_CUSTOM	(0x0fe0007f, 0x07c0001f, prep_emulate_rd12_modify),
+	DECODE_EMULATEX	(0x0fe0007f, 0x07c0001f, emulate_rd12rm0_noflags_nopc,
+						 REGS(0, NOPC, 0, 0, 0)),
 
 	/* BFI			cccc 0111 110x xxxx xxxx xxxx x001 xxxx */
-	DECODE_CUSTOM	(0x0fe00070, 0x07c00010, prep_emulate_rd12rn0_modify),
+	DECODE_EMULATEX	(0x0fe00070, 0x07c00010, emulate_rd12rm0_noflags_nopc,
+						 REGS(0, NOPC, 0, 0, NOPCX)),
 
 	DECODE_END
 };
-- 
1.7.2.5
