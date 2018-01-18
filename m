From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Thu, 18 Jan 2018 18:43:43 +0100
Subject: [PATCH 1/3] drivers/perf: arm_pmu: Add platform hardware setup hooks.
In-Reply-To: <20180118174345.26620-1-sebastian.reichel@collabora.co.uk>
References: <20180118174345.26620-1-sebastian.reichel@collabora.co.uk>
Message-ID: <20180118174345.26620-2-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow platform specific code to be called when enabling or
disabling the hardware.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
[rebased to v4.12]
Signed-off-by: Nandor Han <nandor.han@ge.com>
[Simplify and cleanup for upstreaming]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/perf/arm_pmu.c       | 13 +++++++++++++
 include/linux/perf/arm_pmu.h |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 7bc5eee96b31..165006b9a00d 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -452,8 +452,10 @@ static int armpmu_event_init(struct perf_event *event)
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
+	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
 	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
+	int err;
 
 	/* For task-bound events we may be called on other CPUs */
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
@@ -461,17 +463,28 @@ static void armpmu_enable(struct pmu *pmu)
 
 	if (enabled)
 		armpmu->start(armpmu);
+
+	if (platdata && platdata->reserve_hardware) {
+		err = platdata->reserve_hardware(armpmu);
+		if (err)
+			dev_warn(&armpmu->plat_device->dev, "Could not reserve PMU hardware!\n");
+	}
+
 }
 
 static void armpmu_disable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
+	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
 
 	/* For task-bound events we may be called on other CPUs */
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
 		return;
 
 	armpmu->stop(armpmu);
+
+	if (platdata && platdata->release_hardware)
+		platdata->release_hardware(armpmu);
 }
 
 /*
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index af0f44effd44..942ae9bfe971 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -17,6 +17,8 @@
 #include <linux/sysfs.h>
 #include <asm/cputype.h>
 
+struct arm_pmu;
+
 /*
  * struct arm_pmu_platdata - ARM PMU platform data
  *
@@ -31,6 +33,8 @@
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
+	int (*reserve_hardware)(struct arm_pmu *arm_pmu);
+	void (*release_hardware)(struct arm_pmu *arm_pmu);
 	unsigned long irq_flags;
 };
 
@@ -112,6 +116,7 @@ struct arm_pmu {
 	int		(*map_event)(struct perf_event *event);
 	int		num_events;
 	u64		max_period;
+	bool		reserved_hardware;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
-- 
2.15.1
