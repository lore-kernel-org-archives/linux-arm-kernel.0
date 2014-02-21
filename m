From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Feb 2014 16:54:32 +0000
Subject: [PATCH 2/3] ARM: perf: remove unused PMU probing code
In-Reply-To: <1393001673-8589-1-git-send-email-will.deacon@arm.com>
References: <1393001673-8589-1-git-send-email-will.deacon@arm.com>
Message-ID: <1393001673-8589-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

The ARM perf backend can discover the type of PMU it needs to drive
either from DT or by probing a CPU it is running on. For
Cortex-A{5,7,15} there are no platforms in mainline not using dt, and
this probing won't work well for big.LITTLE systems with heterogeneous
PMUs.

This patch drops the probing for those CPUs, relying on information from
dt instead. Future platforms should describe their PMU(s) with dt.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index ed571d386c0b..326cb58de2f8 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -267,15 +267,6 @@ static int probe_current_pmu(struct arm_pmu *pmu)
 		case ARM_CPU_PART_CORTEX_A9:
 			ret = armv7_a9_pmu_init(pmu);
 			break;
-		case ARM_CPU_PART_CORTEX_A5:
-			ret = armv7_a5_pmu_init(pmu);
-			break;
-		case ARM_CPU_PART_CORTEX_A15:
-			ret = armv7_a15_pmu_init(pmu);
-			break;
-		case ARM_CPU_PART_CORTEX_A7:
-			ret = armv7_a7_pmu_init(pmu);
-			break;
 		}
 	/* Intel CPUs [xscale]. */
 	} else if (implementor == ARM_CPU_IMP_INTEL) {
-- 
1.8.2.2
