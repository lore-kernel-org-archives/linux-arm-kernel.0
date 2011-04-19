From: tixy@yxit.co.uk (Tixy)
Date: Tue, 19 Apr 2011 10:52:20 +0100
Subject: [PATCH 5/5] ARM: kprobes: Tidy-up kprobes-decode.c
In-Reply-To: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
References: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303206740-10101-6-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

- Remove coding standard violations reported by checkpatch.pl
- Delete comment about handling of conditional branches which is no
  longer true.
- Delete comment at end of file which lists all ARM instructions. This
  duplicates data available in the ARM ARM and seems like an
  unnecessary maintenance burden to keep this up to date and accurate.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |  131 +++++++-------------------------------
 1 files changed, 23 insertions(+), 108 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index c573b85..894e139 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -34,9 +34,6 @@
  *
  *   *) If the PC is written to by the instruction, the
  *      instruction must be fully simulated in software.
- *      If it is a conditional instruction, the handler
- *      will use insn[0] to copy its condition code to
- *	set r0 to 1 and insn[1] to "mov pc, lr" to return.
  *
  *   *) Otherwise, a modified form of the instruction is
  *      directly executed.  Its handler calls the
@@ -1026,7 +1023,8 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 		/* SMLALxy : cccc 0001 0100 xxxx xxxx xxxx 1xx0 xxxx */
 		if ((insn & 0x0ff00090) == 0x01400080)
-			return prep_emulate_rdhi16rdlo12rs8rm0_wflags(insn, asi);
+			return prep_emulate_rdhi16rdlo12rs8rm0_wflags(insn,
+									asi);
 
 		/* SMULWy : cccc 0001 0010 xxxx xxxx xxxx 1x10 xxxx */
 		/* SMULxy : cccc 0001 0110 xxxx xxxx xxxx 1xx0 xxxx */
@@ -1097,15 +1095,15 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		/* SMULLS : cccc 0000 1101 xxxx xxxx xxxx 1001 xxxx :cc */
 		/* SMLAL  : cccc 0000 1110 xxxx xxxx xxxx 1001 xxxx :   */
 		/* SMLALS : cccc 0000 1111 xxxx xxxx xxxx 1001 xxxx :cc */
-		if ((insn & 0x00d00000) == 0x00500000) {
+		if ((insn & 0x00d00000) == 0x00500000)
 			return INSN_REJECTED;
-		} else if ((insn & 0x00e00000) == 0x00000000) {
-		       return prep_emulate_rd16rs8rm0_wflags(insn, asi);
-		} else if ((insn & 0x00a00000) == 0x00200000) {
-		       return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
-		} else {
-		       return prep_emulate_rdhi16rdlo12rs8rm0_wflags(insn, asi);
-		}
+		else if ((insn & 0x00e00000) == 0x00000000)
+			return prep_emulate_rd16rs8rm0_wflags(insn, asi);
+		else if ((insn & 0x00a00000) == 0x00200000)
+			return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
+		else
+			return prep_emulate_rdhi16rdlo12rs8rm0_wflags(insn,
+									asi);
 	}
 
 	/* cccc 000x xxxx xxxx xxxx xxxx xxxx 1xx1 xxxx */
@@ -1171,7 +1169,7 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	/*
 	 * ALU op with S bit and Rd == 15 :
-	 * 	cccc 000x xxx1 xxxx 1111 xxxx xxxx xxxx
+	 *	cccc 000x xxx1 xxxx 1111 xxxx xxxx xxxx
 	 */
 	if ((insn & 0x0e10f000) == 0x0010f000)
 		return INSN_REJECTED;
@@ -1401,11 +1399,10 @@ space_cccc_0110__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		if ((insn & 0x00300000) == 0x00100000)
 			return INSN_REJECTED;	/* Unallocated space */
 
-		if ((insn & 0x000f0000) == 0x000f0000) {
+		if ((insn & 0x000f0000) == 0x000f0000)
 			return prep_emulate_rd12rm0(insn, asi);
-		} else {
+		else
 			return prep_emulate_rd12rn16rm0_wflags(insn, asi);
-		}
 	}
 
 	/* Other instruction encodings aren't yet defined */
