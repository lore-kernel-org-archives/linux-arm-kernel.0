From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 25 Sep 2015 16:50:53 +0100
Subject: [PATCH] arm-cci500: Workaround pmu_event_set_period
Message-ID: <1443196253-22765-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

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

Here are the possible solutions:

 1) Disable clock gating on CCI-500 by setting Control_Override_Reg[bit3].
    - The Control_Override_Reg is secure (and hence not programmable from
      Linux), and also has an impact on power consumption.

 2) Change the order of operations
	i.e,
	a) Program and enable individual counters
	b) Enable counting on all the counters by setting PMCR.CEN
	c) Write the period to the individual counters
	d) Disable the counters
    - This could cause in unnecessary noise in the other counters and is
      costly (we should repeat this for all enabled counters).

 3) Don't set the counter value, instead use the current count as the
    starting count and compute the delta at the end of sampling.

This patch implements option 3 for CCI-500. CCI-400 behavior remains
unchanged. The problem didn't surface on a fast model, but was revealed
on an FPGA model. Without this patch profiling on CCI-500 is broken and
should be fixed for 4.3.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: arm at kernel.org
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 577cc4b..7db99dc 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -88,6 +88,10 @@ static const struct of_device_id arm_cci_matches[] = {
 #define CCI_PMU_MAX_HW_CNTRS(model) \
 	((model)->num_hw_cntrs + (model)->fixed_hw_cntrs)
 
+/*	 CCI PMU flags	 */
+/* Writes to CNTR is ignored, see pmu_event_set_period() */
+#define CCI_PMU_IGNORE_CNTR_WRITE	(1 << 0)
+
 /* Types of interfaces that can generate events */
 enum {
 	CCI_IF_SLAVE,
@@ -118,6 +122,7 @@ struct cci_pmu;
  */
 struct cci_pmu_model {
 	char *name;
+	u32 flags;
 	u32 fixed_hw_cntrs;
 	u32 num_hw_cntrs;
 	u32 cntr_size;
@@ -472,6 +477,7 @@ static inline struct cci_pmu_model *probe_cci_model(struct platform_device *pdev
 #define CCI500_GLOBAL_PORT_MIN_EV	0x00
 #define CCI500_GLOBAL_PORT_MAX_EV	0x0f
 
+#define CCI500_PMU_FLAGS		(CCI_PMU_IGNORE_CNTR_WRITE)
 
 #define CCI500_GLOBAL_EVENT_EXT_ATTR_ENTRY(_name, _config) \
 	CCI_EXT_ATTR_ENTRY(_name, cci500_pmu_global_event_show, \
@@ -619,6 +625,11 @@ static ssize_t cci_pmu_event_show(struct device *dev,
 					 (unsigned long)eattr->var);
 }
 
+static inline bool pmu_ignores_cntr_write(struct cci_pmu *cci_pmu)
+{
+	return !!(cci_pmu->model->flags & CCI_PMU_IGNORE_CNTR_WRITE);
+}
+
 static int pmu_is_valid_counter(struct cci_pmu *cci_pmu, int idx)
 {
 	return 0 <= idx && idx <= CCI_PMU_CNTR_LAST(cci_pmu);
@@ -792,15 +803,33 @@ static void pmu_read(struct perf_event *event)
 void pmu_event_set_period(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
+	u64 val = 0;
+
 	/*
-	 * The CCI PMU counters have a period of 2^32. To account for the
-	 * possiblity of extreme interrupt latency we program for a period of
-	 * half that. Hopefully we can handle the interrupt before another 2^31
-	 * events occur and the counter overtakes its previous value.
+	 * If the PMU gates the clock to PMU event counters when the counters
+	 * are not enabled, any write to it is ineffective. Hence we cannot
+	 * set a value reliably. Also, we cannot reset an individual event
+	 * counter; PMCR.RST resets all the counters. However the existing
+	 * counter values can be read back. Hence, we use the existing counter
+	 * value as the period and set the prev_count accordingly. This is
+	 * safe, since we don't support sampling of events anyway.
 	 */
-	u64 val = 1ULL << 31;
+	if (pmu_ignores_cntr_write(cci_pmu)) {
+		val = pmu_read_counter(event);
+	} else {
+		/*
+		 * The CCI PMU counters have a period of 2^32. To account for
+		 * the possiblity of extreme interrupt latency we program for
+		 * a period of half that. Hopefully we can handle the interrupt
+		 * before another 2^31 events occur and the counter overtakes
+		 * its previous value.
+		 */
+		val = 1ULL << 31;
+		pmu_write_counter(event, val);
+	}
+
 	local64_set(&hwc->prev_count, val);
-	pmu_write_counter(event, val);
 }
 
 static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
@@ -1380,6 +1409,7 @@ static struct cci_pmu_model cci_pmu_models[] = {
 		.name = "CCI_500",
 		.fixed_hw_cntrs = 0,
 		.num_hw_cntrs = 8,
+		.flags = CCI500_PMU_FLAGS,
 		.cntr_size = SZ_64K,
 		.format_attrs = cci500_pmu_format_attrs,
 		.nformat_attrs = ARRAY_SIZE(cci500_pmu_format_attrs),
-- 
1.7.9.5
