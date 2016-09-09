From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  9 Sep 2016 14:08:27 +0100
Subject: [PATCH 2/5] arm64: perf: move to common attr_group fields
In-Reply-To: <1473426510-12697-1-git-send-email-mark.rutland@arm.com>
References: <1473426510-12697-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473426510-12697-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By using a common attr_groups array, the common arm_pmu code can set up
common files (e.g. cpumask) for us in subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 838ccf1..bcc8dff 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -523,12 +523,6 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 	.attrs = armv8_pmuv3_format_attrs,
 };
 
-static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
-	&armv8_pmuv3_events_attr_group,
-	&armv8_pmuv3_format_attr_group,
-	NULL,
-};
-
 /*
  * Perf Events' indices
  */
@@ -985,7 +979,10 @@ static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
 	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_pmuv3";
 	cpu_pmu->map_event		= armv8_pmuv3_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv8_pmuv3_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv8_pmuv3_format_attr_group;
 	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
@@ -994,7 +991,10 @@ static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
 	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_cortex_a53";
 	cpu_pmu->map_event		= armv8_a53_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv8_pmuv3_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv8_pmuv3_format_attr_group;
 	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
@@ -1003,7 +1003,10 @@ static int armv8_a57_pmu_init(struct arm_pmu *cpu_pmu)
 	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_cortex_a57";
 	cpu_pmu->map_event		= armv8_a57_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv8_pmuv3_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv8_pmuv3_format_attr_group;
 	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
@@ -1012,7 +1015,10 @@ static int armv8_a72_pmu_init(struct arm_pmu *cpu_pmu)
 	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_cortex_a72";
 	cpu_pmu->map_event		= armv8_a57_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv8_pmuv3_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv8_pmuv3_format_attr_group;
 	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
@@ -1021,7 +1027,10 @@ static int armv8_thunder_pmu_init(struct arm_pmu *cpu_pmu)
 	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_cavium_thunder";
 	cpu_pmu->map_event		= armv8_thunder_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv8_pmuv3_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv8_pmuv3_format_attr_group;
 	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
@@ -1030,7 +1039,10 @@ static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
 	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_brcm_vulcan";
 	cpu_pmu->map_event		= armv8_vulcan_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv8_pmuv3_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&armv8_pmuv3_format_attr_group;
 	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
-- 
1.9.1
