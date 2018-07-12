From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 12 Jul 2018 21:50:51 +0100
Subject: [PATCH net-next 3/4] ARM: net: bpf: improve 64-bit store
 implementation
In-Reply-To: <20180712205003.GU17271@n2100.armlinux.org.uk>
References: <20180712205003.GU17271@n2100.armlinux.org.uk>
Message-ID: <E1fdiY7-0002P7-Rj@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the 64-bit store implementation from:

  ldr     r6, [fp, #-8]
  str     r8, [r6]
  ldr     r6, [fp, #-8]
  mov     r7, #4
  add     r7, r6, r7
  str     r9, [r7]

to:

  ldr     r6, [fp, #-8]
  str     r8, [r6]
  str     r9, [r6, #4]

We leave the store as two separate STR instructions rather than using
STRD as the store may not be aligned, and STR can handle misalignment.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 52 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 3a182e618441..026612ee8151 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -975,29 +975,42 @@ static inline void emit_a32_mul_r64(const s8 dst[], const s8 src[],
 }
 
 /* *(size *)(dst + off) = src */
-static inline void emit_str_r(const s8 dst, const s8 src,
-			      const s32 off, struct jit_ctx *ctx, const u8 sz){
+static inline void emit_str_r(const s8 dst, const s8 src[],
+			      s32 off, struct jit_ctx *ctx, const u8 sz){
 	const s8 *tmp = bpf2a32[TMP_REG_1];
+	s32 off_max;
 	s8 rd;
 
 	rd = arm_bpf_get_reg32(dst, tmp[1], ctx);
-	if (off) {
+
+	if (sz == BPF_H)
+		off_max = 0xff;
+	else
+		off_max = 0xfff;
+
+	if (off < 0 || off > off_max) {
 		emit_a32_mov_i(tmp[0], off, ctx);
-		emit(ARM_ADD_R(tmp[0], rd, tmp[0]), ctx);
+		emit(ARM_ADD_R(tmp[0], tmp[0], rd), ctx);
 		rd = tmp[0];
+		off = 0;
 	}
 	switch (sz) {
-	case BPF_W:
-		/* Store a Word */
-		emit(ARM_STR_I(src, rd, 0), ctx);
+	case BPF_B:
+		/* Store a Byte */
+		emit(ARM_STRB_I(src_lo, rd, off), ctx);
 		break;
 	case BPF_H:
 		/* Store a HalfWord */
-		emit(ARM_STRH_I(src, rd, 0), ctx);
+		emit(ARM_STRH_I(src_lo, rd, off), ctx);
 		break;
-	case BPF_B:
-		/* Store a Byte */
-		emit(ARM_STRB_I(src, rd, 0), ctx);
+	case BPF_W:
+		/* Store a Word */
+		emit(ARM_STR_I(src_lo, rd, off), ctx);
+		break;
+	case BPF_DW:
+		/* Store a Double Word */
+		emit(ARM_STR_I(src_lo, rd, off), ctx);
+		emit(ARM_STR_I(src_hi, rd, off + 4), ctx);
 		break;
 	}
 }
@@ -1539,16 +1552,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		case BPF_DW:
 			/* Sign-extend immediate value into temp reg */
 			emit_a32_mov_se_i64(true, tmp2, imm, ctx);
-			emit_str_r(dst_lo, tmp2[1], off, ctx, BPF_W);
-			emit_str_r(dst_lo, tmp2[0], off+4, ctx, BPF_W);
 			break;
 		case BPF_W:
 		case BPF_H:
 		case BPF_B:
 			emit_a32_mov_i(tmp2[1], imm, ctx);
-			emit_str_r(dst_lo, tmp2[1], off, ctx, BPF_SIZE(code));
 			break;
 		}
+		emit_str_r(dst_lo, tmp2, off, ctx, BPF_SIZE(code));
 		break;
 	/* STX XADD: lock *(u32 *)(dst + off) += src */
 	case BPF_STX | BPF_XADD | BPF_W:
@@ -1560,20 +1571,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_STX | BPF_MEM | BPF_H:
 	case BPF_STX | BPF_MEM | BPF_B:
 	case BPF_STX | BPF_MEM | BPF_DW:
-	{
-		u8 sz = BPF_SIZE(code);
-
 		rs = arm_bpf_get_reg64(src, tmp2, ctx);
-
-		/* Store the value */
-		if (BPF_SIZE(code) == BPF_DW) {
-			emit_str_r(dst_lo, rs[1], off, ctx, BPF_W);
-			emit_str_r(dst_lo, rs[0], off+4, ctx, BPF_W);
-		} else {
-			emit_str_r(dst_lo, rs[1], off, ctx, sz);
-		}
+		emit_str_r(dst_lo, rs, off, ctx, BPF_SIZE(code));
 		break;
-	}
 	/* PC += off if dst == src */
 	/* PC += off if dst > src */
 	/* PC += off if dst >= src */
-- 
2.7.4
