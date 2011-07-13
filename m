From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:54 +0100
Subject: [PATCH 05/24] ARM: kprobes: Migrate ARM data-processing (register)
	instructions to decoding tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-6-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |  111 +++++++++++++++++++++++------------------
 1 files changed, 63 insertions(+), 48 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 6e38bd4..8e4b718 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -968,6 +968,68 @@ static const union decode_item arm_1111_table[] = {
 	DECODE_END
 };
 
+static const union decode_item arm_cccc_000x_table[] = {
+	/* Data-processing (register)					*/
+
+	/* <op>S PC, ...	cccc 000x xxx1 xxxx 1111 xxxx xxxx xxxx */
+	DECODE_REJECT	(0x0e10f000, 0x0010f000),
+
+	/* MOV IP, SP		1110 0001 1010 0000 1100 0000 0000 1101 */
+	DECODE_SIMULATE	(0xffffffff, 0xe1a0c00d, simulate_mov_ipsp),
+
+	/* TST (register)	cccc 0001 0001 xxxx xxxx xxxx xxx0 xxxx */
+	/* TEQ (register)	cccc 0001 0011 xxxx xxxx xxxx xxx0 xxxx */
+	/* CMP (register)	cccc 0001 0101 xxxx xxxx xxxx xxx0 xxxx */
+	/* CMN (register)	cccc 0001 0111 xxxx xxxx xxxx xxx0 xxxx */
+	DECODE_EMULATEX	(0x0f900010, 0x01100000, emulate_rd12rn16rm0rs8_rwflags,
+						 REGS(ANY, 0, 0, 0, ANY)),
+
+	/* MOV (register)	cccc 0001 101x xxxx xxxx xxxx xxx0 xxxx */
+	/* MVN (register)	cccc 0001 111x xxxx xxxx xxxx xxx0 xxxx */
+	DECODE_EMULATEX	(0x0fa00010, 0x01a00000, emulate_rd12rn16rm0rs8_rwflags,
+						 REGS(0, ANY, 0, 0, ANY)),
+
+	/* AND (register)	cccc 0000 000x xxxx xxxx xxxx xxx0 xxxx */
+	/* EOR (register)	cccc 0000 001x xxxx xxxx xxxx xxx0 xxxx */
+	/* SUB (register)	cccc 0000 010x xxxx xxxx xxxx xxx0 xxxx */
+	/* RSB (register)	cccc 0000 011x xxxx xxxx xxxx xxx0 xxxx */
+	/* ADD (register)	cccc 0000 100x xxxx xxxx xxxx xxx0 xxxx */
+	/* ADC (register)	cccc 0000 101x xxxx xxxx xxxx xxx0 xxxx */
+	/* SBC (register)	cccc 0000 110x xxxx xxxx xxxx xxx0 xxxx */
+	/* RSC (register)	cccc 0000 111x xxxx xxxx xxxx xxx0 xxxx */
+	/* ORR (register)	cccc 0001 100x xxxx xxxx xxxx xxx0 xxxx */
+	/* BIC (register)	cccc 0001 110x xxxx xxxx xxxx xxx0 xxxx */
+	DECODE_EMULATEX	(0x0e000010, 0x00000000, emulate_rd12rn16rm0rs8_rwflags,
+						 REGS(ANY, ANY, 0, 0, ANY)),
+
+	/* TST (reg-shift reg)	cccc 0001 0001 xxxx xxxx xxxx 0xx1 xxxx */
+	/* TEQ (reg-shift reg)	cccc 0001 0011 xxxx xxxx xxxx 0xx1 xxxx */
+	/* CMP (reg-shift reg)	cccc 0001 0101 xxxx xxxx xxxx 0xx1 xxxx */
+	/* CMN (reg-shift reg)	cccc 0001 0111 xxxx xxxx xxxx 0xx1 xxxx */
+	DECODE_EMULATEX	(0x0f900090, 0x01100010, emulate_rd12rn16rm0rs8_rwflags,
+						 REGS(ANY, 0, NOPC, 0, ANY)),
+
+	/* MOV (reg-shift reg)	cccc 0001 101x xxxx xxxx xxxx 0xx1 xxxx */
+	/* MVN (reg-shift reg)	cccc 0001 111x xxxx xxxx xxxx 0xx1 xxxx */
+	DECODE_EMULATEX	(0x0fa00090, 0x01a00010, emulate_rd12rn16rm0rs8_rwflags,
+						 REGS(0, ANY, NOPC, 0, ANY)),
+
+	/* AND (reg-shift reg)	cccc 0000 000x xxxx xxxx xxxx 0xx1 xxxx */
+	/* EOR (reg-shift reg)	cccc 0000 001x xxxx xxxx xxxx 0xx1 xxxx */
+	/* SUB (reg-shift reg)	cccc 0000 010x xxxx xxxx xxxx 0xx1 xxxx */
+	/* RSB (reg-shift reg)	cccc 0000 011x xxxx xxxx xxxx 0xx1 xxxx */
+	/* ADD (reg-shift reg)	cccc 0000 100x xxxx xxxx xxxx 0xx1 xxxx */
+	/* ADC (reg-shift reg)	cccc 0000 101x xxxx xxxx xxxx 0xx1 xxxx */
+	/* SBC (reg-shift reg)	cccc 0000 110x xxxx xxxx xxxx 0xx1 xxxx */
+	/* RSC (reg-shift reg)	cccc 0000 111x xxxx xxxx xxxx 0xx1 xxxx */
+	/* ORR (reg-shift reg)	cccc 0001 100x xxxx xxxx xxxx 0xx1 xxxx */
+	/* BIC (reg-shift reg)	cccc 0001 110x xxxx xxxx xxxx 0xx1 xxxx */
+	DECODE_EMULATEX	(0x0e000090, 0x00000010, emulate_rd12rn16rm0rs8_rwflags,
+						 REGS(ANY, ANY, NOPC, 0, ANY)),
+
+	DECODE_END
+};
+
 static enum kprobe_insn __kprobes
 space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
