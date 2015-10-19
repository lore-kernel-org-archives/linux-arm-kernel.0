From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:00:30 +0100
Subject: [PATCHv4 07/24] arm64: Handle width of a cpuid feature
In-Reply-To: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
References: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445259647-21541-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a helper to extract cpuid feature for any given
width.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b5f313d..85507fe 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -76,10 +76,16 @@ static inline void cpus_set_cap(unsigned int num)
 		__set_bit(num, cpu_hwcaps);
 }
 
-static inline int __attribute_const__ cpuid_feature_extract_field(u64 features,
-								  int field)
+static inline int __attribute_const__
+cpuid_feature_extract_field_width(u64 features, int field, int width)
 {
-	return (s64)(features << (64 - 4 - field)) >> (64 - 4);
+	return (s64)(features << (64 - width - field)) >> (64 - width);
+}
+
+static inline int __attribute_const__
+cpuid_feature_extract_field(u64 features, int field)
+{
+	return cpuid_feature_extract_field_width(features, field, 4);
 }
 
 static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
-- 
1.7.9.5
