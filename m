From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:23 +0100
Subject: [PATCH 36/51] ARM: kprobes: Add common decoding function for LDM and
	STM
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-37-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The encoding of these instructions is substantially the same for both
ARM and Thumb, so we can have common decoding and simulation functions.

This patch moves the simulation functions from kprobes-arm.c to
kprobes-common.c. It also adds a new simulation function
(simulate_ldm1_pc) for the case where we load into PC because this may
need to interwork.

The instruction decoding is done by a custom function
(kprobe_decode_ldmstm) rather than just relying on decoding table
entries because we will later be adding optimisation code.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h        |    3 ++
 arch/arm/kernel/kprobes-arm.c    |   58 ++++---------------------------
 arch/arm/kernel/kprobes-common.c |   70 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 51 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 5d6bf0d..c442852 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -136,6 +136,9 @@ static inline void __kprobes load_write_pc(long pcv, struct pt_regs *regs)
 void __kprobes kprobe_simulate_nop(struct kprobe *p, struct pt_regs *regs);
 void __kprobes kprobe_emulate_none(struct kprobe *p, struct pt_regs *regs);
 
+enum kprobe_insn __kprobes
+kprobe_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi);
+
 /*
  * Test if load/store instructions writeback the address register.
  * if P (bit 24) == 0 or W (bit 21) == 1
diff --git a/arch/arm/kernel/kprobes-arm.c b/arch/arm/kernel/kprobes-arm.c
index a1143e8..c6f2c69 100644
--- a/arch/arm/kernel/kprobes-arm.c
+++ b/arch/arm/kernel/kprobes-arm.c
@@ -437,54 +437,6 @@ static void __kprobes simulate_mrs(struct kprobe *p, struct pt_regs *regs)
 	regs->uregs[rd] = regs->ARM_cpsr & mask;
 }
 
-static void __kprobes simulate_ldm1stm1(struct kprobe *p, struct pt_regs *regs)
-{
-	kprobe_opcode_t insn = p->opcode;
-	int rn = (insn >> 16) & 0xf;
-	int lbit = insn & (1 << 20);
-	int wbit = insn & (1 << 21);
-	int ubit = insn & (1 << 23);
-	int pbit = insn & (1 << 24);
-	long *addr = (long *)regs->uregs[rn];
-	int reg_bit_vector;
-	int reg_count;
-
-	reg_count = 0;
-	reg_bit_vector = insn & 0xffff;
-	while (reg_bit_vector) {
-		reg_bit_vector &= (reg_bit_vector - 1);
-		++reg_count;
-	}
-
-	if (!ubit)
-		addr -= reg_count;
-	addr += (!pbit == !ubit);
-
-	reg_bit_vector = insn & 0xffff;
-	while (reg_bit_vector) {
-		int reg = __ffs(reg_bit_vector);
-		reg_bit_vector &= (reg_bit_vector - 1);
-		if (lbit)
-			regs->uregs[reg] = *addr++;
-		else
-			*addr++ = regs->uregs[reg];
-	}
-
-	if (wbit) {
-		if (!ubit)
-			addr -= reg_count;
-		addr -= (!pbit == !ubit);
-		regs->uregs[rn] = (long)addr;
-	}
-}
-
-static void __kprobes simulate_stm1_pc(struct kprobe *p, struct pt_regs *regs)
-{
-	regs->ARM_pc = (long)p->addr + str_pc_offset;
-	simulate_ldm1stm1(p, regs);
-	regs->ARM_pc = (long)p->addr + 4;
-}
-
 static void __kprobes simulate_mov_ipsp(struct kprobe *p, struct pt_regs *regs)
 {
 	regs->uregs[12] = regs->uregs[13];
@@ -1463,9 +1415,13 @@ space_cccc_100x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	/* LDM(1) : cccc 100x x0x1 xxxx xxxx xxxx xxxx xxxx */
 	/* STM(1) : cccc 100x x0x0 xxxx xxxx xxxx xxxx xxxx */
-	asi->insn_handler = ((insn & 0x108000) == 0x008000) ? /* STM & R15 */
-				simulate_stm1_pc : simulate_ldm1stm1;
-	return INSN_GOOD_NO_SLOT;
+
+	/*
+	 * Make the instruction unconditional because the new emulation
+	 * functions don't bother to setup the PSR context.
+	 */
+	insn = (insn | 0xe0000000) & ~0x10000000;
+	return kprobe_decode_ldmstm(insn, asi);
 }
 
 static enum kprobe_insn __kprobes
diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index 41e8218..9ac1427 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -166,6 +166,76 @@ void __kprobes kprobe_emulate_none(struct kprobe *p, struct pt_regs *regs)
 	p->ainsn.insn_fn();
 }
 
+static void __kprobes simulate_ldm1stm1(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_opcode_t insn = p->opcode;
+	int rn = (insn >> 16) & 0xf;
+	int lbit = insn & (1 << 20);
+	int wbit = insn & (1 << 21);
+	int ubit = insn & (1 << 23);
+	int pbit = insn & (1 << 24);
+	long *addr = (long *)regs->uregs[rn];
+	int reg_bit_vector;
+	int reg_count;
+
+	reg_count = 0;
+	reg_bit_vector = insn & 0xffff;
+	while (reg_bit_vector) {
+		reg_bit_vector &= (reg_bit_vector - 1);
+		++reg_count;
+	}
+
+	if (!ubit)
+		addr -= reg_count;
+	addr += (!pbit == !ubit);
+
+	reg_bit_vector = insn & 0xffff;
+	while (reg_bit_vector) {
+		int reg = __ffs(reg_bit_vector);
+		reg_bit_vector &= (reg_bit_vector - 1);
+		if (lbit)
+			regs->uregs[reg] = *addr++;
+		else
+			*addr++ = regs->uregs[reg];
+	}
+
+	if (wbit) {
+		if (!ubit)
+			addr -= reg_count;
+		addr -= (!pbit == !ubit);
+		regs->uregs[rn] = (long)addr;
+	}
+}
+
+static void __kprobes simulate_stm1_pc(struct kprobe *p, struct pt_regs *regs)
+{
+	regs->ARM_pc = (long)p->addr + str_pc_offset;
+	simulate_ldm1stm1(p, regs);
+	regs->ARM_pc = (long)p->addr + 4;
+}
+
+static void __kprobes simulate_ldm1_pc(struct kprobe *p, struct pt_regs *regs)
+{
+	simulate_ldm1stm1(p, regs);
+	load_write_pc(regs->ARM_pc, regs);
+}
+
+enum kprobe_insn __kprobes
+kprobe_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
+{
+	kprobe_insn_handler_t *handler = 0;
+	unsigned reglist = insn & 0xffff;
+	int is_ldm = insn & 0x100000;
+
+	if (reglist & 0x8000)
+		handler = is_ldm ? simulate_ldm1_pc : simulate_stm1_pc;
+	else
+		handler = simulate_ldm1stm1;
+	asi->insn_handler = handler;
+	return INSN_GOOD_NO_SLOT;
+}
+
+
 /*
  * Prepare an instruction slot to receive an instruction for emulating.
  * This is done by placing a subroutine return after the location where the
-- 
1.7.2.5
