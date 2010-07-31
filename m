From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 12:29:16 +0100
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <20100731105225.GI23886@n2100.arm.linux.org.uk>
References: <20100719180136.20305.7333.stgit@e200687-lin>
	<201007291313.29923.siarhei.siamashka@nokia.com>
	<20100729192855.GA4298@elf.ucw.cz>
	<201007301304.54559.siarhei.siamashka@nokia.com>
	<20100731105225.GI23886@n2100.arm.linux.org.uk>
Message-ID: <20100731112916.GN23886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 11:52:25AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 30, 2010 at 01:04:54PM +0300, Siarhei Siamashka wrote:
> > On Thursday 29 July 2010 22:28:56 ext Pavel Machek wrote:
> > > I believe emulation just to annoy users into submitting bugreports is
> > > serious overengineering.
> > 
> > It's not to annoy them, but to provide the users with the information about 
> > valid problems in their applications. It's up to the users to either do 
> > anything with it, or ignore.
> 
> What's missing is that the SWP instruction will eventually be dropped
> from the later ARM architecture revisions, so sooner or later programs
> will break without either SWP emulation support or being fixed.
> 
> The SWP instruction is already deprecated from ARMv6, and in ARMv6 it
> was still present (see the note in section A3.4).  In ARMv7, it defaults
> to being disabled and causing an illegal instruction fault.  The next
> step will be to remove it from the hardware entirely which I suspect
> isn't that far away.
> 
> So this patch makes total sense.
> 
> What I do think we need to do is collect all the definitions for decoding
> instructions together - we have stuff like (in kprobes-decode.c):
> 
>         int rd = (insn >> 12) & 0xf;
> 
> when we also have in arch/arm/mm/alignment.c:
> 
> #define RD_BITS(i)      ((i >> 12) & 15)        /* Rd                   */
> 
> and it seems we're going to get another version of this for the swp
> emulation support.

First stab at merging these ARM ISA decoding macros/code - I'm sure
there's more which can be done:

diff --git a/arch/arm/include/asm/arm-isa.h b/arch/arm/include/asm/arm-isa.h
index e69de29..aad7dd3 100644
--- a/arch/arm/include/asm/arm-isa.h
+++ b/arch/arm/include/asm/arm-isa.h
@@ -0,0 +1,36 @@
+#ifndef __ASM_ARM_ISA_H
+#define __ASM_ARM_ISA_H
+
+#define CODING_BITS(i)	((i) & 0x0e000000)
+
+#define LDST_I_BIT(i)	((i) & (1 << 26))	/* Immediate constant	*/
+#define LDST_P_BIT(i)	((i) & (1 << 24))	/* Preindex		*/
+#define LDST_U_BIT(i)	((i) & (1 << 23))	/* Add offset		*/
+#define LDST_W_BIT(i)	((i) & (1 << 21))	/* Writeback		*/
+#define LDST_L_BIT(i)	((i) & (1 << 20))	/* Load			*/
+
+#define LDST_P_EQ_U(i)	((((i) ^ ((i) >> 1)) & (1 << 23)) == 0)
+
+#define LDSTHD_I_BIT(i)	((i) & (1 << 22))	/* double/half-word immed */
+
+#define RN_BITS(i)	(((i) >> 16) & 15)	/* Rn			*/
+#define RD_BITS(i)	(((i) >> 12) & 15)	/* Rd			*/
+#define RM_BITS(i)	((i) & 15)		/* Rm			*/
+
+#define OFFSET_BITS(i)	((i) & 0x0fff)
+
+#define LDM_S_BIT(i)	((i) & (1 << 22))	/* write CPSR from SPSR	*/
+#define LDM_REGMASK(i)	((i) & 0xffff)
+
+#define IS_SHIFT(i)	(i & 0x0ff0)
+#define SHIFT_BITS(i)	((i >> 7) & 0x1f)
+#define SHIFT_TYPE(i)	(i & 0x60)
+#define SHIFT_LSL	0x00
+#define SHIFT_LSR	0x20
+#define SHIFT_ASR	0x40
+#define SHIFT_RORRRX	0x60
+
+#define IS_T32(hi16) \
+	(((hi16) & 0xe000) == 0xe000 && ((hi16) & 0x1800))
+
+#endif
diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 8bccbfa..a11c45d 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -64,6 +64,8 @@
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 
+#include <asm/arm-isa.h>
+
 #define sign_extend(x, signbit) ((x) | (0 - ((x) & (1 << (signbit)))))
 
 #define branch_displacement(insn) sign_extend(((insn) & 0xffffff) << 2, 25)
