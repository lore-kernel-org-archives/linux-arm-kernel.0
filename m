From: tixy@yxit.co.uk (Tixy)
Date: Tue, 12 Apr 2011 07:45:26 +0100
Subject: [PATCH 6/6] ARM: kprobes: Fix emulation of USAD8 instructions
In-Reply-To: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
References: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302590726-3484-7-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The USAD8 instruction wasn't being explicitly decoded leading
to the incorrect emulation routine being called. It can be correctly
decoded in the same way as the signed multiply instructions so we move
the decoding there.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 915b057..43c2bf2 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1425,11 +1425,6 @@ space_cccc_0111__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	if ((insn & 0x0ff000f0) == 0x03f000f0)
 		return INSN_REJECTED;
 
-	/* USADA8 : cccc 0111 1000 xxxx xxxx xxxx 0001 xxxx */
-	/* USAD8  : cccc 0111 1000 xxxx 1111 xxxx 0001 xxxx */
-	if ((insn & 0x0ff000f0) == 0x07800010)
-		 return prep_emulate_rd16rn12rs8rm0_wflags(insn, asi);
-
 	/* SMLALD : cccc 0111 0100 xxxx xxxx xxxx 00x1 xxxx */
 	/* SMLSLD : cccc 0111 0100 xxxx xxxx xxxx 01x1 xxxx */
 	if ((insn & 0x0ff00090) == 0x07400010)
@@ -1441,8 +1436,11 @@ space_cccc_0111__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	/* SMUSD  : cccc 0111 0000 xxxx 1111 xxxx 01x1 xxxx :  */
 	/* SMMLA  : cccc 0111 0101 xxxx xxxx xxxx 00x1 xxxx :  */
 	/* SMMUL  : cccc 0111 0101 xxxx 1111 xxxx 00x1 xxxx :  */
+	/* USADA8 : cccc 0111 1000 xxxx xxxx xxxx 0001 xxxx :  */
+	/* USAD8  : cccc 0111 1000 xxxx 1111 xxxx 0001 xxxx :  */
 	if ((insn & 0x0ff00090) == 0x07000010 ||
-	    (insn & 0x0ff000d0) == 0x07500010) {
+	    (insn & 0x0ff000d0) == 0x07500010 ||
+	    (insn & 0x0ff000f0) == 0x07800010) {
 
 		if ((insn & 0x0000f000) == 0x0000f000) {
 			return prep_emulate_rd16rs8rm0_wflags(insn, asi);
-- 
1.7.2.5
