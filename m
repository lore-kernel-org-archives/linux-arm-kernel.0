From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  9 Sep 2016 14:08:28 +0100
Subject: [PATCH 3/5] arm: perf: move to common attr_group fields
In-Reply-To: <1473426510-12697-1-git-send-email-mark.rutland@arm.com>
References: <1473426510-12697-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473426510-12697-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By using a common attr_groups array, the common arm_pmu code can set up
common files (e.g. cpumask) for us in subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c | 47 ++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 1506385..b942349 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -596,12 +596,6 @@ static struct attribute_group armv7_pmuv1_events_attr_group = {
 	.attrs = armv7_pmuv1_event_attrs,
 };
 
-static const struct attribute_group *armv7_pmuv1_attr_groups[] = {
-	&armv7_pmuv1_events_attr_group,
-	&armv7_pmu_format_attr_group,
-	NULL,
-};
-
 ARMV7_EVENT_ATTR(mem_access, ARMV7_PERFCTR_MEM_ACCESS);
 ARMV7_EVENT_ATTR(l1i_cache, ARMV7_PERFCTR_L1_ICACHE_ACCESS);
 ARMV7_EVENT_ATTR(l1d_cache_wb, ARMV7_PERFCTR_L1_DCACHE_WB);
@@ -653,12 +647,6 @@ static struct attribute_group armv7_pmuv2_events_attr_group = {
 	.attrs = armv7_pmuv2_event_attrs,
 };
 
-static const struct attribute_group *armv7_pmuv2_attr_groups[] = {
-	&armv7_pmuv2_events_attr_group,
-	&armv7_pmu_format_attr_group,
-	NULL,
-};
-
 /*
  * Perf Events' indices
  */
@@ -1208,7 +1196,10 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a8";
 	cpu_pmu->map_event	= armv7_a8_map_event;
-	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv7_pmuv1_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv7_pmu_format_attr_group;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1217,7 +1208,10 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a9";
 	cpu_pmu->map_event	= armv7_a9_map_event;
-	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv7_pmuv1_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv7_pmu_format_attr_group;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1226,7 +1220,10 @@ static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a5";
 	cpu_pmu->map_event	= armv7_a5_map_event;
-	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv7_pmuv1_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv7_pmu_format_attr_group;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1236,7 +1233,10 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a15";
 	cpu_pmu->map_event	= armv7_a15_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
-	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv7_pmuv2_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv7_pmu_format_attr_group;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1246,7 +1246,10 @@ static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a7";
 	cpu_pmu->map_event	= armv7_a7_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
-	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv7_pmuv2_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv7_pmu_format_attr_group;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1256,7 +1259,10 @@ static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a12";
 	cpu_pmu->map_event	= armv7_a12_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
-	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv7_pmuv2_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv7_pmu_format_attr_group;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1264,7 +1270,10 @@ static int armv7_a17_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int ret = armv7_a12_pmu_init(cpu_pmu);
 	cpu_pmu->name = "armv7_cortex_a17";
-	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv7_pmuv2_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv7_pmu_format_attr_group;
 	return ret;
 }
 
-- 
1.9.1
