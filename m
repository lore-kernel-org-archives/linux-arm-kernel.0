From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:06:05 +0100
Subject: [PATCH 16/24] ARM: kprobes: Add emulate_rd16rn12rm0rs8_rwflags_nopc()
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-17-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This is the emulation function for the instruction format used by the
ARM multiply-accumulate instructions. These don't allow use of PC so we
don't have to add special cases for this.

This function is used to replace use of prep_emulate_rd16rs8rm0_wflags
and prep_emulate_rd16rn12rs8rm0_wflags.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   50 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index f271212..d3b0506 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -984,6 +984,35 @@ emulate_rd12rn16rm0_rwflags_nopc(struct kprobe *p, struct pt_regs *regs)
 	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
 }
 
+static void __kprobes
+emulate_rd16rn12rm0rs8_rwflags_nopc(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rd = (insn >> 16) & 0xf;
+	int rn = (insn >> 12) & 0xf;
+	int rm = insn & 0xf;
+	int rs = (insn >> 8) & 0xf;
+
+	register unsigned long rdv asm("r2") = regs->uregs[rd];
+	register unsigned long rnv asm("r0") = regs->uregs[rn];
+	register unsigned long rmv asm("r3") = regs->uregs[rm];
+	register unsigned long rsv asm("r1") = regs->uregs[rs];
+	unsigned long cpsr = regs->ARM_cpsr;
+
+	__asm__ __volatile__ (
+		"msr	cpsr_fs, %[cpsr]	\n\t"
+		BLX("%[fn]")
+		"mrs	%[cpsr], cpsr		\n\t"
+		: "=r" (rdv), [cpsr] "=r" (cpsr)
+		: "0" (rdv), "r" (rnv), "r" (rmv), "r" (rsv),
+		  "1" (cpsr), [fn] "r" (p->ainsn.insn_fn)
+		: "lr", "memory", "cc"
+	);
+
+	regs->uregs[rd] = rdv;
+	regs->ARM_cpsr = (regs->ARM_cpsr & ~APSR_MASK) | (cpsr & APSR_MASK);
+}
+
 /*
  * For the instruction masking and comparisons in all the "space_*"
  * functions below, Do _not_ rearrange the order of tests unless
@@ -1065,12 +1094,14 @@ static const union decode_item arm_cccc_0001_0xx0____1xx0_table[] = {
 	/* SMULWy		cccc 0001 0010 xxxx xxxx xxxx 1x10 xxxx */
 	DECODE_OR	(0x0ff000b0, 0x012000a0),
 	/* SMULxy		cccc 0001 0110 xxxx xxxx xxxx 1xx0 xxxx */
-	DECODE_CUSTOM	(0x0ff00090, 0x01600080, prep_emulate_rd16rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0ff00090, 0x01600080, emulate_rd16rn12rm0rs8_rwflags_nopc,
+						 REGS(NOPC, 0, NOPC, 0, NOPC)),
 
 	/* SMLAxy		cccc 0001 0000 xxxx xxxx xxxx 1xx0 xxxx */
 	DECODE_OR	(0x0ff00090, 0x01000080),
 	/* SMLAWy		cccc 0001 0010 xxxx xxxx xxxx 1x00 xxxx */
-	DECODE_CUSTOM	(0x0ff000b0, 0x01200080, prep_emulate_rd16rn12rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0ff000b0, 0x01200080, emulate_rd16rn12rm0rs8_rwflags_nopc,
+						 REGS(NOPC, NOPC, NOPC, 0, NOPC)),
 
 	DECODE_END
 };
@@ -1080,13 +1111,15 @@ static const union decode_item arm_cccc_0000_____1001_table[] = {
 
 	/* MUL			cccc 0000 0000 xxxx xxxx xxxx 1001 xxxx */
 	/* MULS			cccc 0000 0001 xxxx xxxx xxxx 1001 xxxx */
-	DECODE_CUSTOM	(0x0fe000f0, 0x00000090, prep_emulate_rd16rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0fe000f0, 0x00000090, emulate_rd16rn12rm0rs8_rwflags_nopc,
+						 REGS(NOPC, 0, NOPC, 0, NOPC)),
 
 	/* MLA			cccc 0000 0010 xxxx xxxx xxxx 1001 xxxx */
 	/* MLAS			cccc 0000 0011 xxxx xxxx xxxx 1001 xxxx */
 	DECODE_OR	(0x0fe000f0, 0x00200090),
 	/* MLS			cccc 0000 0110 xxxx xxxx xxxx 1001 xxxx */
-	DECODE_CUSTOM	(0x0ff000f0, 0x00600090, prep_emulate_rd16rn12rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0ff000f0, 0x00600090, emulate_rd16rn12rm0rs8_rwflags_nopc,
+						 REGS(NOPC, NOPC, NOPC, 0, NOPC)),
 
 	/* UMAAL		cccc 0000 0100 xxxx xxxx xxxx 1001 xxxx */
 	DECODE_OR	(0x0ff000f0, 0x00400090),
@@ -1368,7 +1401,8 @@ static const union decode_item arm_cccc_0111_____xxx1_table[] = {
 	/* SMMUL		cccc 0111 0101 xxxx 1111 xxxx 00x1 xxxx */
 	DECODE_OR	(0x0ff0f0d0, 0x0750f010),
 	/* USAD8		cccc 0111 1000 xxxx 1111 xxxx 0001 xxxx */
-	DECODE_CUSTOM	(0x0ff0f0f0, 0x0780f010, prep_emulate_rd16rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0ff0f0f0, 0x0780f010, emulate_rd16rn12rm0rs8_rwflags_nopc,
+						 REGS(NOPC, 0, NOPC, 0, NOPC)),
 
 	/* SMLAD		cccc 0111 0000 xxxx xxxx xxxx 00x1 xxxx */
 	/* SMLSD		cccc 0111 0000 xxxx xxxx xxxx 01x1 xxxx */
@@ -1376,10 +1410,12 @@ static const union decode_item arm_cccc_0111_____xxx1_table[] = {
 	/* SMMLA		cccc 0111 0101 xxxx xxxx xxxx 00x1 xxxx */
 	DECODE_OR	(0x0ff000d0, 0x07500010),
 	/* USADA8		cccc 0111 1000 xxxx xxxx xxxx 0001 xxxx */
-	DECODE_CUSTOM	(0x0ff000f0, 0x07800010, prep_emulate_rd16rn12rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0ff000f0, 0x07800010, emulate_rd16rn12rm0rs8_rwflags_nopc,
+						 REGS(NOPC, NOPCX, NOPC, 0, NOPC)),
 
 	/* SMMLS		cccc 0111 0101 xxxx xxxx xxxx 11x1 xxxx */
-	DECODE_CUSTOM	(0x0ff000d0, 0x075000d0, prep_emulate_rd16rn12rs8rm0_wflags),
+	DECODE_EMULATEX	(0x0ff000d0, 0x075000d0, emulate_rd16rn12rm0rs8_rwflags_nopc,
+						 REGS(NOPC, NOPC, NOPC, 0, NOPC)),
 
 	/* SBFX			cccc 0111 101x xxxx xxxx xxxx x101 xxxx */
 	/* UBFX			cccc 0111 111x xxxx xxxx xxxx x101 xxxx */
-- 
1.7.2.5
