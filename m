From: tixy@yxit.co.uk (Tixy)
Date: Wed, 13 Jul 2011 10:05:56 +0100
Subject: [PATCH 07/24] ARM: kprobes: Migrate ARM LDRD and STRD to decoding
	tables
In-Reply-To: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
References: <1310547973-31784-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310547973-31784-8-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-arm.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index 2b43d05..e590ff6 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -997,6 +997,23 @@ static const union decode_item arm_1111_table[] = {
 	DECODE_END
 };
 
+static const union decode_item arm_cccc_000x_____1xx1_table[] = {
+	/* LDRD/STRD lr,pc,{...	cccc 000x x0x0 xxxx 111x xxxx 1101 xxxx */
+	DECODE_REJECT	(0x0e10e0d0, 0x0000e0d0),
+
+	/* LDRD (register)	cccc 000x x0x0 xxxx xxxx xxxx 1101 xxxx */
+	/* STRD (register)	cccc 000x x0x0 xxxx xxxx xxxx 1111 xxxx */
+	DECODE_EMULATEX	(0x0e5000d0, 0x000000d0, emulate_ldrdstrd,
+						 REGS(NOPCWB, NOPCX, 0, 0, NOPC)),
+
+	/* LDRD (immediate)	cccc 000x x1x0 xxxx xxxx xxxx 1101 xxxx */
+	/* STRD (immediate)	cccc 000x x1x0 xxxx xxxx xxxx 1111 xxxx */
+	DECODE_EMULATEX	(0x0e5000d0, 0x004000d0, emulate_ldrdstrd,
+						 REGS(NOPCWB, NOPCX, 0, 0, 0)),
+
+	DECODE_END
+};
+
 static const union decode_item arm_cccc_000x_table[] = {
 	/* Data-processing (register)					*/
 
@@ -1192,23 +1209,9 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 			}
 
 		} else if ((insn & 0x0e1000d0) == 0x00000d0) {
-			/* STRD/LDRD */
-			if ((insn & 0x0000e000) == 0x0000e000)
-				return INSN_REJECTED;	/* Rd is LR or PC */
-			if (is_writeback(insn) && is_r15(insn, 16))
-				return INSN_REJECTED;	/* Writeback to PC */
-
-			insn &= 0xfff00fff;
-			insn |= 0x00002000;	/* Rn = r0, Rd = r2 */
-			if (!(insn & (1 << 22))) {
-				/* Register index */
-				insn &= ~0xf;
-				insn |= 1;	/* Rm = r1 */
-			}
-			asi->insn[0] = insn;
-			asi->insn_handler =
-				(insn & (1 << 5)) ? emulate_strd : emulate_ldrd;
-			return INSN_GOOD;
+
+			return kprobe_decode_insn(insn, asi, arm_cccc_000x_____1xx1_table,
+									false);
 		}
 
 		/* LDRH/STRH/LDRSB/LDRSH */
-- 
1.7.2.5
