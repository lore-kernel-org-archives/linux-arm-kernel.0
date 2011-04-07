From: tixy@yxit.co.uk (Tixy)
Date: Thu,  7 Apr 2011 13:25:17 +0100
Subject: [PATCH 3/5] ARM: kprobes: Reject probing of instructions which write
	to PC unpredictably.
In-Reply-To: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
References: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302179119-17573-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 493e741..32401f8 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -68,6 +68,8 @@
 
 #define branch_displacement(insn) sign_extend(((insn) & 0xffffff) << 2, 25)
 
+#define is_r15(insn, bitpos) (((insn) & (0xf << bitpos)) == (0xf << bitpos))
+
 #define PSR_fs	(PSR_f|PSR_s)
 
 #define KPROBE_RETURN_INSTRUCTION	0xe1a0f00e	/* mov pc, lr */
@@ -897,6 +899,9 @@ prep_emulate_ldr_str(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 static enum kprobe_insn __kprobes
 prep_emulate_rd12rm0(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
+	if (is_r15(insn, 12))
+		return INSN_REJECTED;	/* Rd is PC */
+
 	insn &= 0xffff0ff0;	/* Rd = r0, Rm = r0 */
 	asi->insn[0] = insn;
 	asi->insn_handler = emulate_rd12rm0;
@@ -907,6 +912,9 @@ static enum kprobe_insn __kprobes
 prep_emulate_rd12rn16rm0_wflags(kprobe_opcode_t insn,
 				struct arch_specific_insn *asi)
 {
+	if (is_r15(insn, 12))
+		return INSN_REJECTED;	/* Rd is PC */
+
 	insn &= 0xfff00ff0;	/* Rd = r0, Rn = r0 */
 	insn |= 0x00000001;	/* Rm = r1 */
 	asi->insn[0] = insn;
@@ -918,6 +926,9 @@ static enum kprobe_insn __kprobes
 prep_emulate_rd16rs8rm0_wflags(kprobe_opcode_t insn,
 			       struct arch_specific_insn *asi)
 {
+	if (is_r15(insn, 16))
+		return INSN_REJECTED;	/* Rd is PC */
+
 	insn &= 0xfff0f0f0;	/* Rd = r0, Rs = r0 */
 	insn |= 0x00000001;	/* Rm = r1          */
 	asi->insn[0] = insn;
@@ -929,6 +940,9 @@ static enum kprobe_insn __kprobes
 prep_emulate_rd16rn12rs8rm0_wflags(kprobe_opcode_t insn,
 				   struct arch_specific_insn *asi)
 {
+	if (is_r15(insn, 16))
+		return INSN_REJECTED;	/* Rd is PC */
+
 	insn &= 0xfff000f0;	/* Rd = r0, Rn = r0 */
 	insn |= 0x00000102;	/* Rs = r1, Rm = r2 */
 	asi->insn[0] = insn;
@@ -940,6 +954,9 @@ static enum kprobe_insn __kprobes
 prep_emulate_rdhi16rdlo12rs8rm0_wflags(kprobe_opcode_t insn,
 				       struct arch_specific_insn *asi)
 {
+	if (is_r15(insn, 16) || is_r15(insn, 12))
+		return INSN_REJECTED;	/* RdHi or RdLo is PC */
+
 	insn &= 0xfff000f0;	/* RdHi = r0, RdLo = r1 */
 	insn |= 0x00001203;	/* Rs = r2, Rm = r3 */
 	asi->insn[0] = insn;
@@ -1035,6 +1052,8 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 		/* MRS cpsr : cccc 0001 0000 xxxx xxxx xxxx 0000 xxxx */
 		if ((insn & 0x0ff000f0) == 0x01000000) {
+			if (is_r15(insn, 12))
+				return INSN_REJECTED;	/* Rd is PC */
 			asi->insn_handler = simulate_mrs;
 			return INSN_GOOD_NO_SLOT;
 		}
@@ -1065,6 +1084,8 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		/* BLX(2) : cccc 0001 0010 xxxx xxxx xxxx 0011 xxxx */
 		/* BX     : cccc 0001 0010 xxxx xxxx xxxx 0001 xxxx */
 		if ((insn & 0x0ff000d0) == 0x01200010) {
+			if ((insn & 0x0ff000ff) == 0x0120003f)
+				return INSN_REJECTED; /* BLX pc */
 			asi->insn_handler = simulate_blx2bx;
 			return INSN_GOOD_NO_SLOT;
 		}
@@ -1234,6 +1255,8 @@ space_cccc_0110__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	/* SEL : cccc 0110 1000 xxxx xxxx xxxx 1011 xxxx GE: !!! */
 	if ((insn & 0x0ff000f0) == 0x068000b0) {
+		if (is_r15(insn, 12))
+			return INSN_REJECTED;	/* Rd is PC */
 		insn &= 0xfff00ff0;	/* Rd = r0, Rn = r0 */
 		insn |= 0x00000001;	/* Rm = r1 */
 		asi->insn[0] = insn;
@@ -1247,6 +1270,8 @@ space_cccc_0110__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	/* USAT16 : cccc 0110 1110 xxxx xxxx xxxx 0011 xxxx :Q */
 	if ((insn & 0x0fa00030) == 0x06a00010 ||
 	    (insn & 0x0fb000f0) == 0x06a00030) {
+		if (is_r15(insn, 12))
+			return INSN_REJECTED;	/* Rd is PC */
 		insn &= 0xffff0ff0;	/* Rd = r0, Rm = r0 */
 		asi->insn[0] = insn;
 		asi->insn_handler = emulate_sat;
@@ -1384,6 +1409,9 @@ space_cccc_1100_010x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	/* MCRR : cccc 1100 0100 xxxx xxxx xxxx xxxx xxxx : (Rd!=Rn) */
 	/* MRRC : cccc 1100 0101 xxxx xxxx xxxx xxxx xxxx : (Rd!=Rn) */
+	if (is_r15(insn, 16) || is_r15(insn, 12))
+		return INSN_REJECTED;	/* Rn or Rd is PC */
+
 	insn &= 0xfff00fff;
 	insn |= 0x00001000;	/* Rn = r0, Rd = r1 */
 	asi->insn[0] = insn;
-- 
1.7.2.5
