From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 May 2015 17:12:27 +0100
Subject: [PATCH 5/7] arm: perf: probe number of counters on affine CPUs
In-Reply-To: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
References: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431533549-27715-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In heterogeneous systems, the number of counters may differ across
clusters. To find the number of counters for a cluster, we must probe
the PMU from a CPU in that cluster.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index f4207a4..ccec472 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1056,15 +1056,22 @@ static void armv7pmu_init(struct arm_pmu *cpu_pmu)
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
+	return smp_call_function_any(&arm_pmu->supported_cpus,
+				     armv7_read_num_pmnc_events,
+				     &arm_pmu->num_events, 1);
 }
 
 static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1072,8 +1079,7 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a8";
 	cpu_pmu->map_event	= armv7_a8_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1081,8 +1087,7 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a9";
 	cpu_pmu->map_event	= armv7_a9_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1090,8 +1095,7 @@ static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a5";
 	cpu_pmu->map_event	= armv7_a5_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1099,9 +1103,8 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a15";
 	cpu_pmu->map_event	= armv7_a15_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1109,9 +1112,8 @@ static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a7";
 	cpu_pmu->map_event	= armv7_a7_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1119,16 +1121,15 @@ static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a12";
 	cpu_pmu->map_event	= armv7_a12_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int armv7_a17_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv7_a12_pmu_init(cpu_pmu);
+	int ret = armv7_a12_pmu_init(cpu_pmu);
 	cpu_pmu->name = "armv7_cortex_a17";
-	return 0;
+	return ret;
 }
 
 /*
@@ -1508,14 +1509,13 @@ static int krait_pmu_init(struct arm_pmu *cpu_pmu)
 		cpu_pmu->map_event = krait_map_event_no_branch;
 	else
 		cpu_pmu->map_event = krait_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
 	cpu_pmu->reset		= krait_pmu_reset;
 	cpu_pmu->enable		= krait_pmu_enable_event;
 	cpu_pmu->disable	= krait_pmu_disable_event;
 	cpu_pmu->get_event_idx	= krait_pmu_get_event_idx;
 	cpu_pmu->clear_event_idx = krait_pmu_clear_event_idx;
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 /*
@@ -1833,13 +1833,12 @@ static int scorpion_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_scorpion";
 	cpu_pmu->map_event	= scorpion_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->reset		= scorpion_pmu_reset;
 	cpu_pmu->enable		= scorpion_pmu_enable_event;
 	cpu_pmu->disable	= scorpion_pmu_disable_event;
 	cpu_pmu->get_event_idx	= scorpion_pmu_get_event_idx;
 	cpu_pmu->clear_event_idx = scorpion_pmu_clear_event_idx;
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 
 static int scorpion_mp_pmu_init(struct arm_pmu *cpu_pmu)
@@ -1847,13 +1846,12 @@ static int scorpion_mp_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_scorpion_mp";
 	cpu_pmu->map_event	= scorpion_map_event;
-	cpu_pmu->num_events	= armv7_read_num_pmnc_events();
 	cpu_pmu->reset		= scorpion_pmu_reset;
 	cpu_pmu->enable		= scorpion_pmu_enable_event;
 	cpu_pmu->disable	= scorpion_pmu_disable_event;
 	cpu_pmu->get_event_idx	= scorpion_pmu_get_event_idx;
 	cpu_pmu->clear_event_idx = scorpion_pmu_clear_event_idx;
-	return 0;
+	return armv7_probe_num_events(cpu_pmu);
 }
 #else
 static inline int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
-- 
1.9.1
