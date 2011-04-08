From: tixy@yxit.co.uk (Tixy)
Date: Fri,  8 Apr 2011 15:32:55 +0100
Subject: [PATCH 3/4] ARM: kprobes: Reject probing of LDR/STR instructions
	which update PC unpredictably
In-Reply-To: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
References: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302273176-6414-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Using PC as an base register with writeback is UNPREDICTABLE, as is non
word-sized loads or stores of PC. (We only really care about preventing
loads to PC but it keeps the code simpler if we also exclude stores.)

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 9a115b6..2e22977 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -70,6 +70,12 @@
 
 #define is_r15(insn, bitpos) (((insn) & (0xf << bitpos)) == (0xf << bitpos))
 
+/*
+ * Test if load/store instructions writeback the address register.
+ * if P (bit 24) == 0 or W (bit 21) == 1
+ */
+#define is_writeback(insn) ((insn ^ 0x01000000) & 0x01200000)
+
 #define PSR_fs	(PSR_f|PSR_s)
 
 #define KPROBE_RETURN_INSTRUCTION	0xe1a0f00e	/* mov pc, lr */
@@ -886,6 +892,9 @@ prep_emulate_ldr_str(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	int not_imm = (insn & (1 << 26)) ? (insn & (1 << 25))
 					 : (~insn & (1 << 22));
 
+	if (is_writeback(insn) && is_r15(insn, 16))
+		return INSN_REJECTED;	/* Writeback to PC */
+
 	insn &= 0xfff00fff;
 	insn |= 0x00001000;	/* Rn = r0, Rd = r1 */
 	if (not_imm) {
@@ -1167,6 +1176,11 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 		} else if ((insn & 0x0e1000d0) == 0x00000d0) {
 			/* STRD/LDRD */
+			if ((insn & 0x0000e000) == 0x0000e000)
+				return INSN_REJECTED;	/* Rd is LR or PC */
+			if (is_writeback(insn) && is_r15(insn, 16))
+				return INSN_REJECTED;	/* Writeback to PC */
+
 			insn &= 0xfff00fff;
 			insn |= 0x00002000;	/* Rn = r0, Rd = r2 */
 			if (insn & (1 << 22)) {
@@ -1180,6 +1194,9 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 			return INSN_GOOD;
 		}
 
+		/* LDRH/STRH/LDRSB/LDRSH */
+		if (is_r15(insn, 12))
+			return INSN_REJECTED;	/* Rd is PC */
 		return prep_emulate_ldr_str(insn, asi);
 	}
 
-- 
1.7.2.5
