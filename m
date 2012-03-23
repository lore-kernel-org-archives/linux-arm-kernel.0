From: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 23 Mar 2012 11:04:57 +1030
Subject: [PATCH] ARM: test for PMU feature on v7 (v2 with typo fix)
In-Reply-To: <87ty1g88dv.fsf@rustcorp.com.au>
References: <4F590411.9060201@arm.com> <87ty1g88dv.fsf@rustcorp.com.au>
Message-ID: <87r4wk889a.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The v7 ARM (B4.1.82) specifies that bits 27-24 of the ID_DFR0 reg show
what performance monitoring (if any) is available.  We should test this
before assuming (useful for inside virtualized environments, for example).

Signed-off-by: Rusty Russell <rusty.russell@linaro.org>

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 6933244..303d1e1 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1108,6 +1108,12 @@ static struct arm_pmu armv7pmu = {
 	.max_period		= (1LLU << 32) - 1,
 };
 
+static bool armv7_pmu_avail(void)
+{
+	/* 0 means unknown (maybe v1), 1 means v1, 2 means v2, 15 means none */
+	return ((read_cpuid_ext(CPUID_EXT_DFR0) >> 24) & 0xF) != 0xF;
+}
+
 static u32 __init armv7_read_num_pmnc_events(void)
 {
 	u32 nb_cnt;
@@ -1121,6 +1127,8 @@ static u32 __init armv7_read_num_pmnc_events(void)
 
 static struct arm_pmu *__init armv7_a8_pmu_init(void)
 {
+	if (!armv7_pmu_avail())
+		return NULL;
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA8;
 	armv7pmu.name		= "ARMv7 Cortex-A8";
 	armv7pmu.map_event	= armv7_a8_map_event;
@@ -1130,6 +1138,8 @@ static struct arm_pmu *__init armv7_a8_pmu_init(void)
 
 static struct arm_pmu *__init armv7_a9_pmu_init(void)
 {
+	if (!armv7_pmu_avail())
+		return NULL;
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA9;
 	armv7pmu.name		= "ARMv7 Cortex-A9";
 	armv7pmu.map_event	= armv7_a9_map_event;
@@ -1139,6 +1149,8 @@ static struct arm_pmu *__init armv7_a9_pmu_init(void)
 
 static struct arm_pmu *__init armv7_a5_pmu_init(void)
 {
+	if (!armv7_pmu_avail())
+		return NULL;
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA5;
 	armv7pmu.name		= "ARMv7 Cortex-A5";
 	armv7pmu.map_event	= armv7_a5_map_event;
@@ -1148,6 +1160,8 @@ static struct arm_pmu *__init armv7_a5_pmu_init(void)
 
 static struct arm_pmu *__init armv7_a15_pmu_init(void)
 {
+	if (!armv7_pmu_avail())
+		return NULL;
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA15;
 	armv7pmu.name		= "ARMv7 Cortex-A15";
 	armv7pmu.map_event	= armv7_a15_map_event;
