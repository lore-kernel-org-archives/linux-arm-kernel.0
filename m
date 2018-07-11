From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:31:57 +0100
Subject: [PATCH net-next v2 06/14] ARM: net: bpf: 64-bit accessor functions
 for BPF registers
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBTZ-0001J0-Aw@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a couple of 64-bit register accessors, and use them where
appropriate

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 235 ++++++++++++++++++++++++----------------------
 1 file changed, 122 insertions(+), 113 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 08fb4eb285a2..45a3599e94a4 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -478,6 +478,17 @@ static s8 arm_bpf_get_reg32(s8 reg, s8 tmp, struct jit_ctx *ctx)
 	return reg;
 }
 
+static const s8 *arm_bpf_get_reg64(const s8 *reg, const s8 *tmp,
+				   struct jit_ctx *ctx)
+{
+	if (is_stacked(reg[1])) {
+		emit(ARM_LDR_I(tmp[1], ARM_SP, STACK_VAR(reg[1])), ctx);
+		emit(ARM_LDR_I(tmp[0], ARM_SP, STACK_VAR(reg[0])), ctx);
+		reg = tmp;
+	}
+	return reg;
+}
+
 /* If a BPF register is on the stack (stk is true), save the register
  * back to the stack.  If the source register is not the same, then
  * move it into the correct register.
@@ -490,6 +501,20 @@ static void arm_bpf_put_reg32(s8 reg, s8 src, struct jit_ctx *ctx)
 		emit(ARM_MOV_R(reg, src), ctx);
 }
 
+static void arm_bpf_put_reg64(const s8 *reg, const s8 *src,
+			      struct jit_ctx *ctx)
+{
+	if (is_stacked(reg[1])) {
+		emit(ARM_STR_I(src[1], ARM_SP, STACK_VAR(reg[1])), ctx);
+		emit(ARM_STR_I(src[0], ARM_SP, STACK_VAR(reg[0])), ctx);
+	} else {
+		if (reg[1] != src[1])
+			emit(ARM_MOV_R(reg[1], src[1]), ctx);
+		if (reg[0] != src[0])
+			emit(ARM_MOV_R(reg[0], src[0]), ctx);
+	}
+}
+
 static inline void emit_a32_mov_i(const s8 dst, const u32 val,
 				  struct jit_ctx *ctx)
 {
@@ -669,18 +694,16 @@ static inline void emit_a32_alu_i(const s8 dst, const u32 val,
 static inline void emit_a32_neg64(const s8 dst[],
 				struct jit_ctx *ctx){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rd, rm;
+	const s8 *rd;
 
 	/* Setup Operand */
-	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+	rd = arm_bpf_get_reg64(dst, tmp, ctx);
 
 	/* Do Negate Operation */
-	emit(ARM_RSBS_I(rd, rd, 0), ctx);
-	emit(ARM_RSC_I(rm, rm, 0), ctx);
+	emit(ARM_RSBS_I(rd[1], rd[1], 0), ctx);
+	emit(ARM_RSC_I(rd[0], rd[0], 0), ctx);
 
-	arm_bpf_put_reg32(dst_lo, rd, ctx);
-	arm_bpf_put_reg32(dst_hi, rm, ctx);
+	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
 /* dst = dst << src */
