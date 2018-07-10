From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 13:36:44 +0100
Subject: [PATCH net-next 08/13] ARM: net: bpf: use immediate forms of
 instructions where possible
In-Reply-To: <20180710123340.GK17271@n2100.armlinux.org.uk>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
Message-ID: <E1fcrsq-0005V7-Pp@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than moving constants to a register and then using them in a
subsequent instruction, use them directly in the desired instruction
cutting out the "middle" register.  This removes two instructions from
the tail call code path.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 16 +++++++++-------
 arch/arm/net/bpf_jit_32.h |  3 +++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 753b5b2b2e3d..c7591877c350 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -256,7 +256,7 @@ static u32 arm_bpf_ldst_imm12(u32 op, u8 rt, u8 rn, s16 imm12)
 		op |= ARM_INST_LDST__U;
 	else
 		imm12 = -imm12;
-	return op | (imm12 & 0xfff);
+	return op | (imm12 & ARM_INST_LDST__IMM12);
 }
 
 static u32 arm_bpf_ldst_imm8(u32 op, u8 rt, u8 rn, s16 imm8)
@@ -1012,11 +1012,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
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
@@ -1041,10 +1042,10 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 * if (prog == NULL)
 	 *	goto out;
 	 */
+	BUILD_BUG_ON(offsetof(struct bpf_array, ptrs) > ARM_ALU_IMM);
 	off = offsetof(struct bpf_array, ptrs);
-	emit_a32_mov_i(tmp[1], off, ctx);
 	r_array = arm_bpf_get_reg32(r2[1], tmp2[1], ctx);
-	emit(ARM_ADD_R(tmp[1], r_array, tmp[1]), ctx);
+	emit(ARM_ADD_I(tmp[1], r_array, off), ctx);
 	r_index = arm_bpf_get_reg32(r3[1], tmp2[1], ctx);
 	emit(ARM_MOV_SI(tmp[0], r_index, SRTYPE_ASL, 2), ctx);
 	emit(ARM_LDR_R(tmp[1], tmp[1], tmp[0]), ctx);
@@ -1052,9 +1053,10 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
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
index c55bc39d3e22..ca9f1f5589f4 100644
--- a/arch/arm/net/bpf_jit_32.h
+++ b/arch/arm/net/bpf_jit_32.h
@@ -78,6 +78,7 @@
 #define ARM_INST_EOR_I		0x02200000
 
 #define ARM_INST_LDST__U	0x00800000
+#define ARM_INST_LDST__IMM12	0x00000fff
 #define ARM_INST_LDRB_I		0x05500000
 #define ARM_INST_LDRB_R		0x07d00000
 #define ARM_INST_LDRH_I		0x015000b0
@@ -154,6 +155,8 @@
  */
 #define ARM_INST_UDF		0xe7fddef1
 
+#define ARM_ALU_IMM		0xff
+
 /* register */
 #define _AL3_R(op, rd, rn, rm)	((op ## _R) | (rd) << 12 | (rn) << 16 | (rm))
 /* immediate */
-- 
2.7.4
