From: tixy@yxit.co.uk (Tixy)
Date: Thu,  7 Apr 2011 13:25:19 +0100
Subject: [PATCH 5/5] ARM: kprobes: Reject probing of undefined multiply
	instructions
In-Reply-To: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
References: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302179119-17573-6-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The instructions space for 'Multiply and multiply-accumulate'
instructions contains some undefined patterns. We need to reject
probing of these because they may in future become defined and the
kprobes code may then emulate them faultily.

This has already happened with the new MLS instruction which this patch
also adds correct decoding for as well as tightening up other decoding
tests. (Before this patch the wrong emulation routine was being called
for MLS though it still produced correct results.)

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 03f7257..597ae10 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1102,13 +1102,16 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	}
 
 	/* cccc 0000 xxxx xxxx xxxx xxxx xxxx 1001 xxxx */
-	else if ((insn & 0x0f000090) == 0x00000090) {
+	else if ((insn & 0x0f0000f0) == 0x00000090) {
 
 		/* MUL    : cccc 0000 0000 xxxx xxxx xxxx 1001 xxxx :   */
 		/* MULS   : cccc 0000 0001 xxxx xxxx xxxx 1001 xxxx :cc */
 		/* MLA    : cccc 0000 0010 xxxx xxxx xxxx 1001 xxxx :   */
 		/* MLAS   : cccc 0000 0011 xxxx xxxx xxxx 1001 xxxx :cc */
 		/* UMAAL  : cccc 0000 0100 xxxx xxxx xxxx 1001 xxxx :   */
+		/* undef  : cccc 0000 0101 xxxx xxxx xxxx 1001 xxxx :   */
+		/* MLS    : cccc 0000 0110 xxxx xxxx xxxx 1001 xxxx :   */
+		/* undef  : cccc 0000 0111 xxxx xxxx xxxx 1001 xxxx :   */
 		/* UMULL  : cccc 0000 1000 xxxx xxxx xxxx 1001 xxxx :   */
 		/* UMULLS : cccc 0000 1001 xxxx xxxx xxxx 1001 xxxx :cc */
 		/* UMLAL  : cccc 0000 1010 xxxx xxxx xxxx 1001 xxxx :   */
@@ -1117,9 +1120,11 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		/* SMULLS : cccc 0000 1101 xxxx xxxx xxxx 1001 xxxx :cc */
 		/* SMLAL  : cccc 0000 1110 xxxx xxxx xxxx 1001 xxxx :   */
 		/* SMLALS : cccc 0000 1111 xxxx xxxx xxxx 1001 xxxx :cc */
-		if ((insn & 0x0fe000f0) == 0x00000090) {
+		if ((insn & 0x00d00000) == 0x00500000) {
+			return INSN_REJECTED;
+		} else if ((insn & 0x00e00000) == 0x00000000) {
 		       return prep_emulate_rd16rs8rm0_wflags(insn, asi);
-		} else if  ((insn & 0x0fe000f0) == 0x00200090) {
+		} else if ((insn & 0x00a00000) == 0x00200000) {
 		       return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
 		} else {
 		       return prep_emulate_rdhi16rdlo12rs8rm0_wflags(insn, asi);
-- 
1.7.2.5
