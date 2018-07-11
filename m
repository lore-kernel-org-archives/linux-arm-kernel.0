From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:32:12 +0100
Subject: [PATCH net-next v2 09/14] ARM: net: bpf: use immediate forms of
 instructions where possible
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBTo-0001JM-Mr@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than moving constants to a register and then using them in a
subsequent instruction, use them directly in the desired instruction
cutting out the "middle" register.  This removes two instructions from
the tail call code path.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 21 ++++++++++++---------
 arch/arm/net/bpf_jit_32.h |  1 +
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 2cc66aa44dfe..645653e1931e 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -304,7 +304,7 @@ static u32 arm_bpf_ldst_imm12(u32 op, u8 rt, u8 rn, s16 imm12)
 		op |= ARM_INST_LDST__U;
 	else
 		imm12 = -imm12;
-	return op | (imm12 & 0xfff);
+	return op | (imm12 & ARM_INST_LDST__IMM12);
 }
 
 static u32 arm_bpf_ldst_imm8(u32 op, u8 rt, u8 rn, s16 imm8)
@@ -1054,17 +1054,19 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	const int idx0 = ctx->idx;
 #define cur_offset (ctx->idx - idx0)
 #define jmp_offset (out_offset - (cur_offset) - 2)
-	u32 off, lo, hi;
+	u32 lo, hi;
 	s8 r_array, r_index;
+	int off;
 
 	/* if (index >= array->map.max_entries)
 	 *	goto out;
 	 */
+	BUILD_BUG_ON(offsetof(struct bpf_array, map.max_entries) >
+		     ARM_INST_LDST__IMM12);
 	off = offsetof(struct bpf_array, map.max_entries);
 	/* array->map.max_entries */
-	emit_a32_mov_i(tmp[1], off, ctx);
 	r_array = arm_bpf_get_reg32(r2[1], tmp2[1], ctx);
-	emit(ARM_LDR_R(tmp[1], r_array, tmp[1]), ctx);
+	emit(ARM_LDR_I(tmp[1], r_array, off), ctx);
 	/* index is 32-bit for arrays */
 	r_index = arm_bpf_get_reg32(r3[1], tmp2[1], ctx);
 	/* index >= array->map.max_entries */
@@ -1089,10 +1091,10 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 * if (prog == NULL)
 	 *	goto out;
 	 */
-	off = offsetof(struct bpf_array, ptrs);
-	emit_a32_mov_i(tmp[1], off, ctx);
+	BUILD_BUG_ON(imm8m(offsetof(struct bpf_array, ptrs)) < 0);
+	off = imm8m(offsetof(struct bpf_array, ptrs));
 	r_array = arm_bpf_get_reg32(r2[1], tmp2[1], ctx);
-	emit(ARM_ADD_R(tmp[1], r_array, tmp[1]), ctx);
+	emit(ARM_ADD_I(tmp[1], r_array, off), ctx);
 	r_index = arm_bpf_get_reg32(r3[1], tmp2[1], ctx);
 	emit(ARM_MOV_SI(tmp[0], r_index, SRTYPE_ASL, 2), ctx);
 	emit(ARM_LDR_R(tmp[1], tmp[1], tmp[0]), ctx);
@@ -1100,9 +1102,10 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	_emit(ARM_COND_EQ, ARM_B(jmp_offset), ctx);
 
 	/* goto *(prog->bpf_func + prologue_size); */
+	BUILD_BUG_ON(offsetof(struct bpf_prog, bpf_func) >
+		     ARM_INST_LDST__IMM12);
 	off = offsetof(struct bpf_prog, bpf_func);
-	emit_a32_mov_i(tmp2[1], off, ctx);
-	emit(ARM_LDR_R(tmp[1], tmp[1], tmp2[1]), ctx);
+	emit(ARM_LDR_I(tmp[1], tmp[1], off), ctx);
 	emit(ARM_ADD_I(tmp[1], tmp[1], ctx->prologue_bytes), ctx);
 	emit_bx_r(tmp[1], ctx);
 
diff --git a/arch/arm/net/bpf_jit_32.h b/arch/arm/net/bpf_jit_32.h
index c55bc39d3e22..dee8a76fb0bc 100644
--- a/arch/arm/net/bpf_jit_32.h
+++ b/arch/arm/net/bpf_jit_32.h
@@ -78,6 +78,7 @@
 #define ARM_INST_EOR_I		0x02200000
 
 #define ARM_INST_LDST__U	0x00800000
+#define ARM_INST_LDST__IMM12	0x00000fff
 #define ARM_INST_LDRB_I		0x05500000
 #define ARM_INST_LDRB_R		0x07d00000
 #define ARM_INST_LDRH_I		0x015000b0
-- 
2.7.4
