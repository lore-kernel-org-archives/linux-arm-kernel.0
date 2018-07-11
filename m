From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:31:47 +0100
Subject: [PATCH net-next v2 04/14] ARM: net: bpf: remove is_on_stack() and
 sstk/dstk
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBTP-0001Im-3S@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The decision about whether a BPF register is on the stack or in a CPU
register is detected at the top BPF insn processing level, and then
percolated throughout the remainder of the code.  Since we now use
negative register values to represent stacked registers, we can detect
where a BPF register is stored without restoring to carrying this
additional metadata through all code paths.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 336 ++++++++++++++++++++++------------------------
 1 file changed, 160 insertions(+), 176 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 69bf7ab18bf9..e81401aca2df 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -459,27 +459,18 @@ static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
 		emit(ARM_MOV_R(ARM_R0, tmp[1]), ctx);
 }
 
-/* Checks whether BPF register is on scratch stack space or not. */
-static inline bool is_on_stack(u8 bpf_reg)
+/* Is the translated BPF register on stack? */
+static bool is_stacked(s8 reg)
 {
-	static u8 stack_regs[] = {BPF_REG_AX, BPF_REG_3, BPF_REG_4, BPF_REG_5,
-				BPF_REG_7, BPF_REG_8, BPF_REG_9, TCALL_CNT,
-				BPF_REG_2, BPF_REG_FP};
-	int i, reg_len = sizeof(stack_regs);
-
-	for (i = 0 ; i < reg_len ; i++) {
-		if (bpf_reg == stack_regs[i])
-			return true;
-	}
-	return false;
+	return reg < 0;
 }
 
 static inline void emit_a32_mov_i(const s8 dst, const u32 val,
-				  bool dstk, struct jit_ctx *ctx)
+				  struct jit_ctx *ctx)
 {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 
-	if (dstk) {
+	if (is_stacked(dst)) {
 		emit_mov_i(tmp[1], val, ctx);
 		emit(ARM_STR_I(tmp[1], ARM_SP, STACK_VAR(dst)), ctx);
 	} else {
@@ -489,14 +480,13 @@ static inline void emit_a32_mov_i(const s8 dst, const u32 val,
 
 /* Sign extended move */
 static inline void emit_a32_mov_i64(const bool is64, const s8 dst[],
-				  const u32 val, bool dstk,
-				  struct jit_ctx *ctx) {
+				  const u32 val, struct jit_ctx *ctx) {
 	u32 hi = 0;
 
 	if (is64 && (val & (1<<31)))
 		hi = (u32)~0;
-	emit_a32_mov_i(dst_lo, val, dstk, ctx);
-	emit_a32_mov_i(dst_hi, hi, dstk, ctx);
+	emit_a32_mov_i(dst_lo, val, ctx);
+	emit_a32_mov_i(dst_hi, hi, ctx);
 }
 
 static inline void emit_a32_add_r(const u8 dst, const u8 src,
@@ -579,17 +569,16 @@ static inline void emit_alu_r(const u8 dst, const u8 src, const bool is64,
  * dst = dst (op) src
  */
 static inline void emit_a32_alu_r(const s8 dst, const s8 src,
-				  bool dstk, bool sstk,
 				  struct jit_ctx *ctx, const bool is64,
 				  const bool hi, const u8 op) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rn = sstk ? tmp[1] : src;
+	s8 rn = is_stacked(src) ? tmp[1] : src;
 
-	if (sstk)
+	if (is_stacked(src))
 		emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src)), ctx);
 
 	/* ALU operation */
-	if (dstk) {
+	if (is_stacked(dst)) {
 		emit(ARM_LDR_I(tmp[0], ARM_SP, STACK_VAR(dst)), ctx);
 		emit_alu_r(tmp[0], rn, is64, hi, op, ctx);
 		emit(ARM_STR_I(tmp[0], ARM_SP, STACK_VAR(dst)), ctx);
@@ -600,26 +589,24 @@ static inline void emit_a32_alu_r(const s8 dst, const s8 src,
 
 /* ALU operation (64 bit) */
 static inline void emit_a32_alu_r64(const bool is64, const s8 dst[],
-				  const s8 src[], bool dstk,
-				  bool sstk, struct jit_ctx *ctx,
+				  const s8 src[], struct jit_ctx *ctx,
 				  const u8 op) {
-	emit_a32_alu_r(dst_lo, src_lo, dstk, sstk, ctx, is64, false, op);
+	emit_a32_alu_r(dst_lo, src_lo, ctx, is64, false, op);
 	if (is64)
-		emit_a32_alu_r(dst_hi, src_hi, dstk, sstk, ctx, is64, true, op);
+		emit_a32_alu_r(dst_hi, src_hi, ctx, is64, true, op);
 	else
-		emit_a32_mov_i(dst_hi, 0, dstk, ctx);
+		emit_a32_mov_i(dst_hi, 0, ctx);
 }
 
 /* dst = imm (4 bytes)*/
 static inline void emit_a32_mov_r(const s8 dst, const s8 src,
-				  bool dstk, bool sstk,
 				  struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rt = sstk ? tmp[0] : src;
+	s8 rt = is_stacked(src) ? tmp[0] : src;
 
-	if (sstk)
+	if (is_stacked(src))
 		emit(ARM_LDR_I(tmp[0], ARM_SP, STACK_VAR(src)), ctx);
-	if (dstk)
+	if (is_stacked(dst))
 		emit(ARM_STR_I(rt, ARM_SP, STACK_VAR(dst)), ctx);
 	else
 		emit(ARM_MOV_R(dst, rt), ctx);
@@ -627,25 +614,25 @@ static inline void emit_a32_mov_r(const s8 dst, const s8 src,
 
 /* dst = src */
 static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
-				  const s8 src[], bool dstk,
-				  bool sstk, struct jit_ctx *ctx) {
-	emit_a32_mov_r(dst_lo, src_lo, dstk, sstk, ctx);
+				  const s8 src[],
+				  struct jit_ctx *ctx) {
+	emit_a32_mov_r(dst_lo, src_lo, ctx);
 	if (is64) {
 		/* complete 8 byte move */
-		emit_a32_mov_r(dst_hi, src_hi, dstk, sstk, ctx);
+		emit_a32_mov_r(dst_hi, src_hi, ctx);
 	} else {
 		/* Zero out high 4 bytes */
-		emit_a32_mov_i(dst_hi, 0, dstk, ctx);
+		emit_a32_mov_i(dst_hi, 0, ctx);
 	}
 }
 
 /* Shift operations */
-static inline void emit_a32_alu_i(const s8 dst, const u32 val, bool dstk,
+static inline void emit_a32_alu_i(const s8 dst, const u32 val,
 				struct jit_ctx *ctx, const u8 op) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rd = dstk ? tmp[0] : dst;
+	s8 rd = is_stacked(dst) ? tmp[0] : dst;
 
-	if (dstk)
+	if (is_stacked(dst))
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst)), ctx);
 
 	/* Do shift operation */
@@ -661,19 +648,19 @@ static inline void emit_a32_alu_i(const s8 dst, const u32 val, bool dstk,
 		break;
 	}
 
-	if (dstk)
+	if (is_stacked(dst))
 		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst)), ctx);
 }
 
 /* dst = ~dst (64 bit) */
-static inline void emit_a32_neg64(const s8 dst[], bool dstk,
+static inline void emit_a32_neg64(const s8 dst[],
 				struct jit_ctx *ctx){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rd = dstk ? tmp[1] : dst[1];
-	s8 rm = dstk ? tmp[0] : dst[0];
+	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst[1];
+	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst[0];
 
 	/* Setup Operand */
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
@@ -682,26 +669,26 @@ static inline void emit_a32_neg64(const s8 dst[], bool dstk,
 	emit(ARM_RSBS_I(rd, rd, 0), ctx);
 	emit(ARM_RSC_I(rm, rm, 0), ctx);
 
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
 }
 
 /* dst = dst << src */
-static inline void emit_a32_lsh_r64(const s8 dst[], const s8 src[], bool dstk,
-				    bool sstk, struct jit_ctx *ctx) {
+static inline void emit_a32_lsh_r64(const s8 dst[], const s8 src[],
+				    struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 
 	/* Setup Operands */
-	s8 rt = sstk ? tmp2[1] : src_lo;
-	s8 rd = dstk ? tmp[1] : dst_lo;
-	s8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rt = is_stacked(src_lo) ? tmp2[1] : src_lo;
+	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
+	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
 
-	if (sstk)
+	if (is_stacked(src_lo))
 		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
@@ -714,7 +701,7 @@ static inline void emit_a32_lsh_r64(const s8 dst[], const s8 src[], bool dstk,
 	emit(ARM_ORR_SR(ARM_IP, ARM_LR, rd, SRTYPE_LSR, tmp2[0]), ctx);
 	emit(ARM_MOV_SR(ARM_LR, rd, SRTYPE_ASL, rt), ctx);
 
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_STR_I(ARM_LR, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_STR_I(ARM_IP, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	} else {
@@ -724,18 +711,18 @@ static inline void emit_a32_lsh_r64(const s8 dst[], const s8 src[], bool dstk,
 }
 
 /* dst = dst >> src (signed)*/
-static inline void emit_a32_arsh_r64(const s8 dst[], const s8 src[], bool dstk,
-				    bool sstk, struct jit_ctx *ctx) {
+static inline void emit_a32_arsh_r64(const s8 dst[], const s8 src[],
+				     struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup Operands */
-	s8 rt = sstk ? tmp2[1] : src_lo;
-	s8 rd = dstk ? tmp[1] : dst_lo;
-	s8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rt = is_stacked(src_lo) ? tmp2[1] : src_lo;
+	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
+	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
 
-	if (sstk)
+	if (is_stacked(src_lo))
 		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
@@ -748,7 +735,7 @@ static inline void emit_a32_arsh_r64(const s8 dst[], const s8 src[], bool dstk,
 	_emit(ARM_COND_MI, ARM_B(0), ctx);
 	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_ASR, tmp2[0]), ctx);
 	emit(ARM_MOV_SR(ARM_IP, rm, SRTYPE_ASR, rt), ctx);
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_STR_I(ARM_LR, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_STR_I(ARM_IP, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	} else {
@@ -758,18 +745,18 @@ static inline void emit_a32_arsh_r64(const s8 dst[], const s8 src[], bool dstk,
 }
 
 /* dst = dst >> src */
-static inline void emit_a32_rsh_r64(const s8 dst[], const s8 src[], bool dstk,
-				     bool sstk, struct jit_ctx *ctx) {
+static inline void emit_a32_rsh_r64(const s8 dst[], const s8 src[],
+				    struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup Operands */
-	s8 rt = sstk ? tmp2[1] : src_lo;
-	s8 rd = dstk ? tmp[1] : dst_lo;
-	s8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rt = is_stacked(src_lo) ? tmp2[1] : src_lo;
+	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
+	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
 
-	if (sstk)
+	if (is_stacked(src_lo))
 		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
@@ -781,7 +768,7 @@ static inline void emit_a32_rsh_r64(const s8 dst[], const s8 src[], bool dstk,
 	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_ASL, ARM_IP), ctx);
 	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_LSR, tmp2[0]), ctx);
 	emit(ARM_MOV_SR(ARM_IP, rm, SRTYPE_LSR, rt), ctx);
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_STR_I(ARM_LR, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_STR_I(ARM_IP, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	} else {
@@ -791,15 +778,15 @@ static inline void emit_a32_rsh_r64(const s8 dst[], const s8 src[], bool dstk,
 }
 
 /* dst = dst << val */
-static inline void emit_a32_lsh_i64(const s8 dst[], bool dstk,
-				     const u32 val, struct jit_ctx *ctx){
+static inline void emit_a32_lsh_i64(const s8 dst[],
+				    const u32 val, struct jit_ctx *ctx){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup operands */
-	s8 rd = dstk ? tmp[1] : dst_lo;
-	s8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
+	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
 
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
@@ -817,22 +804,22 @@ static inline void emit_a32_lsh_i64(const s8 dst[], bool dstk,
 		emit(ARM_EOR_R(rd, rd, rd), ctx);
 	}
 
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
 }
 
 /* dst = dst >> val */
-static inline void emit_a32_rsh_i64(const s8 dst[], bool dstk,
+static inline void emit_a32_rsh_i64(const s8 dst[],
 				    const u32 val, struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup operands */
-	s8 rd = dstk ? tmp[1] : dst_lo;
-	s8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
+	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
 
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
@@ -850,22 +837,22 @@ static inline void emit_a32_rsh_i64(const s8 dst[], bool dstk,
 		emit(ARM_MOV_I(rm, 0), ctx);
 	}
 
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
 }
 
 /* dst = dst >> val (signed) */
-static inline void emit_a32_arsh_i64(const s8 dst[], bool dstk,
+static inline void emit_a32_arsh_i64(const s8 dst[],
 				     const u32 val, struct jit_ctx *ctx){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	 /* Setup operands */
-	s8 rd = dstk ? tmp[1] : dst_lo;
-	s8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
+	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
 
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
@@ -883,27 +870,27 @@ static inline void emit_a32_arsh_i64(const s8 dst[], bool dstk,
 		emit(ARM_MOV_SI(rm, rm, SRTYPE_ASR, 31), ctx);
 	}
 
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
 }
 
-static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[], bool dstk,
-				    bool sstk, struct jit_ctx *ctx) {
+static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[],
+				    struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup operands for multiplication */
-	s8 rd = dstk ? tmp[1] : dst_lo;
-	s8 rm = dstk ? tmp[0] : dst_hi;
-	s8 rt = sstk ? tmp2[1] : src_lo;
-	s8 rn = sstk ? tmp2[0] : src_hi;
+	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
+	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
+	s8 rt = is_stacked(src_lo) ? tmp2[1] : src_lo;
+	s8 rn = is_stacked(src_lo) ? tmp2[0] : src_hi;
 
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	}
-	if (sstk) {
+	if (is_stacked(src_lo)) {
 		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
 		emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src_hi)), ctx);
 	}
@@ -915,7 +902,7 @@ static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[], bool dstk,
 
 	emit(ARM_UMULL(ARM_IP, rm, rd, rt), ctx);
 	emit(ARM_ADD_R(rm, ARM_LR, rm), ctx);
-	if (dstk) {
+	if (is_stacked(dst_lo)) {
 		emit(ARM_STR_I(ARM_IP, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
 	} else {
@@ -924,15 +911,15 @@ static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[], bool dstk,
 }
 
 /* *(size *)(dst + off) = src */
-static inline void emit_str_r(const s8 dst, const s8 src, bool dstk,
+static inline void emit_str_r(const s8 dst, const s8 src,
 			      const s32 off, struct jit_ctx *ctx, const u8 sz){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rd = dstk ? tmp[1] : dst;
+	s8 rd = is_stacked(dst) ? tmp[1] : dst;
 
-	if (dstk)
+	if (is_stacked(dst))
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst)), ctx);
 	if (off) {
-		emit_a32_mov_i(tmp[0], off, false, ctx);
+		emit_a32_mov_i(tmp[0], off, ctx);
 		emit(ARM_ADD_R(tmp[0], rd, tmp[0]), ctx);
 		rd = tmp[0];
 	}
@@ -953,10 +940,10 @@ static inline void emit_str_r(const s8 dst, const s8 src, bool dstk,
 }
 
 /* dst = *(size*)(src + off) */
-static inline void emit_ldx_r(const s8 dst[], const s8 src, bool dstk,
+static inline void emit_ldx_r(const s8 dst[], const s8 src,
 			      s32 off, struct jit_ctx *ctx, const u8 sz){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	const s8 *rd = dstk ? tmp : dst;
+	const s8 *rd = is_stacked(dst_lo) ? tmp : dst;
 	s8 rm = src;
 	s32 off_max;
 
@@ -966,7 +953,7 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src, bool dstk,
 		off_max = 0xfff;
 
 	if (off < 0 || off > off_max) {
-		emit_a32_mov_i(tmp[0], off, false, ctx);
+		emit_a32_mov_i(tmp[0], off, ctx);
 		emit(ARM_ADD_R(tmp[0], tmp[0], src), ctx);
 		rm = tmp[0];
 		off = 0;
@@ -978,17 +965,17 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src, bool dstk,
 	case BPF_B:
 		/* Load a Byte */
 		emit(ARM_LDRB_I(rd[1], rm, off), ctx);
-		emit_a32_mov_i(dst[0], 0, dstk, ctx);
+		emit_a32_mov_i(dst[0], 0, ctx);
 		break;
 	case BPF_H:
 		/* Load a HalfWord */
 		emit(ARM_LDRH_I(rd[1], rm, off), ctx);
-		emit_a32_mov_i(dst[0], 0, dstk, ctx);
+		emit_a32_mov_i(dst[0], 0, ctx);
 		break;
 	case BPF_W:
 		/* Load a Word */
 		emit(ARM_LDR_I(rd[1], rm, off), ctx);
-		emit_a32_mov_i(dst[0], 0, dstk, ctx);
+		emit_a32_mov_i(dst[0], 0, ctx);
 		break;
 	case BPF_DW:
 		/* Load a Double Word */
@@ -996,10 +983,10 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src, bool dstk,
 		emit(ARM_LDR_I(rd[0], rm, off + 4), ctx);
 		break;
 	}
-	if (dstk)
-		emit(ARM_STR_I(rd[1], ARM_SP, STACK_VAR(dst[1])), ctx);
-	if (dstk && sz == BPF_DW)
-		emit(ARM_STR_I(rd[0], ARM_SP, STACK_VAR(dst[0])), ctx);
+	if (is_stacked(dst_lo))
+		emit(ARM_STR_I(rd[1], ARM_SP, STACK_VAR(dst_lo)), ctx);
+	if (is_stacked(dst_lo) && sz == BPF_DW)
+		emit(ARM_STR_I(rd[0], ARM_SP, STACK_VAR(dst_hi)), ctx);
 }
 
 /* Arithmatic Operation */
@@ -1053,7 +1040,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 */
 	off = offsetof(struct bpf_array, map.max_entries);
 	/* array->map.max_entries */
-	emit_a32_mov_i(tmp[1], off, false, ctx);
+	emit_a32_mov_i(tmp[1], off, ctx);
 	emit(ARM_LDR_I(tmp2[1], ARM_SP, STACK_VAR(r2[1])), ctx);
 	emit(ARM_LDR_R(tmp[1], tmp2[1], tmp[1]), ctx);
 	/* index is 32-bit for arrays */
@@ -1083,7 +1070,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 *	goto out;
 	 */
 	off = offsetof(struct bpf_array, ptrs);
-	emit_a32_mov_i(tmp[1], off, false, ctx);
+	emit_a32_mov_i(tmp[1], off, ctx);
 	emit(ARM_LDR_I(tmp2[1], ARM_SP, STACK_VAR(r2[1])), ctx);
 	emit(ARM_ADD_R(tmp[1], tmp2[1], tmp[1]), ctx);
 	emit(ARM_LDR_I(tmp2[1], ARM_SP, STACK_VAR(r3[1])), ctx);
@@ -1094,7 +1081,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 
 	/* goto *(prog->bpf_func + prologue_size); */
 	off = offsetof(struct bpf_prog, bpf_func);
-	emit_a32_mov_i(tmp2[1], off, false, ctx);
+	emit_a32_mov_i(tmp2[1], off, ctx);
 	emit(ARM_LDR_R(tmp[1], tmp[1], tmp2[1]), ctx);
 	emit(ARM_ADD_I(tmp[1], tmp[1], ctx->prologue_bytes), ctx);
 	emit_bx_r(tmp[1], ctx);
@@ -1193,8 +1180,8 @@ static void build_prologue(struct jit_ctx *ctx)
 	emit(ARM_SUB_I(ARM_SP, ARM_SP, ctx->stack_size), ctx);
 
 	/* Set up BPF prog stack base register */
-	emit_a32_mov_r(fplo, ARM_IP, true, false, ctx);
-	emit_a32_mov_i(fphi, 0, true, ctx);
+	emit_a32_mov_r(fplo, ARM_IP, ctx);
+	emit_a32_mov_i(fphi, 0, ctx);
 
 	/* mov r4, 0 */
 	emit(ARM_MOV_I(r4, 0), ctx);
@@ -1243,8 +1230,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
 	const bool is64 = BPF_CLASS(code) == BPF_ALU64;
-	const bool dstk = is_on_stack(insn->dst_reg);
-	const bool sstk = is_on_stack(insn->src_reg);
 	s8 rd, rt, rm, rn;
 	s32 jmp_offset;
 
@@ -1268,11 +1253,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		switch (BPF_SRC(code)) {
 		case BPF_X:
-			emit_a32_mov_r64(is64, dst, src, dstk, sstk, ctx);
+			emit_a32_mov_r64(is64, dst, src, ctx);
 			break;
 		case BPF_K:
 			/* Sign-extend immediate value to destination reg */
-			emit_a32_mov_i64(is64, dst, imm, dstk, ctx);
+			emit_a32_mov_i64(is64, dst, imm, ctx);
 			break;
 		}
 		break;
@@ -1312,8 +1297,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_XOR | BPF_X:
 		switch (BPF_SRC(code)) {
 		case BPF_X:
-			emit_a32_alu_r64(is64, dst, src, dstk, sstk,
-					 ctx, BPF_OP(code));
+			emit_a32_alu_r64(is64, dst, src, ctx, BPF_OP(code));
 			break;
 		case BPF_K:
 			/* Move immediate value to the temporary register
@@ -1322,9 +1306,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			 * value into temporary reg and then it would be
 			 * safe to do the operation on it.
 			 */
-			emit_a32_mov_i64(is64, tmp2, imm, false, ctx);
-			emit_a32_alu_r64(is64, dst, tmp2, dstk, false,
-					 ctx, BPF_OP(code));
+			emit_a32_mov_i64(is64, tmp2, imm, ctx);
+			emit_a32_alu_r64(is64, dst, tmp2, ctx, BPF_OP(code));
 			break;
 		}
 		break;
@@ -1334,26 +1317,28 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_X:
-		rt = src_lo;
-		rd = dstk ? tmp2[1] : dst_lo;
-		if (dstk)
+		rd = is_stacked(dst_lo) ? tmp2[1] : dst_lo;
+		if (is_stacked(dst_lo))
 			emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
 		switch (BPF_SRC(code)) {
 		case BPF_X:
-			rt = sstk ? tmp2[0] : rt;
-			if (sstk)
+			rt = is_stacked(rt) ? tmp2[0] : src_lo;
+			if (is_stacked(src_lo))
 				emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)),
 				     ctx);
 			break;
 		case BPF_K:
 			rt = tmp2[0];
-			emit_a32_mov_i(rt, imm, false, ctx);
+			emit_a32_mov_i(rt, imm, ctx);
+			break;
+		default:
+			rt = src_lo;
 			break;
 		}
 		emit_udivmod(rd, rd, rt, ctx, BPF_OP(code));
-		if (dstk)
+		if (is_stacked(dst_lo))
 			emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit_a32_mov_i(dst_hi, 0, dstk, ctx);
+		emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
@@ -1367,54 +1352,54 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		if (unlikely(imm > 31))
 			return -EINVAL;
 		if (imm)
-			emit_a32_alu_i(dst_lo, imm, dstk, ctx, BPF_OP(code));
-		emit_a32_mov_i(dst_hi, 0, dstk, ctx);
+			emit_a32_alu_i(dst_lo, imm, ctx, BPF_OP(code));
+		emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	/* dst = dst << imm */
 	case BPF_ALU64 | BPF_LSH | BPF_K:
 		if (unlikely(imm > 63))
 			return -EINVAL;
-		emit_a32_lsh_i64(dst, dstk, imm, ctx);
+		emit_a32_lsh_i64(dst, imm, ctx);
 		break;
 	/* dst = dst >> imm */
 	case BPF_ALU64 | BPF_RSH | BPF_K:
 		if (unlikely(imm > 63))
 			return -EINVAL;
-		emit_a32_rsh_i64(dst, dstk, imm, ctx);
+		emit_a32_rsh_i64(dst, imm, ctx);
 		break;
 	/* dst = dst << src */
 	case BPF_ALU64 | BPF_LSH | BPF_X:
-		emit_a32_lsh_r64(dst, src, dstk, sstk, ctx);
+		emit_a32_lsh_r64(dst, src, ctx);
 		break;
 	/* dst = dst >> src */
 	case BPF_ALU64 | BPF_RSH | BPF_X:
-		emit_a32_rsh_r64(dst, src, dstk, sstk, ctx);
+		emit_a32_rsh_r64(dst, src, ctx);
 		break;
 	/* dst = dst >> src (signed) */
 	case BPF_ALU64 | BPF_ARSH | BPF_X:
-		emit_a32_arsh_r64(dst, src, dstk, sstk, ctx);
+		emit_a32_arsh_r64(dst, src, ctx);
 		break;
 	/* dst = dst >> imm (signed) */
 	case BPF_ALU64 | BPF_ARSH | BPF_K:
 		if (unlikely(imm > 63))
 			return -EINVAL;
-		emit_a32_arsh_i64(dst, dstk, imm, ctx);
+		emit_a32_arsh_i64(dst, imm, ctx);
 		break;
 	/* dst = ~dst */
 	case BPF_ALU | BPF_NEG:
-		emit_a32_alu_i(dst_lo, 0, dstk, ctx, BPF_OP(code));
-		emit_a32_mov_i(dst_hi, 0, dstk, ctx);
+		emit_a32_alu_i(dst_lo, 0, ctx, BPF_OP(code));
+		emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	/* dst = ~dst (64 bit) */
 	case BPF_ALU64 | BPF_NEG:
-		emit_a32_neg64(dst, dstk, ctx);
+		emit_a32_neg64(dst, ctx);
 		break;
 	/* dst = dst * src/imm */
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 		switch (BPF_SRC(code)) {
 		case BPF_X:
-			emit_a32_mul_r64(dst, src, dstk, sstk, ctx);
+			emit_a32_mul_r64(dst, src, ctx);
 			break;
 		case BPF_K:
 			/* Move immediate value to the temporary register
@@ -1423,8 +1408,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			 * reg then it would be safe to do the operation
 			 * on it.
 			 */
-			emit_a32_mov_i64(is64, tmp2, imm, false, ctx);
-			emit_a32_mul_r64(dst, tmp2, dstk, false, ctx);
+			emit_a32_mov_i64(is64, tmp2, imm, ctx);
+			emit_a32_mul_r64(dst, tmp2, ctx);
 			break;
 		}
 		break;
@@ -1432,9 +1417,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = htobe(dst) */
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
 	case BPF_ALU | BPF_END | BPF_FROM_BE:
-		rd = dstk ? tmp[0] : dst_hi;
-		rt = dstk ? tmp[1] : dst_lo;
-		if (dstk) {
+		rd = is_stacked(dst_lo) ? tmp[0] : dst_hi;
+		rt = is_stacked(dst_lo) ? tmp[1] : dst_lo;
+		if (is_stacked(dst_lo)) {
 			emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(dst_lo)), ctx);
 			emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_hi)), ctx);
 		}
@@ -1459,7 +1444,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		case 16:
 			/* zero-extend 16 bits into 64 bits */
 #if __LINUX_ARM_ARCH__ < 6
-			emit_a32_mov_i(tmp2[1], 0xffff, false, ctx);
+			emit_a32_mov_i(tmp2[1], 0xffff, ctx);
 			emit(ARM_AND_R(rt, rt, tmp2[1]), ctx);
 #else /* ARMv6+ */
 			emit(ARM_UXTH(rt, rt), ctx);
@@ -1475,7 +1460,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			break;
 		}
 exit:
-		if (dstk) {
+		if (is_stacked(dst_lo)) {
 			emit(ARM_STR_I(rt, ARM_SP, STACK_VAR(dst_lo)), ctx);
 			emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_hi)), ctx);
 		}
@@ -1487,8 +1472,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		u32 hi, lo = imm;
 
 		hi = insn1.imm;
-		emit_a32_mov_i(dst_lo, lo, dstk, ctx);
-		emit_a32_mov_i(dst_hi, hi, dstk, ctx);
+		emit_a32_mov_i(dst_lo, lo, ctx);
+		emit_a32_mov_i(dst_hi, hi, ctx);
 
 		return 1;
 	}
@@ -1497,10 +1482,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_B:
 	case BPF_LDX | BPF_MEM | BPF_DW:
-		rn = sstk ? tmp2[1] : src_lo;
-		if (sstk)
+		rn = is_stacked(src_lo) ? tmp2[1] : src_lo;
+		if (is_stacked(src_lo))
 			emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src_lo)), ctx);
-		emit_ldx_r(dst, rn, dstk, off, ctx, BPF_SIZE(code));
+		emit_ldx_r(dst, rn, off, ctx, BPF_SIZE(code));
 		break;
 	/* ST: *(size *)(dst + off) = imm */
 	case BPF_ST | BPF_MEM | BPF_W:
@@ -1510,16 +1495,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		switch (BPF_SIZE(code)) {
 		case BPF_DW:
 			/* Sign-extend immediate value into temp reg */
-			emit_a32_mov_i64(true, tmp2, imm, false, ctx);
-			emit_str_r(dst_lo, tmp2[1], dstk, off, ctx, BPF_W);
-			emit_str_r(dst_lo, tmp2[0], dstk, off+4, ctx, BPF_W);
+			emit_a32_mov_i64(true, tmp2, imm, ctx);
+			emit_str_r(dst_lo, tmp2[1], off, ctx, BPF_W);
+			emit_str_r(dst_lo, tmp2[0], off+4, ctx, BPF_W);
 			break;
 		case BPF_W:
 		case BPF_H:
 		case BPF_B:
-			emit_a32_mov_i(tmp2[1], imm, false, ctx);
-			emit_str_r(dst_lo, tmp2[1], dstk, off, ctx,
-				   BPF_SIZE(code));
+			emit_a32_mov_i(tmp2[1], imm, ctx);
+			emit_str_r(dst_lo, tmp2[1], off, ctx, BPF_SIZE(code));
 			break;
 		}
 		break;
@@ -1536,19 +1520,19 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	{
 		u8 sz = BPF_SIZE(code);
 
-		rn = sstk ? tmp2[1] : src_lo;
-		rm = sstk ? tmp2[0] : src_hi;
-		if (sstk) {
+		rn = is_stacked(src_lo) ? tmp2[1] : src_lo;
+		rm = is_stacked(src_lo) ? tmp2[0] : src_hi;
+		if (is_stacked(src_lo)) {
 			emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src_lo)), ctx);
 			emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(src_hi)), ctx);
 		}
 
 		/* Store the value */
 		if (BPF_SIZE(code) == BPF_DW) {
-			emit_str_r(dst_lo, rn, dstk, off, ctx, BPF_W);
-			emit_str_r(dst_lo, rm, dstk, off+4, ctx, BPF_W);
+			emit_str_r(dst_lo, rn, off, ctx, BPF_W);
+			emit_str_r(dst_lo, rm, off+4, ctx, BPF_W);
 		} else {
-			emit_str_r(dst_lo, rn, dstk, off, ctx, sz);
+			emit_str_r(dst_lo, rn, off, ctx, sz);
 		}
 		break;
 	}
