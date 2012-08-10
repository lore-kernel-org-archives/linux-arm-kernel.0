From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Aug 2012 18:36:33 +0100
Subject: [PATCH 7/9] ARM: perf: prepare for moving CPU PMU code into separate
 file
In-Reply-To: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
Message-ID: <1344620195-22372-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU PMU code is tightly coupled with generic ARM PMU handling code.
This makes it cumbersome when trying to add support for other ARM PMUs
(e.g. interconnect, L2 cache controller, bus) as the generic parts of
the code are not readily reusable.

This patch cleans up perf_event.c so that reusable code is exposed via
header files to other potential PMU drivers. The CPU code is
consistently named to identify it as such and also to prepare for moving
it into a separate file.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h   |    9 ++++-
 arch/arm/include/asm/pmu.h          |   11 +++++-
 arch/arm/kernel/perf_event.c        |   69 ++++++++++++++---------------------
 arch/arm/kernel/perf_event_v6.c     |    4 +-
 arch/arm/kernel/perf_event_v7.c     |   10 +++---
 arch/arm/kernel/perf_event_xscale.c |    2 +-
 6 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index e074948..625cd62 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -12,6 +12,13 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
-/* Nothing to see here... */
+/*
+ * The ARMv7 CPU PMU supports up to 32 event counters.
+ */
+#define ARMPMU_MAX_HWEVENTS		32
+
+#define HW_OP_UNSUPPORTED		0xFFFF
+#define C(_x)				PERF_COUNT_HW_CACHE_##_x
+#define CACHE_OP_UNSUPPORTED		0xFFFF
 
 #endif /* __ARM_PERF_EVENT_H__ */
diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index fbec73a..a993ad6 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -89,7 +89,9 @@ struct arm_pmu {
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
 
-int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type);
+extern const struct dev_pm_ops armpmu_dev_pm_ops;
+
+int armpmu_register(struct arm_pmu *armpmu, char *name, int type);
 
 u64 armpmu_event_update(struct perf_event *event,
 			struct hw_perf_event *hwc,
@@ -99,6 +101,13 @@ int armpmu_event_set_period(struct perf_event *event,
 			    struct hw_perf_event *hwc,
 			    int idx);
 
+int armpmu_map_event(struct perf_event *event,
+		     const unsigned (*event_map)[PERF_COUNT_HW_MAX],
+		     const unsigned (*cache_map)[PERF_COUNT_HW_CACHE_MAX]
+						[PERF_COUNT_HW_CACHE_OP_MAX]
+						[PERF_COUNT_HW_CACHE_RESULT_MAX],
+		     u32 raw_event_mask);
+
 #endif /* CONFIG_HW_PERF_EVENTS */
 
 #endif /* __ARM_PMU_H__ */
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 7c29914..9e3afd1 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -29,26 +29,17 @@
 #include <asm/pmu.h>
 #include <asm/stacktrace.h>
 
-/*
- * ARMv6 supports a maximum of 3 events, starting from index 0. If we add
- * another platform that supports more, we need to increase this to be the
- * largest of all platforms.
- *
- * ARMv7 supports up to 32 events:
- *  cycle counter CCNT + 31 events counters CNT0..30.
- *  Cortex-A8 has 1+4 counters, Cortex-A9 has 1+6 counters.
- */
-#define ARMPMU_MAX_HWEVENTS		32
+/* Set at runtime when we know what CPU type we are. */
+static struct arm_pmu *cpu_pmu;
 
 static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events);
 static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], used_mask);
 static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
 
-#define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
-
-/* Set at runtime when we know what CPU type we are. */
-static struct arm_pmu *cpu_pmu;
-
+/*
+ * Despite the names, these two functions are CPU-specific and are used
+ * by the OProfile/perf code.
+ */
 const char *perf_pmu_name(void)
 {
 	if (!cpu_pmu)
@@ -69,13 +60,6 @@ int perf_num_counters(void)
 }
 EXPORT_SYMBOL_GPL(perf_num_counters);
 
