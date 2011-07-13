From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:08 +0100
Subject: [PATCH 19/24] ARM: kprobes: Add
	emulate_rdlo12rdhi16rn0rm8_rwflags_nopc()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-20-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This is the emulation function for the instruction format used by the
ARM multiply long instructions. It replaces use of
prep_emulate_rdhi16rdlo12rs8rm0_wflags().

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 688101f..bb38ae3 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1033,6 +1033,36 @@ emulate_rd12rm0_noflags_nopc(struct kprobe *p, struct pt_regs *regs)
 	regs->uregs[rd] = rdv;
 }
 
+static void __kprobes
+emulate_rdlo12rdhi16rn0rm8_rwflags_nopc(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rdlo = (insn >> 12) & 0xf;
+	int rdhi = (insn >> 16) & 0xf;
+	int rn = insn & 0xf;
+	int rm = (insn >> 8) & 0xf;
+
+	register unsigned long rdlov asm("r0") = regs->uregs[rdlo];
+	register unsigned long rdhiv asm("r2") = regs->uregs[rdhi];
+	register unsigned long rnv asm("r3") = regs->uregs[rn];
+	register unsigned long rmv asm("r1") = regs->uregs[rm];
+	unsigned long cpsr = regs->ARM_cpsr;
+
+	__asm__ __volatile__ (
+		"msr	cpsr_fs, %[cpsr]	\n\t"
+		BLX("%[fn]")
+		"mrs	%[cpsr], cpsr		\n\t"
+		: "=r" (rdlov), "=r" (rdhiv), [cpsr] "=r" (cpsr)
+		: "0" (rdlov), "1" (rdhiv), "r" (rnv), "r" (rmv),
+		  "2" (cpsr), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rdlo] = rdlov;
+	regs->uregs[rdhi] = rdhiv;
+	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
+}
+
 /*
  * For the instruction masking and comparisons in all the "space_*"
  * functions below, Do _not_ rearrange the order of tests unless
@@ -1111,7 +1141,8 @@ static const union decode_item arm_cccc_0001_0xx0____1xx0_table[] = {
 	/* Halfword multiply and multiply-accumulate			*/
 
 	/* SMLALxy		cccc 0001 0100 xxxx xxxx xxxx 1xx0 xxxx */
-	DECODE_CUSTOM	(0x0ff00090, 0x01400080, prep_emulate_rdhi16rdlo12rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0ff00090, 0x01400080, emulate_rdlo12rdhi16rn0rm8_rwflags_nopc,
+						 REGS(NOPC, NOPC, NOPC, 0, NOPC)),
 
 	/* SMULWy		cccc 0001 0010 xxxx xxxx xxxx 1x10 xxxx */
 	DECODE_OR	(0x0ff000b0, 0x012000a0),
@@ -1153,7 +1184,8 @@ static const union decode_item arm_cccc_0000_____1001_table[] = {
 	/* SMULLS		cccc 0000 1101 xxxx xxxx xxxx 1001 xxxx */
 	/* SMLAL		cccc 0000 1110 xxxx xxxx xxxx 1001 xxxx */
 	/* SMLALS		cccc 0000 1111 xxxx xxxx xxxx 1001 xxxx */
-	DECODE_CUSTOM	(0x0f8000f0, 0x00800090, prep_emulate_rdhi16rdlo12rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0f8000f0, 0x00800090, emulate_rdlo12rdhi16rn0rm8_rwflags_nopc,
+						 REGS(NOPC, NOPC, NOPC, 0, NOPC)),
 
 	DECODE_END
 };
@@ -1422,7 +1454,8 @@ static const union decode_item arm_cccc_0111_____xxx1_table[] = {
 
 	/* SMLALD		cccc 0111 0100 xxxx xxxx xxxx 00x1 xxxx */
 	/* SMLSLD		cccc 0111 0100 xxxx xxxx xxxx 01x1 xxxx */
-	DECODE_CUSTOM	(0x0ff00090, 0x07400010, prep_emulate_rdhi16rdlo12rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0ff00090, 0x07400010, emulate_rdlo12rdhi16rn0rm8_rwflags_nopc,
+						 REGS(NOPC, NOPC, NOPC, 0, NOPC)),
 
 	/* SMUAD		cccc 0111 0000 xxxx 1111 xxxx 00x1 xxxx */
 	/* SMUSD		cccc 0111 0000 xxxx 1111 xxxx 01x1 xxxx */
-- 
1.7.2.5
