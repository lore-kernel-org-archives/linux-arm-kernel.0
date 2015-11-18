From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 18 Nov 2015 17:08:56 +0000
Subject: [PATCH 1/5] arm64: cpufeature: Add helpers for extracting unsigned
 values
In-Reply-To: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpuid_feature_extract_field() extracts the feature value
as a signed integer. This could be problematic for features
whose values are unsigned. e.g, ID_AA64DFR0_EL1:BRPs. Add
an unsigned variant for the unsigned fields.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 11d5bb0f..7a16102 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -123,6 +123,18 @@ cpuid_feature_extract_field(u64 features, int field)
 	return cpuid_feature_extract_field_width(features, field, 4);
 }
 
+static inline unsigned int __attribute_const__
+cpuid_feature_extract_unsigned_field_width(u64 features, int field, int width)
+{
+	return (u64)(features << (64 - width - field)) >> (64 - width);
+}
+
+static inline unsigned int __attribute_const__
+cpuid_feature_extract_unsigned_field(u64 features, int field)
+{
+	return cpuid_feature_extract_unsigned_field_width(features, field, 4);
+}
+
 static inline u64 arm64_ftr_mask(struct arm64_ftr_bits *ftrp)
 {
 	return (u64)GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);
-- 
1.7.9.5