-#define HW_OP_UNSUPPORTED		0xFFFF
-
-#define C(_x) \
-	PERF_COUNT_HW_CACHE_##_x
-
-#define CACHE_OP_UNSUPPORTED		0xFFFF
-
 static int
 armpmu_map_cache_event(const unsigned (*cache_map)
 				      [PERF_COUNT_HW_CACHE_MAX]
@@ -106,7 +90,7 @@ armpmu_map_cache_event(const unsigned (*cache_map)
 }
 
 static int
-armpmu_map_event(const unsigned (*event_map)[PERF_COUNT_HW_MAX], u64 config)
+armpmu_map_hw_event(const unsigned (*event_map)[PERF_COUNT_HW_MAX], u64 config)
 {
 	int mapping = (*event_map)[config];
 	return mapping == HW_OP_UNSUPPORTED ? -ENOENT : mapping;
@@ -118,19 +102,20 @@ armpmu_map_raw_event(u32 raw_event_mask, u64 config)
 	return (int)(config & raw_event_mask);
 }
 
-static int map_cpu_event(struct perf_event *event,
-			 const unsigned (*event_map)[PERF_COUNT_HW_MAX],
-			 const unsigned (*cache_map)
-					[PERF_COUNT_HW_CACHE_MAX]
-					[PERF_COUNT_HW_CACHE_OP_MAX]
-					[PERF_COUNT_HW_CACHE_RESULT_MAX],
-			 u32 raw_event_mask)
+int
+armpmu_map_event(struct perf_event *event,
+		 const unsigned (*event_map)[PERF_COUNT_HW_MAX],
+		 const unsigned (*cache_map)
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX],
+		 u32 raw_event_mask)
 {
 	u64 config = event->attr.config;
 
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
-		return armpmu_map_event(event_map, config);
+		return armpmu_map_hw_event(event_map, config);
 	case PERF_TYPE_HW_CACHE:
 		return armpmu_map_cache_event(cache_map, config);
 	case PERF_TYPE_RAW:
@@ -594,6 +579,10 @@ static int armpmu_runtime_suspend(struct device *dev)
 }
 #endif
 
+const struct dev_pm_ops armpmu_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(armpmu_runtime_suspend, armpmu_runtime_resume, NULL)
+};
+
 static void __init armpmu_init(struct arm_pmu *armpmu)
 {
 	atomic_set(&armpmu->active_events, 0);
@@ -624,7 +613,7 @@ int armpmu_register(struct arm_pmu *armpmu, char *name, int type)
 #include "perf_event_v6.c"
 #include "perf_event_v7.c"
 
-static struct pmu_hw_events *armpmu_get_cpu_events(void)
+static struct pmu_hw_events *cpu_pmu_get_cpu_events(void)
 {
 	return &__get_cpu_var(cpu_hw_events);
 }
@@ -638,7 +627,7 @@ static void __devinit cpu_pmu_init(struct arm_pmu *cpu_pmu)
 		events->used_mask = per_cpu(used_mask, cpu);
 		raw_spin_lock_init(&events->pmu_lock);
 	}
-	cpu_pmu->get_hw_events = armpmu_get_cpu_events;
+	cpu_pmu->get_hw_events = cpu_pmu_get_cpu_events;
 
 	/* Ensure the PMU has sane values out of reset. */
 	if (cpu_pmu && cpu_pmu->reset)
@@ -651,8 +640,8 @@ static void __devinit cpu_pmu_init(struct arm_pmu *cpu_pmu)
  * UNKNOWN at reset, the PMU must be explicitly reset to avoid reading
  * junk values out of them.
  */
