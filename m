From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 10:12:39 +0100
Subject: [RFC PATCH 08/11] arm: perf: probe number of counters on affine CPUs
In-Reply-To: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
References: <1365671562-2403-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1365671562-2403-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In heterogeneous systems, the  number of counters may differ across
clusters. To find the number of counters for a cluster, we must probe
the PMU from a CPU in that cluster.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index f4d185e..519948f 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1226,15 +1226,25 @@ static void armv7pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->max_period	= (1LLU << 32) - 1;
 };
 
-static u32 armv7_read_num_pmnc_events(void)
+static void armv7_read_num_pmnc_events(void *info)
 {
-	u32 nb_cnt;
+	int *nb_cnt = info;
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	nb_cnt = (armv7_pmnc_read() >> ARMV7_PMNC_N_SHIFT) & ARMV7_PMNC_N_MASK;
+	*nb_cnt = (armv7_pmnc_read() >> ARMV7_PMNC_N_SHIFT) & ARMV7_PMNC_N_MASK;
 
-	/* Add the CPU cycles counter and return */
-	return nb_cnt + 1;
+	/* Add the CPU cycles counter */
+	*nb_cnt += 1;
+}
+
+static int armv7_probe_num_events(struct arm_pmu *arm_pmu)
+{
+	int ret;
+	ret = smp_call_function_any(&arm_pmu->supported_cpus,
+				    armv7_read_num_pmnc_events,
+				    &arm_pmu->num_events, 1);
+
+	return ret;
 }
 
 static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1242,8 +1252,7 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7_Cortex_A8";
 	cpu_pmu->map_event	= armv7_a8_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1251,8 +1260,7 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7_Cortex_A9";
 	cpu_pmu->map_event	= armv7_a9_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1260,8 +1268,7 @@ static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7_Cortex_A5";
 	cpu_pmu->map_event	= armv7_a5_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1269,9 +1276,8 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7_Cortex_A15";
 	cpu_pmu->map_event	= armv7_a15_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1279,9 +1285,8 @@ static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "ARMv7_Cortex_A7";
 	cpu_pmu->map_event	= armv7_a7_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 #else
 static inline int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
-- 
1.8.1.1
