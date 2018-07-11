From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:32:38 +0100
Subject: [PATCH net-next v2 14/14] ARM: net: bpf: use double-word load/stores
 where available
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBUE-0001Jv-Ae@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use double-word load and stores where support for this instruction is
supported by the CPU architecture.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 55 ++++++++++++++++++++++++++++++++++++-----------
 arch/arm/net/bpf_jit_32.h |  2 ++
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 006ff9615850..a9f68a924800 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -22,6 +22,7 @@
 #include <asm/cacheflush.h>
 #include <asm/hwcap.h>
 #include <asm/opcodes.h>
+#include <asm/system_info.h>
 
 #include "bpf_jit_32.h"
 
@@ -192,6 +193,7 @@ struct jit_ctx {
 	unsigned int idx;
 	unsigned int prologue_bytes;
 	unsigned int epilogue_offset;
+	unsigned int cpu_architecture;
 	u32 flags;
 	u32 *offsets;
 	u32 *target;
@@ -319,10 +321,12 @@ static u32 arm_bpf_ldst_imm8(u32 op, u8 rt, u8 rn, s16 imm8)
 
 #define ARM_LDR_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_LDR_I, rt, rn, off)
 #define ARM_LDRB_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_LDRB_I, rt, rn, off)
+#define ARM_LDRD_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_LDRD_I, rt, rn, off)
 #define ARM_LDRH_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_LDRH_I, rt, rn, off)
 
 #define ARM_STR_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_STR_I, rt, rn, off)
 #define ARM_STRB_I(rt, rn, off)	arm_bpf_ldst_imm12(ARM_INST_STRB_I, rt, rn, off)
+#define ARM_STRD_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_STRD_I, rt, rn, off)
 #define ARM_STRH_I(rt, rn, off)	arm_bpf_ldst_imm8(ARM_INST_STRH_I, rt, rn, off)
 
 /*
@@ -533,10 +537,16 @@ static const s8 *arm_bpf_get_reg64(const s8 *reg, const s8 *tmp,
 				   struct jit_ctx *ctx)
 {
 	if (is_stacked(reg[1])) {
-		emit(ARM_LDR_I(tmp[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[1])),
-		     ctx);
-		emit(ARM_LDR_I(tmp[0], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[0])),
-		     ctx);
+		if (__LINUX_ARM_ARCH__ >= 6 ||
+		    ctx->cpu_architecture >= CPU_ARCH_ARMv5TE) {
+			emit(ARM_LDRD_I(tmp[1], ARM_FP,
+					EBPF_SCRATCH_TO_ARM_FP(reg[1])), ctx);
+		} else {
+			emit(ARM_LDR_I(tmp[1], ARM_FP,
+				       EBPF_SCRATCH_TO_ARM_FP(reg[1])), ctx);
+			emit(ARM_LDR_I(tmp[0], ARM_FP,
+				       EBPF_SCRATCH_TO_ARM_FP(reg[0])), ctx);
+		}
 		reg = tmp;
 	}
 	return reg;
@@ -558,10 +568,16 @@ static void arm_bpf_put_reg64(const s8 *reg, const s8 *src,
 			      struct jit_ctx *ctx)
 {
 	if (is_stacked(reg[1])) {
-		emit(ARM_STR_I(src[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[1])),
-		     ctx);
-		emit(ARM_STR_I(src[0], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(reg[0])),
-		     ctx);
+		if (__LINUX_ARM_ARCH__ >= 6 ||
+		    ctx->cpu_architecture >= CPU_ARCH_ARMv5TE) {
+			emit(ARM_STRD_I(src[1], ARM_FP,
+				       EBPF_SCRATCH_TO_ARM_FP(reg[1])), ctx);
+		} else {
+			emit(ARM_STR_I(src[1], ARM_FP,
+				       EBPF_SCRATCH_TO_ARM_FP(reg[1])), ctx);
+			emit(ARM_STR_I(src[0], ARM_FP,
+				       EBPF_SCRATCH_TO_ARM_FP(reg[0])), ctx);
+		}
 	} else {
 		if (reg[1] != src[1])
 			emit(ARM_MOV_R(reg[1], src[1]), ctx);
@@ -711,13 +727,27 @@ static inline void emit_a32_mov_r(const s8 dst, const s8 src,
 static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 				  const s8 src[],
 				  struct jit_ctx *ctx) {
-	emit_a32_mov_r(dst_lo, src_lo, ctx);
-	if (is64) {
+	if (!is64) {
+		emit_a32_mov_r(dst_lo, src_lo, ctx);
+		/* Zero out high 4 bytes */
+		emit_a32_mov_i(dst_hi, 0, ctx);
+	} else if (__LINUX_ARM_ARCH__ < 6 &&
+		   ctx->cpu_architecture < CPU_ARCH_ARMv5TE) {
 		/* complete 8 byte move */
+		emit_a32_mov_r(dst_lo, src_lo, ctx);
 		emit_a32_mov_r(dst_hi, src_hi, ctx);
+	} else if (is_stacked(src_lo) && is_stacked(dst_lo)) {
+		const u8 *tmp = bpf2a32[TMP_REG_1];
+
+		emit(ARM_LDRD_I(tmp[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(src_lo)), ctx);
+		emit(ARM_STRD_I(tmp[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(dst_lo)), ctx);
+	} else if (is_stacked(src_lo)) {
+		emit(ARM_LDRD_I(dst[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(src_lo)), ctx);
+	} else if (is_stacked(dst_lo)) {
+		emit(ARM_STRD_I(src[1], ARM_FP, EBPF_SCRATCH_TO_ARM_FP(dst_lo)), ctx);
 	} else {
-		/* Zero out high 4 bytes */
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		emit(ARM_MOV_R(dst[0], src[0]), ctx);
+		emit(ARM_MOV_R(dst[1], src[1]), ctx);
 	}
 }
 
@@ -1778,6 +1808,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.prog = prog;
+	ctx.cpu_architecture = cpu_architecture();
 
 	/* Not able to allocate memory for offsets[] , then
 	 * we must fall back to the interpreter
diff --git a/arch/arm/net/bpf_jit_32.h b/arch/arm/net/bpf_jit_32.h
index e541a7a6139a..f4e58bcdaa43 100644
--- a/arch/arm/net/bpf_jit_32.h
+++ b/arch/arm/net/bpf_jit_32.h
@@ -81,6 +81,7 @@
 #define ARM_INST_LDST__IMM12	0x00000fff
 #define ARM_INST_LDRB_I		0x05500000
 #define ARM_INST_LDRB_R		0x07d00000
+#define ARM_INST_LDRD_I		0x014000d0
 #define ARM_INST_LDRH_I		0x015000b0
 #define ARM_INST_LDRH_R		0x019000b0
 #define ARM_INST_LDR_I		0x05100000
@@ -128,6 +129,7 @@
 
 #define ARM_INST_STR_I		0x05000000
 #define ARM_INST_STRB_I		0x05400000
+#define ARM_INST_STRD_I		0x014000f0
 #define ARM_INST_STRH_I		0x014000b0
 
 #define ARM_INST_TST_R		0x01100000
-- 
2.7.4
