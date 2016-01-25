From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 25 Jan 2016 11:21:15 +0000
Subject: [PATCH v6 10/12] arm-cci: CCI-500: Work around PMU counter writes
In-Reply-To: <1453720877-24962-1-git-send-email-suzuki.poulose@arm.com>
References: <1453720877-24962-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1453720877-24962-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCI PMU driver sets the event counter to the half of the maximum
value(2^31) it can count before we start the counters via
pmu_event_set_period(). This is done to give us the best chance to
handle the overflow interrupt, taking care of extreme interrupt latencies.

However, CCI-500 comes with advanced power saving schemes, which
disables the clock to the event counters unless the counters are enabled to
count (PMCR.CEN). This prevents the driver from writing the period to the
counters before starting them.  Also, there is no way we can reset the
individual event counter to 0 (PMCR.RST resets all the counters, losing
their current readings). However the value of the counter is preserved and
could be read back, when the counters are not enabled.

So we cannot reliably use the counters and compute the number of events
generated during the sampling period since we don't have the value of the
counter at start.

This patch works around this issue by changing writes to the counter
with the following steps.

 1) Disable all the counters (remembering any counters which were enabled)
 2) Enable the PMU, now that all the counters are disabled.

 For each counter to be programmed, repeat steps 3-7
 3) Save the current event and program the target counter to count an
    invalid event, which by spec is guaranteed to not-generate any events.
 4) Enable the target counter.
 5) Write to the target counter.
 6) Disable the target counter
 7) Restore the event back on the target counter.

 8) Disable the PMU
 9) Restore the status of the all the counters

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 4e68593..69a8a61 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -890,6 +890,73 @@ static void pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
 		__pmu_write_counters(cci_pmu, mask);
 }
 
+#ifdef CONFIG_ARM_CCI500_PMU
+
+/*
+ * CCI-500 has advanced power saving policies, which could gate the
+ * clocks to the PMU counters, which makes the writes to them ineffective.
+ * The only way to write to those counters is when the global counters
+ * are enabled and the particular counter is enabled.
+ *
+ * So we do the following :
+ *
+ * 1) Disable all the PMU counters, saving their current state
+ * 2) Enable the global PMU profiling, now that all counters are
+ *    disabled.
+ *
+ * For each counter to be programmed, repeat steps 3-7:
+ *
+ * 3) Write an invalid event code to the event control register for the
+      counter, so that the counters are not modified.
+ * 4) Enable the counter control for the counter.
+ * 5) Set the counter value
+ * 6) Restore the event in the target counter
+ * 7) Disable the counter
+ *
+ * 8) Disable the global PMU.
+ * 9) Restore the status of the rest of the counters.
+ *
+ * We choose an event code which has very little chances of getting
+ * assigned a valid code for step(2). We use the highest possible
+ * event code (0x1f) for the master interface 0.
+ */
+#define CCI500_INVALID_EVENT	((CCI500_PORT_M0 << CCI500_PMU_EVENT_SOURCE_SHIFT) | \
+				 (CCI500_PMU_EVENT_CODE_MASK << CCI500_PMU_EVENT_CODE_SHIFT))
+static void cci500_pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
+{
+	int i;
+	DECLARE_BITMAP(saved_mask, cci_pmu->num_cntrs);
+
+	bitmap_zero(saved_mask, cci_pmu->num_cntrs);
+	pmu_save_counters(cci_pmu, saved_mask);
+
+	/*
+	 * Now that all the counters are disabled, we can safely turn the PMU on,
+	 * without syncing the status of the counters
+	 */
+	__cci_pmu_enable(cci_pmu, CCI_CNTRS_NOSYNC);
+
+	for_each_set_bit(i, mask, cci_pmu->num_cntrs) {
+		struct perf_event *event = cci_pmu->hw_events.events[i];
+
+		if (WARN_ON(!event))
+			continue;
+
+		pmu_set_event(cci_pmu, i, CCI500_INVALID_EVENT);
+		pmu_enable_counter(cci_pmu, i);
+		pmu_write_counter(cci_pmu,
+				  (u32)local64_read(&event->hw.prev_count), i);
+		pmu_disable_counter(cci_pmu, i);
+		pmu_set_event(cci_pmu, i, event->hw.config_base);
+	}
+
+	__cci_pmu_disable();
+
+	pmu_restore_counters(cci_pmu, saved_mask);
+}
+
+#endif	/* CONFIG_ARM_CCI500_PMU */
+
 static u64 pmu_event_update(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -1474,6 +1541,7 @@ static struct cci_pmu_model cci_pmu_models[] = {
 			},
 		},
 		.validate_hw_event = cci500_validate_hw_event,
+		.write_counters	= cci500_pmu_write_counters,
 	},
 #endif
 };
-- 
1.7.9.5
