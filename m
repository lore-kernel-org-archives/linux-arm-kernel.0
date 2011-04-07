From: tixy@yxit.co.uk (Tixy)
Date: Thu,  7 Apr 2011 13:25:16 +0100
Subject: [PATCH 2/5] ARM: kprobes: Fix emulation of MRS instruction
In-Reply-To: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
References: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302179119-17573-3-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The MRS instruction should set mode and interrupt bits in the read value
so it is simpler to use a new simulation routine (simulate_mrs) rather
than some modified emulation.

prep_emulate_rd12 is now unused and removed.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index c0a4807..493e741 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -451,6 +451,14 @@ static void __kprobes simulate_blx2bx(struct kprobe *p, struct pt_regs *regs)
 		regs->ARM_cpsr |= PSR_T_BIT;
 }
 
+static void __kprobes simulate_mrs(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rd = (insn >> 12) & 0xf;
+	unsigned long mask = 0xf8ff03df; /* Mask out execution state */
+	regs->uregs[rd] = regs->ARM_cpsr & mask;
+}
+
 static void __kprobes simulate_ldm1stm1(struct kprobe *p, struct pt_regs *regs)
 {
 	kprobe_opcode_t insn = p->opcode;
@@ -896,15 +904,6 @@ prep_emulate_rd12rm0(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 }
 
 static enum kprobe_insn __kprobes
-prep_emulate_rd12(kprobe_opcode_t insn, struct arch_specific_insn *asi)
-{
-	insn &= 0xffff0fff;	/* Rd = r0 */
-	asi->insn[0] = insn;
-	asi->insn_handler = emulate_rd12;
-	return INSN_GOOD;
-}
-
-static enum kprobe_insn __kprobes
 prep_emulate_rd12rn16rm0_wflags(kprobe_opcode_t insn,
 				struct arch_specific_insn *asi)
 {
@@ -1035,8 +1034,10 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 			return INSN_REJECTED;
 
 		/* MRS cpsr : cccc 0001 0000 xxxx xxxx xxxx 0000 xxxx */
-		if ((insn & 0x0ff000f0) == 0x01000000)
-			return prep_emulate_rd12(insn, asi);
+		if ((insn & 0x0ff000f0) == 0x01000000) {
+			asi->insn_handler = simulate_mrs;
+			return INSN_GOOD_NO_SLOT;
+		}
 
 		/* SMLALxy : cccc 0001 0100 xxxx xxxx xxxx 1xx0 xxxx */
 		if ((insn & 0x0ff00090) == 0x01400080)
-- 
1.7.2.5
