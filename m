From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  4 Jan 2016 11:54:43 +0000
Subject: [PATCH v5 04/11] arm-cci: Refactor CCI PMU enable/disable methods
In-Reply-To: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1451908490-2615-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch refactors the CCI PMU driver code a little bit to
make it easier share the code for enabling/disabling the CCI
PMU. This will be used by the hooks to work around the special cases
where writing to a counter is not always that easy(e.g, CCI-500)

No functional changes.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index f6b8717..0189f3a 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -675,6 +675,26 @@ static u32 pmu_get_max_counters(void)
 		CCI_PMCR_NCNT_MASK) >> CCI_PMCR_NCNT_SHIFT;
 }
 
+/* Should be called with cci_pmu->hw_events->pmu_lock held */
+static void __cci_pmu_enable(void)
+{
+	u32 val;
+
+	/* Enable all the PMU counters. */
+	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
+	writel(val, cci_ctrl_base + CCI_PMCR);
+}
+
+/* Should be called with cci_pmu->hw_events->pmu_lock held */
+static void __cci_pmu_disable(void)
+{
+	u32 val;
+
+	/* Disable all the PMU counters. */
+	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) & ~CCI_PMCR_CEN;
+	writel(val, cci_ctrl_base + CCI_PMCR);
+}
+
 static int pmu_get_event_idx(struct cci_pmu_hw_events *hw, struct perf_event *event)
 {
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
@@ -902,16 +922,12 @@ static void cci_pmu_enable(struct pmu *pmu)
 	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
 	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_cntrs);
 	unsigned long flags;
-	u32 val;
 
 	if (!enabled)
 		return;
 
 	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
-
-	/* Enable all the PMU counters. */
-	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
-	writel(val, cci_ctrl_base + CCI_PMCR);
+	__cci_pmu_enable();
 	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
 
 }
@@ -921,13 +937,9 @@ static void cci_pmu_disable(struct pmu *pmu)
 	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
 	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
 	unsigned long flags;
-	u32 val;
 
 	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
-
-	/* Disable all the PMU counters. */
-	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) & ~CCI_PMCR_CEN;
-	writel(val, cci_ctrl_base + CCI_PMCR);
+	__cci_pmu_disable();
 	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
 }
 
-- 
1.7.9.5
