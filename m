From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Nov 2010 17:30:59 +0000
Subject: [PATCH 1/5] ARM: perf: consolidate common PMU behaviour
In-Reply-To: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
Message-ID: <1289842263-21241-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The functions for mapping PMU events (perf, cache and raw) are
common between all PMU types and differ only in the data on which
they operate.

This patch implements common definitions of these mapping functions
and changes the arm_pmu struct to hold pointers to the data which
they require. This is in anticipation of separating out the PMU-specific
code into separate files.

Cc: Jamie Iles <jamie.iles@picochip.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |  131 ++++++++++++------------------------------
 1 files changed, 38 insertions(+), 93 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 07a5035..c49e170 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -84,14 +84,17 @@ struct arm_pmu {
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 	void		(*enable)(struct hw_perf_event *evt, int idx);
 	void		(*disable)(struct hw_perf_event *evt, int idx);
-	int		(*event_map)(int evt);
-	u64		(*raw_event)(u64);
 	int		(*get_event_idx)(struct cpu_hw_events *cpuc,
 					 struct hw_perf_event *hwc);
 	u32		(*read_counter)(int idx);
 	void		(*write_counter)(int idx, u32 val);
 	void		(*start)(void);
 	void		(*stop)(void);
+	const unsigned	(*cache_map)[PERF_COUNT_HW_CACHE_MAX]
+				    [PERF_COUNT_HW_CACHE_OP_MAX]
+				    [PERF_COUNT_HW_CACHE_RESULT_MAX];
+	const unsigned	(*event_map)[PERF_COUNT_HW_MAX];
+	u32		raw_event_mask;
 	int		num_events;
 	u64		max_period;
 };
@@ -136,10 +139,6 @@ EXPORT_SYMBOL_GPL(perf_num_counters);
 
 #define CACHE_OP_UNSUPPORTED		0xFFFF
 
-static unsigned armpmu_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
-				     [PERF_COUNT_HW_CACHE_OP_MAX]
-				     [PERF_COUNT_HW_CACHE_RESULT_MAX];
-
 static int
 armpmu_map_cache_event(u64 config)
 {
@@ -157,7 +156,7 @@ armpmu_map_cache_event(u64 config)
 	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
 		return -EINVAL;
 
-	ret = (int)armpmu_perf_cache_map[cache_type][cache_op][cache_result];
+	ret = (int)(*armpmu->cache_map)[cache_type][cache_op][cache_result];
 
 	if (ret == CACHE_OP_UNSUPPORTED)
 		return -ENOENT;
@@ -166,6 +165,19 @@ armpmu_map_cache_event(u64 config)
 }
 
 static int
+armpmu_map_event(u64 config)
+{
+	int mapping = (*armpmu->event_map)[config];
+	return mapping == HW_OP_UNSUPPORTED ? -EOPNOTSUPP : mapping;
+}
+
+static int
+armpmu_map_raw_event(u64 config)
+{
+	return (int)(config & armpmu->raw_event_mask);
+}
+
+static int
 armpmu_event_set_period(struct perf_event *event,
 			struct hw_perf_event *hwc,
 			int idx)