@@ -688,20 +711,20 @@ static inline void emit_a32_lsh_r64(const s8 dst[], const s8 src[],
 				    struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	s8 rt, rd, rm;
+	const s8 *rd;
+	s8 rt;
 
 	/* Setup Operands */
 	rt = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
-	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+	rd = arm_bpf_get_reg64(dst, tmp, ctx);
 
 	/* Do LSH operation */
 	emit(ARM_SUB_I(ARM_IP, rt, 32), ctx);
 	emit(ARM_RSB_I(tmp2[0], rt, 32), ctx);
-	emit(ARM_MOV_SR(ARM_LR, rm, SRTYPE_ASL, rt), ctx);
-	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rd, SRTYPE_ASL, ARM_IP), ctx);
-	emit(ARM_ORR_SR(ARM_IP, ARM_LR, rd, SRTYPE_LSR, tmp2[0]), ctx);
-	emit(ARM_MOV_SR(ARM_LR, rd, SRTYPE_ASL, rt), ctx);
+	emit(ARM_MOV_SR(ARM_LR, rd[0], SRTYPE_ASL, rt), ctx);
+	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rd[1], SRTYPE_ASL, ARM_IP), ctx);
+	emit(ARM_ORR_SR(ARM_IP, ARM_LR, rd[1], SRTYPE_LSR, tmp2[0]), ctx);
+	emit(ARM_MOV_SR(ARM_LR, rd[1], SRTYPE_ASL, rt), ctx);
 
 	arm_bpf_put_reg32(dst_lo, ARM_LR, ctx);
 	arm_bpf_put_reg32(dst_hi, ARM_IP, ctx);
@@ -712,21 +735,21 @@ static inline void emit_a32_arsh_r64(const s8 dst[], const s8 src[],
 				     struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	s8 rt, rd, rm;
+	const s8 *rd;
+	s8 rt;
 
 	/* Setup Operands */
 	rt = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
-	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+	rd = arm_bpf_get_reg64(dst, tmp, ctx);
 
 	/* Do the ARSH operation */
 	emit(ARM_RSB_I(ARM_IP, rt, 32), ctx);
 	emit(ARM_SUBS_I(tmp2[0], rt, 32), ctx);
-	emit(ARM_MOV_SR(ARM_LR, rd, SRTYPE_LSR, rt), ctx);
-	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_ASL, ARM_IP), ctx);
+	emit(ARM_MOV_SR(ARM_LR, rd[1], SRTYPE_LSR, rt), ctx);
+	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rd[0], SRTYPE_ASL, ARM_IP), ctx);
 	_emit(ARM_COND_MI, ARM_B(0), ctx);
-	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_ASR, tmp2[0]), ctx);
-	emit(ARM_MOV_SR(ARM_IP, rm, SRTYPE_ASR, rt), ctx);
+	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rd[0], SRTYPE_ASR, tmp2[0]), ctx);
+	emit(ARM_MOV_SR(ARM_IP, rd[0], SRTYPE_ASR, rt), ctx);
 
 	arm_bpf_put_reg32(dst_lo, ARM_LR, ctx);
 	arm_bpf_put_reg32(dst_hi, ARM_IP, ctx);
@@ -737,20 +760,20 @@ static inline void emit_a32_rsh_r64(const s8 dst[], const s8 src[],
 				    struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	s8 rt, rd, rm;
+	const s8 *rd;
+	s8 rt;
 
 	/* Setup Operands */
 	rt = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
-	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+	rd = arm_bpf_get_reg64(dst, tmp, ctx);
 
 	/* Do RSH operation */
 	emit(ARM_RSB_I(ARM_IP, rt, 32), ctx);
 	emit(ARM_SUBS_I(tmp2[0], rt, 32), ctx);
-	emit(ARM_MOV_SR(ARM_LR, rd, SRTYPE_LSR, rt), ctx);
-	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_ASL, ARM_IP), ctx);
-	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_LSR, tmp2[0]), ctx);
-	emit(ARM_MOV_SR(ARM_IP, rm, SRTYPE_LSR, rt), ctx);
+	emit(ARM_MOV_SR(ARM_LR, rd[1], SRTYPE_LSR, rt), ctx);
+	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rd[0], SRTYPE_ASL, ARM_IP), ctx);
+	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rd[0], SRTYPE_LSR, tmp2[0]), ctx);
+	emit(ARM_MOV_SR(ARM_IP, rd[0], SRTYPE_LSR, rt), ctx);
 
 	arm_bpf_put_reg32(dst_lo, ARM_LR, ctx);
 	arm_bpf_put_reg32(dst_hi, ARM_IP, ctx);
