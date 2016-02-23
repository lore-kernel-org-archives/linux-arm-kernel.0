From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:49:50 +0000
Subject: [PATCH 08/13] arm-cci: Add routines to save/restore all counters
In-Reply-To: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456224595-3282-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds helper routines to disable the counter controls for
all the counters on the CCI PMU and restore it back, by
preserving the original state in caller provided mask.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index d289037..7ce7da0 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -719,6 +719,44 @@ static void pmu_set_event(struct cci_pmu *cci_pmu, int idx, unsigned long event)
 }
 
 /*
+ * For all counters on the CCI-PMU, disable any 'enabled' counters,
+ * saving the changed counters in the mask, so that we can restore
+ * it later using pmu_restore_counters. The mask is private to the
+ * caller. We cannot rely on the used_mask maintained by the CCI_PMU
+ * as it only tells us if the counter is assigned to perf_event or not.
+ * The state of the perf_event cannot be locked by the PMU layer, hence
+ * we check the individual counter status (which can be locked by
+ * cci_pm->hw_events->pmu_lock).
+ *
+ * @mask should be initialised to empty by the caller.
+ */
+static void __maybe_unused
+pmu_save_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
+{
+	int i;
+
+	for (i = 0; i < cci_pmu->num_cntrs; i++) {
+		if (pmu_counter_is_enabled(cci_pmu, i)) {
+			set_bit(i, mask);
+			pmu_disable_counter(cci_pmu, i);
+		}
+	}
+}
+
+/*
+ * Restore the status of the counters. Reversal of the pmu_save_counters().
+ * For each counter set in the mask, enable the counter back.
+ */
+static void __maybe_unused
+pmu_restore_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
+{
+	int i;
+
+	for_each_set_bit(i, mask, cci_pmu->num_cntrs)
+		pmu_enable_counter(cci_pmu, i);
+}
+
+/*
  * Returns the number of programmable counters actually implemented
  * by the cci
  */
-- 
1.7.9.5
