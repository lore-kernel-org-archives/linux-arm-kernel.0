From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:31:41 +0100
Subject: [PATCH net-next v2 03/14] ARM: net: bpf: use negative numbers for
 stacked registers
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBTJ-0001Ie-V7@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use negative numbers for eBPF registers that live on the stack.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 200 +++++++++++++++++++++++-----------------------
 1 file changed, 102 insertions(+), 98 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index c81da1a50834..69bf7ab18bf9 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -101,7 +101,11 @@ enum {
 	BPF_JIT_SCRATCH_REGS,
 };
 
-#define STACK_OFFSET(k)	((k) * 4)
+/*
+ * Negative "register" values indicate the register is stored on the stack
+ * and are the offset from the top of the eBPF JIT scratch space.
+ */
+#define STACK_OFFSET(k)	(-4 - (k) * 4)
 #define SCRATCH_SIZE	(BPF_JIT_SCRATCH_REGS * 4)
 
 #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)	/* TEMP Register 1 */
@@ -125,7 +129,7 @@ enum {
  * scratch memory space and we have to build eBPF 64 bit register from those.
  *
  */
-static const u8 bpf2a32[][2] = {
+static const s8 bpf2a32[][2] = {
 	/* return value from in-kernel function, and exit value from eBPF */
 	[BPF_REG_0] = {ARM_R1, ARM_R0},
 	/* arguments from eBPF program to in-kernel function */
@@ -291,7 +295,7 @@ static void jit_fill_hole(void *area, unsigned int size)
 #define STACK_SIZE	ALIGN(_STACK_SIZE, STACK_ALIGNMENT)
 
 /* Get the offset of eBPF REGISTERs stored on scratch space. */
-#define STACK_VAR(off) (STACK_SIZE - off)
+#define STACK_VAR(off) (STACK_SIZE + (off))
 
 #if __LINUX_ARM_ARCH__ < 7
 
@@ -408,7 +412,7 @@ static inline int epilogue_offset(const struct jit_ctx *ctx)
 
 static inline void emit_udivmod(u8 rd, u8 rm, u8 rn, struct jit_ctx *ctx, u8 op)
 {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
 
 #if __LINUX_ARM_ARCH__ == 7
 	if (elf_hwcap & HWCAP_IDIVA) {
@@ -470,10 +474,10 @@ static inline bool is_on_stack(u8 bpf_reg)
 	return false;
 }
 
-static inline void emit_a32_mov_i(const u8 dst, const u32 val,
+static inline void emit_a32_mov_i(const s8 dst, const u32 val,
 				  bool dstk, struct jit_ctx *ctx)
 {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
 
 	if (dstk) {
 		emit_mov_i(tmp[1], val, ctx);
@@ -484,7 +488,7 @@ static inline void emit_a32_mov_i(const u8 dst, const u32 val,
 }
 
 /* Sign extended move */
-static inline void emit_a32_mov_i64(const bool is64, const u8 dst[],
+static inline void emit_a32_mov_i64(const bool is64, const s8 dst[],
 				  const u32 val, bool dstk,
 				  struct jit_ctx *ctx) {
 	u32 hi = 0;
@@ -574,12 +578,12 @@ static inline void emit_alu_r(const u8 dst, const u8 src, const bool is64,
 /* ALU operation (32 bit)
  * dst = dst (op) src
  */
-static inline void emit_a32_alu_r(const u8 dst, const u8 src,
+static inline void emit_a32_alu_r(const s8 dst, const s8 src,
 				  bool dstk, bool sstk,
 				  struct jit_ctx *ctx, const bool is64,
 				  const bool hi, const u8 op) {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	u8 rn = sstk ? tmp[1] : src;
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	s8 rn = sstk ? tmp[1] : src;
 
 	if (sstk)
 		emit(ARM_LDR_I(rn, ARM_SP, STACK_VAR(src)), ctx);
@@ -595,8 +599,8 @@ static inline void emit_a32_alu_r(const u8 dst, const u8 src,
 }
 
 /* ALU operation (64 bit) */
-static inline void emit_a32_alu_r64(const bool is64, const u8 dst[],
-				  const u8 src[], bool dstk,
+static inline void emit_a32_alu_r64(const bool is64, const s8 dst[],
+				  const s8 src[], bool dstk,
 				  bool sstk, struct jit_ctx *ctx,
 				  const u8 op) {
 	emit_a32_alu_r(dst_lo, src_lo, dstk, sstk, ctx, is64, false, op);
@@ -607,11 +611,11 @@ static inline void emit_a32_alu_r64(const bool is64, const u8 dst[],
 }
 
 /* dst = imm (4 bytes)*/
-static inline void emit_a32_mov_r(const u8 dst, const u8 src,
+static inline void emit_a32_mov_r(const s8 dst, const s8 src,
 				  bool dstk, bool sstk,
 				  struct jit_ctx *ctx) {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	u8 rt = sstk ? tmp[0] : src;
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	s8 rt = sstk ? tmp[0] : src;
 
 	if (sstk)
 		emit(ARM_LDR_I(tmp[0], ARM_SP, STACK_VAR(src)), ctx);
@@ -622,8 +626,8 @@ static inline void emit_a32_mov_r(const u8 dst, const u8 src,
 }
 
 /* dst = src */
-static inline void emit_a32_mov_r64(const bool is64, const u8 dst[],
-				  const u8 src[], bool dstk,
+static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
+				  const s8 src[], bool dstk,
 				  bool sstk, struct jit_ctx *ctx) {
 	emit_a32_mov_r(dst_lo, src_lo, dstk, sstk, ctx);
 	if (is64) {
@@ -636,10 +640,10 @@ static inline void emit_a32_mov_r64(const bool is64, const u8 dst[],
 }
 
 /* Shift operations */
-static inline void emit_a32_alu_i(const u8 dst, const u32 val, bool dstk,
+static inline void emit_a32_alu_i(const s8 dst, const u32 val, bool dstk,
 				struct jit_ctx *ctx, const u8 op) {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	u8 rd = dstk ? tmp[0] : dst;
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	s8 rd = dstk ? tmp[0] : dst;
 
 	if (dstk)
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst)), ctx);
@@ -662,11 +666,11 @@ static inline void emit_a32_alu_i(const u8 dst, const u32 val, bool dstk,
 }
 
 /* dst = ~dst (64 bit) */
-static inline void emit_a32_neg64(const u8 dst[], bool dstk,
+static inline void emit_a32_neg64(const s8 dst[], bool dstk,
 				struct jit_ctx *ctx){
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	u8 rd = dstk ? tmp[1] : dst[1];
-	u8 rm = dstk ? tmp[0] : dst[0];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	s8 rd = dstk ? tmp[1] : dst[1];
+	s8 rm = dstk ? tmp[0] : dst[0];
 
 	/* Setup Operand */
 	if (dstk) {
@@ -685,15 +689,15 @@ static inline void emit_a32_neg64(const u8 dst[], bool dstk,
 }
 
 /* dst = dst << src */
-static inline void emit_a32_lsh_r64(const u8 dst[], const u8 src[], bool dstk,
+static inline void emit_a32_lsh_r64(const s8 dst[], const s8 src[], bool dstk,
 				    bool sstk, struct jit_ctx *ctx) {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 
 	/* Setup Operands */
-	u8 rt = sstk ? tmp2[1] : src_lo;
-	u8 rd = dstk ? tmp[1] : dst_lo;
-	u8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rt = sstk ? tmp2[1] : src_lo;
+	s8 rd = dstk ? tmp[1] : dst_lo;
+	s8 rm = dstk ? tmp[0] : dst_hi;
 
 	if (sstk)
 		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
@@ -720,14 +724,14 @@ static inline void emit_a32_lsh_r64(const u8 dst[], const u8 src[], bool dstk,
 }
 
 /* dst = dst >> src (signed)*/
-static inline void emit_a32_arsh_r64(const u8 dst[], const u8 src[], bool dstk,
+static inline void emit_a32_arsh_r64(const s8 dst[], const s8 src[], bool dstk,
 				    bool sstk, struct jit_ctx *ctx) {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup Operands */
-	u8 rt = sstk ? tmp2[1] : src_lo;
-	u8 rd = dstk ? tmp[1] : dst_lo;
-	u8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rt = sstk ? tmp2[1] : src_lo;
+	s8 rd = dstk ? tmp[1] : dst_lo;
+	s8 rm = dstk ? tmp[0] : dst_hi;
 
 	if (sstk)
 		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
@@ -754,14 +758,14 @@ static inline void emit_a32_arsh_r64(const u8 dst[], const u8 src[], bool dstk,
 }
 
 /* dst = dst >> src */
-static inline void emit_a32_rsh_r64(const u8 dst[], const u8 src[], bool dstk,
+static inline void emit_a32_rsh_r64(const s8 dst[], const s8 src[], bool dstk,
 				     bool sstk, struct jit_ctx *ctx) {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup Operands */
-	u8 rt = sstk ? tmp2[1] : src_lo;
-	u8 rd = dstk ? tmp[1] : dst_lo;
-	u8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rt = sstk ? tmp2[1] : src_lo;
+	s8 rd = dstk ? tmp[1] : dst_lo;
+	s8 rm = dstk ? tmp[0] : dst_hi;
 
 	if (sstk)
 		emit(ARM_LDR_I(rt, ARM_SP, STACK_VAR(src_lo)), ctx);
@@ -787,13 +791,13 @@ static inline void emit_a32_rsh_r64(const u8 dst[], const u8 src[], bool dstk,
 }
 
 /* dst = dst << val */
-static inline void emit_a32_lsh_i64(const u8 dst[], bool dstk,
+static inline void emit_a32_lsh_i64(const s8 dst[], bool dstk,
 				     const u32 val, struct jit_ctx *ctx){
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup operands */
-	u8 rd = dstk ? tmp[1] : dst_lo;
-	u8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rd = dstk ? tmp[1] : dst_lo;
+	s8 rm = dstk ? tmp[0] : dst_hi;
 
 	if (dstk) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
@@ -820,13 +824,13 @@ static inline void emit_a32_lsh_i64(const u8 dst[], bool dstk,
 }
 
 /* dst = dst >> val */
-static inline void emit_a32_rsh_i64(const u8 dst[], bool dstk,
+static inline void emit_a32_rsh_i64(const s8 dst[], bool dstk,
 				    const u32 val, struct jit_ctx *ctx) {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup operands */
-	u8 rd = dstk ? tmp[1] : dst_lo;
-	u8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rd = dstk ? tmp[1] : dst_lo;
+	s8 rm = dstk ? tmp[0] : dst_hi;
 
 	if (dstk) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
@@ -853,13 +857,13 @@ static inline void emit_a32_rsh_i64(const u8 dst[], bool dstk,
 }
 
 /* dst = dst >> val (signed) */
-static inline void emit_a32_arsh_i64(const u8 dst[], bool dstk,
+static inline void emit_a32_arsh_i64(const s8 dst[], bool dstk,
 				     const u32 val, struct jit_ctx *ctx){
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	 /* Setup operands */
-	u8 rd = dstk ? tmp[1] : dst_lo;
-	u8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rd = dstk ? tmp[1] : dst_lo;
+	s8 rm = dstk ? tmp[0] : dst_hi;
 
 	if (dstk) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
@@ -885,15 +889,15 @@ static inline void emit_a32_arsh_i64(const u8 dst[], bool dstk,
 	}
 }
 
-static inline void emit_a32_mul_r64(const u8 dst[], const u8 src[], bool dstk,
+static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[], bool dstk,
 				    bool sstk, struct jit_ctx *ctx) {
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	/* Setup operands for multiplication */
-	u8 rd = dstk ? tmp[1] : dst_lo;
-	u8 rm = dstk ? tmp[0] : dst_hi;
-	u8 rt = sstk ? tmp2[1] : src_lo;
-	u8 rn = sstk ? tmp2[0] : src_hi;
+	s8 rd = dstk ? tmp[1] : dst_lo;
+	s8 rm = dstk ? tmp[0] : dst_hi;
+	s8 rt = sstk ? tmp2[1] : src_lo;
+	s8 rn = sstk ? tmp2[0] : src_hi;
 
 	if (dstk) {
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst_lo)), ctx);
@@ -920,10 +924,10 @@ static inline void emit_a32_mul_r64(const u8 dst[], const u8 src[], bool dstk,
 }
 
 /* *(size *)(dst + off) = src */
-static inline void emit_str_r(const u8 dst, const u8 src, bool dstk,
+static inline void emit_str_r(const s8 dst, const s8 src, bool dstk,
 			      const s32 off, struct jit_ctx *ctx, const u8 sz){
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	u8 rd = dstk ? tmp[1] : dst;
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	s8 rd = dstk ? tmp[1] : dst;
 
 	if (dstk)
 		emit(ARM_LDR_I(rd, ARM_SP, STACK_VAR(dst)), ctx);
@@ -949,11 +953,11 @@ static inline void emit_str_r(const u8 dst, const u8 src, bool dstk,
 }
 
 /* dst = *(size*)(src + off) */
-static inline void emit_ldx_r(const u8 dst[], const u8 src, bool dstk,
+static inline void emit_ldx_r(const s8 dst[], const s8 src, bool dstk,
 			      s32 off, struct jit_ctx *ctx, const u8 sz){
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *rd = dstk ? tmp : dst;
-	u8 rm = src;
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *rd = dstk ? tmp : dst;
+	s8 rm = src;
 	s32 off_max;
 
 	if (sz == BPF_H)
@@ -1034,11 +1038,11 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 {
 
 	/* bpf_tail_call(void *prog_ctx, struct bpf_array *array, u64 index) */
-	const u8 *r2 = bpf2a32[BPF_REG_2];
-	const u8 *r3 = bpf2a32[BPF_REG_3];
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
-	const u8 *tcc = bpf2a32[TCALL_CNT];
+	const s8 *r2 = bpf2a32[BPF_REG_2];
+	const s8 *r3 = bpf2a32[BPF_REG_3];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tcc = bpf2a32[TCALL_CNT];
 	const int idx0 = ctx->idx;
 #define cur_offset (ctx->idx - idx0)
 #define jmp_offset (out_offset - (cur_offset) - 2)
@@ -1112,7 +1116,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 static inline void emit_rev16(const u8 rd, const u8 rn, struct jit_ctx *ctx)
 {
 #if __LINUX_ARM_ARCH__ < 6
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 
 	emit(ARM_AND_I(tmp2[1], rn, 0xff), ctx);
 	emit(ARM_MOV_SI(tmp2[0], rn, SRTYPE_LSR, 8), ctx);
@@ -1127,7 +1131,7 @@ static inline void emit_rev16(const u8 rd, const u8 rn, struct jit_ctx *ctx)
 static inline void emit_rev32(const u8 rd, const u8 rn, struct jit_ctx *ctx)
 {
 #if __LINUX_ARM_ARCH__ < 6
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 
 	emit(ARM_AND_I(tmp2[1], rn, 0xff), ctx);
 	emit(ARM_MOV_SI(tmp2[0], rn, SRTYPE_LSR, 24), ctx);
@@ -1147,10 +1151,10 @@ static inline void emit_rev32(const u8 rd, const u8 rn, struct jit_ctx *ctx)
 }
 
 // push the scratch stack register on top of the stack
-static inline void emit_push_r64(const u8 src[], const u8 shift,
+static inline void emit_push_r64(const s8 src[], const u8 shift,
 		struct jit_ctx *ctx)
 {
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	u16 reg_set = 0;
 
 	emit(ARM_LDR_I(tmp2[1], ARM_SP, STACK_VAR(src[1]+shift)), ctx);
@@ -1162,13 +1166,13 @@ static inline void emit_push_r64(const u8 src[], const u8 shift,
 
 static void build_prologue(struct jit_ctx *ctx)
 {
-	const u8 r0 = bpf2a32[BPF_REG_0][1];
-	const u8 r2 = bpf2a32[BPF_REG_1][1];
-	const u8 r3 = bpf2a32[BPF_REG_1][0];
-	const u8 r4 = bpf2a32[BPF_REG_6][1];
-	const u8 fplo = bpf2a32[BPF_REG_FP][1];
-	const u8 fphi = bpf2a32[BPF_REG_FP][0];
-	const u8 *tcc = bpf2a32[TCALL_CNT];
+	const s8 r0 = bpf2a32[BPF_REG_0][1];
+	const s8 r2 = bpf2a32[BPF_REG_1][1];
+	const s8 r3 = bpf2a32[BPF_REG_1][0];
+	const s8 r4 = bpf2a32[BPF_REG_6][1];
+	const s8 fplo = bpf2a32[BPF_REG_FP][1];
+	const s8 fphi = bpf2a32[BPF_REG_FP][0];
+	const s8 *tcc = bpf2a32[TCALL_CNT];
 
 	/* Save callee saved registers. */
 #ifdef CONFIG_FRAME_POINTER
@@ -1231,17 +1235,17 @@ static void build_epilogue(struct jit_ctx *ctx)
 static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
 	const u8 code = insn->code;
-	const u8 *dst = bpf2a32[insn->dst_reg];
-	const u8 *src = bpf2a32[insn->src_reg];
-	const u8 *tmp = bpf2a32[TMP_REG_1];
-	const u8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *dst = bpf2a32[insn->dst_reg];
+	const s8 *src = bpf2a32[insn->src_reg];
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
 	const bool is64 = BPF_CLASS(code) == BPF_ALU64;
 	const bool dstk = is_on_stack(insn->dst_reg);
 	const bool sstk = is_on_stack(insn->src_reg);
-	u8 rd, rt, rm, rn;
+	s8 rd, rt, rm, rn;
 	s32 jmp_offset;
 
 #define check_imm(bits, imm) do {				\
@@ -1672,12 +1676,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* function call */
 	case BPF_JMP | BPF_CALL:
 	{
-		const u8 *r0 = bpf2a32[BPF_REG_0];
-		const u8 *r1 = bpf2a32[BPF_REG_1];
-		const u8 *r2 = bpf2a32[BPF_REG_2];
-		const u8 *r3 = bpf2a32[BPF_REG_3];
-		const u8 *r4 = bpf2a32[BPF_REG_4];
-		const u8 *r5 = bpf2a32[BPF_REG_5];
+		const s8 *r0 = bpf2a32[BPF_REG_0];
+		const s8 *r1 = bpf2a32[BPF_REG_1];
+		const s8 *r2 = bpf2a32[BPF_REG_2];
+		const s8 *r3 = bpf2a32[BPF_REG_3];
+		const s8 *r4 = bpf2a32[BPF_REG_4];
+		const s8 *r5 = bpf2a32[BPF_REG_5];
 		const u32 func = (u32)__bpf_call_base + (u32)imm;
 
 		emit_a32_mov_r64(true, r0, r1, false, false, ctx);
-- 
2.7.4
