From: tixy@yxit.co.uk (Tixy)
Date: Fri,  8 Apr 2011 15:32:56 +0100
Subject: [PATCH 4/4] ARM: kprobes: Fix emulation of LDRD and STRD instructions
In-Reply-To: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
References: <1302273176-6414-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302273176-6414-5-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The decoding of these instructions got the register indexed and
immediate indexed forms the wrong way around, causing incorrect
emulation.

Instructions like "LDRD Rx, [Rx]" were corrupting Rx because the base
register writeback was being performed unconditionally, overwriting the
value just loaded from memory. The fix is to only writeback the base
register when that form of the instruction is used. Note, now that we
reject probing writeback with PC the emulation code doesn't need the
check rn!=15.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 2e22977..bb239f6 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -560,8 +560,8 @@ static void __kprobes emulate_ldrd(struct kprobe *p, struct pt_regs *regs)
 		  [i_fn] "r" (i_fn)
 		: "r0", "r1", "r2", "r3", "lr", "cc"
 	);
-	if (rn != 15)
-		regs->uregs[rn] = rnv;  /* Save Rn in case of writeback. */
+	if (is_writeback(insn))
+		regs->uregs[rn] = rnv;
 }
 
 static void __kprobes emulate_strd(struct kprobe *p, struct pt_regs *regs)
@@ -580,8 +580,8 @@ static void __kprobes emulate_strd(struct kprobe *p, struct pt_regs *regs)
 	rnv_wb = insnslot_4arg_rflags(rnv, rmv, regs->uregs[rd],
 					       regs->uregs[rd+1],
 					       regs->ARM_cpsr, i_fn);
-	if (rn != 15)
-		regs->uregs[rn] = rnv_wb;  /* Save Rn in case of writeback. */
+	if (is_writeback(insn))
+		regs->uregs[rn] = rnv_wb;
 }
 
 static void __kprobes emulate_ldr(struct kprobe *p, struct pt_regs *regs)
@@ -1183,8 +1183,8 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 			insn &= 0xfff00fff;
 			insn |= 0x00002000;	/* Rn = r0, Rd = r2 */
-			if (insn & (1 << 22)) {
-				/* I bit */
+			if (!(insn & (1 << 22))) {
+				/* Register index */
 				insn &= ~0xf;
 				insn |= 1;	/* Rm = r1 */
 			}
-- 
1.7.2.5
