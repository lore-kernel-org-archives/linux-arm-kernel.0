From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jan 2017 16:03:40 +0000
Subject: [RFC PATCH v2 01/10] arm64: cpufeature: allow for version discrepancy
 in PMU implementations
In-Reply-To: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
Message-ID: <1484323429-15231-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perf already supports multiple PMU instances for heterogeneous systems,
so there's no need to be strict in the cpufeature checking, particularly
as the PMU extension is optional in the architecture.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fdf8f045929f..47d0226620e8 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -184,7 +184,11 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
-	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
+	/*
+	 * We can instantiate multiple PMU instances with different levels
+	 * of support.
+	 * */
+	S_ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_TRACEVER_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
 	ARM64_FTR_END,
-- 
2.1.4
