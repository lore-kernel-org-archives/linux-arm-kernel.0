From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Feb 2018 17:21:57 +0000
Subject: [PATCH] arm64: perf: correct PMUVer probing
Message-ID: <20180214172157.46527-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ID_AA64DFR0_EL1.PMUVer field doesn't follow the usual ID registers
scheme. While value 0xf indicates a non-architected PMU is implemented,
values 0x1 to 0xe indicate an increasingly featureful architected PMU,
as if the field were unsigned.

For more details, see ARM DDI 0487C.a, D10.1.4, "Alternative ID scheme
used for the Performance Monitors Extension version".

Currently, we treat the field as signed, and erroneously bail out for
values 0x8 to 0xe. Let's correct that.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 75b220ba73a3..85a251b6dfa8 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -908,9 +908,9 @@ static void __armv8pmu_probe_pmu(void *info)
 	int pmuver;
 
 	dfr0 = read_sysreg(id_aa64dfr0_el1);
-	pmuver = cpuid_feature_extract_signed_field(dfr0,
+	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
 			ID_AA64DFR0_PMUVER_SHIFT);
-	if (pmuver < 1)
+	if (pmuver == 0xf || pmuver == 0)
 		return;
 
 	probe->present = true;
-- 
2.11.0
