From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 15 Dec 2015 17:33:42 +0900
Subject: [PATCH v7 4/6] arm64: insn: add instruction decoders for ldp/stp and
 add/sub
In-Reply-To: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
References: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1450168424-10010-5-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once a function prologue analyzer is implemented, it can be utilized to
make the output from ftrace-based stack tracer more precise, especially
stack usage for each function. But the current insn routines
lacks support for some instructions, including stp, add, sub and mov to
parse a function prologue.

This patch adds decoders against such instructions. Those decoders are
used solely by stack tracer for now, but generic enough for other uses.

Reviewed-by: Jungseok Lee <jungseoklee85@gmail.com>
Tested-by: Jungseok Lee <jungseoklee85@gmail.com>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/insn.h |   18 ++++++
 arch/arm64/kernel/insn.c      |  128 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 138 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 30e50eb..6fca8b0 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -161,6 +161,8 @@ enum aarch64_insn_size_type {
 enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_LOAD_REG_OFFSET,
 	AARCH64_INSN_LDST_STORE_REG_OFFSET,
+	AARCH64_INSN_LDST_LOAD_PAIR_REG_OFFSET,
+	AARCH64_INSN_LDST_STORE_PAIR_REG_OFFSET,
 	AARCH64_INSN_LDST_LOAD_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
@@ -225,6 +227,8 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
 
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
+__AARCH64_INSN_FUNCS(stp_reg,	0x7FC00000, 0x29000000)
+__AARCH64_INSN_FUNCS(ldp_reg,	0x7FC00000, 0x29400000)
 __AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
 __AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
 __AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
@@ -277,6 +281,7 @@ __AARCH64_INSN_FUNCS(hint,	0xFFFFF01F, 0xD503201F)
 __AARCH64_INSN_FUNCS(br,	0xFFFFFC1F, 0xD61F0000)
 __AARCH64_INSN_FUNCS(blr,	0xFFFFFC1F, 0xD63F0000)
 __AARCH64_INSN_FUNCS(ret,	0xFFFFFC1F, 0xD65F0000)
+__AARCH64_INSN_FUNCS(eret,	0xFFFFFFFF, 0xD69F03E0)
 
 #undef	__AARCH64_INSN_FUNCS
 
@@ -370,6 +375,19 @@ bool aarch32_insn_is_wide(u32 insn);
 u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
 u32 aarch32_insn_mcr_extract_opc2(u32 insn);
 u32 aarch32_insn_mcr_extract_crm(u32 insn);
+int aarch64_insn_extract_add_sub_imm(u32 insn,
+				     enum aarch64_insn_register *dst,
+				     enum aarch64_insn_register *src,
+				     int *imm,
+				     enum aarch64_insn_variant *variant,
+				     enum aarch64_insn_adsb_type *type);
+int aarch64_insn_extract_load_store_pair(u32 insn,
+					 enum aarch64_insn_register *reg1,
+					 enum aarch64_insn_register *reg2,
+					 enum aarch64_insn_register *base,
+					 int *offset,
+					 enum aarch64_insn_variant *variant,
+					 enum aarch64_insn_ldst_type *type);
 #endif /* __ASSEMBLY__ */
 
 #endif	/* __ASM_INSN_H */
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index c08b9ad..99d6e57 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -33,6 +33,7 @@
 #include <asm/insn.h>
 
 #define AARCH64_INSN_SF_BIT	BIT(31)
+#define AARCH64_INSN_S_BIT	BIT(29)
 #define AARCH64_INSN_N_BIT	BIT(22)
 
 static int aarch64_insn_encoding_class[] = {
@@ -388,17 +389,10 @@ u32 __kprobes aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 	return insn;
 }
 
-static u32 aarch64_insn_encode_register(enum aarch64_insn_register_type type,
-					u32 insn,
-					enum aarch64_insn_register reg)
+static int aarch64_insn_get_reg_shift(enum aarch64_insn_register_type type)
 {
 	int shift;
 
-	if (reg < AARCH64_INSN_REG_0 || reg > AARCH64_INSN_REG_SP) {
-		pr_err("%s: unknown register encoding %d\n", __func__, reg);
-		return 0;
-	}
-
 	switch (type) {
 	case AARCH64_INSN_REGTYPE_RT:
 	case AARCH64_INSN_REGTYPE_RD:
@@ -415,6 +409,26 @@ static u32 aarch64_insn_encode_register(enum aarch64_insn_register_type type,
 		shift = 16;
 		break;
 	default:
+		shift = -1;
+		break;
+	}
+
+	return shift;
+}
+
+static u32 aarch64_insn_encode_register(enum aarch64_insn_register_type type,
+					u32 insn,
+					enum aarch64_insn_register reg)
+{
+	int shift;
+
+	if (reg < AARCH64_INSN_REG_0 || reg > AARCH64_INSN_REG_SP) {
+		pr_err("%s: unknown register encoding %d\n", __func__, reg);
+		return 0;
+	}
+
+	shift = aarch64_insn_get_reg_shift(type);
+	if (shift < 0) {
 		pr_err("%s: unknown register type encoding %d\n", __func__,
 		       type);
 		return 0;
@@ -632,6 +646,12 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 	int shift;
 
 	switch (type) {
+	case AARCH64_INSN_LDST_LOAD_PAIR_REG_OFFSET:
+		insn = aarch64_insn_get_ldp_reg_value();
+		break;
+	case AARCH64_INSN_LDST_STORE_PAIR_REG_OFFSET:
+		insn = aarch64_insn_get_stp_reg_value();
+		break;
 	case AARCH64_INSN_LDST_LOAD_PAIR_PRE_INDEX:
 		insn = aarch64_insn_get_ldp_pre_value();
 		break;
@@ -1141,3 +1161,95 @@ u32 aarch32_insn_mcr_extract_crm(u32 insn)
 {
 	return insn & CRM_MASK;
 }
+
+static enum aarch64_insn_register aarch64_insn_decode_reg_num(u32 insn,
+				enum aarch64_insn_register_type type)
+{
+	int shift;
+
+	shift = aarch64_insn_get_reg_shift(type);
+	if (shift < 0) {
+		pr_err("%s: unknown register type decoding %d\n", __func__,
+		       type);
+		return ~0L;
+	}
+
+	return (insn >> shift) & 0x1f;
+}
+
+int aarch64_insn_extract_add_sub_imm(u32 insn,
+				     enum aarch64_insn_register *dst,
+				     enum aarch64_insn_register *src,
+				     int *imm,
+				     enum aarch64_insn_variant *variant,
+				     enum aarch64_insn_adsb_type *type)
+{
+	int shift;
+
+	if (aarch64_insn_is_add_imm(insn))
+		*type =	((insn) & AARCH64_INSN_S_BIT) ?
+				AARCH64_INSN_ADSB_ADD_SETFLAGS :
+				AARCH64_INSN_ADSB_ADD;
+	else if (aarch64_insn_is_sub_imm(insn))
+		*type =	((insn) & AARCH64_INSN_S_BIT) ?
+				AARCH64_INSN_ADSB_SUB_SETFLAGS :
+				AARCH64_INSN_ADSB_SUB;
+	else
+		return -EINVAL;
+
+	*variant = (insn & AARCH64_INSN_SF_BIT) ? AARCH64_INSN_VARIANT_64BIT :
+					AARCH64_INSN_VARIANT_32BIT;
+
+	*dst = aarch64_insn_decode_reg_num(insn, AARCH64_INSN_REGTYPE_RD);
+
+	*src = aarch64_insn_decode_reg_num(insn, AARCH64_INSN_REGTYPE_RN);
+
+	*imm = (int)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12, insn);
+	shift = (insn >> 22) & 0x3;
+	if (shift == 0x1)
+		*imm <<= 12;
+	else if (shift != 0x0)
+		return -EINVAL;
+
+	return 0;
+}
+
+int aarch64_insn_extract_load_store_pair(u32 insn,
+					 enum aarch64_insn_register *reg1,
+					 enum aarch64_insn_register *reg2,
+					 enum aarch64_insn_register *base,
+					 int *offset,
+					 enum aarch64_insn_variant *variant,
+					 enum aarch64_insn_ldst_type *type)
+{
+	u64 imm;
+
+	if (aarch64_insn_is_stp_reg(insn))
+		*type = AARCH64_INSN_LDST_STORE_PAIR_REG_OFFSET;
+	else if (aarch64_insn_is_stp_post(insn))
+		*type = AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX;
+	else if (aarch64_insn_is_stp_pre(insn))
+		*type = AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX;
+	else if (aarch64_insn_is_ldp_reg(insn))
+		*type = AARCH64_INSN_LDST_LOAD_PAIR_REG_OFFSET;
+	else if (aarch64_insn_is_ldp_post(insn))
+		*type = AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX;
+	else if (aarch64_insn_is_ldp_pre(insn))
+		*type = AARCH64_INSN_LDST_LOAD_PAIR_PRE_INDEX;
+	else
+		return -EINVAL;
+
+	*variant = (insn & AARCH64_INSN_S_BIT) ? AARCH64_INSN_VARIANT_64BIT :
+				AARCH64_INSN_VARIANT_32BIT;
+
+	*reg1 = aarch64_insn_decode_reg_num(insn, AARCH64_INSN_REGTYPE_RT);
+
+	*reg2 = aarch64_insn_decode_reg_num(insn, AARCH64_INSN_REGTYPE_RT2);
+
+	*base = aarch64_insn_decode_reg_num(insn, AARCH64_INSN_REGTYPE_RN);
+
+	imm = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_7, insn);
+	*offset = (int)(sign_extend64(imm, 6) * 8);
+
+	return 0;
+}
-- 
1.7.9.5
