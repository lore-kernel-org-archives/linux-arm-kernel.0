From: tixy@yxit.co.uk (Tixy)
Date: Mon,  4 Apr 2011 21:33:16 +0100
Subject: [PATCH 2/4] ARM: kprobes: Remove redundant condition checks from
	simulation routines
In-Reply-To: <1301949198-31570-1-git-send-email-tixy@yxit.co.uk>
References: <1301949198-31570-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1301949198-31570-3-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Now we have the framework code handling conditionally executed
instructions we can remove redundant checks in individual simulation
routines.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   30 +++---------------------------
 1 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index c88c8d2..9161fdc 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -72,10 +72,6 @@
 #define PSR_fs	(PSR_f|PSR_s)
 
 #define KPROBE_RETURN_INSTRUCTION	0xe1a0f00e	/* mov pc, lr */
-#define SET_R0_TRUE_INSTRUCTION		0xe3a00001	/* mov	r0, #1 */
-
-#define	truecc_insn(insn)	(((insn) & 0xf0000000) | \
-				 (SET_R0_TRUE_INSTRUCTION & 0x0fffffff))
 
 typedef long (insn_0arg_fn_t)(void);
 typedef long (insn_1arg_fn_t)(long);
@@ -420,14 +416,10 @@ insnslot_llret_4arg_rwflags(long r0, long r1, long r2, long r3, long *cpsr,
 
 static void __kprobes simulate_bbl(struct kprobe *p, struct pt_regs *regs)
 {
-	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
 	long iaddr = (long)p->addr;
 	int disp  = branch_displacement(insn);
 
-	if (!insnslot_1arg_rflags(0, regs->ARM_cpsr, i_fn))
-		return;
-
 	if (insn & (1 << 24))
 		regs->ARM_lr = iaddr + 4;
 
@@ -447,14 +439,10 @@ static void __kprobes simulate_blx1(struct kprobe *p, struct pt_regs *regs)
 
 static void __kprobes simulate_blx2bx(struct kprobe *p, struct pt_regs *regs)
 {
-	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
 	int rm = insn & 0xf;
 	long rmv = regs->uregs[rm];
 
-	if (!insnslot_1arg_rflags(0, regs->ARM_cpsr, i_fn))
-		return;
-
 	if (insn & (1 << 5))
 		regs->ARM_lr = (long)p->addr + 4;
 
@@ -466,7 +454,6 @@ static void __kprobes simulate_blx2bx(struct kprobe *p, struct pt_regs *regs)
 
 static void __kprobes simulate_ldm1stm1(struct kprobe *p, struct pt_regs *regs)
 {
-	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
 	int rn = (insn >> 16) & 0xf;
 	int lbit = insn & (1 << 20);
@@ -477,9 +464,6 @@ static void __kprobes simulate_ldm1stm1(struct kprobe *p, struct pt_regs *regs)
 	int reg_bit_vector;
 	int reg_count;
 
-	if (!insnslot_1arg_rflags(0, regs->ARM_cpsr, i_fn))
-		return;
-
 	reg_count = 0;
 	reg_bit_vector = insn & 0xffff;
 	while (reg_bit_vector) {
@@ -511,11 +495,6 @@ static void __kprobes simulate_ldm1stm1(struct kprobe *p, struct pt_regs *regs)
 
 static void __kprobes simulate_stm1_pc(struct kprobe *p, struct pt_regs *regs)
 {
-	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
-
-	if (!insnslot_1arg_rflags(0, regs->ARM_cpsr, i_fn))
-		return;
-
 	regs->ARM_pc = (long)p->addr + str_pc_offset;
 	simulate_ldm1stm1(p, regs);
 	regs->ARM_pc = (long)p->addr + 4;
@@ -1045,9 +1024,8 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		/* BLX(2) : cccc 0001 0010 xxxx xxxx xxxx 0011 xxxx */
 		/* BX     : cccc 0001 0010 xxxx xxxx xxxx 0001 xxxx */
 		if ((insn & 0x0ff000d0) == 0x01200010) {
-			asi->insn[0] = truecc_insn(insn);
 			asi->insn_handler = simulate_blx2bx;
-			return INSN_GOOD;
+			return INSN_GOOD_NO_SLOT;
 		}
 
 		/* CLZ : cccc 0001 0110 xxxx xxxx xxxx 0001 xxxx */
@@ -1322,10 +1300,9 @@ space_cccc_100x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	/* LDM(1) : cccc 100x x0x1 xxxx xxxx xxxx xxxx xxxx */
 	/* STM(1) : cccc 100x x0x0 xxxx xxxx xxxx xxxx xxxx */
-	asi->insn[0] = truecc_insn(insn);
 	asi->insn_handler = ((insn & 0x108000) == 0x008000) ? /* STM & R15 */
 				simulate_stm1_pc : simulate_ldm1stm1;
-	return INSN_GOOD;
+	return INSN_GOOD_NO_SLOT;
 }
 
 static enum kprobe_insn __kprobes
@@ -1333,9 +1310,8 @@ space_cccc_101x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	/* B  : cccc 1010 xxxx xxxx xxxx xxxx xxxx xxxx */
 	/* BL : cccc 1011 xxxx xxxx xxxx xxxx xxxx xxxx */
-	asi->insn[0] = truecc_insn(insn);
 	asi->insn_handler = simulate_bbl;
-	return INSN_GOOD;
+	return INSN_GOOD_NO_SLOT;
 }
 
 static enum kprobe_insn __kprobes
-- 
1.7.2.5
