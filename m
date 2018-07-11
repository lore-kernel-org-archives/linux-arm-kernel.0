From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:31:52 +0100
Subject: [PATCH net-next v2 05/14] ARM: net: bpf: provide accessor functions
 for BPF registers
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBTU-0001It-7D@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many of the code paths need to have knowledge about whether a register
is stacked or in a CPU register.  Move this decision making to a pair
of helper functions instead of having it scattered throughout the
code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 329 ++++++++++++++++++----------------------------
 1 file changed, 128 insertions(+), 201 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index e81401aca2df..08fb4eb285a2 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -465,6 +465,31 @@ static bool is_stacked(s8 reg)
 	return reg < 0;
 }
 
+/* If a BPF register is on the stack (stk is true), load it to the
+ * supplied temporary register and return the temporary register
+ * for subsequent operations, otherwise just use the CPU register.
+ */
+static s8 arm_bpf_get_reg32(s8 reg, s8 tmp, struct jit_ctx *ctx)
+{
+	if (is_stacked(reg)) {
+		emit(ARM_LDR_I(tmp, ARM_SP, STACK_VAR(reg)), ctx);
+		reg = tmp;
+	}
+	return reg;
+}
+
+/* If a BPF register is on the stack (stk is true), save the register
+ * back to the stack.  If the source register is not the same, then
+ * move it into the correct register.
+ */
+static void arm_bpf_put_reg32(s8 reg, s8 src, struct jit_ctx *ctx)
+{
+	if (is_stacked(reg))
+		emit(ARM_STR_I(src, ARM_SP, STACK_VAR(reg)), ctx);
+	else if (reg != src)
+		emit(ARM_MOV_R(reg, src), ctx);
+}
+
 static inline void emit_a32_mov_i(const s8 dst, const u32 val,
 				  struct jit_ctx *ctx)
 {
@@ -472,7 +497,7 @@ static inline void emit_a32_mov_i(const s8 dst, const u32 val,
 
 	if (is_stacked(dst)) {
 		emit_mov_i(tmp[1], val, ctx);
-		emit(ARM_STR_I(tmp[1], ARM_SP, STACK_VAR(dst)), ctx);
+		arm_bpf_put_reg32(dst, tmp[1], ctx);
 	} else {
 		emit_mov_i(dst, val, ctx);
 	}
@@ -572,19 +597,13 @@ static inline void emit_a32_alu_r(const s8 dst, const s8 src,
 				  struct jit_ctx *ctx, const bool is64,
 				  const bool hi, const u8 op) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rn = is_stacked(src) ? tmp[1] : src;
-
-	if (is_stacked(src))
-		emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src)), ctx);
+	s8 rn, rd;
 
+	rn = arm_bpf_get_reg32(src, tmp[1], ctx);
+	rd = arm_bpf_get_reg32(dst, tmp[0], ctx);
 	/* ALU operation */
-	if (is_stacked(dst)) {
-		emit(ARM_LDR_I(tmp[0], ARM_SP, STACK_VAR(dst)), ctx);
-		emit_alu_r(tmp[0], rn, is64, hi, op, ctx);
-		emit(ARM_STR_I(tmp[0], ARM_SP, STACK_VAR(dst)), ctx);
-	} else {
-		emit_alu_r(dst, rn, is64, hi, op, ctx);
-	}
+	emit_alu_r(rd, rn, is64, hi, op, ctx);
+	arm_bpf_put_reg32(dst, rd, ctx);
 }
 
 /* ALU operation (64 bit) */
@@ -598,18 +617,14 @@ static inline void emit_a32_alu_r64(const bool is64, const s8 dst[],
 		emit_a32_mov_i(dst_hi, 0, ctx);
 }
 
-/* dst = imm (4 bytes)*/
+/* dst = src (4 bytes)*/
 static inline void emit_a32_mov_r(const s8 dst, const s8 src,
 				  struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rt = is_stacked(src) ? tmp[0] : src;
+	s8 rt;
 
-	if (is_stacked(src))
-		emit(ARM_LDR_I(tmp[0], ARM_SP, STACK_VAR(src)), ctx);
-	if (is_stacked(dst))
-		emit(ARM_STR_I(rt, ARM_SP, STACK_VAR(dst)), ctx);
-	else
-		emit(ARM_MOV_R(dst, rt), ctx);
+	rt = arm_bpf_get_reg32(src, tmp[0], ctx);
+	arm_bpf_put_reg32(dst, rt, ctx);
 }
 
 /* dst = src */