@@ -1436,11 +1433,10 @@ space_cccc_0111__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	    (insn & 0x0ff000d0) == 0x07500010 ||
 	    (insn & 0x0ff000f0) == 0x07800010) {
 
-		if ((insn & 0x0000f000) == 0x0000f000) {
+		if ((insn & 0x0000f000) == 0x0000f000)
 			return prep_emulate_rd16rs8rm0_wflags(insn, asi);
-		} else {
+		else
 			return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
-		}
 	}
 
 	/* SMMLS  : cccc 0111 0101 xxxx xxxx xxxx 11x1 xxxx :  */
@@ -1633,40 +1629,38 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	asi->insn_check_cc = condition_checks[insn>>28];
 	asi->insn[1] = KPROBE_RETURN_INSTRUCTION;
 
-	if ((insn & 0xf0000000) == 0xf0000000) {
+	if ((insn & 0xf0000000) == 0xf0000000)
 
 		return space_1111(insn, asi);
 
-	} else if ((insn & 0x0e000000) == 0x00000000) {
+	else if ((insn & 0x0e000000) == 0x00000000)
 
 		return space_cccc_000x(insn, asi);
 
-	} else if ((insn & 0x0e000000) == 0x02000000) {
+	else if ((insn & 0x0e000000) == 0x02000000)
 
 		return space_cccc_001x(insn, asi);
 
-	} else if ((insn & 0x0f000010) == 0x06000010) {
+	else if ((insn & 0x0f000010) == 0x06000010)
 
 		return space_cccc_0110__1(insn, asi);
 
-	} else if ((insn & 0x0f000010) == 0x07000010) {
+	else if ((insn & 0x0f000010) == 0x07000010)
 
 		return space_cccc_0111__1(insn, asi);
 
-	} else if ((insn & 0x0c000000) == 0x04000000) {
+	else if ((insn & 0x0c000000) == 0x04000000)
 
 		return space_cccc_01xx(insn, asi);
 
-	} else if ((insn & 0x0e000000) == 0x08000000) {
+	else if ((insn & 0x0e000000) == 0x08000000)
 
 		return space_cccc_100x(insn, asi);
 
-	} else if ((insn & 0x0e000000) == 0x0a000000) {
+	else if ((insn & 0x0e000000) == 0x0a000000)
 
 		return space_cccc_101x(insn, asi);
 
-	}
-
 	return space_cccc_11xx(insn, asi);
 }
 
@@ -1674,82 +1668,3 @@ void __init arm_kprobe_decode_init(void)
 {
 	find_str_pc_offset();
 }
