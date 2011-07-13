From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:58 +0100
Subject: [PATCH 09/24] ARM: kprobes: Migrate ARM space_cccc_001x to decoding
	tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-10-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |  116 ++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 66 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index ef350a5..f2eed03 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -1203,72 +1203,56 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	return kprobe_decode_insn(insn, asi, arm_cccc_000x_table, false);
 }
 
-static enum kprobe_insn __kprobes
-space_cccc_001x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	/* MOVW  : cccc 0011 0000 xxxx xxxx xxxx xxxx xxxx */
-	/* MOVT  : cccc 0011 0100 xxxx xxxx xxxx xxxx xxxx */
-	if ((insn & 0x0fb00000) == 0x03000000)
-		return prep_emulate_rd12_modify(insn, asi);
-
-	/* hints : cccc 0011 0010 0000 xxxx xxxx xxxx xxxx */
-	if ((insn & 0x0fff0000) == 0x03200000) {
-		unsigned op2 = insn & 0x000000ff;
-		if (op2 == 0x01 || op2 == 0x04) {
-			/* YIELD : cccc 0011 0010 0000 xxxx xxxx 0000 0001 */
-			/* SEV   : cccc 0011 0010 0000 xxxx xxxx 0000 0100 */
-			asi->insn[0] = insn;
-			asi->insn_handler = emulate_none;
-			return INSN_GOOD;
-		} else if (op2 <= 0x03) {
-			/* NOP   : cccc 0011 0010 0000 xxxx xxxx 0000 0000 */
-			/* WFE   : cccc 0011 0010 0000 xxxx xxxx 0000 0010 */
-			/* WFI   : cccc 0011 0010 0000 xxxx xxxx 0000 0011 */
-			/*
-			 * We make WFE and WFI true NOPs to avoid stalls due
-			 * to missing events whilst processing the probe.
-			 */
-			asi->insn_handler = emulate_nop;
-			return INSN_GOOD_NO_SLOT;
-		}
-		/* For DBG and unallocated hints it's safest to reject them */
-		return INSN_REJECTED;
-	}
+static const union decode_item arm_cccc_001x_table[] = {
+	/* Data-processing (immediate)					*/
+
+	/* MOVW			cccc 0011 0000 xxxx xxxx xxxx xxxx xxxx */
+	/* MOVT			cccc 0011 0100 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_CUSTOM	(0x0fb00000, 0x03000000, prep_emulate_rd12_modify),
+
+	/* YIELD		cccc 0011 0010 0000 xxxx xxxx 0000 0001 */
+	DECODE_OR	(0x0fff00ff, 0x03200001),
+	/* SEV			cccc 0011 0010 0000 xxxx xxxx 0000 0100 */
+	DECODE_EMULATE	(0x0fff00ff, 0x03200004, kprobe_emulate_none),
+	/* NOP			cccc 0011 0010 0000 xxxx xxxx 0000 0000 */
+	/* WFE			cccc 0011 0010 0000 xxxx xxxx 0000 0010 */
+	/* WFI			cccc 0011 0010 0000 xxxx xxxx 0000 0011 */
+	DECODE_SIMULATE	(0x0fff00fc, 0x03200000, kprobe_simulate_nop),
+	/* DBG			cccc 0011 0010 0000 xxxx xxxx ffff xxxx */
+	/* unallocated hints	cccc 0011 0010 0000 xxxx xxxx xxxx xxxx */
+	/* MSR (immediate)	cccc 0011 0x10 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_REJECT	(0x0fb00000, 0x03200000),
+
+	/* <op>S PC, ...	cccc 001x xxx1 xxxx 1111 xxxx xxxx xxxx */
+	DECODE_REJECT	(0x0e10f000, 0x0210f000),
+
+	/* TST (immediate)	cccc 0011 0001 xxxx xxxx xxxx xxxx xxxx */
+	/* TEQ (immediate)	cccc 0011 0011 xxxx xxxx xxxx xxxx xxxx */
+	/* CMP (immediate)	cccc 0011 0101 xxxx xxxx xxxx xxxx xxxx */
+	/* CMN (immediate)	cccc 0011 0111 xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0x0f900000, 0x03100000, emulate_rd12rn16rm0rs8_rwflags,
+						 REGS(ANY, 0, 0, 0, 0)),
+
+	/* MOV (immediate)	cccc 0011 101x xxxx xxxx xxxx xxxx xxxx */
+	/* MVN (immediate)	cccc 0011 111x xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0x0fa00000, 0x03a00000, emulate_rd12rn16rm0rs8_rwflags,
+						 REGS(0, ANY, 0, 0, 0)),
+
+	/* AND (immediate)	cccc 0010 000x xxxx xxxx xxxx xxxx xxxx */
+	/* EOR (immediate)	cccc 0010 001x xxxx xxxx xxxx xxxx xxxx */
+	/* SUB (immediate)	cccc 0010 010x xxxx xxxx xxxx xxxx xxxx */
+	/* RSB (immediate)	cccc 0010 011x xxxx xxxx xxxx xxxx xxxx */
+	/* ADD (immediate)	cccc 0010 100x xxxx xxxx xxxx xxxx xxxx */
+	/* ADC (immediate)	cccc 0010 101x xxxx xxxx xxxx xxxx xxxx */
+	/* SBC (immediate)	cccc 0010 110x xxxx xxxx xxxx xxxx xxxx */
+	/* RSC (immediate)	cccc 0010 111x xxxx xxxx xxxx xxxx xxxx */
+	/* ORR (immediate)	cccc 0011 100x xxxx xxxx xxxx xxxx xxxx */
+	/* BIC (immediate)	cccc 0011 110x xxxx xxxx xxxx xxxx xxxx */
+	DECODE_EMULATEX	(0x0e000000, 0x02000000, emulate_rd12rn16rm0rs8_rwflags,
+						 REGS(ANY, ANY, 0, 0, 0)),
 
-	/*
-	 * MSR   : cccc 0011 0x10 xxxx xxxx xxxx xxxx xxxx
-	 * ALU op with S bit and Rd == 15 :
-	 *	   cccc 001x xxx1 xxxx 1111 xxxx xxxx xxxx
-	 */
-	if ((insn & 0x0fb00000) == 0x03200000 ||	/* MSR */
-	    (insn & 0x0e10f000) == 0x0210f000)		/* ALU s-bit, R15  */
-		return INSN_REJECTED;
-
-	/*
-	 * Data processing: 32-bit Immediate
-	 * ALU op : cccc 001x xxxx xxxx xxxx xxxx xxxx xxxx
-	 * MOV    : cccc 0011 101x xxxx xxxx xxxx xxxx xxxx
-	 * *S (bit 20) updates condition codes
-	 * ADC/SBC/RSC reads the C flag
-	 */
-	insn &= 0xfff00fff;	/* Rn = r0 and Rd = r0 */
-	asi->insn[0] = insn;
-
-	if ((insn & 0x0f900000) == 0x03100000) {
-		/*
-		 * TST : cccc 0011 0001 xxxx xxxx xxxx xxxx xxxx
-		 * TEQ : cccc 0011 0011 xxxx xxxx xxxx xxxx xxxx
-		 * CMP : cccc 0011 0101 xxxx xxxx xxxx xxxx xxxx
-		 * CMN : cccc 0011 0111 xxxx xxxx xxxx xxxx xxxx
-		 */
-		asi->insn_handler = emulate_alu_tests_imm;
-	} else {
-		/* ALU ops which write to Rd */
-		asi->insn_handler = (insn & (1 << 20)) ?  /* S-bit */
-			emulate_alu_imm_rwflags : emulate_alu_imm_rflags;
-	}
-	return INSN_GOOD;
-}
+	DECODE_END
+};
 
 static enum kprobe_insn __kprobes
 space_cccc_0110__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
@@ -1548,7 +1532,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	else if ((insn & 0x0e000000) == 0x02000000)
 
-		return space_cccc_001x(insn, asi);
+		return kprobe_decode_insn(insn, asi, arm_cccc_001x_table, false);
 
 	else if ((insn & 0x0f000010) == 0x06000010)
 
-- 
1.7.2.5
