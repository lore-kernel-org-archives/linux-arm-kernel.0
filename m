From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 May 2015 17:12:26 +0100
Subject: [PATCH 4/7] arm: perf: filter unschedulable events
In-Reply-To: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
References: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431533549-27715-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Different CPU microarchitectures implement different PMU events, and
thus events which can be scheduled on one microarchitecture cannot be
scheduled on another, and vice-versa. Some archicted events behave
differently across microarchitectures, and thus cannot be meaningfully
summed. Due to this, we reject the scheduling of an event on a CPU of a
different microarchitecture to that the event targets.

When the core perf code is scheduling events and encounters an event
which cannot be scheduled, it stops attempting to schedule events. As
the perf core periodically rotates the list of events, for some
proportion of the time events which are unschedulable will block events
which are schedulable, resulting in low utilisation of the hardware
counters.

This patch implements a pmu::filter_match callback such that we can
detect and skip such events while scheduling early, before they can
block the schedulable events. This prevents the low HW counter
utilisation issue.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 9b536be..df02807 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -524,6 +524,18 @@ static void armpmu_disable(struct pmu *pmu)
 	armpmu->stop(armpmu);
 }
 
+/*
+ * In heterogeneous systems, events are specific to a particular
+ * microarchitecture, and aren't suitable for another. Thus, only match CPUs of
+ * the same microarchitecture.
+ */
+static int armpmu_filter_match(struct perf_event *event)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+	unsigned int cpu = smp_processor_id();
+	return cpumask_test_cpu(cpu, &armpmu->supported_cpus);
+}
+
 #ifdef CONFIG_PM
 static int armpmu_runtime_resume(struct device *dev)
 {
@@ -564,6 +576,7 @@ static void armpmu_init(struct arm_pmu *armpmu)
 		.start		= armpmu_start,
 		.stop		= armpmu_stop,
 		.read		= armpmu_read,
+		.filter_match	= armpmu_filter_match,
 	};
 }
 
-- 
1.9.1