@@ -761,27 +784,25 @@ static inline void emit_a32_lsh_i64(const s8 dst[],
 				    const u32 val, struct jit_ctx *ctx){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	s8 rd, rm;
+	const s8 *rd;
 
 	/* Setup operands */
-	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+	rd = arm_bpf_get_reg64(dst, tmp, ctx);
 
 	/* Do LSH operation */
 	if (val < 32) {
-		emit(ARM_MOV_SI(tmp2[0], rm, SRTYPE_ASL, val), ctx);
-		emit(ARM_ORR_SI(rm, tmp2[0], rd, SRTYPE_LSR, 32 - val), ctx);
-		emit(ARM_MOV_SI(rd, rd, SRTYPE_ASL, val), ctx);
+		emit(ARM_MOV_SI(tmp2[0], rd[0], SRTYPE_ASL, val), ctx);
+		emit(ARM_ORR_SI(rd[0], tmp2[0], rd[1], SRTYPE_LSR, 32 - val), ctx);
+		emit(ARM_MOV_SI(rd[1], rd[1], SRTYPE_ASL, val), ctx);
 	} else {
 		if (val == 32)
-			emit(ARM_MOV_R(rm, rd), ctx);
+			emit(ARM_MOV_R(rd[0], rd[1]), ctx);
 		else
-			emit(ARM_MOV_SI(rm, rd, SRTYPE_ASL, val - 32), ctx);
-		emit(ARM_EOR_R(rd, rd, rd), ctx);
+			emit(ARM_MOV_SI(rd[0], rd[1], SRTYPE_ASL, val - 32), ctx);
+		emit(ARM_EOR_R(rd[1], rd[1], rd[1]), ctx);
 	}
 
-	arm_bpf_put_reg32(dst_lo, rd, ctx);
-	arm_bpf_put_reg32(dst_hi, rm, ctx);
+	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
 /* dst = dst >> val */
@@ -789,27 +810,25 @@ static inline void emit_a32_rsh_i64(const s8 dst[],
 				    const u32 val, struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	s8 rd, rm;
+	const s8 *rd;
 
 	/* Setup operands */
-	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+	rd = arm_bpf_get_reg64(dst, tmp, ctx);
 
 	/* Do LSR operation */
 	if (val < 32) {
-		emit(ARM_MOV_SI(tmp2[1], rd, SRTYPE_LSR, val), ctx);
-		emit(ARM_ORR_SI(rd, tmp2[1], rm, SRTYPE_ASL, 32 - val), ctx);
-		emit(ARM_MOV_SI(rm, rm, SRTYPE_LSR, val), ctx);
+		emit(ARM_MOV_SI(tmp2[1], rd[1], SRTYPE_LSR, val), ctx);
+		emit(ARM_ORR_SI(rd[1], tmp2[1], rd[0], SRTYPE_ASL, 32 - val), ctx);
+		emit(ARM_MOV_SI(rd[0], rd[0], SRTYPE_LSR, val), ctx);
 	} else if (val == 32) {
-		emit(ARM_MOV_R(rd, rm), ctx);
-		emit(ARM_MOV_I(rm, 0), ctx);
+		emit(ARM_MOV_R(rd[1], rd[0]), ctx);
+		emit(ARM_MOV_I(rd[0], 0), ctx);
 	} else {
-		emit(ARM_MOV_SI(rd, rm, SRTYPE_LSR, val - 32), ctx);
-		emit(ARM_MOV_I(rm, 0), ctx);
+		emit(ARM_MOV_SI(rd[1], rd[0], SRTYPE_LSR, val - 32), ctx);
+		emit(ARM_MOV_I(rd[0], 0), ctx);
 	}
 
-	arm_bpf_put_reg32(dst_lo, rd, ctx);
-	arm_bpf_put_reg32(dst_hi, rm, ctx);
+	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
 /* dst = dst >> val (signed) */
@@ -817,51 +836,47 @@ static inline void emit_a32_arsh_i64(const s8 dst[],
 				     const u32 val, struct jit_ctx *ctx){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	s8 rd, rm;
+	const s8 *rd;
 
 	/* Setup operands */
-	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+	rd = arm_bpf_get_reg64(dst, tmp, ctx);
 
 	/* Do ARSH operation */
 	if (val < 32) {
-		emit(ARM_MOV_SI(tmp2[1], rd, SRTYPE_LSR, val), ctx);
-		emit(ARM_ORR_SI(rd, tmp2[1], rm, SRTYPE_ASL, 32 - val), ctx);
-		emit(ARM_MOV_SI(rm, rm, SRTYPE_ASR, val), ctx);
+		emit(ARM_MOV_SI(tmp2[1], rd[1], SRTYPE_LSR, val), ctx);
+		emit(ARM_ORR_SI(rd[1], tmp2[1], rd[0], SRTYPE_ASL, 32 - val), ctx);
+		emit(ARM_MOV_SI(rd[0], rd[0], SRTYPE_ASR, val), ctx);
 	} else if (val == 32) {
-		emit(ARM_MOV_R(rd, rm), ctx);
-		emit(ARM_MOV_SI(rm, rm, SRTYPE_ASR, 31), ctx);
+		emit(ARM_MOV_R(rd[1], rd[0]), ctx);
+		emit(ARM_MOV_SI(rd[0], rd[0], SRTYPE_ASR, 31), ctx);
 	} else {
-		emit(ARM_MOV_SI(rd, rm, SRTYPE_ASR, val - 32), ctx);
-		emit(ARM_MOV_SI(rm, rm, SRTYPE_ASR, 31), ctx);
+		emit(ARM_MOV_SI(rd[1], rd[0], SRTYPE_ASR, val - 32), ctx);
+		emit(ARM_MOV_SI(rd[0], rd[0], SRTYPE_ASR, 31), ctx);
 	}
 
-	arm_bpf_put_reg32(dst_lo, rd, ctx);
-	arm_bpf_put_reg32(dst_hi, rm, ctx);
+	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
 static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[],
 				    struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	s8 rd, rm, rt, rn;
+	const s8 *rd, *rt;
 
 	/* Setup operands for multiplication */
-	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
-	rt = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
-	rn = arm_bpf_get_reg32(src_hi, tmp2[0], ctx);
+	rd = arm_bpf_get_reg64(dst, tmp, ctx);
+	rt = arm_bpf_get_reg64(src, tmp2, ctx);
 
 	/* Do Multiplication */
-	emit(ARM_MUL(ARM_IP, rd, rn), ctx);
-	emit(ARM_MUL(ARM_LR, rm, rt), ctx);
+	emit(ARM_MUL(ARM_IP, rd[1], rt[0]), ctx);
+	emit(ARM_MUL(ARM_LR, rd[0], rt[1]), ctx);
 	emit(ARM_ADD_R(ARM_LR, ARM_IP, ARM_LR), ctx);
 
-	emit(ARM_UMULL(ARM_IP, rm, rd, rt), ctx);
-	emit(ARM_ADD_R(rm, ARM_LR, rm), ctx);
+	emit(ARM_UMULL(ARM_IP, rd[0], rd[1], rt[1]), ctx);
+	emit(ARM_ADD_R(rd[0], ARM_LR, rd[0]), ctx);
 
 	arm_bpf_put_reg32(dst_lo, ARM_IP, ctx);
-	arm_bpf_put_reg32(dst_hi, rm, ctx);
+	arm_bpf_put_reg32(dst_hi, rd[0], ctx);
 }
 
 /* *(size *)(dst + off) = src */
@@ -918,17 +933,17 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src,
 	case BPF_B:
 		/* Load a Byte */
 		emit(ARM_LDRB_I(rd[1], rm, off), ctx);
-		emit_a32_mov_i(dst[0], 0, ctx);
+		emit_a32_mov_i(rd[0], 0, ctx);
 		break;
 	case BPF_H:
 		/* Load a HalfWord */
 		emit(ARM_LDRH_I(rd[1], rm, off), ctx);
-		emit_a32_mov_i(dst[0], 0, ctx);
+		emit_a32_mov_i(rd[0], 0, ctx);
 		break;
 	case BPF_W:
 		/* Load a Word */
 		emit(ARM_LDR_I(rd[1], rm, off), ctx);
-		emit_a32_mov_i(dst[0], 0, ctx);
+		emit_a32_mov_i(rd[0], 0, ctx);
 		break;
 	case BPF_DW:
 		/* Load a Double Word */
@@ -936,9 +951,7 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src,
 		emit(ARM_LDR_I(rd[0], rm, off + 4), ctx);
 		break;
 	}
-	arm_bpf_put_reg32(dst[1], rd[1], ctx);
-	if (sz == BPF_DW)
-		arm_bpf_put_reg32(dst[0], rd[0], ctx);
+	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
 /* Arithmatic Operation */
@@ -982,11 +995,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	const s8 *tcc = bpf2a32[TCALL_CNT];
+	const s8 *tc;
 	const int idx0 = ctx->idx;
 #define cur_offset (ctx->idx - idx0)
 #define jmp_offset (out_offset - (cur_offset) - 2)
 	u32 off, lo, hi;
-	s8 r_array, r_index, r_tc_lo, r_tc_hi;
+	s8 r_array, r_index;
 
 	/* if (index >= array->map.max_entries)
 	 *	goto out;
@@ -1008,15 +1022,13 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 */
 	lo = (u32)MAX_TAIL_CALL_CNT;
 	hi = (u32)((u64)MAX_TAIL_CALL_CNT >> 32);
-	r_tc_lo = arm_bpf_get_reg32(tcc[1], tmp[1], ctx);
-	r_tc_hi = arm_bpf_get_reg32(tcc[0], tmp[0], ctx);
-	emit(ARM_CMP_I(r_tc_hi, hi), ctx);
-	_emit(ARM_COND_EQ, ARM_CMP_I(r_tc_lo, lo), ctx);
+	tc = arm_bpf_get_reg64(tcc, tmp, ctx);
+	emit(ARM_CMP_I(tc[0], hi), ctx);
+	_emit(ARM_COND_EQ, ARM_CMP_I(tc[1], lo), ctx);
 	_emit(ARM_COND_HI, ARM_B(jmp_offset), ctx);
-	emit(ARM_ADDS_I(r_tc_lo, r_tc_lo, 1), ctx);
-	emit(ARM_ADC_I(r_tc_hi, r_tc_hi, 0), ctx);
-	arm_bpf_put_reg32(tcc[1], r_tc_lo, ctx);
-	arm_bpf_put_reg32(tcc[0], r_tc_hi, ctx);
+	emit(ARM_ADDS_I(tc[1], tc[1], 1), ctx);
+	emit(ARM_ADC_I(tc[0], tc[0], 0), ctx);
+	arm_bpf_put_reg64(tcc, tmp, ctx);
 
 	/* prog = array->ptrs[index]
 	 * if (prog == NULL)
@@ -1183,7 +1195,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
 	const bool is64 = BPF_CLASS(code) == BPF_ALU64;
-	s8 rd, rt, rm, rn;
+	const s8 *rd, *rs;
+	s8 rd_lo, rt, rm, rn;
 	s32 jmp_offset;
 
 #define check_imm(bits, imm) do {				\
@@ -1270,7 +1283,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_X:
-		rd = arm_bpf_get_reg32(dst_lo, tmp2[1], ctx);
+		rd_lo = arm_bpf_get_reg32(dst_lo, tmp2[1], ctx);
 		switch (BPF_SRC(code)) {
 		case BPF_X:
 			rt = arm_bpf_get_reg32(src_lo, tmp2[0], ctx);
@@ -1283,8 +1296,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			rt = src_lo;
 			break;
 		}
-		emit_udivmod(rd, rd, rt, ctx, BPF_OP(code));
-		arm_bpf_put_reg32(dst_lo, rd, ctx);
+		emit_udivmod(rd_lo, rd_lo, rt, ctx, BPF_OP(code));
+		arm_bpf_put_reg32(dst_lo, rd_lo, ctx);
 		emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	case BPF_ALU64 | BPF_DIV | BPF_K:
@@ -1364,21 +1377,20 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = htobe(dst) */
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
 	case BPF_ALU | BPF_END | BPF_FROM_BE:
-		rt = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-		rd = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+		rd = arm_bpf_get_reg64(dst, tmp, ctx);
 		if (BPF_SRC(code) == BPF_FROM_LE)
 			goto emit_bswap_uxt;
 		switch (imm) {
 		case 16:
-			emit_rev16(rt, rt, ctx);
+			emit_rev16(rd[1], rd[1], ctx);
 			goto emit_bswap_uxt;
 		case 32:
-			emit_rev32(rt, rt, ctx);
+			emit_rev32(rd[1], rd[1], ctx);
 			goto emit_bswap_uxt;
 		case 64:
-			emit_rev32(ARM_LR, rt, ctx);
-			emit_rev32(rt, rd, ctx);
-			emit(ARM_MOV_R(rd, ARM_LR), ctx);
+			emit_rev32(ARM_LR, rd[1], ctx);
+			emit_rev32(rd[1], rd[0], ctx);
+			emit(ARM_MOV_R(rd[0], ARM_LR), ctx);
 			break;
 		}
 		goto exit;
@@ -1388,23 +1400,22 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			/* zero-extend 16 bits into 64 bits */
 #if __LINUX_ARM_ARCH__ < 6
 			emit_a32_mov_i(tmp2[1], 0xffff, ctx);
-			emit(ARM_AND_R(rt, rt, tmp2[1]), ctx);
+			emit(ARM_AND_R(rd[1], rd[1], tmp2[1]), ctx);
 #else /* ARMv6+ */
-			emit(ARM_UXTH(rt, rt), ctx);
+			emit(ARM_UXTH(rd[1], rd[1]), ctx);
 #endif
-			emit(ARM_EOR_R(rd, rd, rd), ctx);
+			emit(ARM_EOR_R(rd[0], rd[0], rd[0]), ctx);
 			break;
 		case 32:
 			/* zero-extend 32 bits into 64 bits */
-			emit(ARM_EOR_R(rd, rd, rd), ctx);
+			emit(ARM_EOR_R(rd[0], rd[0], rd[0]), ctx);
 			break;
 		case 64:
 			/* nop */
 			break;
 		}
 exit:
