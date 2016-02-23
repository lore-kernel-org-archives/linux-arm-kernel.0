From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:49:52 +0000
Subject: [PATCH 10/13] arm-cci: Provide hook for writing to PMU counters
In-Reply-To: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456224595-3282-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a hook for writing to CCI PMU counters. This callback
can be used for CCI models which requires some extra work
to program the PMU counter values. To accommodate group writes
and single counter writes, the call back accepts a bitmask
of the counter indices which need to be programmed with the
given value.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index bcc4c59..f1d3f47 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -126,6 +126,7 @@ struct cci_pmu_model {
 	struct event_range event_ranges[CCI_IF_MAX];
 	int (*validate_hw_event)(struct cci_pmu *, unsigned long);
 	int (*get_event_idx)(struct cci_pmu *, struct cci_pmu_hw_events *, unsigned long);
+	void (*write_counters)(struct cci_pmu *, unsigned long *);
 };
 
 static struct cci_pmu_model cci_pmu_models[];
@@ -868,7 +869,7 @@ static void pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
 	pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
 }
 
-static void pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
+static void __pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
 {
 	int i;
 	struct cci_pmu_hw_events *cci_hw = &cci_pmu->hw_events;
@@ -882,6 +883,14 @@ static void pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
 	}
 }
 
+static void pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
+{
+	if (cci_pmu->model->write_counters)
+		cci_pmu->model->write_counters(cci_pmu, mask);
+	else
+		__pmu_write_counters(cci_pmu, mask);
+}
+
 static u64 pmu_event_update(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-- 
1.7.9.5
