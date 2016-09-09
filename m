From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  9 Sep 2016 14:07:08 +0100
Subject: [PATCH v4 1/9] arm64: Set the safe value for L1 icache policy
In-Reply-To: <1473426436-17870-1-git-send-email-suzuki.poulose@arm.com>
References: <1473426436-17870-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1473426436-17870-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now we use 0 as the safe value for CTR_EL0:L1Ip, which is
not defined at the moment. The safer value for the L1Ip should be
the weakest of the policies, which happens to be AIVIVT. While at it,
fix the comment about safe_val.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 2 +-
 arch/arm64/kernel/cpufeature.c      | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c07c5d1..df47969 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -63,7 +63,7 @@ struct arm64_ftr_bits {
 	enum ftr_type	type;
 	u8		shift;
 	u8		width;
-	s64		safe_val; /* safe value for discrete features */
+	s64		safe_val; /* safe value for FTR_EXACT features */
 };
 
 /*
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c3d7ae4..4a19138d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -147,9 +147,10 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
-	 * make use of *minLine
+	 * make use of *minLine.
+	 * If we have differing I-cache policies, report it as the weakest - AIVIVT.
 	 */
-	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, 14, 2, 0),	/* L1Ip */
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_AIVIVT),	/* L1Ip */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 10, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
 	ARM64_FTR_END,
-- 
2.7.4
