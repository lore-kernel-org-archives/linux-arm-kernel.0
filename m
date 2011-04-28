From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Apr 2011 15:47:10 +0100
Subject: [RFC PATCH 11/15] ARM: perf: refactor event mapping
Message-ID: <mailman.81.1313415785.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently mapping an event type to a hardware configuration value
depends on the data being pointed to from struct arm_pmu. These fields
(cache_map, event_map, raw_event_mask) are currently specific to CPU
PMUs, and do not serve the general case well.

This patch replaces the event map pointers on struct arm_pmu with a new
'map_event' function pointer. Small shim functions are used to reuse
the existing common code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c        |   67 +++++++++++++++++++----------------
 arch/arm/kernel/perf_event_v6.c     |   21 ++++++++---
 arch/arm/kernel/perf_event_v7.c     |   37 ++++++++++++++-----
 arch/arm/kernel/perf_event_xscale.c |   14 ++++---
 4 files changed, 87 insertions(+), 52 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 1a2ebbf..b13bf23 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -75,11 +75,7 @@ struct arm_pmu {
 	void		(*start)(void);
 	void		(*stop)(void);
 	void		(*reset)(void *);
-	const unsigned	(*cache_map)[PERF_COUNT_HW_CACHE_MAX]
-				    [PERF_COUNT_HW_CACHE_OP_MAX]
-				    [PERF_COUNT_HW_CACHE_RESULT_MAX];
-	const unsigned	(*event_map)[PERF_COUNT_HW_MAX];
-	u32		raw_event_mask;
+	int		(*map_event)(struct perf_event *event);
 	int		num_events;
 	atomic_t	active_events;
 	struct mutex	reserve_mutex;
@@ -129,7 +125,11 @@ EXPORT_SYMBOL_GPL(perf_num_counters);
 #define CACHE_OP_UNSUPPORTED		0xFFFF
 
 static int
-armpmu_map_cache_event(u64 config)
+armpmu_map_cache_event(const unsigned (*cache_map)
+				      [PERF_COUNT_HW_CACHE_MAX]
+				      [PERF_COUNT_HW_CACHE_OP_MAX]
+				      [PERF_COUNT_HW_CACHE_RESULT_MAX],
+		       u64 config)
 {
 	unsigned int cache_type, cache_op, cache_result, ret;
 
@@ -145,7 +145,7 @@ armpmu_map_cache_event(u64 config)
 	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
 		return -EINVAL;
 
-	ret = (int)(*armpmu->cache_map)[cache_type][cache_op][cache_result];
+	ret = (int)(*cache_map)[cache_type][cache_op][cache_result];
 
 	if (ret == CACHE_OP_UNSUPPORTED)
 		return -ENOENT;
@@ -154,16 +154,38 @@ armpmu_map_cache_event(u64 config)
 }
 
 static int
-armpmu_map_event(u64 config)
+armpmu_map_event(const unsigned (*event_map)[PERF_COUNT_HW_MAX], u64 config)
 {
-	int mapping = (*armpmu->event_map)[config];
-	return mapping == HW_OP_UNSUPPORTED ? -EOPNOTSUPP : mapping;
+	int mapping = (*event_map)[config];
+	return mapping == HW_OP_UNSUPPORTED ? -ENOENT : mapping;
 }
 
 static int
-armpmu_map_raw_event(u64 config)
+armpmu_map_raw_event(u32 raw_event_mask, u64 config)
 {
-	return (int)(config & armpmu->raw_event_mask);
+	return (int)(config & raw_event_mask);
+}
+
+static int map_cpu_event(struct perf_event *event,
+			 const unsigned (*event_map)[PERF_COUNT_HW_MAX],
+			 const unsigned (*cache_map)
+					[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX],
+			 u32 raw_event_mask)
+{
+	u64 config = event->attr.config;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_HARDWARE:
+		return armpmu_map_event(event_map, config);
+	case PERF_TYPE_HW_CACHE:
+		return armpmu_map_cache_event(cache_map, config);
+	case PERF_TYPE_RAW:
+		return armpmu_map_raw_event(raw_event_mask, config);
+	}
+
+	return -ENOENT;
 }
 
 static int
@@ -484,17 +506,7 @@ __hw_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int mapping, err;
 
