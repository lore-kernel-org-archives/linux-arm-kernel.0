From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 23 Nov 2018 18:29:02 +0100
Subject: [PATCH] arm64/bpf: use movn/movk/movk sequence to generate kernel
 addresses
Message-ID: <20181123172902.21480-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, all executable code is guaranteed to reside in the vmalloc
space (or the module space), and so jump targets will only use 48
bits at most, and the remaining bits are guaranteed to be 0x1.

This means we can generate an immediate jump address using a sequence
of one MOVN (move wide negated) and two MOVK instructions, where the
first one sets the lower 16 bits but also sets all top bits to 0x1.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

I looked into using ADRP/ADD pairs, but this is very fiddly, since
it requires knowledge about where the ADRP instruction ends up in
memory. (ADRP produces a PC-relative address with bits [11:0] cleared,
and so in addition to the distance between the instruction and the
target, we also need to know their offsets modulo 4096 and I wasn't
sure whether the offsets are guaranteed to be relative to the start
of a page or not)

 arch/arm64/net/bpf_jit_comp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..3b4d2c6fc133 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -134,10 +134,9 @@ static inline void emit_a64_mov_i64(const int reg, const u64 val,
 }
 
 /*
- * This is an unoptimized 64 immediate emission used for BPF to BPF call
- * addresses. It will always do a full 64 bit decomposition as otherwise
- * more complexity in the last extra pass is required since we previously
- * reserved 4 instructions for the address.
+ * Kernel addresses in the vmalloc space use at most 48 bits, and the
+ * remaining bits are guaranteed to be 0x1. So we can compose the address
+ * with a fixed length movn/movk/movk sequence.
  */
 static inline void emit_addr_mov_i64(const int reg, const u64 val,
 				     struct jit_ctx *ctx)
@@ -145,8 +144,8 @@ static inline void emit_addr_mov_i64(const int reg, const u64 val,
 	u64 tmp = val;
 	int shift = 0;
 
-	emit(A64_MOVZ(1, reg, tmp & 0xffff, shift), ctx);
-	for (;shift < 48;) {
+	emit(A64_MOVN(1, reg, ~tmp & 0xffff, shift), ctx);
+	while (shift < 32) {
 		tmp >>= 16;
 		shift += 16;
 		emit(A64_MOVK(1, reg, tmp & 0xffff, shift), ctx);
@@ -627,10 +626,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		const u8 r0 = bpf2a64[BPF_REG_0];
 		const u64 func = (u64)__bpf_call_base + imm;
 
-		if (ctx->prog->is_func)
-			emit_addr_mov_i64(tmp, func, ctx);
-		else
-			emit_a64_mov_i64(tmp, func, ctx);
+		emit_addr_mov_i64(tmp, func, ctx);
 		emit(A64_BLR(tmp), ctx);
 		emit(A64_MOV(1, r0, A64_R(0)), ctx);
 		break;
-- 
2.19.1