-
-
-/*
- * All ARM instructions listed below.
- *
- * Instructions and their general purpose registers are given.
- * If a particular register may not use R15, it is prefixed with a "!".
- * If marked with a "*" means the value returned by reading R15
- * is implementation defined.
- *
- * ADC/ADD/AND/BIC/CMN/CMP/EOR/MOV/MVN/ORR/RSB/RSC/SBC/SUB/TEQ
- *     TST: Rd, Rn, Rm, !Rs
- * BX: Rm
- * BLX(2): !Rm
- * BX: Rm (R15 legal, but discouraged)
- * BXJ: !Rm,
- * CLZ: !Rd, !Rm
- * CPY: Rd, Rm
- * LDC/2,STC/2 immediate offset & unindex: Rn
- * LDC/2,STC/2 immediate pre/post-indexed: !Rn
- * LDM(1/3): !Rn, register_list
- * LDM(2): !Rn, !register_list
- * LDR,STR,PLD immediate offset: Rd, Rn
- * LDR,STR,PLD register offset: Rd, Rn, !Rm
- * LDR,STR,PLD scaled register offset: Rd, !Rn, !Rm
- * LDR,STR immediate pre/post-indexed: Rd, !Rn
- * LDR,STR register pre/post-indexed: Rd, !Rn, !Rm
- * LDR,STR scaled register pre/post-indexed: Rd, !Rn, !Rm
- * LDRB,STRB immediate offset: !Rd, Rn
- * LDRB,STRB register offset: !Rd, Rn, !Rm
- * LDRB,STRB scaled register offset: !Rd, !Rn, !Rm
- * LDRB,STRB immediate pre/post-indexed: !Rd, !Rn
- * LDRB,STRB register pre/post-indexed: !Rd, !Rn, !Rm
- * LDRB,STRB scaled register pre/post-indexed: !Rd, !Rn, !Rm
- * LDRT,LDRBT,STRBT immediate pre/post-indexed: !Rd, !Rn
- * LDRT,LDRBT,STRBT register pre/post-indexed: !Rd, !Rn, !Rm
- * LDRT,LDRBT,STRBT scaled register pre/post-indexed: !Rd, !Rn, !Rm
- * LDRH/SH/SB/D,STRH/SH/SB/D immediate offset: !Rd, Rn
- * LDRH/SH/SB/D,STRH/SH/SB/D register offset: !Rd, Rn, !Rm
- * LDRH/SH/SB/D,STRH/SH/SB/D immediate pre/post-indexed: !Rd, !Rn
- * LDRH/SH/SB/D,STRH/SH/SB/D register pre/post-indexed: !Rd, !Rn, !Rm
- * LDREX: !Rd, !Rn
- * MCR/2: !Rd
- * MCRR/2,MRRC/2: !Rd, !Rn
- * MLA: !Rd, !Rn, !Rm, !Rs
- * MOV: Rd
- * MRC/2: !Rd (if Rd==15, only changes cond codes, not the register)
- * MRS,MSR: !Rd
- * MUL: !Rd, !Rm, !Rs
- * PKH{BT,TB}: !Rd, !Rn, !Rm
- * QDADD,[U]QADD/16/8/SUBX: !Rd, !Rm, !Rn
- * QDSUB,[U]QSUB/16/8/ADDX: !Rd, !Rm, !Rn
- * REV/16/SH: !Rd, !Rm
- * RFE: !Rn
- * {S,U}[H]ADD{16,8,SUBX},{S,U}[H]SUB{16,8,ADDX}: !Rd, !Rn, !Rm
- * SEL: !Rd, !Rn, !Rm
- * SMLA<x><y>,SMLA{D,W<y>},SMLSD,SMML{A,S}: !Rd, !Rn, !Rm, !Rs
- * SMLAL<x><y>,SMLA{D,LD},SMLSLD,SMMULL,SMULW<y>: !RdHi, !RdLo, !Rm, !Rs
- * SMMUL,SMUAD,SMUL<x><y>,SMUSD: !Rd, !Rm, !Rs
- * SSAT/16: !Rd, !Rm
- * STM(1/2): !Rn, register_list* (R15 in reg list not recommended)
- * STRT immediate pre/post-indexed: Rd*, !Rn
- * STRT register pre/post-indexed: Rd*, !Rn, !Rm
- * STRT scaled register pre/post-indexed: Rd*, !Rn, !Rm
- * STREX: !Rd, !Rn, !Rm
- * SWP/B: !Rd, !Rn, !Rm
- * {S,U}XTA{B,B16,H}: !Rd, !Rn, !Rm
- * {S,U}XT{B,B16,H}: !Rd, !Rm
- * UM{AA,LA,UL}L: !RdHi, !RdLo, !Rm, !Rs
- * USA{D8,A8,T,T16}: !Rd, !Rm, !Rs
- *
- * May transfer control by writing R15 (possible mode changes or alternate
- * mode accesses marked by "*"):
- * ALU op (* with s-bit), B, BL, BKPT, BLX(1/2), BX, BXJ, CPS*, CPY,
- * LDM(1), LDM(2/3)*, LDR, MOV, RFE*, SWI*
- *
- * Instructions that do not take general registers, nor transfer control:
- * CDP/2, SETEND, SRS*
- */
-- 
1.7.2.5
