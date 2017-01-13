From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jan 2017 16:03:41 +0000
Subject: [RFC PATCH v2 02/10] arm64: cpufeature: Don't enforce system-wide SPE
 capability
In-Reply-To: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
Message-ID: <1484323429-15231-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The statistical profiling extension (SPE) is an optional feature of
ARMv8.1 and is unlikely to be supported by all of the CPUs in a
heterogeneous system.

This patch updates the cpufeature checks so that such systems are not
tainted as unsupported.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 1 +
 arch/arm64/kernel/cpufeature.c  | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 98ae03f8eedd..e156e7793a65 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -190,6 +190,7 @@
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
 /* id_aa64dfr0 */
+#define ID_AA64DFR0_PMSVER_SHIFT	32
 #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
 #define ID_AA64DFR0_WRPS_SHIFT		20
 #define ID_AA64DFR0_BRPS_SHIFT		12
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 47d0226620e8..c18eb78d3a00 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -180,7 +180,8 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 36, 28, 0),
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_PMSVER_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
-- 
2.1.4