-	/* Decode the generic type into an ARM event identifier. */
-	if (PERF_TYPE_HARDWARE == event->attr.type) {
-		mapping = armpmu_map_event(event->attr.config);
-	} else if (PERF_TYPE_HW_CACHE == event->attr.type) {
-		mapping = armpmu_map_cache_event(event->attr.config);
-	} else if (PERF_TYPE_RAW == event->attr.type) {
-		mapping = armpmu_map_raw_event(event->attr.config);
-	} else {
-		pr_debug("event type %x not supported\n", event->attr.type);
-		return -EOPNOTSUPP;
-	}
+	mapping = armpmu->map_event(event);
 
 	if (mapping < 0) {
 		pr_debug("event %x:%llx not supported\n", event->attr.type,
@@ -550,15 +562,8 @@ static int armpmu_event_init(struct perf_event *event)
 	int err = 0;
 	atomic_t *active_events = &armpmu->active_events;
 
-	switch (event->attr.type) {
-	case PERF_TYPE_RAW:
-	case PERF_TYPE_HARDWARE:
-	case PERF_TYPE_HW_CACHE:
-		break;
-
-	default:
+	if (armpmu->map_event(event) == -ENOENT)
 		return -ENOENT;
-	}
 
 	event->destroy = hw_perf_event_destroy;
 
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 68cf704..a4c5aa9 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -657,6 +657,12 @@ armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
+static int armv6_map_event(struct perf_event *event)
+{
+	return map_cpu_event(event, &armv6_perf_map,
+				&armv6_perf_cache_map, 0xFF);
+}
+
 static struct arm_pmu armv6pmu = {
 	.id			= ARM_PERF_PMU_ID_V6,
 	.name			= "v6",
@@ -668,9 +674,7 @@ static struct arm_pmu armv6pmu = {
 	.get_event_idx		= armv6pmu_get_event_idx,
 	.start			= armv6pmu_start,
 	.stop			= armv6pmu_stop,
-	.cache_map		= &armv6_perf_cache_map,
-	.event_map		= &armv6_perf_map,
-	.raw_event_mask		= 0xFF,
+	.map_event		= armv6_map_event,
 	.num_events		= 3,
 	.max_period		= (1LLU << 32) - 1,
 };
@@ -687,6 +691,13 @@ static struct arm_pmu *__init armv6pmu_init(void)
  * disable the interrupt reporting and update the event. When unthrottling we
  * reset the period and enable the interrupt reporting.
  */
+
+static int armv6mpcore_map_event(struct perf_event *event)
+{
+	return map_cpu_event(event, &armv6mpcore_perf_map,
+				&armv6mpcore_perf_cache_map, 0xFF);
+}
+
 static struct arm_pmu armv6mpcore_pmu = {
 	.id			= ARM_PERF_PMU_ID_V6MP,
 	.name			= "v6mpcore",
@@ -698,9 +709,7 @@ static struct arm_pmu armv6mpcore_pmu = {
 	.get_event_idx		= armv6pmu_get_event_idx,
 	.start			= armv6pmu_start,
 	.stop			= armv6pmu_stop,
-	.cache_map		= &armv6mpcore_perf_cache_map,
-	.event_map		= &armv6mpcore_perf_map,
-	.raw_event_mask		= 0xFF,
+	.map_event		= armv6mpcore_map_event,
 	.num_events		= 3,
 	.max_period		= (1LLU << 32) - 1,
 };
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 68ac522..be7b58a 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1140,6 +1140,30 @@ static void armv7pmu_reset(void *info)
 	armv7_pmnc_write(ARMV7_PMNC_P | ARMV7_PMNC_C);
 }
 
+static int armv7_a8_map_event(struct perf_event *event)
+{
+	return map_cpu_event(event, &armv7_a8_perf_map,
+				&armv7_a8_perf_cache_map, 0xFF);
+}
+
+static int armv7_a9_map_event(struct perf_event *event)
+{
+	return map_cpu_event(event, &armv7_a9_perf_map,
+				&armv7_a9_perf_cache_map, 0xFF);
+}
+
+static int armv7_a5_map_event(struct perf_event *event)
+{
+	return map_cpu_event(event, &armv7_a5_perf_map,
+				&armv7_a5_perf_cache_map, 0xFF);
+}
+
+static int armv7_a15_map_event(struct perf_event *event)
+{
+	return map_cpu_event(event, &armv7_a15_perf_map,
+				&armv7_a15_perf_cache_map, 0xFF);
+}
+
 static struct arm_pmu armv7pmu = {
 	.handle_irq		= armv7pmu_handle_irq,
 	.enable			= armv7pmu_enable_event,
@@ -1150,7 +1174,6 @@ static struct arm_pmu armv7pmu = {
 	.start			= armv7pmu_start,
 	.stop			= armv7pmu_stop,
 	.reset			= armv7pmu_reset,
-	.raw_event_mask		= 0xFF,
 	.max_period		= (1LLU << 32) - 1,
 };
 
@@ -1169,8 +1192,7 @@ static struct arm_pmu *__init armv7_a8_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA8;
 	armv7pmu.name		= "ARMv7 Cortex-A8";
-	armv7pmu.cache_map	= &armv7_a8_perf_cache_map;
-	armv7pmu.event_map	= &armv7_a8_perf_map;
+	armv7pmu.map_event	= armv7_a8_map_event;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
 	return &armv7pmu;
 }
@@ -1179,8 +1201,7 @@ static struct arm_pmu *__init armv7_a9_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA9;
 	armv7pmu.name		= "ARMv7 Cortex-A9";
-	armv7pmu.cache_map	= &armv7_a9_perf_cache_map;
-	armv7pmu.event_map	= &armv7_a9_perf_map;
+	armv7pmu.map_event	= armv7_a9_map_event;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
 	return &armv7pmu;
 }
@@ -1189,8 +1210,7 @@ static struct arm_pmu *__init armv7_a5_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA5;
 	armv7pmu.name		= "ARMv7 Cortex-A5";
-	armv7pmu.cache_map	= &armv7_a5_perf_cache_map;
-	armv7pmu.event_map	= &armv7_a5_perf_map;
+	armv7pmu.map_event	= armv7_a5_map_event;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
 	return &armv7pmu;
 }
@@ -1199,8 +1219,7 @@ static struct arm_pmu *__init armv7_a15_pmu_init(void)
 {
 	armv7pmu.id		= ARM_PERF_PMU_ID_CA15;
 	armv7pmu.name		= "ARMv7 Cortex-A15";
-	armv7pmu.cache_map	= &armv7_a15_perf_cache_map;
-	armv7pmu.event_map	= &armv7_a15_perf_map;
+	armv7pmu.map_event	= armv7_a15_map_event;
 	armv7pmu.num_events	= armv7_read_num_pmnc_events();
 	armv7pmu.set_event_filter = armv7pmu_set_event_filter;
 	return &armv7pmu;
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 18e4823..d4c7610 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -425,6 +425,12 @@ xscale1pmu_write_counter(int counter, u32 val)
 	}
 }
 
