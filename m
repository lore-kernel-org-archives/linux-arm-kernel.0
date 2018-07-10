From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 13:36:39 +0100
Subject: [PATCH net-next 07/13] ARM: net: bpf: access eBPF scratch space using
 ARM FP register
In-Reply-To: <20180710123340.GK17271@n2100.armlinux.org.uk>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
Message-ID: <E1fcrsl-0005V0-Lp@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Access the eBPF scratch space using the frame pointer rather than our
stack pointer, as the offsets from the ARM frame pointer are constant
across all eBPF programs.

Since we no longer reference the scratch space registers from the stack
pointer, this simplifies emit_push_r64() as it no longer needs to know
how many words are pushed onto the stack.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 45a3599e94a4..753b5b2b2e3d 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -108,6 +108,12 @@ enum {
 #define STACK_OFFSET(k)	(-4 - (k) * 4)
 #define SCRATCH_SIZE	(BPF_JIT_SCRATCH_REGS * 4)
 
+#ifdef CONFIG_FRAME_POINTER
+#define EBPF_SCRATCH_TO_ARM_FP(x) ((x) - 4 * hweight16(CALLEE_PUSH_MASK) - 4)
+#else
+#define EBPF_SCRATCH_TO_ARM_FP(x) (x)
+#endif
+
 #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)	/* TEMP Register 1 */
 #define TMP_REG_2	(MAX_BPF_JIT_REG + 1)	/* TEMP Register 2 */
 #define TCALL_CNT	(MAX_BPF_JIT_REG + 2)	/* Tail Call Count */
@@ -294,9 +300,6 @@ static void jit_fill_hole(void *area, unsigned int size)
 #define _STACK_SIZE	(ctx->prog->aux->stack_depth + SCRATCH_SIZE)
 #define STACK_SIZE	ALIGN(_STACK_SIZE, STACK_ALIGNMENT)
 
-/* Get the offset of eBPF REGISTERs stored on scratch space. */
-#define STACK_VAR(off) (STACK_SIZE + (off))
-
 #if __LINUX_ARM_ARCH__ < 7
 
 static u16 imm_offset(u32 k, struct jit_ctx *ctx)
@@ -472,7 +475,7 @@ static bool is_stacked(s8 reg)
 static s8 arm_bpf_get_reg32(s8 reg, s8 tmp, struct jit_ctx *ctx)
 {
 	if (is_stacked(reg)) {
-		emit(ARM_LDR_I(tmp, ARM_SP, STACK_VAR(reg)), ctx);
+		emit(ARM_LDR_I(tmp, ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg)), ctx);
 		reg = tmp;
 	}
 	return reg;
@@ -482,8 +485,10 @@ static const s8 *arm_bpf_get_reg64(const s8 *reg, const s8 *tmp,
 				   struct jit_ctx *ctx)
 {
 	if (is_stacked(reg[1])) {
-		emit(ARM_LDR_I(tmp[1], ARM_SP, STACK_VAR(reg[1])), ctx);
-		emit(ARM_LDR_I(tmp[0], ARM_SP, STACK_VAR(reg[0])), ctx);
+		emit(ARM_LDR_I(tmp[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[1])),
+		     ctx);
+		emit(ARM_LDR_I(tmp[0], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[0])),
+		     ctx);
 		reg = tmp;
 	}
 	return reg;
@@ -496,7 +501,7 @@ static const s8 *arm_bpf_get_reg64(const s8 *reg, const s8 *tmp,
 static void arm_bpf_put_reg32(s8 reg, s8 src, struct jit_ctx *ctx)
 {
 	if (is_stacked(reg))
-		emit(ARM_STR_I(src, ARM_SP, STACK_VAR(reg)), ctx);
+		emit(ARM_STR_I(src, ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg)), ctx);
 	else if (reg != src)
 		emit(ARM_MOV_R(reg, src), ctx);
 }
@@ -505,8 +510,10 @@ static void arm_bpf_put_reg64(const s8 *reg, const s8 *src,
 			      struct jit_ctx *ctx)
 {
 	if (is_stacked(reg[1])) {
-		emit(ARM_STR_I(src[1], ARM_SP, STACK_VAR(reg[1])), ctx);
-		emit(ARM_STR_I(src[0], ARM_SP, STACK_VAR(reg[0])), ctx);
+		emit(ARM_STR_I(src[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[1])),
+		     ctx);
+		emit(ARM_STR_I(src[0], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[0])),
+		     ctx);
 	} else {
 		if (reg[1] != src[1])
 			emit(ARM_MOV_R(reg[1], src[1]), ctx);
@@ -1103,16 +1110,15 @@ static inline void emit_rev32(const u8 rd, const u8 rn, struct jit_ctx *ctx)
 }
 
 // push the scratch stack register on top of the stack
-static inline void emit_push_r64(const s8 src[], const u8 shift,
-		struct jit_ctx *ctx)
+static inline void emit_push_r64(const s8 src[], struct jit_ctx *ctx)
 {
 	const s8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *rt;
 	u16 reg_set = 0;
 
-	emit(ARM_LDR_I(tmp2[1], ARM_SP, STACK_VAR(src[1]+shift)), ctx);
-	emit(ARM_LDR_I(tmp2[0], ARM_SP, STACK_VAR(src[0]+shift)), ctx);
+	rt = arm_bpf_get_reg64(src, tmp2, ctx);
 
-	reg_set = (1 << tmp2[1]) | (1 << tmp2[0]);
+	reg_set = (1 << rt[1]) | (1 << rt[0]);
 	emit(ARM_PUSH(reg_set), ctx);
 }
 
@@ -1155,8 +1161,8 @@ static void build_prologue(struct jit_ctx *ctx)
 	emit(ARM_MOV_R(r3, r4), ctx);
 	emit(ARM_MOV_R(r2, r0), ctx);
 	/* Initialize Tail Count */
-	emit(ARM_STR_I(r4, ARM_SP, STACK_VAR(tcc[0])), ctx);
-	emit(ARM_STR_I(r4, ARM_SP, STACK_VAR(tcc[1])), ctx);
+	emit(ARM_STR_I(r4, ARM_FP, EBPF_SCRATCH_TO_ARM_FP(tcc[0])), ctx);
+	emit(ARM_STR_I(r4, ARM_FP, EBPF_SCRATCH_TO_ARM_FP(tcc[1])), ctx);
 	/* end of prologue */
 }
 
@@ -1606,9 +1612,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 
 		emit_a32_mov_r64(true, r0, r1, ctx);
 		emit_a32_mov_r64(true, r1, r2, ctx);
-		emit_push_r64(r5, 0, ctx);
-		emit_push_r64(r4, 8, ctx);
-		emit_push_r64(r3, 16, ctx);
+		emit_push_r64(r5, ctx);
+		emit_push_r64(r4, ctx);
+		emit_push_r64(r3, ctx);
 
 		emit_a32_mov_i(tmp[1], func, ctx);
 		emit_blx_r(tmp[1], ctx);
-- 
2.7.4