@@ -458,11 +470,11 @@ __hw_perf_event_init(struct perf_event *event)
 
 	/* Decode the generic type into an ARM event identifier. */
 	if (PERF_TYPE_HARDWARE == event->attr.type) {
-		mapping = armpmu->event_map(event->attr.config);
+		mapping = armpmu_map_event(event->attr.config);
 	} else if (PERF_TYPE_HW_CACHE == event->attr.type) {
 		mapping = armpmu_map_cache_event(event->attr.config);
 	} else if (PERF_TYPE_RAW == event->attr.type) {
-		mapping = armpmu->raw_event(event->attr.config);
+		mapping = armpmu_map_raw_event(event->attr.config);
 	} else {
 		pr_debug("event type %x not supported\n", event->attr.type);
 		return -EOPNOTSUPP;
@@ -1121,30 +1133,6 @@ armv6pmu_stop(void)
 	spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
-static inline int
-armv6pmu_event_map(int config)
-{
-	int mapping = armv6_perf_map[config];
-	if (HW_OP_UNSUPPORTED == mapping)
-		mapping = -EOPNOTSUPP;
-	return mapping;
-}
-
-static inline int
-armv6mpcore_pmu_event_map(int config)
-{
-	int mapping = armv6mpcore_perf_map[config];
-	if (HW_OP_UNSUPPORTED == mapping)
-		mapping = -EOPNOTSUPP;
-	return mapping;
-}
-
-static u64
-armv6pmu_raw_event(u64 config)
-{
-	return config & 0xff;
-}
-
 static int
 armv6pmu_get_event_idx(struct cpu_hw_events *cpuc,
 		       struct hw_perf_event *event)
@@ -1240,13 +1228,14 @@ static const struct arm_pmu armv6pmu = {
 	.handle_irq		= armv6pmu_handle_irq,
 	.enable			= armv6pmu_enable_event,
 	.disable		= armv6pmu_disable_event,
-	.event_map		= armv6pmu_event_map,
-	.raw_event		= armv6pmu_raw_event,
 	.read_counter		= armv6pmu_read_counter,
 	.write_counter		= armv6pmu_write_counter,
 	.get_event_idx		= armv6pmu_get_event_idx,
 	.start			= armv6pmu_start,
 	.stop			= armv6pmu_stop,
+	.cache_map		= &armv6_perf_cache_map,
+	.event_map		= &armv6_perf_map,
+	.raw_event_mask		= 0xFF,
 	.num_events		= 3,
 	.max_period		= (1LLU << 32) - 1,
 };
@@ -1263,13 +1252,14 @@ static const struct arm_pmu armv6mpcore_pmu = {
 	.handle_irq		= armv6pmu_handle_irq,
 	.enable			= armv6pmu_enable_event,
 	.disable		= armv6mpcore_pmu_disable_event,
-	.event_map		= armv6mpcore_pmu_event_map,
-	.raw_event		= armv6pmu_raw_event,
 	.read_counter		= armv6pmu_read_counter,
 	.write_counter		= armv6pmu_write_counter,
 	.get_event_idx		= armv6pmu_get_event_idx,
 	.start			= armv6pmu_start,
 	.stop			= armv6pmu_stop,
+	.cache_map		= &armv6mpcore_perf_cache_map,
+	.event_map		= &armv6mpcore_perf_map,
+	.raw_event_mask		= 0xFF,
 	.num_events		= 3,
 	.max_period		= (1LLU << 32) - 1,
 };
@@ -2093,27 +2083,6 @@ static void armv7pmu_stop(void)
 	spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
-static inline int armv7_a8_pmu_event_map(int config)
-{
-	int mapping = armv7_a8_perf_map[config];
-	if (HW_OP_UNSUPPORTED == mapping)
-		mapping = -EOPNOTSUPP;
-	return mapping;
-}
-
-static inline int armv7_a9_pmu_event_map(int config)
-{
-	int mapping = armv7_a9_perf_map[config];
-	if (HW_OP_UNSUPPORTED == mapping)
-		mapping = -EOPNOTSUPP;
-	return mapping;
-}
-
-static u64 armv7pmu_raw_event(u64 config)
-{
-	return config & 0xff;
-}
-
 static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
 				  struct hw_perf_event *event)
 {
@@ -2144,12 +2113,12 @@ static struct arm_pmu armv7pmu = {
 	.handle_irq		= armv7pmu_handle_irq,
 	.enable			= armv7pmu_enable_event,
 	.disable		= armv7pmu_disable_event,
-	.raw_event		= armv7pmu_raw_event,
 	.read_counter		= armv7pmu_read_counter,
 	.write_counter		= armv7pmu_write_counter,
 	.get_event_idx		= armv7pmu_get_event_idx,
 	.start			= armv7pmu_start,
 	.stop			= armv7pmu_stop,
+	.raw_event_mask		= 0xFF,
 	.max_period		= (1LLU << 32) - 1,
 };
 
@@ -2318,21 +2287,6 @@ static const unsigned xscale_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 #define	XSCALE_PMU_RESET	(CCNT_RESET | PMN_RESET)
 #define XSCALE_PMU_CNT64	0x008
 
-static inline int
-xscalepmu_event_map(int config)
-{
-	int mapping = xscale_perf_map[config];
-	if (HW_OP_UNSUPPORTED == mapping)
-		mapping = -EOPNOTSUPP;
-	return mapping;
-}
-
-static u64
-xscalepmu_raw_event(u64 config)
-{
-	return config & 0xff;
-}
-
 #define XSCALE1_OVERFLOWED_MASK	0x700
 #define XSCALE1_CCOUNT_OVERFLOW	0x400
 #define XSCALE1_COUNT0_OVERFLOW	0x100
@@ -2598,13 +2552,14 @@ static const struct arm_pmu xscale1pmu = {
 	.handle_irq	= xscale1pmu_handle_irq,
 	.enable		= xscale1pmu_enable_event,
 	.disable	= xscale1pmu_disable_event,
-	.event_map	= xscalepmu_event_map,
-	.raw_event	= xscalepmu_raw_event,
 	.read_counter	= xscale1pmu_read_counter,
 	.write_counter	= xscale1pmu_write_counter,
 	.get_event_idx	= xscale1pmu_get_event_idx,
 	.start		= xscale1pmu_start,
 	.stop		= xscale1pmu_stop,
+	.cache_map	= &xscale_perf_cache_map,
+	.event_map	= &xscale_perf_map,
+	.raw_event_mask	= 0xFF,
 	.num_events	= 3,
 	.max_period	= (1LLU << 32) - 1,
 };
@@ -2953,13 +2908,14 @@ static const struct arm_pmu xscale2pmu = {
 	.handle_irq	= xscale2pmu_handle_irq,
 	.enable		= xscale2pmu_enable_event,
 	.disable	= xscale2pmu_disable_event,
-	.event_map	= xscalepmu_event_map,
-	.raw_event	= xscalepmu_raw_event,
 	.read_counter	= xscale2pmu_read_counter,
 	.write_counter	= xscale2pmu_write_counter,
 	.get_event_idx	= xscale2pmu_get_event_idx,
 	.start		= xscale2pmu_start,
 	.stop		= xscale2pmu_stop,
+	.cache_map	= &xscale_perf_cache_map,
+	.event_map	= &xscale_perf_map,
+	.raw_event_mask	= 0xFF,
 	.num_events	= 5,
 	.max_period	= (1LLU << 32) - 1,
 };
@@ -2978,20 +2934,14 @@ init_hw_perf_events(void)
 		case 0xB560:	/* ARM1156 */
 		case 0xB760:	/* ARM1176 */
 			armpmu = &armv6pmu;
-			memcpy(armpmu_perf_cache_map, armv6_perf_cache_map,
-					sizeof(armv6_perf_cache_map));
 			break;
 		case 0xB020:	/* ARM11mpcore */
 			armpmu = &armv6mpcore_pmu;
-			memcpy(armpmu_perf_cache_map,
-			       armv6mpcore_perf_cache_map,
-			       sizeof(armv6mpcore_perf_cache_map));
 			break;
 		case 0xC080:	/* Cortex-A8 */
 			armv7pmu.id = ARM_PERF_PMU_ID_CA8;
-			memcpy(armpmu_perf_cache_map, armv7_a8_perf_cache_map,
-				sizeof(armv7_a8_perf_cache_map));
-			armv7pmu.event_map = armv7_a8_pmu_event_map;
+			armv7pmu.cache_map = &armv7_a8_perf_cache_map;
+			armv7pmu.event_map = &armv7_a8_perf_map;
 			armpmu = &armv7pmu;
 
 			/* Reset PMNC and read the nb of CNTx counters
@@ -3000,9 +2950,8 @@ init_hw_perf_events(void)
 			break;
 		case 0xC090:	/* Cortex-A9 */
 			armv7pmu.id = ARM_PERF_PMU_ID_CA9;
-			memcpy(armpmu_perf_cache_map, armv7_a9_perf_cache_map,
-				sizeof(armv7_a9_perf_cache_map));
-			armv7pmu.event_map = armv7_a9_pmu_event_map;
+			armv7pmu.cache_map = &armv7_a9_perf_cache_map;
+			armv7pmu.event_map = &armv7_a9_perf_map;
 			armpmu = &armv7pmu;
 
 			/* Reset PMNC and read the nb of CNTx counters
@@ -3016,13 +2965,9 @@ init_hw_perf_events(void)
 		switch (part_number) {
 		case 1:
 			armpmu = &xscale1pmu;
-			memcpy(armpmu_perf_cache_map, xscale_perf_cache_map,
-					sizeof(xscale_perf_cache_map));
 			break;
 		case 2:
 			armpmu = &xscale2pmu;
-			memcpy(armpmu_perf_cache_map, xscale_perf_cache_map,
-					sizeof(xscale_perf_cache_map));
 			break;
 		}
 	}
-- 
1.7.0.4
