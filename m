From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 20 Oct 2015 14:05:23 +0100
Subject: [PATCHv2 1/4] arm-cci: Refactor CCI PMU code
In-Reply-To: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445346326-30820-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch refactors the CCI PMU driver code a little bit to
make it easier share the code for enabling/disabling the CCI
PMU. This will be used by the hooks to work around the special cases
where writing to a counter is not always that easy(e.g, CCI-500)

No functional changes.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: arm at kernel.org
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   94 +++++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 38 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 577cc4b..5435d87 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -738,6 +738,53 @@ static void pmu_free_irq(struct cci_pmu *cci_pmu)
 	}
 }
 
+/* Should be called with cci_pmu->hw_events->pmu_lock */
+static void __cci_pmu_enable(void)
+{
+	u32 val;
+
+	/* Enable all the PMU counters. */
+	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
+	writel(val, cci_ctrl_base + CCI_PMCR);
+}
+
+/* Should be called with cci_pmu->hw_events->pmu_lock */
+static void __cci_pmu_disable(void)
+{
+	u32 val;
+
+	/* Disable all the PMU counters. */
+	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) & ~CCI_PMCR_CEN;
+	writel(val, cci_ctrl_base + CCI_PMCR);
+}
+
+static void cci_pmu_enable(struct pmu *pmu)
+{
+	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_cntrs);
+	unsigned long flags;
+
+	if (!enabled)
+		return;
+
+	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
+	__cci_pmu_enable();
+	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
+
+}
+
+static void cci_pmu_disable(struct pmu *pmu)
+{
+	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
+	__cci_pmu_disable();
+	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
+}
+
 static u32 pmu_read_counter(struct perf_event *event)
 {
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
@@ -754,16 +801,22 @@ static u32 pmu_read_counter(struct perf_event *event)
 	return value;
 }
 
+static void __pmu_write_counter(struct cci_pmu *cci_pmu, int idx, u32 value)
+{
+	pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
+}
+
 static void pmu_write_counter(struct perf_event *event, u32 value)
 {
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
 	struct hw_perf_event *hw_counter = &event->hw;
 	int idx = hw_counter->idx;
 
-	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx)))
+	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
 		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
-	else
-		pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
+		return;
+	}
+	__pmu_write_counter(cci_pmu, idx, value);
 }
 
 static u64 pmu_event_update(struct perf_event *event)
@@ -869,41 +922,6 @@ static void hw_perf_event_destroy(struct perf_event *event)
 	}
 }
 
-static void cci_pmu_enable(struct pmu *pmu)
-{
-	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
-	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
-	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_cntrs);
-	unsigned long flags;
-	u32 val;
-
-	if (!enabled)
-		return;
-
-	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
-
-	/* Enable all the PMU counters. */
-	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
-	writel(val, cci_ctrl_base + CCI_PMCR);
-	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
-
-}
-
-static void cci_pmu_disable(struct pmu *pmu)
-{
-	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
-	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
-	unsigned long flags;
-	u32 val;
-
-	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
-
-	/* Disable all the PMU counters. */
-	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) & ~CCI_PMCR_CEN;
-	writel(val, cci_ctrl_base + CCI_PMCR);
-	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
-}
-
 /*
  * Check if the idx represents a non-programmable counter.
  * All the fixed event counters are mapped before the programmable
-- 
1.7.9.5
