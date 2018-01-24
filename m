From: m.slodczyk2@partner.samsung.com (Maciej Slodczyk)
Date: Wed, 24 Jan 2018 13:34:29 +0100
Subject: [PATCH 2/7] arm64: uprobes - fix checkpatch.pl issues
In-Reply-To: <1516797274-20320-1-git-send-email-m.slodczyk2@partner.samsung.com>
References: <1516797274-20320-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180124123452eucas1p1bce78beeb29c089cf1d85ba8db089186@eucas1p1.samsung.com>
Message-ID: <1516797274-20320-3-git-send-email-m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix checkpatch.pl issues in moved arm uprobes code.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 lib/probes/arm/actions-arm.c | 4 ++--
 lib/probes/arm/decode-arm.c  | 1 +
 lib/probes/arm/decode-arm.h  | 4 ++--
 lib/probes/arm/decode.c      | 6 ++++++
 lib/probes/arm/decode.h      | 7 +++++--
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/probes/arm/actions-arm.c b/lib/probes/arm/actions-arm.c
index a25795a..db6017d 100644
--- a/lib/probes/arm/actions-arm.c
+++ b/lib/probes/arm/actions-arm.c
@@ -165,10 +165,10 @@ uprobe_decode_ldmstm(probes_opcode_t insn,
 {
 	struct arch_uprobe *auprobe = container_of(asi, struct arch_uprobe,
 						   asi);
-	unsigned reglist = insn & 0xffff;
+	unsigned int reglist = insn & 0xffff;
 	int rn = (insn >> 16) & 0xf;
 	int lbit = insn & (1 << 20);
-	unsigned used = reglist | (1 << rn);
+	unsigned int used = reglist | (1 << rn);
 
 	if (rn == 15)
 		return INSN_REJECTED;
diff --git a/lib/probes/arm/decode-arm.c b/lib/probes/arm/decode-arm.c
index f72c33a..3aa2e58 100644
--- a/lib/probes/arm/decode-arm.c
+++ b/lib/probes/arm/decode-arm.c
@@ -101,6 +101,7 @@ void __kprobes simulate_mrs(probes_opcode_t insn,
 {
 	int rd = (insn >> 12) & 0xf;
 	unsigned long mask = 0xf8ff03df; /* Mask out execution state */
+
 	regs->uregs[rd] = regs->ARM_cpsr & mask;
 }
 
diff --git a/lib/probes/arm/decode-arm.h b/lib/probes/arm/decode-arm.h
index b3b80f6..ed34f03 100644
--- a/lib/probes/arm/decode-arm.h
+++ b/lib/probes/arm/decode-arm.h
@@ -66,8 +66,8 @@ void __kprobes simulate_mov_ipsp(probes_opcode_t opcode,
 
 extern const union decode_item probes_decode_arm_table[];
 
-enum probes_insn arm_probes_decode_insn(probes_opcode_t,
-		struct arch_probes_insn *, bool emulate,
+enum probes_insn arm_probes_decode_insn(probes_opcode_t opcode,
+		struct arch_probes_insn *api, bool emulate,
 		const union decode_action *actions,
 		const struct decode_checker *checkers[]);
 
diff --git a/lib/probes/arm/decode.c b/lib/probes/arm/decode.c
index 880ebe0..6840054 100644
--- a/lib/probes/arm/decode.c
+++ b/lib/probes/arm/decode.c
@@ -55,6 +55,7 @@ bool load_write_pc_interworks;
 void __init test_load_write_pc_interworking(void)
 {
 	int arch = cpu_architecture();
+
 	BUG_ON(arch == CPU_ARCH_UNKNOWN);
 	load_write_pc_interworks = arch >= CPU_ARCH_ARMv5T;
 }
@@ -69,6 +70,7 @@ bool alu_write_pc_interworks;
 void __init test_alu_write_pc_interworking(void)
 {
 	int arch = cpu_architecture();
+
 	BUG_ON(arch == CPU_ARCH_UNKNOWN);
 	alu_write_pc_interworks = arch >= CPU_ARCH_ARMv7;
 }
@@ -151,6 +153,7 @@ static unsigned long __kprobes __check_lt(unsigned long cpsr)
 static unsigned long __kprobes __check_gt(unsigned long cpsr)
 {
 	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+
 	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
 	return (~temp) & PSR_N_BIT;
 }
@@ -158,6 +161,7 @@ static unsigned long __kprobes __check_gt(unsigned long cpsr)
 static unsigned long __kprobes __check_le(unsigned long cpsr)
 {
 	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+
 	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
 	return temp & PSR_N_BIT;
 }
@@ -228,6 +232,7 @@ set_emulated_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
 #ifdef CONFIG_THUMB2_KERNEL
 	if (thumb) {
 		u16 *ip = (u16 *)asi->insn;
+
 		if (is_wide_instruction(insn))
 			*ip++ = __opcode_to_mem_thumb16(insn >> 16);
 		*ip++ = __opcode_to_mem_thumb16(insn);
@@ -465,6 +470,7 @@ probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
 
 		case DECODE_TYPE_TABLE: {
 			struct decode_table *d = (struct decode_table *)h;
+
 			next = (struct decode_header *)d->table.table;
 			break;
 		}
diff --git a/lib/probes/arm/decode.h b/lib/probes/arm/decode.h
index 548d622..43b02fd 100644
--- a/lib/probes/arm/decode.h
+++ b/lib/probes/arm/decode.h
@@ -59,6 +59,7 @@ static inline unsigned long it_advance(unsigned long cpsr)
 		/* We need to shift left ITSTATE<4:0> */
 		const unsigned long mask = 0x06001c00;  /* Mask ITSTATE<4:0> */
 		unsigned long it = cpsr & mask;
+
 		it <<= 1;
 		it |= it >> (27 - 10);  /* Carry ITSTATE<2> to correct place */
 		it &= mask;
@@ -71,6 +72,7 @@ static inline unsigned long it_advance(unsigned long cpsr)
 static inline void __kprobes bx_write_pc(long pcv, struct pt_regs *regs)
 {
 	long cpsr = regs->ARM_cpsr;
+
 	if (pcv & 0x1) {
 		cpsr |= PSR_T_BIT;
 		pcv &= ~0x1;
@@ -253,7 +255,8 @@ static inline void __kprobes alu_write_pc(long pcv, struct pt_regs *regs)
  * instruction will be modified to "AND R0, R2, R3, ASL R1" and then placed into
  * the kprobes instruction slot. This can then be called later by the handler
  * function emulate_rd12rn16rm0rs8_rwflags (a pointer to which is retrieved from
- * the indicated slot in the action array), in order to simulate the instruction.
+ * the indicated slot in the action array), in order to simulate the
+ * instruction.
  */
 
 enum decode_type {
@@ -282,7 +285,7 @@ enum decode_reg_type {
 	REG_TYPE_NOPCWB,   /* No PC if load/store write-back flag also set */
 
 	/* The following types are used when the encoding for PC indicates
-	 * another instruction form. This distiction only matters for test
+	 * another instruction form. This distinction only matters for test
 	 * case coverage checks.
 	 */
 	REG_TYPE_NOPCX,	   /* Register must not be PC */
-- 
2.7.4
