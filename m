From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 20 Oct 2015 14:05:25 +0100
Subject: [PATCHv2 3/4] arm-cci: Add routines to enable/disable all counters
In-Reply-To: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445346326-30820-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds helper routines to manipulate the counter controls for
all the counters on the CCI PMU.

pmu_disable_counters_ctrl: Iterates over the counters,
checking the status of each counter and disabling any enabled
counters. For each such changed counter, the mask is updated so that
one can restore the state later using pmu_enable_counters_ctrl.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: arm at kernel.org
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 1a75010..7f4a266 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -663,6 +663,36 @@ static u32 pmu_get_event(struct cci_pmu *cci_pmu, int idx)
 }
 
 /*
+ * Restore the status of the counters.
+ * For each counter set in the mask, enable the counter back.
+ */
+static void pmu_restore_counters_ctrl(struct cci_pmu *cci_pmu, unsigned long *mask)
+{
+	int i;
+
+	for_each_set_bit(i, mask, cci_pmu->num_cntrs)
+		pmu_enable_counter(cci_pmu, i);
+}
+
+/*
+ * For all counters on the CCI-PMU, disable any 'enabled' counters,
+ * saving the changed counters in the mask, so that we can restore
+ * it later using pmu_restore_counters_ctrl.
+ */
+static void pmu_disable_counters_ctrl(struct cci_pmu *cci_pmu, unsigned long *mask)
+{
+	int i;
+
+	for (i = 0; i < cci_pmu->num_cntrs; i++) {
+		clear_bit(i, mask);
+		if (pmu_get_counter_ctrl(cci_pmu, i)) {
+			set_bit(i, mask);
+			pmu_disable_counter(cci_pmu, i);
+		}
+	}
+}
+
+/*
  * Returns the number of programmable counters actually implemented
  * by the cci
  */
-- 
1.7.9.5
