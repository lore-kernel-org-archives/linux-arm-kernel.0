From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 May 2011 10:07:57 +0100
Subject: [RFC PATCH 15/15] ARM: perf: move arm_pmu into <asm/pmu.h>
Message-ID: <mailman.85.1313415787.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, struct arm_pmu and related functions are only visible to
{,arch/arm/}/kernel/perf_event.c. This prevents new drivers from using
the framework.

This patch  moves declarations to asm/pmu.h, allowing new PMU drivers
to use the framework.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h   |   64 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/perf_event.c |   53 ++--------------------------------
 2 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index f210708..9c2c877 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -13,6 +13,7 @@
 #define __ARM_PMU_H__
 
 #include <linux/interrupt.h>
+#include <linux/perf_event.h>
 
 /*
  * Types of PMUs that can be accessed directly and require mutual
@@ -69,4 +70,67 @@ release_pmu(struct platform_device *pdev)	{ }
 
 #endif /* CONFIG_CPU_HAS_PMU */
 
+#ifdef CONFIG_HW_PERF_EVENTS
+
+/* The events for a given PMU register set. */
+struct pmu_hw_events {
+	/*
+	 * The events that are active on the PMU for the given index.
+	 */
+	struct perf_event	**events;
+
+	/*
+	 * A 1 bit for an index indicates that the counter is being used for
+	 * an event. A 0 means that the counter can be used.
+	 */
+	unsigned long           *used_mask;
+
+	/*
+	 * Hardware lock to serialize accesses to PMU registers. Needed for the
+	 * read/modify/write sequences.
+	 */
+	raw_spinlock_t		pmu_lock;
+};
+
+struct arm_pmu {
+	struct pmu	pmu;
+	enum arm_perf_pmu_ids id;
+	enum arm_pmu_type type;
+	cpumask_t	active_irqs;
+	const char	*name;
+	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
+	void		(*enable)(struct hw_perf_event *evt, int idx);
+	void		(*disable)(struct hw_perf_event *evt, int idx);
+	int		(*get_event_idx)(struct pmu_hw_events *hw_events,
+					 struct hw_perf_event *hwc);
+	int		(*set_event_filter)(struct hw_perf_event *evt,
+					    struct perf_event_attr *attr);
+	u32		(*read_counter)(int idx);
+	void		(*write_counter)(int idx, u32 val);
+	void		(*start)(void);
+	void		(*stop)(void);
+	void		(*reset)(void *);
+	int		(*map_event)(struct perf_event *event);
+	int		num_events;
+	atomic_t	active_events;
+	struct mutex	reserve_mutex;
+	u64		max_period;
+	struct platform_device	*plat_device;
+	struct pmu_hw_events	*(*get_hw_events)(void);
+};
+
+#define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
+
+int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type);
+
+u64 armpmu_event_update(struct perf_event *event,
+			struct hw_perf_event *hwc,
+			int idx, int overflow);
+
+int armpmu_event_set_period(struct perf_event *event,
+			    struct hw_perf_event *hwc,
+			    int idx);
+
+#endif /* CONFIG_HW_PERF_EVENTS */
+
 #endif /* __ARM_PMU_H__ */
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 8315133..aaa631b 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -37,57 +37,10 @@
  */
 #define ARMPMU_MAX_HWEVENTS		32
 
-/* The events for a given PMU register set. */
-struct pmu_hw_events {
-	/*
-	 * The events that are active on the PMU for the given index.
-	 */
-	struct perf_event	**events;
-
-	/*
-	 * A 1 bit for an index indicates that the counter is being used for
-	 * an event. A 0 means that the counter can be used.
-	 */
-	unsigned long           *used_mask;
-
-	/*
-	 * Hardware lock to serialize accesses to PMU registers. Needed for the
-	 * read/modify/write sequences.
-	 */
-	raw_spinlock_t		pmu_lock;
-};
-
 static DEFINE_PER_CPU(struct perf_event * [ARMPMU_MAX_HWEVENTS], hw_events);
 static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(ARMPMU_MAX_HWEVENTS)], used_mask);
 static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
 
-struct arm_pmu {
-	struct pmu	pmu;
-	enum arm_perf_pmu_ids id;
-	enum arm_pmu_type type;
-	cpumask_t	active_irqs;
-	const char	*name;
-	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
-	void		(*enable)(struct hw_perf_event *evt, int idx);
-	void		(*disable)(struct hw_perf_event *evt, int idx);
-	int		(*get_event_idx)(struct pmu_hw_events *hw_events,
-					 struct hw_perf_event *hwc);
-	int		(*set_event_filter)(struct hw_perf_event *evt,
-					    struct perf_event_attr *attr);
-	u32		(*read_counter)(int idx);
-	void		(*write_counter)(int idx, u32 val);
-	void		(*start)(void);
-	void		(*stop)(void);
-	void		(*reset)(void *);
-	int		(*map_event)(struct perf_event *event);
-	int		num_events;
-	atomic_t	active_events;
-	struct mutex	reserve_mutex;
-	u64		max_period;
-	struct platform_device	*plat_device;
-	struct pmu_hw_events	*(*get_hw_events)(void);
-};
-
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
 
 /* Set at runtime when we know what CPU type we are. */
@@ -194,7 +147,7 @@ static int map_cpu_event(struct perf_event *event,
 	return -ENOENT;
 }
 
-static int
+int
 armpmu_event_set_period(struct perf_event *event,
 			struct hw_perf_event *hwc,
 			int idx)
@@ -230,7 +183,7 @@ armpmu_event_set_period(struct perf_event *event,
 	return ret;
 }
 
-static u64
+u64
 armpmu_event_update(struct perf_event *event,
 		    struct hw_perf_event *hwc,
 		    int idx, int overflow)
@@ -646,7 +599,7 @@ static void __init armpmu_init(struct arm_pmu *armpmu)
 	};
 }
 
-static int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type)
+int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type)
 {
 	armpmu_init(armpmu);
 	return perf_pmu_register(&armpmu->pmu, name, type);
-- 
1.7.0.4
