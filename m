From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 17 Nov 2015 14:05:39 +0900
Subject: [PATCH] arm64: extract a field correctly in
 cpuid_feature_extract_field()
Message-ID: <1447736739-4131-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basically, cpuid_feature_extract_field() does shift-left and then
shift-right to extract a specific field in an operand. But
a shift-left'ed value is casted to 's64' and so a succeeding shift-right
operation results in creating a sign-extended (and bogus) value.

For example, commit 3085bb01b406 ("arm64/debug: Make use of the system
wide safe value") changed get_num_brps() using this function, and so
we cannot identify the correct number of hw breakpoints available:

> hw-breakpoint: found 0 breakpoint and 0 watchpoint registers.

ID_AARCH64DFR0_EL1 is 0xf0f0f106 (on fast model), but get_num_brps()
returns zero.

This patch fixes the issue by removing the casting.
I think that cpuid_featuer_extract_field(), arm64_ftr_value() and others
should return an unsigned value as an extracted field.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/cpufeature.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 11d5bb0f..ab01508 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -114,7 +114,7 @@ static inline void cpus_set_cap(unsigned int num)
 static inline int __attribute_const__
 cpuid_feature_extract_field_width(u64 features, int field, int width)
 {
-	return (s64)(features << (64 - width - field)) >> (64 - width);
+	return (features << (64 - width - field)) >> (64 - width);
 }
 
 static inline int __attribute_const__
-- 
1.7.9.5
