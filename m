From: tixy@yxit.co.uk (Tixy)
Date: Fri,  8 Apr 2011 15:32:54 +0100
Subject: [PATCH 2/4] ARM: kprobes: Fix emulation of LDRH, STRH,
	LDRSB and LDRSH instructions
In-Reply-To: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
References: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302273176-6414-3-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The decoding of these instructions got the register indexed and
immediate indexed forms the wrong way around, causing incorrect
emulation.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 36726c4..9a115b6 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -883,11 +883,12 @@ emulate_alu_tests(struct kprobe *p, struct pt_regs *regs)
 static enum kprobe_insn __kprobes
 prep_emulate_ldr_str(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
-	int ibit = (insn & (1 << 26)) ? 25 : 22;
+	int not_imm = (insn & (1 << 26)) ? (insn & (1 << 25))
+					 : (~insn & (1 << 22));
 
 	insn &= 0xfff00fff;
 	insn |= 0x00001000;	/* Rn = r0, Rd = r1 */
-	if (insn & (1 << ibit)) {
+	if (not_imm) {
 		insn &= ~0xf;
 		insn |= 2;	/* Rm = r2 */
 	}
-- 
1.7.2.5
