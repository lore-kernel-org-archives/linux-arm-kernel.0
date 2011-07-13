From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:57 +0100
Subject: [PATCH 08/24] ARM: kprobes: Migrate ARM space_cccc_000x to decoding
	tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-9-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |  254 +++++++++++++++++++----------------------
 1 files changed, 117 insertions(+), 137 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index e590ff6..ef350a5 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -997,7 +997,99 @@ static const union decode_item arm_1111_table[] = {
 	DECODE_END
 };
 
+static const union decode_item arm_cccc_0001_0xx0____0xxx_table[] = {
+	/* Miscellaneous instructions					*/
+
+	/* MRS cpsr		cccc 0001 0000 xxxx xxxx xxxx 0000 xxxx */
+	DECODE_SIMULATEX(0x0ff000f0, 0x01000000, simulate_mrs,
+						 REGS(0, NOPC, 0, 0, 0)),
+
+	/* BX			cccc 0001 0010 xxxx xxxx xxxx 0001 xxxx */
+	DECODE_SIMULATE	(0x0ff000f0, 0x01200010, simulate_blx2bx),
+
+	/* BLX (register)	cccc 0001 0010 xxxx xxxx xxxx 0011 xxxx */
+	DECODE_SIMULATEX(0x0ff000f0, 0x01200030, simulate_blx2bx,
+						 REGS(0, 0, 0, 0, NOPC)),
+
+	/* CLZ			cccc 0001 0110 xxxx xxxx xxxx 0001 xxxx */
+	DECODE_CUSTOM	(0x0ff000f0, 0x01600010, prep_emulate_rd12rm0),
+
+	/* QADD			cccc 0001 0000 xxxx xxxx xxxx 0101 xxxx */
+	/* QSUB			cccc 0001 0010 xxxx xxxx xxxx 0101 xxxx */
+	/* QDADD		cccc 0001 0100 xxxx xxxx xxxx 0101 xxxx */
+	/* QDSUB		cccc 0001 0110 xxxx xxxx xxxx 0101 xxxx */
+	DECODE_CUSTOM	(0x0f9000f0, 0x01000050, prep_emulate_rd12rn16rm0_wflags),
+
+	/* BXJ			cccc 0001 0010 xxxx xxxx xxxx 0010 xxxx */
+	/* MSR			cccc 0001 0x10 xxxx xxxx xxxx 0000 xxxx */
+	/* MRS spsr		cccc 0001 0100 xxxx xxxx xxxx 0000 xxxx */
+	/* BKPT			1110 0001 0010 xxxx xxxx xxxx 0111 xxxx */
+	/* SMC			cccc 0001 0110 xxxx xxxx xxxx 0111 xxxx */
+	/* And unallocated instructions...				*/
+	DECODE_END
+};
+
+static const union decode_item arm_cccc_0001_0xx0____1xx0_table[] = {
+	/* Halfword multiply and multiply-accumulate			*/
+
+	/* SMLALxy		cccc 0001 0100 xxxx xxxx xxxx 1xx0 xxxx */
+	DECODE_CUSTOM	(0x0ff00090, 0x01400080, prep_emulate_rdhi16rdlo12rs8rm0_wflags),
+
+	/* SMULWy		cccc 0001 0010 xxxx xxxx xxxx 1x10 xxxx */
+	DECODE_OR	(0x0ff000b0, 0x012000a0),
+	/* SMULxy		cccc 0001 0110 xxxx xxxx xxxx 1xx0 xxxx */
+	DECODE_CUSTOM	(0x0ff00090, 0x01600080, prep_emulate_rd16rs8rm0_wflags),
+
+	/* SMLAxy		cccc 0001 0000 xxxx xxxx xxxx 1xx0 xxxx */
+	DECODE_OR	(0x0ff00090, 0x01000080),
+	/* SMLAWy		cccc 0001 0010 xxxx xxxx xxxx 1x00 xxxx */
+	DECODE_CUSTOM	(0x0ff000b0, 0x01200080, prep_emulate_rd16rn12rs8rm0_wflags),
+
+	DECODE_END
+};
+
+static const union decode_item arm_cccc_0000_____1001_table[] = {
+	/* Multiply and multiply-accumulate				*/
+
+	/* MUL			cccc 0000 0000 xxxx xxxx xxxx 1001 xxxx */
+	/* MULS			cccc 0000 0001 xxxx xxxx xxxx 1001 xxxx */
+	DECODE_CUSTOM	(0x0fe000f0, 0x00000090, prep_emulate_rd16rs8rm0_wflags),
+
+	/* MLA			cccc 0000 0010 xxxx xxxx xxxx 1001 xxxx */
+	/* MLAS			cccc 0000 0011 xxxx xxxx xxxx 1001 xxxx */
+	DECODE_OR	(0x0fe000f0, 0x00200090),
+	/* MLS			cccc 0000 0110 xxxx xxxx xxxx 1001 xxxx */
+	DECODE_CUSTOM	(0x0ff000f0, 0x00600090, prep_emulate_rd16rn12rs8rm0_wflags),
+
+	/* UMAAL		cccc 0000 0100 xxxx xxxx xxxx 1001 xxxx */
+	DECODE_OR	(0x0ff000f0, 0x00400090),
+	/* UMULL		cccc 0000 1000 xxxx xxxx xxxx 1001 xxxx */
+	/* UMULLS		cccc 0000 1001 xxxx xxxx xxxx 1001 xxxx */
+	/* UMLAL		cccc 0000 1010 xxxx xxxx xxxx 1001 xxxx */
+	/* UMLALS		cccc 0000 1011 xxxx xxxx xxxx 1001 xxxx */
+	/* SMULL		cccc 0000 1100 xxxx xxxx xxxx 1001 xxxx */
+	/* SMULLS		cccc 0000 1101 xxxx xxxx xxxx 1001 xxxx */
+	/* SMLAL		cccc 0000 1110 xxxx xxxx xxxx 1001 xxxx */
+	/* SMLALS		cccc 0000 1111 xxxx xxxx xxxx 1001 xxxx */
+	DECODE_CUSTOM	(0x0f8000f0, 0x00800090, prep_emulate_rdhi16rdlo12rs8rm0_wflags),
+
+	DECODE_END
+};
+
+static const union decode_item arm_cccc_0001_____1001_table[] = {
+	/* Synchronization primitives					*/
+
+	/* SMP/SWPB		cccc 0001 0x00 xxxx xxxx xxxx 1001 xxxx */
+	DECODE_CUSTOM	(0x0fb000f0, 0x01000090, prep_emulate_rd12rn16rm0_wflags),
+
+	/* LDREX/STREX{,D,B,H}	cccc 0001 1xxx xxxx xxxx xxxx 1001 xxxx */
+	/* And unallocated instructions...				*/
+	DECODE_END
+};
+
 static const union decode_item arm_cccc_000x_____1xx1_table[] = {
+	/* Extra load/store instructions				*/
+
 	/* LDRD/STRD lr,pc,{...	cccc 000x x0x0 xxxx 111x xxxx 1101 xxxx */
 	DECODE_REJECT	(0x0e10e0d0, 0x0000e0d0),
 
@@ -1011,6 +1103,20 @@ static const union decode_item arm_cccc_000x_____1xx1_table[] = {
 	DECODE_EMULATEX	(0x0e5000d0, 0x004000d0, emulate_ldrdstrd,
 						 REGS(NOPCWB, NOPCX, 0, 0, 0)),
 
+	/* Reject Rd is PC */
+	/* TODO: fold this into next entry when it is made a DECODE_EMULATE */
+	DECODE_REJECT	(0x0000f000, 0x0000f000),
+
+	/* STRH (register)	cccc 000x x0x0 xxxx xxxx xxxx 1011 xxxx */
+	/* LDRH (register)	cccc 000x x0x1 xxxx xxxx xxxx 1011 xxxx */
+	/* LDRSB (register)	cccc 000x x0x1 xxxx xxxx xxxx 1101 xxxx */
+	/* LDRSH (register)	cccc 000x x0x1 xxxx xxxx xxxx 1111 xxxx */
+	/* STRH (immediate)	cccc 000x x1x0 xxxx xxxx xxxx 1011 xxxx */
+	/* LDRH (immediate)	cccc 000x x1x1 xxxx xxxx xxxx 1011 xxxx */
+	/* LDRSB (immediate)	cccc 000x x1x1 xxxx xxxx xxxx 1101 xxxx */
+	/* LDRSH (immediate)	cccc 000x x1x1 xxxx xxxx xxxx 1111 xxxx */
+	DECODE_CUSTOM	(0x0e000090, 0x00000090, prep_emulate_ldr_str),
+
 	DECODE_END
 };
 
@@ -1079,146 +1185,20 @@ static const union decode_item arm_cccc_000x_table[] = {
 static enum kprobe_insn __kprobes
 space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
-	/* cccc 0001 0xx0 xxxx xxxx xxxx xxxx xxx0 xxxx */
-	if ((insn & 0x0f900010) == 0x01000000) {
-
-		/* MRS cpsr : cccc 0001 0000 xxxx xxxx xxxx 0000 xxxx */
-		if ((insn & 0x0ff000f0) == 0x01000000) {
-			if (is_r15(insn, 12))
-				return INSN_REJECTED;	/* Rd is PC */
-			asi->insn_handler = simulate_mrs;
-			return INSN_GOOD_NO_SLOT;
-		}
-
-		/* SMLALxy : cccc 0001 0100 xxxx xxxx xxxx 1xx0 xxxx */
-		if ((insn & 0x0ff00090) == 0x01400080)
-			return prep_emulate_rdhi16rdlo12rs8rm0_wflags(insn,
-									asi);
-
-		/* SMULWy : cccc 0001 0010 xxxx xxxx xxxx 1x10 xxxx */
-		/* SMULxy : cccc 0001 0110 xxxx xxxx xxxx 1xx0 xxxx */
-		if ((insn & 0x0ff000b0) == 0x012000a0 ||
-		    (insn & 0x0ff00090) == 0x01600080)
-			return prep_emulate_rd16rs8rm0_wflags(insn, asi);
-
-		/* SMLAxy : cccc 0001 0000 xxxx xxxx xxxx 1xx0 xxxx : Q */
-		/* SMLAWy : cccc 0001 0010 xxxx xxxx xxxx 1x00 xxxx : Q */
-		if ((insn & 0x0ff00090) == 0x01000080 ||
-		    (insn & 0x0ff000b0) == 0x01200080)
-			return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
-
-		/* BXJ      : cccc 0001 0010 xxxx xxxx xxxx 0010 xxxx */
-		/* MSR      : cccc 0001 0x10 xxxx xxxx xxxx 0000 xxxx */
-		/* MRS spsr : cccc 0001 0100 xxxx xxxx xxxx 0000 xxxx */
-
-		/* Other instruction encodings aren't yet defined */
-		return INSN_REJECTED;
-	}
-
-	/* cccc 0001 0xx0 xxxx xxxx xxxx xxxx 0xx1 xxxx */
-	else if ((insn & 0x0f900090) == 0x01000010) {
-
-		/* BLX(2) : cccc 0001 0010 xxxx xxxx xxxx 0011 xxxx */
-		/* BX     : cccc 0001 0010 xxxx xxxx xxxx 0001 xxxx */
-		if ((insn & 0x0ff000d0) == 0x01200010) {
-			if ((insn & 0x0ff000ff) == 0x0120003f)
-				return INSN_REJECTED; /* BLX pc */
-			asi->insn_handler = simulate_blx2bx;
-			return INSN_GOOD_NO_SLOT;
-		}
-
-		/* CLZ : cccc 0001 0110 xxxx xxxx xxxx 0001 xxxx */
-		if ((insn & 0x0ff000f0) == 0x01600010)
-			return prep_emulate_rd12rm0(insn, asi);
+	if ((insn & 0x0f900080) == 0x01000000)
+		return kprobe_decode_insn(insn, asi, arm_cccc_0001_0xx0____0xxx_table, false);
 
-		/* QADD    : cccc 0001 0000 xxxx xxxx xxxx 0101 xxxx :Q */
-		/* QSUB    : cccc 0001 0010 xxxx xxxx xxxx 0101 xxxx :Q */
-		/* QDADD   : cccc 0001 0100 xxxx xxxx xxxx 0101 xxxx :Q */
-		/* QDSUB   : cccc 0001 0110 xxxx xxxx xxxx 0101 xxxx :Q */
-		if ((insn & 0x0f9000f0) == 0x01000050)
-			return prep_emulate_rd12rn16rm0_wflags(insn, asi);
+	if ((insn & 0x0f900090) == 0x01000080)
+		return kprobe_decode_insn(insn, asi, arm_cccc_0001_0xx0____1xx0_table, false);
 
-		/* BKPT : 1110 0001 0010 xxxx xxxx xxxx 0111 xxxx */
-		/* SMC  : cccc 0001 0110 xxxx xxxx xxxx 0111 xxxx */
+	if ((insn & 0x0f0000f0) == 0x00000090)
+		return kprobe_decode_insn(insn, asi, arm_cccc_0000_____1001_table, false);
 
-		/* Other instruction encodings aren't yet defined */
-		return INSN_REJECTED;
-	}
+	if ((insn & 0x0f0000f0) == 0x01000090)
+		return kprobe_decode_insn(insn, asi, arm_cccc_0001_____1001_table, false);
 
-	/* cccc 0000 xxxx xxxx xxxx xxxx xxxx 1001 xxxx */
-	else if ((insn & 0x0f0000f0) == 0x00000090) {
-
-		/* MUL    : cccc 0000 0000 xxxx xxxx xxxx 1001 xxxx :   */
-		/* MULS   : cccc 0000 0001 xxxx xxxx xxxx 1001 xxxx :cc */
-		/* MLA    : cccc 0000 0010 xxxx xxxx xxxx 1001 xxxx :   */
-		/* MLAS   : cccc 0000 0011 xxxx xxxx xxxx 1001 xxxx :cc */
-		/* UMAAL  : cccc 0000 0100 xxxx xxxx xxxx 1001 xxxx :   */
-		/* undef  : cccc 0000 0101 xxxx xxxx xxxx 1001 xxxx :   */
-		/* MLS    : cccc 0000 0110 xxxx xxxx xxxx 1001 xxxx :   */
-		/* undef  : cccc 0000 0111 xxxx xxxx xxxx 1001 xxxx :   */
-		/* UMULL  : cccc 0000 1000 xxxx xxxx xxxx 1001 xxxx :   */
-		/* UMULLS : cccc 0000 1001 xxxx xxxx xxxx 1001 xxxx :cc */
-		/* UMLAL  : cccc 0000 1010 xxxx xxxx xxxx 1001 xxxx :   */
-		/* UMLALS : cccc 0000 1011 xxxx xxxx xxxx 1001 xxxx :cc */
-		/* SMULL  : cccc 0000 1100 xxxx xxxx xxxx 1001 xxxx :   */
-		/* SMULLS : cccc 0000 1101 xxxx xxxx xxxx 1001 xxxx :cc */
-		/* SMLAL  : cccc 0000 1110 xxxx xxxx xxxx 1001 xxxx :   */
-		/* SMLALS : cccc 0000 1111 xxxx xxxx xxxx 1001 xxxx :cc */
-		if ((insn & 0x00d00000) == 0x00500000)
-			return INSN_REJECTED;
-		else if ((insn & 0x00e00000) == 0x00000000)
-			return prep_emulate_rd16rs8rm0_wflags(insn, asi);
-		else if ((insn & 0x00a00000) == 0x00200000)
-			return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
-		else
-			return prep_emulate_rdhi16rdlo12rs8rm0_wflags(insn,
-									asi);
-	}
-
-	/* cccc 000x xxxx xxxx xxxx xxxx xxxx 1xx1 xxxx */
-	else if ((insn & 0x0e000090) == 0x00000090) {
-
-		/* SWP   : cccc 0001 0000 xxxx xxxx xxxx 1001 xxxx */
-		/* SWPB  : cccc 0001 0100 xxxx xxxx xxxx 1001 xxxx */
-		/* ???   : cccc 0001 0x01 xxxx xxxx xxxx 1001 xxxx */
-		/* ???   : cccc 0001 0x10 xxxx xxxx xxxx 1001 xxxx */
-		/* ???   : cccc 0001 0x11 xxxx xxxx xxxx 1001 xxxx */
-		/* STREX : cccc 0001 1000 xxxx xxxx xxxx 1001 xxxx */
-		/* LDREX : cccc 0001 1001 xxxx xxxx xxxx 1001 xxxx */
-		/* STREXD: cccc 0001 1010 xxxx xxxx xxxx 1001 xxxx */
-		/* LDREXD: cccc 0001 1011 xxxx xxxx xxxx 1001 xxxx */
-		/* STREXB: cccc 0001 1100 xxxx xxxx xxxx 1001 xxxx */
-		/* LDREXB: cccc 0001 1101 xxxx xxxx xxxx 1001 xxxx */
-		/* STREXH: cccc 0001 1110 xxxx xxxx xxxx 1001 xxxx */
-		/* LDREXH: cccc 0001 1111 xxxx xxxx xxxx 1001 xxxx */
-
-		/* LDRD  : cccc 000x xxx0 xxxx xxxx xxxx 1101 xxxx */
-		/* STRD  : cccc 000x xxx0 xxxx xxxx xxxx 1111 xxxx */
-		/* LDRH  : cccc 000x xxx1 xxxx xxxx xxxx 1011 xxxx */
-		/* STRH  : cccc 000x xxx0 xxxx xxxx xxxx 1011 xxxx */
-		/* LDRSB : cccc 000x xxx1 xxxx xxxx xxxx 1101 xxxx */
-		/* LDRSH : cccc 000x xxx1 xxxx xxxx xxxx 1111 xxxx */
-		if ((insn & 0x0f0000f0) == 0x01000090) {
-			if ((insn & 0x0fb000f0) == 0x01000090) {
-				/* SWP/SWPB */
-				return prep_emulate_rd12rn16rm0_wflags(insn,
-									asi);
-			} else {
-				/* STREX/LDREX variants and unallocaed space */
-				return INSN_REJECTED;
-			}
-
-		} else if ((insn & 0x0e1000d0) == 0x00000d0) {
-
-			return kprobe_decode_insn(insn, asi, arm_cccc_000x_____1xx1_table,
-									false);
-		}
-
-		/* LDRH/STRH/LDRSB/LDRSH */
-		if (is_r15(insn, 12))
-			return INSN_REJECTED;	/* Rd is PC */
-		return prep_emulate_ldr_str(insn, asi);
-	}
+	if ((insn & 0x0e000090) == 0x00000090)
+		return kprobe_decode_insn(insn, asi, arm_cccc_000x_____1xx1_table, false);
 
 	return kprobe_decode_insn(insn, asi, arm_cccc_000x_table, false);
 }
-- 
1.7.2.5
