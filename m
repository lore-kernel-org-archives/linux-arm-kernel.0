From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 12 Jul 2018 21:50:56 +0100
Subject: [PATCH net-next 4/4] ARM: net: bpf: improve 64-bit ALU implementation
In-Reply-To: <20180712205003.GU17271@n2100.armlinux.org.uk>
References: <20180712205003.GU17271@n2100.armlinux.org.uk>
Message-ID: <E1fdiYC-0002PE-W5@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improbe the 64-bit ALU implementation from:

  movw    r8, #65532
  movt    r8, #65535
  movw    r9, #65535
  movt    r9, #65535
  ldr     r7, [fp, #-44]
  adds    r7, r7, r8
  str     r7, [fp, #-44]
  ldr     r7, [fp, #-40]
  adc     r7, r7, r9
  str     r7, [fp, #-40]

to:

  movw    r8, #65532
  movt    r8, #65535
  movw    r9, #65535
  movt    r9, #65535
  ldrd    r6, [fp, #-44]
  adds    r6, r6, r8
  adc     r7, r7, r9
  strd    r6, [fp, #-44]

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 026612ee8151..25b3ee85066e 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -716,11 +716,30 @@ static inline void emit_a32_alu_r(const s8 dst, const s8 src,
 static inline void emit_a32_alu_r64(const bool is64, const s8 dst[],
 				  const s8 src[], struct jit_ctx *ctx,
 				  const u8 op) {
-	emit_a32_alu_r(dst_lo, src_lo, ctx, is64, false, op);
-	if (is64)
-		emit_a32_alu_r(dst_hi, src_hi, ctx, is64, true, op);
-	else
-		emit_a32_mov_i(dst_hi, 0, ctx);
+	const s8 *tmp = bpf2a32[TMP_REG_1];
+	const s8 *tmp2 = bpf2a32[TMP_REG_2];
+	const s8 *rd;
+
+	rd = arm_bpf_get_reg64(dst, tmp, ctx);
+	if (is64) {
+		const s8 *rs;
+
+		rs = arm_bpf_get_reg64(src, tmp2, ctx);
+
+		/* ALU operation */
+		emit_alu_r(rd[1], rs[1], true, false, op, ctx);
+		emit_alu_r(rd[0], rs[0], true, true, op, ctx);
+	} else {
+		s8 rs;
+
+		rs = arm_bpf_get_reg32(src_lo, tmp2[1], ctx);
+
+		/* ALU operation */
+		emit_alu_r(rd[1], rs, true, false, op, ctx);
+		emit_a32_mov_i(rd[0], 0, ctx);
+	}
+
+	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
 /* dst = src (4 bytes)*/
-- 
2.7.4