@@ -630,10 +645,9 @@ static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 static inline void emit_a32_alu_i(const s8 dst, const u32 val,
 				struct jit_ctx *ctx, const u8 op) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rd = is_stacked(dst) ? tmp[0] : dst;
+	s8 rd;
 
-	if (is_stacked(dst))
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst)), ctx);
+	rd = arm_bpf_get_reg32(dst, tmp[0], ctx);
 
 	/* Do shift operation */
 	switch (op) {
@@ -648,31 +662,25 @@ static inline void emit_a32_alu_i(const s8 dst, const u32 val,
 		break;
 	}
 
-	if (is_stacked(dst))
-		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst)), ctx);
+	arm_bpf_put_reg32(dst, rd, ctx);
 }
 
 /* dst = ~dst (64 bit) */
 static inline void emit_a32_neg64(const s8 dst[],
 				struct jit_ctx *ctx){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst[1];
-	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst[0];
+	s8 rd, rm;
 
 	/* Setup Operand */
-	if (is_stacked(dst_lo)) {
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
 
 	/* Do Negate Operation */
 	emit(ARM_RSBS_I(rd, rd, 0), ctx);
 	emit(ARM_RSC_I(rm, rm, 0), ctx);
 
-	if (is_stacked(dst_lo)) {
-		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	arm_bpf_put_reg32(dst_lo, rd, ctx);
+	arm_bpf_put_reg32(dst_hi, rm, ctx);
 }
 
 /* dst = dst << src */
@@ -680,18 +688,12 @@ static inline void emit_a32_lsh_r64(const s8 dst[], const s8 src[],
 				    struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
+	s8 rt, rd, rm;
 
 	/* Setup Operands */
-	s8 rt = is_stacked(src_lo) ? tmp2[1] : src_lo;
-	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
-	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
-
-	if (is_stacked(src_lo))
-		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
-	if (is_stacked(dst_lo)) {
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	rt = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
+	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
 
 	/* Do LSH operation */
 	emit(ARM_SUB_I(ARM_IP, rt, 32), ctx);
@@ -701,13 +703,8 @@ static inline void emit_a32_lsh_r64(const s8 dst[], const s8 src[],
 	emit(ARM_ORR_SR(ARM_IP, ARM_LR, rd, SRTYPE_LSR, tmp2[0]), ctx);
 	emit(ARM_MOV_SR(ARM_LR, rd, SRTYPE_ASL, rt), ctx);
 
-	if (is_stacked(dst_lo)) {
-		emit(ARM_STR_I(ARM_LR, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_STR_I(ARM_IP, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	} else {
-		emit(ARM_MOV_R(rd, ARM_LR), ctx);
-		emit(ARM_MOV_R(rm, ARM_IP), ctx);
-	}
+	arm_bpf_put_reg32(dst_lo, ARM_LR, ctx);
+	arm_bpf_put_reg32(dst_hi, ARM_IP, ctx);
 }
 
 /* dst = dst >> src (signed)*/
@@ -715,17 +712,12 @@ static inline void emit_a32_arsh_r64(const s8 dst[], const s8 src[],
 				     struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
+	s8 rt, rd, rm;
+
 	/* Setup Operands */
-	s8 rt = is_stacked(src_lo) ? tmp2[1] : src_lo;
-	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
-	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
-
-	if (is_stacked(src_lo))
-		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
-	if (is_stacked(dst_lo)) {
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	rt = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
+	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
 
 	/* Do the ARSH operation */
 	emit(ARM_RSB_I(ARM_IP, rt, 32), ctx);
@@ -735,13 +727,9 @@ static inline void emit_a32_arsh_r64(const s8 dst[], const s8 src[],
 	_emit(ARM_COND_MI, ARM_B(0), ctx);
 	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_ASR, tmp2[0]), ctx);
 	emit(ARM_MOV_SR(ARM_IP, rm, SRTYPE_ASR, rt), ctx);
-	if (is_stacked(dst_lo)) {
-		emit(ARM_STR_I(ARM_LR, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_STR_I(ARM_IP, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	} else {
-		emit(ARM_MOV_R(rd, ARM_LR), ctx);
-		emit(ARM_MOV_R(rm, ARM_IP), ctx);
-	}
+
+	arm_bpf_put_reg32(dst_lo, ARM_LR, ctx);
+	arm_bpf_put_reg32(dst_hi, ARM_IP, ctx);
 }
 
 /* dst = dst >> src */
@@ -749,17 +737,12 @@ static inline void emit_a32_rsh_r64(const s8 dst[], const s8 src[],
 				    struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
+	s8 rt, rd, rm;
+
 	/* Setup Operands */
-	s8 rt = is_stacked(src_lo) ? tmp2[1] : src_lo;
-	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
-	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
-
-	if (is_stacked(src_lo))
-		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
-	if (is_stacked(dst_lo)) {
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	rt = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
+	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
 
 	/* Do RSH operation */
 	emit(ARM_RSB_I(ARM_IP, rt, 32), ctx);
@@ -768,13 +751,9 @@ static inline void emit_a32_rsh_r64(const s8 dst[], const s8 src[],
 	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_ASL, ARM_IP), ctx);
 	emit(ARM_ORR_SR(ARM_LR, ARM_LR, rm, SRTYPE_LSR, tmp2[0]), ctx);
 	emit(ARM_MOV_SR(ARM_IP, rm, SRTYPE_LSR, rt), ctx);
-	if (is_stacked(dst_lo)) {
-		emit(ARM_STR_I(ARM_LR, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_STR_I(ARM_IP, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	} else {
-		emit(ARM_MOV_R(rd, ARM_LR), ctx);
-		emit(ARM_MOV_R(rm, ARM_IP), ctx);
-	}
+
+	arm_bpf_put_reg32(dst_lo, ARM_LR, ctx);
+	arm_bpf_put_reg32(dst_hi, ARM_IP, ctx);
 }
 
 /* dst = dst << val */
@@ -782,14 +761,11 @@ static inline void emit_a32_lsh_i64(const s8 dst[],
 				    const u32 val, struct jit_ctx *ctx){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	/* Setup operands */
-	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
-	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
+	s8 rd, rm;
 
-	if (is_stacked(dst_lo)) {
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	/* Setup operands */
+	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
 
 	/* Do LSH operation */
 	if (val < 32) {
@@ -804,10 +780,8 @@ static inline void emit_a32_lsh_i64(const s8 dst[],
 		emit(ARM_EOR_R(rd, rd, rd), ctx);
 	}
 
-	if (is_stacked(dst_lo)) {
-		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	arm_bpf_put_reg32(dst_lo, rd, ctx);
+	arm_bpf_put_reg32(dst_hi, rm, ctx);
 }
 
 /* dst = dst >> val */
@@ -815,14 +789,11 @@ static inline void emit_a32_rsh_i64(const s8 dst[],
 				    const u32 val, struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	/* Setup operands */
-	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
-	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
+	s8 rd, rm;
 
-	if (is_stacked(dst_lo)) {
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	/* Setup operands */
+	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
 
 	/* Do LSR operation */
 	if (val < 32) {
@@ -837,10 +808,8 @@ static inline void emit_a32_rsh_i64(const s8 dst[],
 		emit(ARM_MOV_I(rm, 0), ctx);
 	}
 
-	if (is_stacked(dst_lo)) {
-		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	arm_bpf_put_reg32(dst_lo, rd, ctx);
+	arm_bpf_put_reg32(dst_hi, rm, ctx);
 }
 
 /* dst = dst >> val (signed) */
@@ -848,14 +817,11 @@ static inline void emit_a32_arsh_i64(const s8 dst[],
 				     const u32 val, struct jit_ctx *ctx){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
-	 /* Setup operands */
-	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
-	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
+	s8 rd, rm;
 
-	if (is_stacked(dst_lo)) {
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	/* Setup operands */
+	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
 
 	/* Do ARSH operation */
 	if (val < 32) {
@@ -870,30 +836,21 @@ static inline void emit_a32_arsh_i64(const s8 dst[],
 		emit(ARM_MOV_SI(rm, rm, SRTYPE_ASR, 31), ctx);
 	}
 
-	if (is_stacked(dst_lo)) {
-		emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
+	arm_bpf_put_reg32(dst_lo, rd, ctx);
+	arm_bpf_put_reg32(dst_hi, rm, ctx);
 }
 
 static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[],
 				    struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
+	s8 rd, rm, rt, rn;
+
 	/* Setup operands for multiplication */
-	s8 rd = is_stacked(dst_lo) ? tmp[1] : dst_lo;
-	s8 rm = is_stacked(dst_lo) ? tmp[0] : dst_hi;
-	s8 rt = is_stacked(src_lo) ? tmp2[1] : src_lo;
-	s8 rn = is_stacked(src_lo) ? tmp2[0] : src_hi;
-
-	if (is_stacked(dst_lo)) {
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	}
-	if (is_stacked(src_lo)) {
-		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
-		emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src_hi)), ctx);
-	}
+	rd = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+	rm = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
+	rt = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
+	rn = arm_bpf_get_reg32(src_hi, tmp2[0], ctx);
 
 	/* Do Multiplication */
 	emit(ARM_MUL(ARM_IP, rd, rn), ctx);
@@ -902,22 +859,18 @@ static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[],
 
 	emit(ARM_UMULL(ARM_IP, rm, rd, rt), ctx);
 	emit(ARM_ADD_R(rm, ARM_LR, rm), ctx);
-	if (is_stacked(dst_lo)) {
-		emit(ARM_STR_I(ARM_IP, ARM_SP, STACK_VAR(dst_lo)), ctx);
-		emit(ARM_STR_I(rm, ARM_SP, STACK_VAR(dst_hi)), ctx);
-	} else {
-		emit(ARM_MOV_R(rd, ARM_IP), ctx);
-	}
+
+	arm_bpf_put_reg32(dst_lo, ARM_IP, ctx);
+	arm_bpf_put_reg32(dst_hi, rm, ctx);
 }
 
 /* *(size *)(dst + off) = src */
 static inline void emit_str_r(const s8 dst, const s8 src,
 			      const s32 off, struct jit_ctx *ctx, const u8 sz){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	s8 rd = is_stacked(dst) ? tmp[1] : dst;
+	s8 rd;
 
-	if (is_stacked(dst))
-		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst)), ctx);
+	rd = arm_bpf_get_reg32(dst, tmp[1], ctx);
 	if (off) {
 		emit_a32_mov_i(tmp[0], off, ctx);
 		emit(ARM_ADD_R(tmp[0], rd, tmp[0]), ctx);
@@ -983,10 +936,9 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src,
 		emit(ARM_LDR_I(rd[0], rm, off + 4), ctx);
 		break;
 	}
-	if (is_stacked(dst_lo))
-		emit(ARM_STR_I(rd[1], ARM_SP, STACK_VAR(dst_lo)), ctx);
-	if (is_stacked(dst_lo) && sz == BPF_DW)
-		emit(ARM_STR_I(rd[0], ARM_SP, STACK_VAR(dst_hi)), ctx);
+	arm_bpf_put_reg32(dst[1], rd[1], ctx);
+	if (sz == BPF_DW)
+		arm_bpf_put_reg32(dst[0], rd[0], ctx);
 }
 
 /* Arithmatic Operation */
@@ -1034,6 +986,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 #define cur_offset (ctx->idx - idx0)
 #define jmp_offset (out_offset - (cur_offset) - 2)
 	u32 off, lo, hi;
+	s8 r_array, r_index, r_tc_lo, r_tc_hi;
 
 	/* if (index >= array->map.max_entries)
 	 *	goto out;
@@ -1041,12 +994,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	off = offsetof(struct bpf_array, map.max_entries);
 	/* array->map.max_entries */
 	emit_a32_mov_i(tmp[1], off, ctx);
-	emit(ARM_LDR_I(tmp2[1], ARM_SP, STACK_VAR(r2[1])), ctx);
-	emit(ARM_LDR_R(tmp[1], tmp2[1], tmp[1]), ctx);
+	r_array = arm_bpf_get_reg32(r2[1], tmp2[1], ctx);
+	emit(ARM_LDR_R(tmp[1], r_array, tmp[1]), ctx);
 	/* index is 32-bit for arrays */
-	emit(ARM_LDR_I(tmp2[1], ARM_SP, STACK_VAR(r3[1])), ctx);
+	r_index = arm_bpf_get_reg32(r3[1], tmp2[1], ctx);
 	/* index >= array->map.max_entries */
-	emit(ARM_CMP_R(tmp2[1], tmp[1]), ctx);
+	emit(ARM_CMP_R(r_index, tmp[1]), ctx);
 	_emit(ARM_COND_CS, ARM_B(jmp_offset), ctx);
 
 	/* if (tail_call_cnt > MAX_TAIL_CALL_CNT)
@@ -1055,15 +1008,15 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 */
 	lo = (u32)MAX_TAIL_CALL_CNT;
 	hi = (u32)((u64)MAX_TAIL_CALL_CNT >> 32);
-	emit(ARM_LDR_I(tmp[1], ARM_SP, STACK_VAR(tcc[1])), ctx);
-	emit(ARM_LDR_I(tmp[0], ARM_SP, STACK_VAR(tcc[0])), ctx);
-	emit(ARM_CMP_I(tmp[0], hi), ctx);
-	_emit(ARM_COND_EQ, ARM_CMP_I(tmp[1], lo), ctx);
+	r_tc_lo = arm_bpf_get_reg32(tcc[1], tmp[1], ctx);
+	r_tc_hi = arm_bpf_get_reg32(tcc[0], tmp[0], ctx);
+	emit(ARM_CMP_I(r_tc_hi, hi), ctx);
+	_emit(ARM_COND_EQ, ARM_CMP_I(r_tc_lo, lo), ctx);
 	_emit(ARM_COND_HI, ARM_B(jmp_offset), ctx);
-	emit(ARM_ADDS_I(tmp[1], tmp[1], 1), ctx);
-	emit(ARM_ADC_I(tmp[0], tmp[0], 0), ctx);
-	emit(ARM_STR_I(tmp[1], ARM_SP, STACK_VAR(tcc[1])), ctx);
-	emit(ARM_STR_I(tmp[0], ARM_SP, STACK_VAR(tcc[0])), ctx);
+	emit(ARM_ADDS_I(r_tc_lo, r_tc_lo, 1), ctx);
+	emit(ARM_ADC_I(r_tc_hi, r_tc_hi, 0), ctx);
+	arm_bpf_put_reg32(tcc[1], r_tc_lo, ctx);
+	arm_bpf_put_reg32(tcc[0], r_tc_hi, ctx);
 
 	/* prog = array->ptrs[index]
 	 * if (prog == NULL)
@@ -1071,10 +1024,10 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 */
 	off = offsetof(struct bpf_array, ptrs);
 	emit_a32_mov_i(tmp[1], off, ctx);
-	emit(ARM_LDR_I(tmp2[1], ARM_SP, STACK_VAR(r2[1])), ctx);
-	emit(ARM_ADD_R(tmp[1], tmp2[1], tmp[1]), ctx);
-	emit(ARM_LDR_I(tmp2[1], ARM_SP, STACK_VAR(r3[1])), ctx);
-	emit(ARM_MOV_SI(tmp[0], tmp2[1], SRTYPE_ASL, 2), ctx);
+	r_array = arm_bpf_get_reg32(r2[1], tmp2[1], ctx);
+	emit(ARM_ADD_R(tmp[1], r_array, tmp[1]), ctx);
+	r_index = arm_bpf_get_reg32(r3[1], tmp2[1], ctx);
+	emit(ARM_MOV_SI(tmp[0], r_index, SRTYPE_ASL, 2), ctx);
 	emit(ARM_LDR_R(tmp[1], tmp[1], tmp[0]), ctx);
 	emit(ARM_CMP_I(tmp[1], 0), ctx);
 	_emit(ARM_COND_EQ, ARM_B(jmp_offset), ctx);
@@ -1317,15 +1270,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_X:
-		rd = is_stacked(dst_lo) ? tmp2[1] : dst_lo;
-		if (is_stacked(dst_lo))
-			emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
+		rd = arm_bpf_get_reg32(dst_lo, tmp2[1], ctx);
 		switch (BPF_SRC(code)) {
 		case BPF_X:
-			rt = is_stacked(rt) ? tmp2[0] : src_lo;
-			if (is_stacked(src_lo))
-				emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)),
-				     ctx);
+			rt = arm_bpf_get_reg32(src_lo, tmp2[0], ctx);
 			break;
 		case BPF_K:
 			rt = tmp2[0];
@@ -1336,8 +1284,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			break;
 		}
 		emit_udivmod(rd, rd, rt, ctx, BPF_OP(code));
-		if (is_stacked(dst_lo))
-			emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
+		arm_bpf_put_reg32(dst_lo, rd, ctx);
 		emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	case BPF_ALU64 | BPF_DIV | BPF_K:
@@ -1417,12 +1364,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = htobe(dst) */
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
 	case BPF_ALU | BPF_END | BPF_FROM_BE:
-		rd = is_stacked(dst_lo) ? tmp[0] : dst_hi;
-		rt = is_stacked(dst_lo) ? tmp[1] : dst_lo;
-		if (is_stacked(dst_lo)) {
-			emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(dst_lo)), ctx);
-			emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_hi)), ctx);
-		}
+		rt = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+		rd = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
 		if (BPF_SRC(code) == BPF_FROM_LE)
 			goto emit_bswap_uxt;
 		switch (imm) {
@@ -1460,10 +1403,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			break;
 		}
 exit:
-		if (is_stacked(dst_lo)) {
-			emit(ARM_STR_I(rt, ARM_SP, STACK_VAR(dst_lo)), ctx);
-			emit(ARM_STR_I(rd, ARM_SP, STACK_VAR(dst_hi)), ctx);
-		}
+		arm_bpf_put_reg32(dst_lo, rt, ctx);
+		arm_bpf_put_reg32(dst_hi, rd, ctx);
 		break;
 	/* dst = imm64 */
 	case BPF_LD | BPF_IMM | BPF_DW:
@@ -1482,9 +1423,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_B:
 	case BPF_LDX | BPF_MEM | BPF_DW:
-		rn = is_stacked(src_lo) ? tmp2[1] : src_lo;
-		if (is_stacked(src_lo))
-			emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src_lo)), ctx);
+		rn = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
 		emit_ldx_r(dst, rn, off, ctx, BPF_SIZE(code));
 		break;
 	/* ST: *(size *)(dst + off) = imm */
@@ -1520,12 +1459,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	{
 		u8 sz = BPF_SIZE(code);
 
-		rn = is_stacked(src_lo) ? tmp2[1] : src_lo;
-		rm = is_stacked(src_lo) ? tmp2[0] : src_hi;
-		if (is_stacked(src_lo)) {
-			emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src_lo)), ctx);
-			emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(src_hi)), ctx);
-		}
+		rn = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
+		rm = arm_bpf_get_reg32(src_hi, tmp2[0], ctx);
 
 		/* Store the value */
 		if (BPF_SIZE(code) == BPF_DW) {
@@ -1559,12 +1494,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_JMP | BPF_JSLT | BPF_X:
 	case BPF_JMP | BPF_JSLE | BPF_X:
 		/* Setup source registers */
-		rm = is_stacked(src_lo) ? tmp2[0] : src_hi;
-		rn = is_stacked(src_lo) ? tmp2[1] : src_lo;
-		if (is_stacked(src_lo)) {
-			emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src_lo)), ctx);
-			emit(ARM_LDR_I(rm, ARM_SP, STACK_VAR(src_hi)), ctx);
-		}
+		rm = arm_bpf_get_reg32(src_hi, tmp2[0], ctx);
+		rn = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
 		goto go_jmp;
 	/* PC += off if dst == imm */
 	/* PC += off if dst > imm */
@@ -1596,12 +1527,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit_a32_mov_i64(true, tmp2, imm, ctx);
 go_jmp:
 		/* Setup destination register */
-		rd = is_stacked(dst_lo) ? tmp[0] : dst_hi;
-		rt = is_stacked(dst_lo) ? tmp[1] : dst_lo;
-		if (is_stacked(dst_lo)) {
-			emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(dst_lo)), ctx);
-			emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_hi)), ctx);
-		}
+		rt = arm_bpf_get_reg32(dst_lo, tmp[1], ctx);
+		rd = arm_bpf_get_reg32(dst_hi, tmp[0], ctx);
 
 		/* Check for the condition */
 		emit_ar_r(rd, rt, rm, rn, ctx, BPF_OP(code));
-- 
2.7.4
