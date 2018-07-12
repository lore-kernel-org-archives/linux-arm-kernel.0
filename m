From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 12 Jul 2018 21:50:41 +0100
Subject: [PATCH net-next 1/4] ARM: net: bpf: improve 64-bit load immediate
 implementation
In-Reply-To: <20180712205003.GU17271@n2100.armlinux.org.uk>
References: <20180712205003.GU17271@n2100.armlinux.org.uk>
Message-ID: <E1fdiXx-0002Ot-Hx@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than writing each 32-bit half of the 64-bit immediate value
separately when the register is on the stack:

  movw    r6, #45056      ; 0xb000
  movt    r6, #60979      ; 0xee33
  str     r6, [fp, #-44]  ; 0xffffffd4
  mov     r6, #0
  str     r6, [fp, #-40]  ; 0xffffffd8

arrange to use the double-word store when available instead:

  movw    r6, #45056      ; 0xb000
  movt    r6, #60979      ; 0xee33
  mov     r7, #0
  strd    r6, [fp, #-44]  ; 0xffffffd4

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index a9f68a924800..6558bd73bbb9 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -599,9 +599,20 @@ static inline void emit_a32_mov_i(const s8 dst, const u32 val,
 	}
 }
 
+static void emit_a32_mov_i64(const s8 dst[], u64 val, struct jit_ctx *ctx)
+{
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *rd = is_stacked(dst_lo) ? tmp : dst;
+
+	emit_mov_i(rd[1], (u32)val, ctx);
+	emit_mov_i(rd[0], val >> 32, ctx);
+
+	arm_bpf_put_reg64(dst, rd, ctx);
+}
+
 /* Sign extended move */
-static inline void emit_a32_mov_i64(const bool is64, const s8 dst[],
-				  const u32 val, struct jit_ctx *ctx) {
+static inline void emit_a32_mov_se_i64(const bool is64, const s8 dst[],
+				       const u32 val, struct jit_ctx *ctx) {
 	u32 hi = 0;
 
 	if (is64 && (val & (1<<31)))
@@ -1309,7 +1320,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			break;
 		case BPF_K:
 			/* Sign-extend immediate value to destination reg */
-			emit_a32_mov_i64(is64, dst, imm, ctx);
+			emit_a32_mov_se_i64(is64, dst, imm, ctx);
 			break;
 		}
 		break;
@@ -1358,7 +1369,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			 * value into temporary reg and then it would be
 			 * safe to do the operation on it.
 			 */
-			emit_a32_mov_i64(is64, tmp2, imm, ctx);
+			emit_a32_mov_se_i64(is64, tmp2, imm, ctx);
 			emit_a32_alu_r64(is64, dst, tmp2, ctx, BPF_OP(code));
 			break;
 		}
@@ -1454,7 +1465,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			 * reg then it would be safe to do the operation
 			 * on it.
 			 */
-			emit_a32_mov_i64(is64, tmp2, imm, ctx);
+			emit_a32_mov_se_i64(is64, tmp2, imm, ctx);
 			emit_a32_mul_r64(dst, tmp2, ctx);
 			break;
 		}
@@ -1506,12 +1517,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = imm64 */
 	case BPF_LD | BPF_IMM | BPF_DW:
 	{
-		const struct bpf_insn insn1 = insn[1];
-		u32 hi, lo = imm;
+		u64 val = (u32)imm | (u64)insn[1].imm << 32;
 
-		hi = insn1.imm;
-		emit_a32_mov_i(dst_lo, lo, ctx);
-		emit_a32_mov_i(dst_hi, hi, ctx);
+		emit_a32_mov_i64(dst, val, ctx);
 
 		return 1;
 	}
@@ -1531,7 +1539,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		switch (BPF_SIZE(code)) {
 		case BPF_DW:
 			/* Sign-extend immediate value into temp reg */
-			emit_a32_mov_i64(true, tmp2, imm, ctx);
+			emit_a32_mov_se_i64(true, tmp2, imm, ctx);
 			emit_str_r(dst_lo, tmp2[1], off, ctx, BPF_W);
 			emit_str_r(dst_lo, tmp2[0], off+4, ctx, BPF_W);
 			break;
@@ -1620,7 +1628,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		rm = tmp2[0];
 		rn = tmp2[1];
 		/* Sign-extend immediate value */
-		emit_a32_mov_i64(true, tmp2, imm, ctx);
+		emit_a32_mov_se_i64(true, tmp2, imm, ctx);
 go_jmp:
 		/* Setup destination register */
 		rd = arm_bpf_get_reg64(dst, tmp, ctx);
-- 
2.7.4
