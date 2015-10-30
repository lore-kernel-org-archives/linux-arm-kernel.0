From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 30 Oct 2015 14:25:40 +0900
Subject: [PATCH v4 5/6] arm64: insn: add instruction decoders for ldp/stp and
 add/sub
In-Reply-To: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
References: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1446182741-31019-6-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A function prologue analyzer is a requisite for implementing stack tracer
and getting better views of stack usages on arm64.
To implement a function prologue analyzer, we have to be able to decode,
at least, stp, add, sub and mov instructions.

This patch adds decoders for those instructions, that are used solely
by stack tracer for now, but generic enough for other uses.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/insn.h |   18 ++++++++
 arch/arm64/kernel/insn.c      |  102 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 30e50eb..8d5c538 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -165,6 +165,8 @@ enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
 	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
+	AARCH64_INSN_LDST_LOAD_PAIR,
+	AARCH64_INSN_LDST_STORE_PAIR,
 };
 
 enum aarch64_insn_adsb_type {
@@ -225,6 +227,8 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
 
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
+__AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
+__AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
 __AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
 __AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
 __AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
@@ -277,6 +281,7 @@ __AARCH64_INSN_FUNCS(hint,	0xFFFFF01F, 0xD503201F)
 __AARCH64_INSN_FUNCS(br,	0xFFFFFC1F, 0xD61F0000)
 __AARCH64_INSN_FUNCS(blr,	0xFFFFFC1F, 0xD63F0000)
 __AARCH64_INSN_FUNCS(ret,	0xFFFFFC1F, 0xD65F0000)
+__AARCH64_INSN_FUNCS(eret,	0xFFFFFFFF, 0xD69F00E0)
 
 #undef	__AARCH64_INSN_FUNCS
 
@@ -370,6 +375,19 @@ bool aarch32_insn_is_wide(u32 insn);
 u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
 u32 aarch32_insn_mcr_extract_opc2(u32 insn);
 u32 aarch32_insn_mcr_extract_crm(u32 insn);
+int aarch64_insn_decode_add_sub_imm(u32 insn,
+				    enum aarch64_insn_register *dst,
+				    enum aarch64_insn_register *src,
+				    int *imm,
+				    enum aarch64_insn_variant *variant,
+				    enum aarch64_insn_adsb_type *type);
+int aarch64_insn_decode_load_store_pair(u32 insn,
+					enum aarch64_insn_register *reg1,
+					enum aarch64_insn_register *reg2,
+					enum aarch64_insn_register *base,
+					int *offset,
+					enum aarch64_insn_variant *variant,
+					enum aarch64_insn_ldst_type *type);
 #endif /* __ASSEMBLY__ */
 
 #endif	/* __ASM_INSN_H */
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index c08b9ad..b56a66c 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -33,6 +33,7 @@
 #include <asm/insn.h>
 
 #define AARCH64_INSN_SF_BIT	BIT(31)
+#define AARCH64_INSN_S_BIT	BIT(29)
 #define AARCH64_INSN_N_BIT	BIT(22)
 
 static int aarch64_insn_encoding_class[] = {
@@ -1141,3 +1142,104 @@ u32 aarch32_insn_mcr_extract_crm(u32 insn)
 {
 	return insn & CRM_MASK;
 }
+
+enum aarch64_insn_register aarch64_insn_extract_reg_num(u32 insn,
+				enum aarch64_insn_register_type type)
+{
+	int shift;
+
+	switch (type) {
+	case AARCH64_INSN_REGTYPE_RT:
+	case AARCH64_INSN_REGTYPE_RD:
+		shift = 0;
+		break;
+	case AARCH64_INSN_REGTYPE_RN:
+		shift = 5;
+		break;
+	case AARCH64_INSN_REGTYPE_RT2:
+	case AARCH64_INSN_REGTYPE_RA:
+		shift = 10;
+		break;
+	case AARCH64_INSN_REGTYPE_RM:
+		shift = 16;
+		break;
+	default:
+		pr_err("%s: unknown register type decoding %d\n", __func__,
+		       type);
+		return ~0L;
+	}
+
+	return (insn & (GENMASK(4, 0) << shift)) >> shift;
+}
+
+int aarch64_insn_decode_add_sub_imm(u32 insn,
+				    enum aarch64_insn_register *dst,
+				    enum aarch64_insn_register *src,
+				    int *imm,
+				    enum aarch64_insn_variant *variant,
+				    enum aarch64_insn_adsb_type *type)
+{
+	if (aarch64_insn_is_add_imm(insn))
+		*type =	((insn) & AARCH64_INSN_S_BIT) ?
+				AARCH64_INSN_ADSB_ADD_SETFLAGS :
+				AARCH64_INSN_ADSB_ADD;
+	else if (aarch64_insn_is_sub_imm(insn))
+		*type =	((insn) & AARCH64_INSN_S_BIT) ?
+				AARCH64_INSN_ADSB_SUB_SETFLAGS :
+				AARCH64_INSN_ADSB_SUB;
+	else
+		return 0;
+
+	*variant = (insn & AARCH64_INSN_SF_BIT) ? AARCH64_INSN_VARIANT_64BIT :
+					AARCH64_INSN_VARIANT_32BIT;
+
+	*dst = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RD);
+
+	*src = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RN);
+
+	/* TODO: ignore shilft field[23:22] */
+	*imm = (int)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12, insn);
+
+	return 1;
+}
+
+int aarch64_insn_decode_load_store_pair(u32 insn,
+					enum aarch64_insn_register *reg1,
+					enum aarch64_insn_register *reg2,
+					enum aarch64_insn_register *base,
+					int *offset,
+					enum aarch64_insn_variant *variant,
+					enum aarch64_insn_ldst_type *type)
+{
+	int imm;
+
+	if (aarch64_insn_is_stp(insn))
+		*type = AARCH64_INSN_LDST_STORE_PAIR;
+	else if (aarch64_insn_is_stp_post(insn))
+		*type = AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX;
+	else if (aarch64_insn_is_stp_pre(insn))
+		*type = AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX;
+	else if (aarch64_insn_is_ldp(insn))
+		*type = AARCH64_INSN_LDST_LOAD_PAIR;
+	else if (aarch64_insn_is_ldp_post(insn))
+		*type = AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX;
+	else if (aarch64_insn_is_ldp_pre(insn))
+		*type = AARCH64_INSN_LDST_LOAD_PAIR_PRE_INDEX;
+	else
+		return 0;
+
+	*variant = (insn & AARCH64_INSN_S_BIT) ? AARCH64_INSN_VARIANT_64BIT :
+				AARCH64_INSN_VARIANT_32BIT;
+
+	*reg1 = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RT);
+
+	*reg2 = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RT2);
+
+	*base = aarch64_insn_extract_reg_num(insn, AARCH64_INSN_REGTYPE_RN);
+
+	imm = (int)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_7, insn);
+	asm("sbfm %0, %0, 0, 6" : "+r" (imm));
+	*offset = imm * 8;
+
+	return 1;
+}
-- 
1.7.9.5