@@ -1126,54 +1188,7 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		return prep_emulate_ldr_str(insn, asi);
 	}
 
-	/* cccc 000x xxxx xxxx xxxx xxxx xxxx xxxx xxxx */
-
-	/*
-	 * ALU op with S bit and Rd == 15 :
-	 *	cccc 000x xxx1 xxxx 1111 xxxx xxxx xxxx
-	 */
-	if ((insn & 0x0e10f000) == 0x0010f000)
-		return INSN_REJECTED;
-
-	/*
-	 * "mov ip, sp" is the most common kprobe'd instruction by far.
-	 * Check and optimize for it explicitly.
-	 */
-	if (insn == 0xe1a0c00d) {
-		asi->insn_handler = simulate_mov_ipsp;
-		return INSN_GOOD_NO_SLOT;
-	}
-
-	/*
-	 * Data processing: Immediate-shift / Register-shift
-	 * ALU op : cccc 000x xxxx xxxx xxxx xxxx xxxx xxxx
-	 * CPY    : cccc 0001 1010 xxxx xxxx 0000 0000 xxxx
-	 * MOV    : cccc 0001 101x xxxx xxxx xxxx xxxx xxxx
-	 * *S (bit 20) updates condition codes
-	 * ADC/SBC/RSC reads the C flag
-	 */
-	insn &= 0xfff00ff0;	/* Rn = r0, Rd = r0 */
-	insn |= 0x00000001;	/* Rm = r1 */
-	if (insn & 0x010) {
-		insn &= 0xfffff0ff;     /* register shift */
-		insn |= 0x00000200;     /* Rs = r2 */
-	}
-	asi->insn[0] = insn;
-
-	if ((insn & 0x0f900000) == 0x01100000) {
-		/*
-		 * TST : cccc 0001 0001 xxxx xxxx xxxx xxxx xxxx
-		 * TEQ : cccc 0001 0011 xxxx xxxx xxxx xxxx xxxx
-		 * CMP : cccc 0001 0101 xxxx xxxx xxxx xxxx xxxx
-		 * CMN : cccc 0001 0111 xxxx xxxx xxxx xxxx xxxx
-		 */
-		asi->insn_handler = emulate_alu_tests;
-	} else {
-		/* ALU ops which write to Rd */
-		asi->insn_handler = (insn & (1 << 20)) ?  /* S-bit */
-				emulate_alu_rwflags : emulate_alu_rflags;
-	}
-	return INSN_GOOD;
+	return kprobe_decode_insn(insn, asi, arm_cccc_000x_table, false);
 }
 
 static enum kprobe_insn __kprobes
-- 
1.7.2.5
