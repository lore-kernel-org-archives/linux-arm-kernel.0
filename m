From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:49:51 +0000
Subject: [PATCH 09/13] arm-cci: Add helper to enable PMU without synchornising
 counters
In-Reply-To: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456224595-3282-10-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On CCI-500 writing to a counter requires turning the PMU on. So,
synchronising the counter state should not be performed for such special cases,
while turning the PMU on. This patch adds a helper, __cci_pmu_enable_nosync(),
without flushing the counter states.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7ce7da0..bcc4c59 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -640,18 +640,23 @@ void cci_pmu_sync_counters(struct cci_pmu *cci_pmu)
 }
 
 /* Should be called with cci_pmu->hw_events->pmu_lock held */
-static void __cci_pmu_enable(struct cci_pmu *cci_pmu)
+static void __cci_pmu_enable_nosync(struct cci_pmu *cci_pmu)
 {
 	u32 val;
 
-	cci_pmu_sync_counters(cci_pmu);
-
 	/* Enable all the PMU counters. */
 	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
 	writel(val, cci_ctrl_base + CCI_PMCR);
 }
 
 /* Should be called with cci_pmu->hw_events->pmu_lock held */
+static void __cci_pmu_enable_sync(struct cci_pmu *cci_pmu)
+{
+	cci_pmu_sync_counters(cci_pmu);
+	__cci_pmu_enable_nosync(cci_pmu);
+}
+
+/* Should be called with cci_pmu->hw_events->pmu_lock held */
 static void __cci_pmu_disable(void)
 {
 	u32 val;
@@ -960,7 +965,7 @@ static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
 	}
 
 	/* Enable the PMU and sync possibly overflowed counters */
-	__cci_pmu_enable(cci_pmu);
+	__cci_pmu_enable_sync(cci_pmu);
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 
 	return IRQ_RETVAL(handled);
@@ -1004,7 +1009,7 @@ static void cci_pmu_enable(struct pmu *pmu)
 		return;
 
 	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
-	__cci_pmu_enable(cci_pmu);
+	__cci_pmu_enable_sync(cci_pmu);
 	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
 
 }
-- 
1.7.9.5
