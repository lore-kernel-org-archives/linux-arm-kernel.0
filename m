From: tixy@yxit.co.uk (Tixy)
Date: Fri,  8 Apr 2011 15:32:53 +0100
Subject: [PATCH 1/4] ARM: kprobes: Reject probing of STREX and LDREX
	instructions
In-Reply-To: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
References: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302273176-6414-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The emulation code for STREX and LDREX instructions is faulty, however,
rather than attempting to fix this we reject probes of these
instructions. We do this because they can never succeed in gaining
exclusive access as the exception framework clears the exclusivity
monitor when a probes breakpoint is hit. (This is a general problem
when probing all instructions executing between a LDREX and its
corresponding STREX and can lead to infinite retry loops.)

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 597ae10..36726c4 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1136,17 +1136,34 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 		/* SWP   : cccc 0001 0000 xxxx xxxx xxxx 1001 xxxx */
 		/* SWPB  : cccc 0001 0100 xxxx xxxx xxxx 1001 xxxx */
-		/* LDRD  : cccc 000x xxx0 xxxx xxxx xxxx 1101 xxxx */
-		/* STRD  : cccc 000x xxx0 xxxx xxxx xxxx 1111 xxxx */
+		/* ???   : cccc 0001 0x01 xxxx xxxx xxxx 1001 xxxx */
+		/* ???   : cccc 0001 0x10 xxxx xxxx xxxx 1001 xxxx */
+		/* ???   : cccc 0001 0x11 xxxx xxxx xxxx 1001 xxxx */
 		/* STREX : cccc 0001 1000 xxxx xxxx xxxx 1001 xxxx */
 		/* LDREX : cccc 0001 1001 xxxx xxxx xxxx 1001 xxxx */
+		/* STREXD: cccc 0001 1010 xxxx xxxx xxxx 1001 xxxx */
+		/* LDREXD: cccc 0001 1011 xxxx xxxx xxxx 1001 xxxx */
+		/* STREXB: cccc 0001 1100 xxxx xxxx xxxx 1001 xxxx */
+		/* LDREXB: cccc 0001 1101 xxxx xxxx xxxx 1001 xxxx */
+		/* STREXH: cccc 0001 1110 xxxx xxxx xxxx 1001 xxxx */
+		/* LDREXH: cccc 0001 1111 xxxx xxxx xxxx 1001 xxxx */
+
+		/* LDRD  : cccc 000x xxx0 xxxx xxxx xxxx 1101 xxxx */
+		/* STRD  : cccc 000x xxx0 xxxx xxxx xxxx 1111 xxxx */
 		/* LDRH  : cccc 000x xxx1 xxxx xxxx xxxx 1011 xxxx */
 		/* STRH  : cccc 000x xxx0 xxxx xxxx xxxx 1011 xxxx */
 		/* LDRSB : cccc 000x xxx1 xxxx xxxx xxxx 1101 xxxx */
 		/* LDRSH : cccc 000x xxx1 xxxx xxxx xxxx 1111 xxxx */
-		if ((insn & 0x0fb000f0) == 0x01000090) {
-			/* SWP/SWPB */
-			return prep_emulate_rd12rn16rm0_wflags(insn, asi);
+		if ((insn & 0x0f0000f0) == 0x01000090) {
+			if ((insn & 0x0fb000f0) == 0x01000090) {
+				/* SWP/SWPB */
+				return prep_emulate_rd12rn16rm0_wflags(insn,
+									asi);
+			} else {
+				/* STREX/LDREX variants and unallocaed space */
+				return INSN_REJECTED;
+			}
+
 		} else if ((insn & 0x0e1000d0) == 0x00000d0) {
 			/* STRD/LDRD */
 			insn &= 0xfff00fff;
-- 
1.7.2.5
