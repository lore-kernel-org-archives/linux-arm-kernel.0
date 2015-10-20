From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 20 Oct 2015 14:05:26 +0100
Subject: [PATCHv2 4/4] arm-cci500: Work around PMU counter writes
In-Reply-To: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445346326-30820-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCI PMU driver sets the event counter to the half of the maximum
value(2^31) it can count before we start the counters via
pmu_event_set_period(). This is done to give us the best chance to
handle the overflow interrupt, taking care of extreme interrupt latencies.

However, CCI-500 comes with advanced power saving schemes, which disables
the clock to the event counters unless the counters are enabled to count
(PMCR.CEN). This prevents the driver from writing the period to the
counters before starting them.  Also, there is no way we can reset the
individual event counter to 0 (PMCR.RST resets all the counters, losing
their current readings). However the value of the counter is preserved and
could be read back, when the counters are not enabled.

So we cannot reliably use the counters and compute the number of events
generated during the sampling period since we don't have the value of the
counter at start.

This patch works around this issue by changing writes to the counter
with the following steps only for th CCI-500.

 1) Disable all the counters (remembering any counters which were enabled)
 2) Save the current event and program the target counter to count an
    invalid event, which by spec is guaranteed to not-generate any events.
 3) Enable the target counter.
 4) Enable the CCI PMU
 5) Write to the target counter.
 6) Disable the CCI PMU and the target counter
 7) Restore the event back on the target counter.
 8) Restore the status of the all the counters

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: arm at kernel.org
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7f4a266..cbb54b9 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -128,6 +128,7 @@ struct cci_pmu_model {
 	struct event_range event_ranges[CCI_IF_MAX];
 	int (*validate_hw_event)(struct cci_pmu *, unsigned long);
 	int (*get_event_idx)(struct cci_pmu *, struct cci_pmu_hw_events *, unsigned long);
+	void (*write_counter)(struct cci_pmu *, int, u32);
 };
 
 static struct cci_pmu_model cci_pmu_models[];
@@ -472,6 +473,12 @@ static inline struct cci_pmu_model *probe_cci_model(struct platform_device *pdev
 #define CCI500_GLOBAL_PORT_MIN_EV	0x00
 #define CCI500_GLOBAL_PORT_MAX_EV	0x0f
 
+/*
+ * For a guranteed non-counting event, we use a master source with the highest
+ * possible event code, which has the least chances of being assigned a code for.
+ */
+#define CCI500_INVALID_EVENT		(CCI500_PORT_M0 << CCI500_PMU_EVENT_SOURCE_SHIFT | \
+					CCI500_PMU_EVENT_CODE_MASK << CCI500_PMU_EVENT_CODE_SHIFT)
 
 #define CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(_name, _config) \
 	CCI_EXT_ATTR_ENTRY(_name, cci500_pmu_global_event_show, \
@@ -846,6 +853,47 @@ static void __pmu_write_counter(struct cci_pmu *cci_pmu, int idx, u32 value)
 	pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
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
+ * 2) Save the programmed event, and write an invalid event code
+ *    to the event control register for the counter, so that the
+ *    counters are not modified.
+ * 3) Enable the counter control for the counter.
+ * 4) Enable the global PMU profiling
+ * 5) Set the counter value
+ * 6) Disable the counter, global PMU.
+ * 7) Restore the event in the target counter
+ * 8) Restore the status of the rest of the counters.
+ */
+static void cci500_write_counter(struct cci_pmu *cci_pmu, int idx, u32 value)
+{
+	unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];
+	u32 event;
+
+	memset(mask, 0, BITS_TO_LONGS(cci_pmu->num_cntrs) * sizeof(unsigned long));
+
+	pmu_disable_counters_ctrl(cci_pmu, mask);
+	event = pmu_get_event(cci_pmu, idx);
+	pmu_set_event(cci_pmu, idx, CCI500_INVALID_EVENT);
+	pmu_enable_counter(cci_pmu, idx);
+	__cci_pmu_enable();
+	__pmu_write_counter(cci_pmu, idx, value);
+	__cci_pmu_disable();
+	pmu_disable_counter(cci_pmu, idx);
+	pmu_set_event(cci_pmu, idx, event);
+	pmu_restore_counters_ctrl(cci_pmu, mask);
+}
+
+#endif	/* ARM_CCI500_PMU */
 static void pmu_write_counter(struct perf_event *event, u32 value)
 {
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
@@ -856,7 +904,10 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
 		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
 		return;
 	}
-	__pmu_write_counter(cci_pmu, idx, value);
+	if (cci_pmu->model->write_counter)
+		cci_pmu->model->write_counter(cci_pmu, idx, value);
+	else
+		__pmu_write_counter(cci_pmu, idx, value);
 }
 
 static u64 pmu_event_update(struct perf_event *event)
@@ -1458,6 +1509,7 @@ static struct cci_pmu_model cci_pmu_models[] = {
 			},
 		},
 		.validate_hw_event = cci500_validate_hw_event,
+		.write_counter = cci500_write_counter,
 	},
 #endif
 };
-- 
1.7.9.5
