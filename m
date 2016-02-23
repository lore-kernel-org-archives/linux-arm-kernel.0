From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:49:47 +0000
Subject: [PATCH 05/13] arm-cci: Delay PMU counter writes to pmu::pmu_enable
In-Reply-To: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456224595-3282-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CCI PMU driver always reprograms the counters to a safe value (half of the
counter max, = 2^31) before starting the profiling to account for extreme
interrupt latencies. Also, the cost of writing to a PMU counter could be
very costly on some PMUs(e.g, CCI-500). In order to ammortise the cost of
programming the counters, this patch delays the counter writes to pmu::pmu_enable().
We use the PER_HES_ARCH flag to keep track of the counters which need to
be programmed. Before turning on the PMU, we go through the counters that
were marked for write, and perform the operation in a batch.

To unify all the counter writes to pmu_enable(), this patch also makes sure that
we disable-and-enable the PMU in the irq handler to program any counters that
overflowed.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   57 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index e42842b..629c9e0 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -159,6 +159,8 @@ enum cci_models {
 	CCI_MODEL_MAX
 };
 
+static void pmu_write_counters(struct cci_pmu *cci_pmu,
+				 unsigned long *mask);
 static ssize_t cci_pmu_format_show(struct device *dev,
 			struct device_attribute *attr, char *buf);
 static ssize_t cci_pmu_event_show(struct device *dev,
@@ -606,11 +608,44 @@ static int cci500_validate_hw_event(struct cci_pmu *cci_pmu,
 }
 #endif	/* CONFIG_ARM_CCI500_PMU */
 
+/*
+ * Program the CCI PMU counters which have PERF_HES_ARCH set
+ * with the event period and mark them ready before we enable
+ * PMU.
+ */
+void cci_pmu_sync_counters(struct cci_pmu *cci_pmu)
+{
+	int i;
+	struct cci_pmu_hw_events *cci_hw = &cci_pmu->hw_events;
+
+	DECLARE_BITMAP(mask, cci_pmu->num_cntrs);
+
+	bitmap_zero(mask, cci_pmu->num_cntrs);
+	for_each_set_bit(i, cci_pmu->hw_events.used_mask, cci_pmu->num_cntrs) {
+		struct perf_event *event = cci_hw->events[i];
+
+		if (WARN_ON(!event))
+			continue;
+
+		/* Leave the events which are not counting */
+		if (event->hw.state & PERF_HES_STOPPED)
+			continue;
+		if (event->hw.state & PERF_HES_ARCH) {
+			set_bit(i, mask);
+			event->hw.state &= ~PERF_HES_ARCH;
+		}
+	}
+
+	pmu_write_counters(cci_pmu, mask);
+}
+
 /* Should be called with cci_pmu->hw_events->pmu_lock held */
-static void __cci_pmu_enable(void)
+static void __cci_pmu_enable(struct cci_pmu *cci_pmu)
 {
 	u32 val;
 
+	cci_pmu_sync_counters(cci_pmu);
+
 	/* Enable all the PMU counters. */
 	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
 	writel(val, cci_ctrl_base + CCI_PMCR);
@@ -791,8 +826,7 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
 		pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
 }
 
-static void __maybe_unused
-pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
+static void pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
 {
 	int i;
 	struct cci_pmu_hw_events *cci_hw = &cci_pmu->hw_events;
@@ -840,7 +874,14 @@ void pmu_event_set_period(struct perf_event *event)
 	 */
 	u64 val = 1ULL << 31;
 	local64_set(&hwc->prev_count, val);
-	pmu_write_counter(event, val);
+
+	/*
+	 * CCI PMU uses PERF_HES_ARCH to keep track of the counters, whose
+	 * values needs to be sync-ed with the s/w state before the PMU is
+	 * enabled.
+	 * Mark this counter for sync.
+	 */
+	hwc->state |= PERF_HES_ARCH;
 }
 
 static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
@@ -851,6 +892,9 @@ static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
 	int idx, handled = IRQ_NONE;
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/* Disable the PMU while we walk through the counters */
+	__cci_pmu_disable();
 	/*
 	 * Iterate over counters and update the corresponding perf events.
 	 * This should work regardless of whether we have per-counter overflow
@@ -877,6 +921,9 @@ static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
 		pmu_event_set_period(event);
 		handled = IRQ_HANDLED;
 	}
+
+	/* Enable the PMU and sync possibly overflowed counters */
+	__cci_pmu_enable(cci_pmu);
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 
 	return IRQ_RETVAL(handled);
@@ -920,7 +967,7 @@ static void cci_pmu_enable(struct pmu *pmu)
 		return;
 
 	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
-	__cci_pmu_enable();
+	__cci_pmu_enable(cci_pmu);
 	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
 
 }
-- 
1.7.9.5
