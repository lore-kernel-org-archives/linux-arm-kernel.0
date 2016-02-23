From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:49:46 +0000
Subject: [PATCH 04/13] arm-cci: Refactor CCI PMU enable/disable methods
In-Reply-To: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456224595-3282-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch refactors the CCI PMU driver code a little bit to
make it easier share the code for enabling/disabling the CCI
PMU. This will be used by the hooks to work around the special cases
where writing to a counter is not always that easy(e.g, CCI-500)

No functional changes.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 6a76ac7..e42842b 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -606,6 +606,26 @@ static int cci500_validate_hw_event(struct cci_pmu *cci_pmu,
 }
 #endif	/* CONFIG_ARM_CCI500_PMU */
 
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
 static ssize_t cci_pmu_format_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -895,16 +915,12 @@ static void cci_pmu_enable(struct pmu *pmu)
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
@@ -914,13 +930,9 @@ static void cci_pmu_disable(struct pmu *pmu)
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
