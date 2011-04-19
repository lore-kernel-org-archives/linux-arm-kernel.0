From: tixy@yxit.co.uk (Tixy)
Date: Tue, 19 Apr 2011 10:52:16 +0100
Subject: [PATCH 1/5] ARM: kprobes: Reject probing of undefined data processing
	instructions
In-Reply-To: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
References: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303206740-10101-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The instruction decoding in space_cccc_000x needs to reject probing of
instructions with undefined patterns as they may in future become
defined and then emulated faultily - as has already happened with the
SMC instruction.

This fix is achieved by testing for the instruction patterns we want to
probe and making the the default fall-through paths reject probes. This
also allows us to remove some explicit tests for instructions that we
wish to reject, as that is now the default action.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 4c8eda2..a50a68a 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -966,14 +966,6 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	/* cccc 0001 0xx0 xxxx xxxx xxxx xxxx xxx0 xxxx */
 	if ((insn & 0x0f900010) == 0x01000000) {
 
-		/* BXJ      : cccc 0001 0010 xxxx xxxx xxxx 0010 xxxx */
-		/* MSR      : cccc 0001 0x10 xxxx xxxx xxxx 0000 xxxx */
-		/* MRS spsr : cccc 0001 0100 xxxx xxxx xxxx 0000 xxxx */
-		if ((insn & 0x0ff000f0) == 0x01200020 ||
-		    (insn & 0x0fb000f0) == 0x01200000 ||
-		    (insn & 0x0ff000f0) == 0x01400000)
-			return INSN_REJECTED;
-
 		/* MRS cpsr : cccc 0001 0000 xxxx xxxx xxxx 0000 xxxx */
 		if ((insn & 0x0ff000f0) == 0x01000000) {
 			if (is_r15(insn, 12))
@@ -994,17 +986,21 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 		/* SMLAxy : cccc 0001 0000 xxxx xxxx xxxx 1xx0 xxxx : Q */
 		/* SMLAWy : cccc 0001 0010 xxxx xxxx xxxx 1x00 xxxx : Q */
-		return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
+		if ((insn & 0x0ff00090) == 0x01000080 ||
+		    (insn & 0x0ff000b0) == 0x01200080)
+			return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
+
+		/* BXJ      : cccc 0001 0010 xxxx xxxx xxxx 0010 xxxx */
+		/* MSR      : cccc 0001 0x10 xxxx xxxx xxxx 0000 xxxx */
+		/* MRS spsr : cccc 0001 0100 xxxx xxxx xxxx 0000 xxxx */
 
+		/* Other instruction encodings aren't yet defined */
+		return INSN_REJECTED;
 	}
 
 	/* cccc 0001 0xx0 xxxx xxxx xxxx xxxx 0xx1 xxxx */
 	else if ((insn & 0x0f900090) == 0x01000010) {
 
-		/* BKPT : 1110 0001 0010 xxxx xxxx xxxx 0111 xxxx */
-		if ((insn & 0xfff000f0) == 0xe1200070)
-			return INSN_REJECTED;
-
 		/* BLX(2) : cccc 0001 0010 xxxx xxxx xxxx 0011 xxxx */
 		/* BX     : cccc 0001 0010 xxxx xxxx xxxx 0001 xxxx */
 		if ((insn & 0x0ff000d0) == 0x01200010) {
@@ -1022,7 +1018,14 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		/* QSUB    : cccc 0001 0010 xxxx xxxx xxxx 0101 xxxx :Q */
 		/* QDADD   : cccc 0001 0100 xxxx xxxx xxxx 0101 xxxx :Q */
 		/* QDSUB   : cccc 0001 0110 xxxx xxxx xxxx 0101 xxxx :Q */
-		return prep_emulate_rd12rn16rm0_wflags(insn, asi);
+		if ((insn & 0x0f9000f0) == 0x01000050)
+			return prep_emulate_rd12rn16rm0_wflags(insn, asi);
+
+		/* BKPT : 1110 0001 0010 xxxx xxxx xxxx 0111 xxxx */
+		/* SMC  : cccc 0001 0110 xxxx xxxx xxxx 0111 xxxx */
+
+		/* Other instruction encodings aren't yet defined */
+		return INSN_REJECTED;
 	}
 
 	/* cccc 0000 xxxx xxxx xxxx xxxx xxxx 1001 xxxx */
-- 
1.7.2.5
