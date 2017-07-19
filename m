From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Jul 2017 17:01:25 +0100
Subject: [PATCH 04/11] arm64/cpufeature: add ARMv8.3 id_aa64isar1 bits
In-Reply-To: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1500480092-28480-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From ARMv8.3 onwards, ID_AA64ISAR1 is no longer entirely RES0, and now
has four fields describing the presence of pointer authentication
functionality:

* APA - address authentication present, using an architected algorithm
* API - address authentication present, using an IMP DEF algorithm
* GPA - generic authentication present, using an architected algorithm
* GPI - generic authentication present, using an IMP DEF algoithm

This patch adds the requisite definitions so that we can identify the
presence of this functionality. For the timebeing, the features are
hidden from userspace.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9f9e0064..b23ad83 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -120,7 +120,11 @@ static int __init register_cpu_hwcaps_dumper(void)
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64ISAR1_LRCPC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64ISAR1_FCMA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64ISAR1_JSCVT_SHIFT, 4, 0),
-	ARM64_FTR_END,
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64ISAR1_GPI_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64ISAR1_GPA_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64ISAR1_API_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64ISAR1_APA_SHIFT, 4, 0),
+	ARM64_FTR_END
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
-- 
1.9.1