@@ -1575,9 +1559,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_JMP | BPF_JSLT | BPF_X:
 	case BPF_JMP | BPF_JSLE | BPF_X:
 		/* Setup source registers */
-		rm = sstk ? tmp2[0] : src_hi;
-		rn = sstk ? tmp2[1] : src_lo;
-		if (sstk) {
+		rm = is_stacked(src_lo) ? tmp2[0] : src_hi;
+		rn = is_stacked(src_lo) ? tmp2[1] : src_lo;
+		if (is_stacked(src_lo)) {
 			emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src_lo)), ctx);
 			emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(src_hi)), ctx);
 		}
@@ -1609,12 +1593,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		rm = tmp2[0];
 		rn = tmp2[1];
 		/* Sign-extend immediate value */
-		emit_a32_mov_i64(true, tmp2, imm, false, ctx);
+		emit_a32_mov_i64(true, tmp2, imm, ctx);
 go_jmp:
 		/* Setup destination register */
-		rd = dstk ? tmp[0] : dst_hi;
-		rt = dstk ? tmp[1] : dst_lo;
-		if (dstk) {
+		rd = is_stacked(dst_lo) ? tmp[0] : dst_hi;
+		rt = is_stacked(dst_lo) ? tmp[1] : dst_lo;
+		if (is_stacked(dst_lo)) {
 			emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(dst_lo)), ctx);
 			emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_hi)), ctx);
 		}
@@ -1684,13 +1668,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		const s8 *r5 = bpf2a32[BPF_REG_5];
 		const u32 func = (u32)__bpf_call_base + (u32)imm;
 
-		emit_a32_mov_r64(true, r0, r1, false, false, ctx);
-		emit_a32_mov_r64(true, r1, r2, false, true, ctx);
+		emit_a32_mov_r64(true, r0, r1, ctx);
+		emit_a32_mov_r64(true, r1, r2, ctx);
 		emit_push_r64(r5, 0, ctx);
 		emit_push_r64(r4, 8, ctx);
 		emit_push_r64(r3, 16, ctx);
 
-		emit_a32_mov_i(tmp[1], func, false, ctx);
+		emit_a32_mov_i(tmp[1], func, ctx);
 		emit_blx_r(tmp[1], ctx);
 
 		emit(ARM_ADD_I(ARM_SP, ARM_SP, imm8m(24)), ctx); // callee clean
-- 
2.7.4
