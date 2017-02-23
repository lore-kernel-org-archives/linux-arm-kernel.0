From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Feb 2017 16:03:17 +0000
Subject: [PATCH] arm64/cpufeature: check correct field width when updating
 sys_val
Message-ID: <1487865797-25418-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we're updating a register's sys_val, we use arm64_ftr_value() to
find the new field value. We use cpuid_feature_extract_field() to find
the new value, but this implicitly assumes a 4-bit field, so we may
extract more bits than we mean to for fields like CTR_EL0.L1ip.

This affects update_cpu_ftr_reg(), where we may extract erroneous values
for ftr_cur and ftr_new. Depending on the additional bits extracted in
either case, we may erroneously detect that the value is mismatched, and
we'll try to compute a new safe value.

Dependent on these extra bits and feature type, arm64_ftr_safe_value()
may pessimistically select the always-safe value, or may erroneously
choose either the extracted cur or new value as the safe option. The
extra bits will subsequently be masked out in arm64_ftr_set_value(), so
we may choose a higher value, yet write back a lower one.

Fix this by passing the width down explicitly in arm64_ftr_value(), so
we always extract the correct amount.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Strictly speaking, this fixes:

  3c739b5710843621 ("arm64: Keep track of CPU feature registers")

... but this doesn't (yet) have any functional impact.

Luckily the L1ip detection reads from cpuinfo_arm64 directly, and is not
affected by this error.

Mark.

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 4ce82ed..05310ad 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -184,16 +184,22 @@ static inline u64 arm64_ftr_reg_user_value(const struct arm64_ftr_reg *reg)
 }
 
 static inline int __attribute_const__
-cpuid_feature_extract_field(u64 features, int field, bool sign)
+cpuid_feature_extract_field_width(u64 features, int field, int width, bool sign)
 {
 	return (sign) ?
-		cpuid_feature_extract_signed_field(features, field) :
-		cpuid_feature_extract_unsigned_field(features, field);
+		cpuid_feature_extract_signed_field_width(features, field, width) :
+		cpuid_feature_extract_unsigned_field_width(features, field, width);
+}
+
+static inline int __attribute_const__
+cpuid_feature_extract_field(u64 features, int field, bool sign)
+{
+	return cpuid_feature_extract_field_width(features, field, 4, sign);
 }
 
 static inline s64 arm64_ftr_value(const struct arm64_ftr_bits *ftrp, u64 val)
 {
-	return (s64)cpuid_feature_extract_field(val, ftrp->shift, ftrp->sign);
+	return (s64)cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width, ftrp->sign);
 }
 
 static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
-- 
1.9.1
