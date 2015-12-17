From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 17 Dec 2015 17:49:15 +0000
Subject: [PATCH v4 08/12] arm-cci: Add routines to save/restore all counters
In-Reply-To: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1450374559-23315-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds helper routines to disable the counter controls for
all the counters on the CCI PMU and restore it back, by
preserving the original state in caller provided mask.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7f77f65..7207def 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -679,6 +679,45 @@ pmu_get_event(struct cci_pmu *cci_pmu, int idx)
 	return pmu_read_register(cci_pmu, idx, CCI_PMU_EVT_SEL);
 }
 
+
+/*
+ * For all counters on the CCI-PMU, disable any 'enabled' counters,
+ * saving the changed counters in the mask, so that we can restore
+ * it later using pmu_restore_counters. The mask is private to the
+ * caller. We cannot rely on the used_mask maintained by the CCI_PMU
+ * as it only tells us if the counter is assigned to perf_event or not.
+ * The state of the perf_event cannot be locked by the PMU layer, hence
+ * we check the individual counter status (which can be locked by
+ * cci_pm->hw_events->pmu_lock).
+ *
+ * @mask should be initialised by the caller.
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
+ * Restore the status of the counters. Reversal of the pmu_disable_counters().
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
 /*
  * Returns the number of programmable counters actually implemented
  * by the cci
-- 
1.7.9.5