@@ -448,7 +450,7 @@ static void __kprobes simulate_blx2bx(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rm = insn & 0xf;
+	int rm = RM_BITS(insn);
 	long rmv = regs->uregs[rm];
 
 	if (!insnslot_1arg_rflags(0, regs->ARM_cpsr, i_fn))
@@ -467,11 +469,11 @@ static void __kprobes simulate_ldm1stm1(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rn = (insn >> 16) & 0xf;
-	int lbit = insn & (1 << 20);
-	int wbit = insn & (1 << 21);
-	int ubit = insn & (1 << 23);
-	int pbit = insn & (1 << 24);
+	int rn = RN_BITS(insn);
+	int lbit = LDST_L_BIT(insn);
+	int wbit = LDST_W_BIT(insn);
+	int ubit = LDST_U_BIT(insn);
+	int pbit = LDST_P_BIT(insn);
 	long *addr = (long *)regs->uregs[rn];
 	int reg_bit_vector;
 	int reg_count;
@@ -480,7 +482,7 @@ static void __kprobes simulate_ldm1stm1(struct kprobe *p, struct pt_regs *regs)
 		return;
 
 	reg_count = 0;
-	reg_bit_vector = insn & 0xffff;
+	reg_bit_vector = LDM_REGMASK(insn);
 	while (reg_bit_vector) {
 		reg_bit_vector &= (reg_bit_vector - 1);
 		++reg_count;
@@ -490,7 +492,7 @@ static void __kprobes simulate_ldm1stm1(struct kprobe *p, struct pt_regs *regs)
 		addr -= reg_count;
 	addr += (!pbit == !ubit);
 
-	reg_bit_vector = insn & 0xffff;
+	reg_bit_vector = LDM_REGMASK(insn);
 	while (reg_bit_vector) {
 		int reg = __ffs(reg_bit_vector);
 		reg_bit_vector &= (reg_bit_vector - 1);
@@ -529,7 +531,7 @@ static void __kprobes emulate_ldcstc(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rn = (insn >> 16) & 0xf;
+	int rn = RN_BITS(insn);
 	long rnv = regs->uregs[rn];
 
 	/* Save Rn in case of writeback. */
@@ -540,9 +542,9 @@ static void __kprobes emulate_ldrd(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_2arg_fn_t *i_fn = (insn_2arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
-	int rm = insn & 0xf;  /* rm may be invalid, don't care. */
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
+	int rm = RM_BITS(insn);  /* rm may be invalid, don't care. */
 
 	/* Not following the C calling convention here, so need asm(). */
 	__asm__ __volatile__ (
@@ -568,9 +570,9 @@ static void __kprobes emulate_strd(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_4arg_fn_t *i_fn = (insn_4arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
-	int rm  = insn & 0xf;
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
+	int rm = RM_BITS(insn);
 	long rnv = regs->uregs[rn];
 	long rmv = regs->uregs[rm];  /* rm/rmv may be invalid, don't care. */
 
@@ -585,9 +587,9 @@ static void __kprobes emulate_ldr(struct kprobe *p, struct pt_regs *regs)
 	kprobe_opcode_t insn = p->opcode;
 	long ppc = (long)p->addr + 8;
 	union reg_pair fnr;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
-	int rm = insn & 0xf;
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
+	int rm = RM_BITS(insn);
 	long rdv;
 	long rnv = (rn == 15) ? ppc : regs->uregs[rn];
 	long rmv = (rm == 15) ? ppc : regs->uregs[rm];
@@ -616,9 +618,9 @@ static void __kprobes emulate_str(struct kprobe *p, struct pt_regs *regs)
 	insn_3arg_fn_t *i_fn = (insn_3arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
 	long iaddr = (long)p->addr;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
-	int rm = insn & 0xf;
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
+	int rm = RM_BITS(insn);
 	long rdv = (rd == 15) ? iaddr + str_pc_offset : regs->uregs[rd];
 	long rnv = (rn == 15) ? iaddr +  8 : regs->uregs[rn];
 	long rmv = regs->uregs[rm];  /* rm/rmv may be invalid, don't care. */
@@ -633,8 +635,8 @@ static void __kprobes emulate_mrrc(struct kprobe *p, struct pt_regs *regs)
 	insn_llret_0arg_fn_t *i_fn = (insn_llret_0arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
 	union reg_pair fnr;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
 
 	fnr.dr = insnslot_llret_0arg_rflags(regs->ARM_cpsr, i_fn);
 	regs->uregs[rn] = fnr.r0;
@@ -645,8 +647,8 @@ static void __kprobes emulate_mcrr(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_2arg_fn_t *i_fn = (insn_2arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
 	long rnv = regs->uregs[rn];
 	long rdv = regs->uregs[rd];
 
@@ -657,8 +659,8 @@ static void __kprobes emulate_sat(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rm = insn & 0xf;
+	int rd = RD_BITS(insn);
+	int rm = RM_BITS(insn);
 	long rmv = regs->uregs[rm];
 
 	/* Writes Q flag */
@@ -669,9 +671,9 @@ static void __kprobes emulate_sel(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_2arg_fn_t *i_fn = (insn_2arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
-	int rm = insn & 0xf;
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
+	int rm = RM_BITS(insn);
 	long rnv = regs->uregs[rn];
 	long rmv = regs->uregs[rm];
 
@@ -690,7 +692,7 @@ static void __kprobes emulate_rd12(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_0arg_fn_t *i_fn = (insn_0arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
+	int rd = RD_BITS(insn);
 
 	regs->uregs[rd] = insnslot_0arg_rflags(regs->ARM_cpsr, i_fn);
 }
@@ -699,7 +701,7 @@ static void __kprobes emulate_ird12(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int ird = (insn >> 12) & 0xf;
+	int ird = RD_BITS(insn);
 
 	insnslot_1arg_rflags(regs->uregs[ird], regs->ARM_cpsr, i_fn);
 }
@@ -708,7 +710,7 @@ static void __kprobes emulate_rn16(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rn = (insn >> 16) & 0xf;
+	int rn = RN_BITS(insn);
 	long rnv = regs->uregs[rn];
 
 	insnslot_1arg_rflags(rnv, regs->ARM_cpsr, i_fn);
@@ -718,8 +720,8 @@ static void __kprobes emulate_rd12rm0(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rm = insn & 0xf;
+	int rd = RD_BITS(insn);
+	int rm = RM_BITS(insn);
 	long rmv = regs->uregs[rm];
 
 	regs->uregs[rd] = insnslot_1arg_rflags(rmv, regs->ARM_cpsr, i_fn);
@@ -730,9 +732,9 @@ emulate_rd12rn16rm0_rwflags(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_2arg_fn_t *i_fn = (insn_2arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
-	int rm = insn & 0xf;
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
+	int rm = RM_BITS(insn);
 	long rnv = regs->uregs[rn];
 	long rmv = regs->uregs[rm];
 
@@ -745,10 +747,10 @@ emulate_rd16rn12rs8rm0_rwflags(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_3arg_fn_t *i_fn = (insn_3arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 16) & 0xf;
-	int rn = (insn >> 12) & 0xf;
+	int rd = RN_BITS(insn);		/* intentionally swapped! */
+	int rn = RD_BITS(insn);		/* intentionally swapped! */
 	int rs = (insn >> 8) & 0xf;
-	int rm = insn & 0xf;
+	int rm = RM_BITS(insn);
 	long rnv = regs->uregs[rn];
 	long rsv = regs->uregs[rs];
 	long rmv = regs->uregs[rm];
@@ -762,9 +764,9 @@ emulate_rd16rs8rm0_rwflags(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_2arg_fn_t *i_fn = (insn_2arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 16) & 0xf;
+	int rd = RN_BITS(insn);
 	int rs = (insn >> 8) & 0xf;
-	int rm = insn & 0xf;
+	int rm = RM_BITS(insn);
 	long rsv = regs->uregs[rs];
 	long rmv = regs->uregs[rm];
 
@@ -778,10 +780,10 @@ emulate_rdhi16rdlo12rs8rm0_rwflags(struct kprobe *p, struct pt_regs *regs)
 	insn_llret_4arg_fn_t *i_fn = (insn_llret_4arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
 	union reg_pair fnr;
-	int rdhi = (insn >> 16) & 0xf;
-	int rdlo = (insn >> 12) & 0xf;
+	int rdhi = RN_BITS(insn);
+	int rdlo = RD_BITS(insn);
 	int rs   = (insn >> 8) & 0xf;
-	int rm   = insn & 0xf;
+	int rm   = RM_BITS(insn);
 	long rsv = regs->uregs[rs];
 	long rmv = regs->uregs[rm];
 
@@ -797,8 +799,8 @@ emulate_alu_imm_rflags(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
 	long rnv = (rn == 15) ? (long)p->addr + 8 : regs->uregs[rn];
 
 	regs->uregs[rd] = insnslot_1arg_rflags(rnv, regs->ARM_cpsr, i_fn);
@@ -809,8 +811,8 @@ emulate_alu_imm_rwflags(struct kprobe *p, struct pt_regs *regs)
 {
 	insn_1arg_fn_t *i_fn = (insn_1arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);
 	long rnv = (rn == 15) ? (long)p->addr + 8 : regs->uregs[rn];
 
 	regs->uregs[rd] = insnslot_1arg_rwflags(rnv, &regs->ARM_cpsr, i_fn);
@@ -822,10 +824,10 @@ emulate_alu_rflags(struct kprobe *p, struct pt_regs *regs)
 	insn_3arg_fn_t *i_fn = (insn_3arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
 	long ppc = (long)p->addr + 8;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;	/* rn/rnv/rs/rsv may be */
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);	/* rn/rnv/rs/rsv may be */
 	int rs = (insn >> 8) & 0xf;	/* invalid, don't care. */
-	int rm = insn & 0xf;
+	int rm = RM_BITS(insn);
 	long rnv = (rn == 15) ? ppc : regs->uregs[rn];
 	long rmv = (rm == 15) ? ppc : regs->uregs[rm];
 	long rsv = regs->uregs[rs];
@@ -840,10 +842,10 @@ emulate_alu_rwflags(struct kprobe *p, struct pt_regs *regs)
 	insn_3arg_fn_t *i_fn = (insn_3arg_fn_t *)&p->ainsn.insn[0];
 	kprobe_opcode_t insn = p->opcode;
 	long ppc = (long)p->addr + 8;
-	int rd = (insn >> 12) & 0xf;
-	int rn = (insn >> 16) & 0xf;	/* rn/rnv/rs/rsv may be */
+	int rd = RD_BITS(insn);
+	int rn = RN_BITS(insn);	/* rn/rnv/rs/rsv may be */
 	int rs = (insn >> 8) & 0xf;	/* invalid, don't care. */
-	int rm = insn & 0xf;
+	int rm = RM_BITS(insn);
 	long rnv = (rn == 15) ? ppc : regs->uregs[rn];
 	long rmv = (rm == 15) ? ppc : regs->uregs[rm];
 	long rsv = regs->uregs[rs];
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 6f98c35..77ebbd3 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -22,6 +22,7 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 
+#include <asm/arm-isa.h>
 #include <asm/unaligned.h>
 
 #include "fault.h"
@@ -36,39 +37,9 @@
  * *** NOTE ***
  * This code is not portable to processors with late data abort handling.
  */
-#define CODING_BITS(i)	(i & 0x0e000000)
-
-#define LDST_I_BIT(i)	(i & (1 << 26))		/* Immediate constant	*/
-#define LDST_P_BIT(i)	(i & (1 << 24))		/* Preindex		*/
-#define LDST_U_BIT(i)	(i & (1 << 23))		/* Add offset		*/
-#define LDST_W_BIT(i)	(i & (1 << 21))		/* Writeback		*/
-#define LDST_L_BIT(i)	(i & (1 << 20))		/* Load			*/
-
-#define LDST_P_EQ_U(i)	((((i) ^ ((i) >> 1)) & (1 << 23)) == 0)
-
-#define LDSTHD_I_BIT(i)	(i & (1 << 22))		/* double/half-word immed */
-#define LDM_S_BIT(i)	(i & (1 << 22))		/* write CPSR from SPSR	*/
-
-#define RN_BITS(i)	((i >> 16) & 15)	/* Rn			*/
-#define RD_BITS(i)	((i >> 12) & 15)	/* Rd			*/
-#define RM_BITS(i)	(i & 15)		/* Rm			*/
-
-#define REGMASK_BITS(i)	(i & 0xffff)
-#define OFFSET_BITS(i)	(i & 0x0fff)
-
-#define IS_SHIFT(i)	(i & 0x0ff0)
-#define SHIFT_BITS(i)	((i >> 7) & 0x1f)
-#define SHIFT_TYPE(i)	(i & 0x60)
-#define SHIFT_LSL	0x00
-#define SHIFT_LSR	0x20
-#define SHIFT_ASR	0x40
-#define SHIFT_RORRRX	0x60
-
 #define BAD_INSTR 	0xdeadc0de
 
 /* Thumb-2 32 bit format per ARMv7 DDI0406A A6.3, either f800h,e800h,f800h */
-#define IS_T32(hi16) \
-	(((hi16) & 0xe000) == 0xe000 && ((hi16) & 0x1800))
 
 static unsigned long ai_user;
 static unsigned long ai_sys;
@@ -462,7 +433,7 @@ do_alignment_ldmstm(unsigned long addr, unsigned long instr, struct pt_regs *reg
 	ai_multi += 1;
 
 	/* count the number of registers in the mask to be transferred */
-	nr_regs = hweight16(REGMASK_BITS(instr)) * 4;
+	nr_regs = hweight16(LDM_REGMASK(instr)) * 4;
 
 	rn = RN_BITS(instr);
 	newaddr = eaddr = regs->uregs[rn];
@@ -497,7 +468,7 @@ do_alignment_ldmstm(unsigned long addr, unsigned long instr, struct pt_regs *reg
 #endif
 
 	if (user_mode(regs)) {
-		for (regbits = REGMASK_BITS(instr), rd = 0; regbits;
+		for (regbits = LDM_REGMASK(instr), rd = 0; regbits;
 		     regbits >>= 1, rd += 1)
 			if (regbits & 1) {
 				if (LDST_L_BIT(instr)) {
@@ -509,7 +480,7 @@ do_alignment_ldmstm(unsigned long addr, unsigned long instr, struct pt_regs *reg
 				eaddr += 4;
 			}
 	} else {
-		for (regbits = REGMASK_BITS(instr), rd = 0; regbits;
+		for (regbits = LDM_REGMASK(instr), rd = 0; regbits;
 		     regbits >>= 1, rd += 1)
 			if (regbits & 1) {
 				if (LDST_L_BIT(instr)) {
@@ -524,7 +495,7 @@ do_alignment_ldmstm(unsigned long addr, unsigned long instr, struct pt_regs *reg
 
 	if (LDST_W_BIT(instr))
 		regs->uregs[rn] = newaddr;
-	if (!LDST_L_BIT(instr) || !(REGMASK_BITS(instr) & (1 << 15)))
+	if (!LDST_L_BIT(instr) || !(LDM_REGMASK(instr) & (1 << 15)))
 		regs->ARM_pc -= correction;
 	return TYPE_DONE;
 
