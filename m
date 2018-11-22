From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 22 Nov 2018 09:46:45 +0100
Subject: [PATCH 1/2] arm64/insn: add support for emitting ADR/ADRP instructions
In-Reply-To: <20181122084646.3247-1-ard.biesheuvel@linaro.org>
References: <20181122084646.3247-1-ard.biesheuvel@linaro.org>
Message-ID: <20181122084646.3247-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for emitting ADR and ADRP instructions so we can switch
over our PLT generation code in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/insn.h |  8 ++++++
 arch/arm64/kernel/insn.c      | 29 ++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index c6802dea6cab..9c01f04db64d 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -261,6 +261,11 @@ enum aarch64_insn_prfm_policy {
 	AARCH64_INSN_PRFM_POLICY_STRM,
 };
 
+enum aarch64_insn_adr_type {
+	AARCH64_INSN_ADR_TYPE_ADRP,
+	AARCH64_INSN_ADR_TYPE_ADR,
+};
+
 #define	__AARCH64_INSN_FUNCS(abbr, mask, val)	\
 static __always_inline bool aarch64_insn_is_##abbr(u32 code) \
 { return (code & (mask)) == (val); } \
@@ -393,6 +398,9 @@ u32 aarch64_insn_gen_add_sub_imm(enum aarch64_insn_register dst,
 				 enum aarch64_insn_register src,
 				 int imm, enum aarch64_insn_variant variant,
 				 enum aarch64_insn_adsb_type type);
+u32 aarch64_insn_gen_adr(unsigned long pc, unsigned long addr,
+			 enum aarch64_insn_register reg,
+			 enum aarch64_insn_adr_type type);
 u32 aarch64_insn_gen_bitfield(enum aarch64_insn_register dst,
 			      enum aarch64_insn_register src,
 			      int immr, int imms,
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 2b3413549734..7820a4a688fa 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -1239,6 +1239,35 @@ u32 aarch64_insn_gen_logical_shifted_reg(enum aarch64_insn_register dst,
 	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_6, insn, shift);
 }
 
+u32 aarch64_insn_gen_adr(unsigned long pc, unsigned long addr,
+			 enum aarch64_insn_register reg,
+			 enum aarch64_insn_adr_type type)
+{
+	u32 insn;
+	s32 offset;
+
+	switch (type) {
+	case AARCH64_INSN_ADR_TYPE_ADR:
+		insn = aarch64_insn_get_adr_value();
+		offset = addr - pc;
+		break;
+	case AARCH64_INSN_ADR_TYPE_ADRP:
+		insn = aarch64_insn_get_adrp_value();
+		offset = (addr - ALIGN_DOWN(pc, SZ_4K)) >> 12;
+		break;
+	default:
+		pr_err("%s: unknown adr encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	if (offset < -SZ_1M || offset >= SZ_1M)
+		return AARCH64_BREAK_FAULT;
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, reg);
+
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_ADR, insn, offset);
+}
+
 /*
  * Decode the imm field of a branch, and return the byte offset as a
  * signed value (so it can be used when computing a new branch
-- 
2.17.1
