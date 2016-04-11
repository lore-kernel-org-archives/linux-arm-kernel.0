From: ashoks@broadcom.com (Ashok Kumar)
Date: Mon, 11 Apr 2016 06:02:20 -0700
Subject: [PATCH v4 5/6] arm64/perf: Filter common events based on PMCEIDn_EL0
In-Reply-To: <1460379741-1181-1-git-send-email-ashoks@broadcom.com>
References: <1460379741-1181-1-git-send-email-ashoks@broadcom.com>
Message-ID: <1460379741-1181-6-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The complete common architectural and micro-architectural
event number structure is filtered based on PMCEIDn_EL0 and
exposed to /sys using is_visibile function pointer in events
attribute_group.
To filter the events in is_visible function, pmceid based bitmap
is stored in arm_pmu structure and the id field from
perf_pmu_events_attr is used to check against the bitmap.

The function which derives event bitmap from PMCEIDn_EL0 is
executed in the cpus, which has the pmu being initialized,
for heterogeneous pmu support.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
---
 arch/arm64/kernel/perf_event.c | 74 +++++++++++++++++++++++++++++++++++-------
 include/linux/perf/arm_pmu.h   |  2 ++
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 2ee61e8..ac250b5 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -325,10 +325,22 @@ static const unsigned armv8_thunder_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 };
 
+
+static ssize_t
+armv8pmu_events_sysfs_show(struct device *dev,
+			   struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
 #define ARMV8_EVENT_ATTR_RESOLVE(m) #m
 #define ARMV8_EVENT_ATTR(name, config) \
-	PMU_EVENT_ATTR_STRING(name, armv8_event_attr_##name, \
-			      "event=" ARMV8_EVENT_ATTR_RESOLVE(config))
+	PMU_EVENT_ATTR(name, armv8_event_attr_##name, \
+		       config, armv8pmu_events_sysfs_show)
 
 ARMV8_EVENT_ATTR(sw_incr, ARMV8_PMUV3_PERFCTR_SW_INCR);
 ARMV8_EVENT_ATTR(l1i_cache_refill, ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL);
@@ -433,9 +445,27 @@ static struct attribute *armv8_pmuv3_event_attrs[] = {
 	NULL,
 };
 
+static umode_t
+armv8pmu_event_attr_is_visible(struct kobject *kobj,
+			       struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
+
+	if (test_bit(pmu_attr->id, cpu_pmu->pmceid_bitmap))
+		return attr->mode;
+
+	return 0;
+}
+
 static struct attribute_group armv8_pmuv3_events_attr_group = {
 	.name = "events",
 	.attrs = armv8_pmuv3_event_attrs,
+	.is_visible = armv8pmu_event_attr_is_visible,
 };
 
 PMU_FORMAT_ATTR(event, "config:0-9");
@@ -871,11 +901,32 @@ static void armv8pmu_read_num_pmnc_events(void *info)
 	*nb_cnt += 1;
 }
 
-static int armv8pmu_probe_num_events(struct arm_pmu *arm_pmu)
+static void armv8pmu_read_common_events_bitmap(unsigned long *bmp)
 {
-	return smp_call_function_any(&arm_pmu->supported_cpus,
-				    armv8pmu_read_num_pmnc_events,
-				    &arm_pmu->num_events, 1);
+	u32 arr[2], reg;
+
+	asm volatile("mrs %0, pmceid0_el0" : "=r" (reg));
+	arr[0] = reg;
+	asm volatile("mrs %0, pmceid1_el0" : "=r" (reg));
+	arr[1] = reg;
+
+	bitmap_from_u32array(bmp, ARMV8_PMUV3_MAX_COMMON_EVENTS,
+			     arr, ARRAY_SIZE(arr));
+}
+
+static void __armv8pmu_probe_pmu(void *info)
+{
+	struct arm_pmu *cpu_pmu = info;
+
+	armv8pmu_read_num_pmnc_events(&cpu_pmu->num_events);
+	armv8pmu_read_common_events_bitmap(cpu_pmu->pmceid_bitmap);
+}
+
+static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
+{
+	return smp_call_function_any(&cpu_pmu->supported_cpus,
+				    __armv8pmu_probe_pmu,
+				    cpu_pmu, 1);
 }
 
 static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
@@ -898,7 +949,8 @@ static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
 	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_pmuv3";
 	cpu_pmu->map_event		= armv8_pmuv3_map_event;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
+	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
 static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
@@ -907,7 +959,7 @@ static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name			= "armv8_cortex_a53";
 	cpu_pmu->map_event		= armv8_a53_map_event;
 	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
 static int armv8_a57_pmu_init(struct arm_pmu *cpu_pmu)
@@ -916,7 +968,7 @@ static int armv8_a57_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name			= "armv8_cortex_a57";
 	cpu_pmu->map_event		= armv8_a57_map_event;
 	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
 static int armv8_a72_pmu_init(struct arm_pmu *cpu_pmu)
@@ -925,7 +977,7 @@ static int armv8_a72_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name			= "armv8_cortex_a72";
 	cpu_pmu->map_event		= armv8_a57_map_event;
 	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
 static int armv8_thunder_pmu_init(struct arm_pmu *cpu_pmu)
@@ -934,7 +986,7 @@ static int armv8_thunder_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name			= "armv8_cavium_thunder";
 	cpu_pmu->map_event		= armv8_thunder_map_event;
 	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 4196c90..d28ac05 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -105,6 +105,8 @@ struct arm_pmu {
 	struct mutex	reserve_mutex;
 	u64		max_period;
 	bool		secure_access; /* 32-bit ARM only */
+#define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
+	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 	struct platform_device	*plat_device;
 	struct pmu_hw_events	__percpu *hw_events;
 	struct notifier_block	hotplug_nb;
-- 
2.1.0
