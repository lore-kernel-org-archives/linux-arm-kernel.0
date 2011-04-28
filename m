From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Apr 2011 16:27:54 +0100
Subject: [RFC PATCH 12/15] ARM: perf: add support for multiple PMUs
Message-ID: <mailman.82.1313415786.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, a single static instance of struct pmu is used when
registering an ARM PMU with the main perf subsystem. This limits
the ARM perf code to supporting a single PMU.

This patch replaces the static struct pmu instance with a member
variable on struct arm_pmu. This provides bidirectional mapping
between the two structs, and therefore allows for support of multiple
PMUs. The function 'to_arm_pmu' is provided for convenience.

PMU-generic functions are also updated to use the new mapping, and
PMU-generic initialisation of the member variables is moved into a new
function: armpmu_init.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |   63 +++++++++++++++++++++++++++--------------
 1 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index b13bf23..7f31eff 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -59,6 +59,7 @@ struct cpu_hw_events {
 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
 struct arm_pmu {
+	struct pmu	pmu;
 	enum arm_perf_pmu_ids id;
 	enum arm_pmu_type type;
 	cpumask_t	active_irqs;
@@ -84,6 +85,8 @@ struct arm_pmu {
 	struct cpu_hw_events	*(*get_hw_events)(void);
 };
 
+#define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
+
 /* Set at runtime when we know what CPU type we are. */
 static struct arm_pmu *armpmu;
 
@@ -193,6 +196,7 @@ armpmu_event_set_period(struct perf_event *event,
 			struct hw_perf_event *hwc,
 			int idx)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	s64 left = local64_read(&hwc->period_left);
 	s64 period = hwc->sample_period;
 	int ret = 0;
@@ -228,6 +232,7 @@ armpmu_event_update(struct perf_event *event,
 		    struct hw_perf_event *hwc,
 		    int idx, int overflow)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	u64 delta, prev_raw_count, new_raw_count;
 
 again:
@@ -267,6 +272,7 @@ armpmu_read(struct perf_event *event)
 static void
 armpmu_stop(struct perf_event *event, int flags)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
 	/*
@@ -284,6 +290,7 @@ armpmu_stop(struct perf_event *event, int flags)
 static void
 armpmu_start(struct perf_event *event, int flags)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
 	/*
@@ -308,6 +315,7 @@ armpmu_start(struct perf_event *event, int flags)
 static void
 armpmu_del(struct perf_event *event, int flags)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct cpu_hw_events *cpuc = armpmu->get_hw_events();
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
@@ -324,6 +332,7 @@ armpmu_del(struct perf_event *event, int flags)
 static int
 armpmu_add(struct perf_event *event, int flags)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct cpu_hw_events *cpuc = armpmu->get_hw_events();
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
@@ -358,12 +367,11 @@ out:
 	return err;
 }
 
-static struct pmu pmu;
-
 static int
 validate_event(struct cpu_hw_events *cpuc,
 	       struct perf_event *event)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event fake_event = event->hw;
 	struct pmu *leader_pmu = event->group_leader->pmu;
 
@@ -397,6 +405,7 @@ validate_group(struct perf_event *event)
 
 static irqreturn_t armpmu_platform_irq(int irq, void *dev)
 {
+	struct arm_pmu *armpmu = (struct arm_pmu *) dev;
 	struct platform_device *plat_device = armpmu->plat_device;
 	struct arm_pmu_platdata *plat = dev_get_platdata(&plat_device->dev);
 
@@ -404,7 +413,7 @@ static irqreturn_t armpmu_platform_irq(int irq, void *dev)
 }
 
 static void
-armpmu_release_hardware(void)
+armpmu_release_hardware(struct arm_pmu *armpmu)
 {
 	int i, irq, irqs;
 	struct platform_device *pmu_device = armpmu->plat_device;
@@ -416,14 +425,14 @@ armpmu_release_hardware(void)
 			continue;
 		irq = platform_get_irq(pmu_device, i);
 		if (irq >= 0)
-			free_irq(irq, NULL);
+			free_irq(irq, armpmu);
 	}
 
 	release_pmu(armpmu->type);
 }
 
 static int
-armpmu_reserve_hardware(void)
+armpmu_reserve_hardware(struct arm_pmu *armpmu)
 {
 	struct arm_pmu_platdata *plat;
 	irq_handler_t handle_irq;
@@ -467,11 +476,11 @@ armpmu_reserve_hardware(void)
 
 		err = request_irq(irq, handle_irq,
 				  IRQF_DISABLED | IRQF_NOBALANCING,
-				  "arm-pmu", NULL);
+				  "arm-pmu", armpmu);
 		if (err) {
 			pr_err("unable to request IRQ%d for ARM PMU counters\n",
 				irq);
-			armpmu_release_hardware();
+			armpmu_release_hardware(armpmu);
 			return err;
 		}
 
@@ -484,11 +493,12 @@ armpmu_reserve_hardware(void)
 static void
 hw_perf_event_destroy(struct perf_event *event)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	atomic_t *active_events	 = &armpmu->active_events;
 	struct mutex *pmu_reserve_mutex = &armpmu->reserve_mutex;
 
 	if (atomic_dec_and_mutex_lock(active_events, pmu_reserve_mutex)) {
-		armpmu_release_hardware();
+		armpmu_release_hardware(armpmu);
 		mutex_unlock(pmu_reserve_mutex);
 	}
 }
@@ -503,6 +513,7 @@ event_requires_mode_exclusion(struct perf_event_attr *attr)
 static int
 __hw_perf_event_init(struct perf_event *event)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int mapping, err;
 
@@ -559,6 +570,7 @@ __hw_perf_event_init(struct perf_event *event)
 
 static int armpmu_event_init(struct perf_event *event)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	int err = 0;
 	atomic_t *active_events = &armpmu->active_events;
 
@@ -570,7 +582,7 @@ static int armpmu_event_init(struct perf_event *event)
 	if (!atomic_inc_not_zero(active_events)) {
 		mutex_lock(&armpmu->reserve_mutex);
 		if (atomic_read(active_events) == 0)
-			err = armpmu_reserve_hardware();
+			err = armpmu_reserve_hardware(armpmu);
 
 		if (!err)
 			atomic_inc(active_events);
@@ -589,6 +601,7 @@ static int armpmu_event_init(struct perf_event *event)
 
 static void armpmu_enable(struct pmu *pmu)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(pmu);
 	/* Enable all of the perf events on hardware. */
 	int idx, enabled = 0;
 	struct cpu_hw_events *cpuc = armpmu->get_hw_events();
@@ -609,24 +622,31 @@ static void armpmu_enable(struct pmu *pmu)
 
 static void armpmu_disable(struct pmu *pmu)
 {
+	struct arm_pmu *armpmu = to_arm_pmu(pmu);
 	armpmu->stop();
 }
 
-static struct pmu pmu = {
-	.pmu_enable	= armpmu_enable,
-	.pmu_disable	= armpmu_disable,
-	.event_init	= armpmu_event_init,
-	.add		= armpmu_add,
-	.del		= armpmu_del,
-	.start		= armpmu_start,
-	.stop		= armpmu_stop,
-	.read		= armpmu_read,
-};
-
 static void __init armpmu_init(struct arm_pmu *armpmu)
 {
 	atomic_set(&armpmu->active_events, 0);
 	mutex_init(&armpmu->reserve_mutex);
+
+	armpmu->pmu = (struct pmu) {
+		.pmu_enable	= armpmu_enable,
+		.pmu_disable	= armpmu_disable,
+		.event_init	= armpmu_event_init,
+		.add		= armpmu_add,
+		.del		= armpmu_del,
+		.start		= armpmu_start,
+		.stop		= armpmu_stop,
+		.read		= armpmu_read,
+	};
+}
+
+static int __init armpmu_register(struct arm_pmu *armpmu, char *name, int type)
+{
+	armpmu_init(armpmu);
+	return perf_pmu_register(&armpmu->pmu, name, type);
 }
 
 /* Include the PMU-specific implementations. */
@@ -751,8 +771,7 @@ init_hw_perf_events(void)
 		pr_info("enabled with %s PMU driver, %d counters available\n",
 			armpmu->name, armpmu->num_events);
 		cpu_pmu_init(armpmu);
-		armpmu_init(armpmu);
-		perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
+		armpmu_register(armpmu, "cpu", PERF_TYPE_RAW);
 	} else {
 		pr_info("no hardware support available\n");
 	}
-- 
1.7.0.4
