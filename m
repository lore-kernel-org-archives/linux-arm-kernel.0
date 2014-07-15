From: zlim.lnx@gmail.com (Zi Shen Lim)
Date: Mon, 14 Jul 2014 23:25:10 -0700
Subject: [PATCH RFCv3 12/14] arm64: introduce aarch64_insn_gen_data3()
In-Reply-To: <1405405512-4423-1-git-send-email-zlim.lnx@gmail.com>
References: <1405405512-4423-1-git-send-email-zlim.lnx@gmail.com>
Message-ID: <1405405512-4423-13-git-send-email-zlim.lnx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce function to generate data-processing (3 source) instructions.

Signed-off-by: Zi Shen Lim <zlim.lnx@gmail.com>
---
 arch/arm64/include/asm/insn.h | 14 ++++++++++++++
 arch/arm64/kernel/insn.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 367245f..36e8465 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -79,6 +79,7 @@ enum aarch64_insn_register_type {
 	AARCH64_INSN_REGTYPE_RT2,
 	AARCH64_INSN_REGTYPE_RM,
 	AARCH64_INSN_REGTYPE_RD,
+	AARCH64_INSN_REGTYPE_RA,
 };
 
 enum aarch64_insn_register {
@@ -200,6 +201,11 @@ enum aarch64_insn_data2_type {
 	AARCH64_INSN_DATA2_RORV,
 };
 
+enum aarch64_insn_data3_type {
+	AARCH64_INSN_DATA3_MADD,
+	AARCH64_INSN_DATA3_MSUB,
+};
+
 #define	__AARCH64_INSN_FUNCS(abbr, mask, val)	\
 static __always_inline bool aarch64_insn_is_##abbr(u32 code) \
 { return (code & (mask)) == (val); } \
@@ -226,6 +232,8 @@ __AARCH64_INSN_FUNCS(add,	0x7F200000, 0x0B000000)
 __AARCH64_INSN_FUNCS(adds,	0x7F200000, 0x2B000000)
 __AARCH64_INSN_FUNCS(sub,	0x7F200000, 0x4B000000)
 __AARCH64_INSN_FUNCS(subs,	0x7F200000, 0x6B000000)
+__AARCH64_INSN_FUNCS(madd,	0x7FE08000, 0x1B000000)
+__AARCH64_INSN_FUNCS(msub,	0x7FE08000, 0x1B008000)
 __AARCH64_INSN_FUNCS(udiv,	0x7FE0FC00, 0x1AC00800)
 __AARCH64_INSN_FUNCS(sdiv,	0x7FE0FC00, 0x1AC00C00)
 __AARCH64_INSN_FUNCS(lslv,	0x7FE0FC00, 0x1AC02000)
@@ -309,6 +317,12 @@ u32 aarch64_insn_gen_data2(enum aarch64_insn_register dst,
 			   enum aarch64_insn_register reg,
 			   enum aarch64_insn_variant variant,
 			   enum aarch64_insn_data2_type type);
+u32 aarch64_insn_gen_data3(enum aarch64_insn_register dst,
+			   enum aarch64_insn_register src,
+			   enum aarch64_insn_register reg1,
+			   enum aarch64_insn_register reg2,
+			   enum aarch64_insn_variant variant,
+			   enum aarch64_insn_data3_type type);
 
 bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
 
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 7778b18..01664e3 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -299,6 +299,7 @@ static u32 aarch64_insn_encode_register(enum aarch64_insn_register_type type,
 		shift = 5;
 		break;
 	case AARCH64_INSN_REGTYPE_RT2:
+	case AARCH64_INSN_REGTYPE_RA:
 		shift = 10;
 		break;
 	case AARCH64_INSN_REGTYPE_RM:
@@ -830,3 +831,44 @@ u32 aarch64_insn_gen_data2(enum aarch64_insn_register dst,
 
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, reg);
 }
+
+u32 aarch64_insn_gen_data3(enum aarch64_insn_register dst,
+			   enum aarch64_insn_register src,
+			   enum aarch64_insn_register reg1,
+			   enum aarch64_insn_register reg2,
+			   enum aarch64_insn_variant variant,
+			   enum aarch64_insn_data3_type type)
+{
+	u32 insn;
+
+	switch (type) {
+	case AARCH64_INSN_DATA3_MADD:
+		insn = aarch64_insn_get_madd_value();
+		break;
+	case AARCH64_INSN_DATA3_MSUB:
+		insn = aarch64_insn_get_msub_value();
+		break;
+	default:
+		BUG_ON(1);
+	}
+
+	switch (variant) {
+	case AARCH64_INSN_VARIANT_32BIT:
+		break;
+	case AARCH64_INSN_VARIANT_64BIT:
+		insn |= BIT(31);
+		break;
+	default:
+		BUG_ON(1);
+	}
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, dst);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RA, insn, src);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    reg1);
+
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn,
+					    reg2);
+}
-- 
1.9.1