-		arm_bpf_put_reg32(dst_lo, rt, ctx);
-		arm_bpf_put_reg32(dst_hi, rd, ctx);
+		arm_bpf_put_reg64(dst, rd, ctx);
 		break;
 	/* dst = imm64 */
 	case BPF_LD | BPF_IMM | BPF_DW:
@@ -1459,15 +1470,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	{
 		u8 sz = BPF_SIZE(code);
 
-		rn = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
-		rm = arm_bpf_get_reg32(src_hi, tmp2[0], ctx);
+		rs = arm_bpf_get_reg64(src, tmp2, ctx);
 
 		/* Store the value */
 		if (BPF_SIZE(code) == BPF_DW) {
-			emit_str_r(dst_lo, rn, off, ctx, BPF_W);
-			emit_str_r(dst_lo, rm, off+4, ctx, BPF_W);
+			emit_str_r(dst_lo, rs[1], off, ctx, BPF_W);
+			emit_str_r(dst_lo, rs[0], off+4, ctx, BPF_W);
 		} else {
-			emit_str_r(dst_lo, rn, off, ctx, sz);
+			emit_str_r(dst_lo, rs[1], off, ctx, sz);
 		}
 		break;
 	}
@@ -1527,11 +1537,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit_a32_mov_i64(true, tmp2, imm, ctx);
 go_jmp:
 		/* Setup destination register */
-		rt = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
-		rd = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+		rd = arm_bpf_get_reg64(dst, tmp, ctx);
 
 		/* Check for the condition */
-		emit_ar_r(rd, rt, rm, rn, ctx, BPF_OP(code));
+		emit_ar_r(rd[0], rd[1], rm, rn, ctx, BPF_OP(code));
 
 		/* Setup JUMP instruction */
 		jmp_offset = bpf2a32_offset(i+off, i, ctx);
-- 
2.7.4