+static int xscale_map_event(struct perf_event *event)
+{
+	return map_cpu_event(event, &xscale_perf_map,
+				&xscale_perf_cache_map, 0xFF);
+}
+
 static struct arm_pmu xscale1pmu = {
 	.id		= ARM_PERF_PMU_ID_XSCALE1,
 	.name		= "xscale1",
@@ -436,9 +442,7 @@ static struct arm_pmu xscale1pmu = {
 	.get_event_idx	= xscale1pmu_get_event_idx,
 	.start		= xscale1pmu_start,
 	.stop		= xscale1pmu_stop,
-	.cache_map	= &xscale_perf_cache_map,
-	.event_map	= &xscale_perf_map,
-	.raw_event_mask	= 0xFF,
+	.map_event	= xscale_map_event,
 	.num_events	= 3,
 	.max_period	= (1LLU << 32) - 1,
 };
@@ -799,9 +803,7 @@ static struct arm_pmu xscale2pmu = {
 	.get_event_idx	= xscale2pmu_get_event_idx,
 	.start		= xscale2pmu_start,
 	.stop		= xscale2pmu_stop,
-	.cache_map	= &xscale_perf_cache_map,
-	.event_map	= &xscale_perf_map,
-	.raw_event_mask	= 0xFF,
+	.map_event	= xscale_map_event,
 	.num_events	= 5,
 	.max_period	= (1LLU << 32) - 1,
 };
-- 
1.7.0.4
