From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  6 Apr 2017 19:29:22 +0100
Subject: [PATCHv2 15/16] arm64: pmuv3: handle !PMUv3 when probing
In-Reply-To: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1491503363-17731-16-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When probing via ACPI, we won't know up-front whether a CPU has a PMUv3
compatible PMU. Thus we need to consult ID registers during probe time.

This patch updates our PMUv3 probing code to test for the presence of
PMUv3 functionality before touching an PMUv3-specific registers, and
before updating the struct arm_pmu with PMUv3 data.

When a PMUv3-compatible PMU is not present, probing will return -ENODEV.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 85 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 57ae9d9..50790d7 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -957,11 +957,24 @@ static int armv8_vulcan_map_event(struct perf_event *event)
 				ARMV8_PMU_EVTYPE_EVENT);
 }
 
+struct armv8pmu_probe_info {
+	struct arm_pmu *pmu;
+	bool present;
+};
+
 static void __armv8pmu_probe_pmu(void *info)
 {
-	struct arm_pmu *cpu_pmu = info;
+	struct armv8pmu_probe_info *probe = info;
+	struct arm_pmu *cpu_pmu = probe->pmu;
+	u64 dfr0;
 	u32 pmceid[2];
 
+	dfr0 = read_sysreg(id_aa64dfr0_el1);
+	if (((dfr0 >> ID_AA64DFR0_PMUVER_SHIFT) & 0xf) != 1)
+		return;
+
+	probe->present = true;
+
 	/* Read the nb of CNTx counters supported from PMNC */
 	cpu_pmu->num_events = (armv8pmu_pmcr_read() >> ARMV8_PMU_PMCR_N_SHIFT)
 		& ARMV8_PMU_PMCR_N_MASK;
@@ -979,13 +992,27 @@ static void __armv8pmu_probe_pmu(void *info)
 
 static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 {
-	return smp_call_function_any(&cpu_pmu->supported_cpus,
+	struct armv8pmu_probe_info probe = {
+		.pmu = cpu_pmu,
+		.present = false,
+	};
+	int ret;
+
+	ret = smp_call_function_any(&cpu_pmu->supported_cpus,
 				    __armv8pmu_probe_pmu,
-				    cpu_pmu, 1);
+				    &probe, 1);
+	if (ret)
+		return ret;
+
+	return probe.present ? 0 : -ENODEV;
 }
 
-static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
+static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 {
+	int ret = armv8pmu_probe_pmu(cpu_pmu);
+	if (ret)
+		return ret;
+
 	cpu_pmu->handle_irq		= armv8pmu_handle_irq,
 	cpu_pmu->enable			= armv8pmu_enable_event,
 	cpu_pmu->disable		= armv8pmu_disable_event,
@@ -997,78 +1024,104 @@ static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->reset			= armv8pmu_reset,
 	cpu_pmu->max_period		= (1LLU << 32) - 1,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
+
+	return 0;
 }
 
 static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
+	int ret = armv8_pmu_init(cpu_pmu);
+	if (ret)
+		return ret;
+
 	cpu_pmu->name			= "armv8_pmuv3";
 	cpu_pmu->map_event		= armv8_pmuv3_map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
 		&armv8_pmuv3_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
 		&armv8_pmuv3_format_attr_group;
-	return armv8pmu_probe_pmu(cpu_pmu);
+
+	return 0;
 }
 
 static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
+	int ret = armv8_pmu_init(cpu_pmu);
+	if (ret)
+		return ret;
+
 	cpu_pmu->name			= "armv8_cortex_a53";
 	cpu_pmu->map_event		= armv8_a53_map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
 		&armv8_pmuv3_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
 		&armv8_pmuv3_format_attr_group;
-	return armv8pmu_probe_pmu(cpu_pmu);
+
+	return 0;
 }
 
 static int armv8_a57_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
+	int ret = armv8_pmu_init(cpu_pmu);
+	if (ret)
+		return ret;
+
 	cpu_pmu->name			= "armv8_cortex_a57";
 	cpu_pmu->map_event		= armv8_a57_map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
 		&armv8_pmuv3_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
 		&armv8_pmuv3_format_attr_group;
-	return armv8pmu_probe_pmu(cpu_pmu);
+
+	return 0;
 }
 
 static int armv8_a72_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
+	int ret = armv8_pmu_init(cpu_pmu);
+	if (ret)
+		return ret;
+
 	cpu_pmu->name			= "armv8_cortex_a72";
 	cpu_pmu->map_event		= armv8_a57_map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
 		&armv8_pmuv3_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
 		&armv8_pmuv3_format_attr_group;
-	return armv8pmu_probe_pmu(cpu_pmu);
+
+	return 0;
 }
 
 static int armv8_thunder_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
+	int ret = armv8_pmu_init(cpu_pmu);
+	if (ret)
+		return ret;
+
 	cpu_pmu->name			= "armv8_cavium_thunder";
 	cpu_pmu->map_event		= armv8_thunder_map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
 		&armv8_pmuv3_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
 		&armv8_pmuv3_format_attr_group;
-	return armv8pmu_probe_pmu(cpu_pmu);
+
+	return 0;
 }
 
 static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
+	int ret = armv8_pmu_init(cpu_pmu);
+	if (ret)
+		return ret;
+
 	cpu_pmu->name			= "armv8_brcm_vulcan";
 	cpu_pmu->map_event		= armv8_vulcan_map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
 		&armv8_pmuv3_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
 		&armv8_pmuv3_format_attr_group;
-	return armv8pmu_probe_pmu(cpu_pmu);
+
+	return 0;
 }
 
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
-- 
1.9.1
