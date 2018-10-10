From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Oct 2018 17:31:50 +0100
Subject: [PATCH 1/6] arm64: perf: Reject stand-alone CHAIN events for PMUv3
In-Reply-To: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
References: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
Message-ID: <1539189115-16221-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't make sense for a perf event to be configured as a CHAIN event
in isolation, so extend the arm_pmu structure with a ->filter_match()
function to allow the backend PMU implementation to reject CHAIN events
early.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 7 +++++++
 drivers/perf/arm_pmu.c         | 8 +++++++-
 include/linux/perf/arm_pmu.h   | 1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 8e38d5267f22..e213f8e867f6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -966,6 +966,12 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
+static int armv8pmu_filter_match(struct perf_event *event)
+{
+	unsigned long evtype = event->hw.config_base & ARMV8_PMU_EVTYPE_EVENT;
+	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
+}
+
 static void armv8pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
@@ -1114,6 +1120,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->stop			= armv8pmu_stop,
 	cpu_pmu->reset			= armv8pmu_reset,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
+	cpu_pmu->filter_match		= armv8pmu_filter_match;
 
 	return 0;
 }
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 7f01f6f60b87..d0b7dd8fb184 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -485,7 +485,13 @@ static int armpmu_filter_match(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	unsigned int cpu = smp_processor_id();
-	return cpumask_test_cpu(cpu, &armpmu->supported_cpus);
+	int ret;
+
+	ret = cpumask_test_cpu(cpu, &armpmu->supported_cpus);
+	if (ret && armpmu->filter_match)
+		return armpmu->filter_match(event);
+
+	return ret;
 }
 
 static ssize_t armpmu_cpumask_show(struct device *dev,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 10f92e1d8e7b..bf309ff6f244 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -99,6 +99,7 @@ struct arm_pmu {
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
+	int		(*filter_match)(struct perf_event *event);
 	int		num_events;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
-- 
2.1.4