-static int __cpuinit pmu_cpu_notify(struct notifier_block *b,
-					unsigned long action, void *hcpu)
+static int __cpuinit cpu_pmu_notify(struct notifier_block *b,
+				    unsigned long action, void *hcpu)
 {
 	if ((action & ~CPU_TASKS_FROZEN) != CPU_STARTING)
 		return NOTIFY_DONE;
@@ -663,12 +652,8 @@ static int __cpuinit pmu_cpu_notify(struct notifier_block *b,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __cpuinitdata pmu_cpu_notifier = {
-	.notifier_call = pmu_cpu_notify,
-};
-
-static const struct dev_pm_ops armpmu_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(armpmu_runtime_suspend, armpmu_runtime_resume, NULL)
+static struct notifier_block __cpuinitdata cpu_pmu_hotplug_notifier = {
+	.notifier_call = cpu_pmu_notify,
 };
 
 /*
@@ -771,7 +756,7 @@ static int __devinit cpu_pmu_device_probe(struct platform_device *pdev)
 
 	cpu_pmu->plat_device = pdev;
 	cpu_pmu_init(cpu_pmu);
-	register_cpu_notifier(&pmu_cpu_notifier);
+	register_cpu_notifier(&cpu_pmu_hotplug_notifier);
 	armpmu_register(cpu_pmu, cpu_pmu->name, PERF_TYPE_RAW);
 
 	return 0;
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index a4328b1..6ccc079 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -645,7 +645,7 @@ armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
 
 static int armv6_map_event(struct perf_event *event)
 {
-	return map_cpu_event(event, &armv6_perf_map,
+	return armpmu_map_event(event, &armv6_perf_map,
 				&armv6_perf_cache_map, 0xFF);
 }
 
@@ -679,7 +679,7 @@ static struct arm_pmu *__devinit armv6pmu_init(void)
 
 static int armv6mpcore_map_event(struct perf_event *event)
 {
-	return map_cpu_event(event, &armv6mpcore_perf_map,
+	return armpmu_map_event(event, &armv6mpcore_perf_map,
 				&armv6mpcore_perf_cache_map, 0xFF);
 }
 
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index d65a1b8..bd4b090 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1204,31 +1204,31 @@ static void armv7pmu_reset(void *info)
 
 static int armv7_a8_map_event(struct perf_event *event)
 {
-	return map_cpu_event(event, &armv7_a8_perf_map,
+	return armpmu_map_event(event, &armv7_a8_perf_map,
 				&armv7_a8_perf_cache_map, 0xFF);
 }
 
 static int armv7_a9_map_event(struct perf_event *event)
 {
-	return map_cpu_event(event, &armv7_a9_perf_map,
+	return armpmu_map_event(event, &armv7_a9_perf_map,
 				&armv7_a9_perf_cache_map, 0xFF);
 }
 
 static int armv7_a5_map_event(struct perf_event *event)
 {
-	return map_cpu_event(event, &armv7_a5_perf_map,
+	return armpmu_map_event(event, &armv7_a5_perf_map,
 				&armv7_a5_perf_cache_map, 0xFF);
 }
 
 static int armv7_a15_map_event(struct perf_event *event)
 {
-	return map_cpu_event(event, &armv7_a15_perf_map,
+	return armpmu_map_event(event, &armv7_a15_perf_map,
 				&armv7_a15_perf_cache_map, 0xFF);
 }
 
 static int armv7_a7_map_event(struct perf_event *event)
 {
-	return map_cpu_event(event, &armv7_a7_perf_map,
+	return armpmu_map_event(event, &armv7_a7_perf_map,
 				&armv7_a7_perf_cache_map, 0xFF);
 }
 
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index dcc478c..426e19f 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -430,7 +430,7 @@ xscale1pmu_write_counter(int counter, u32 val)
 
 static int xscale_map_event(struct perf_event *event)
 {
-	return map_cpu_event(event, &xscale_perf_map,
+	return armpmu_map_event(event, &xscale_perf_map,
 				&xscale_perf_cache_map, 0xFF);
 }
 
-- 
1.7.4.1
