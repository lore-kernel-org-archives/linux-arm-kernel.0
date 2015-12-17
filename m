From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 17 Dec 2015 17:49:14 +0000
Subject: [PATCH v4 07/12] arm-cci: Get the status of a counter
In-Reply-To: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1450374559-23315-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper routines to get the counter status and the event
programmed on it.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index e2824a7..7f77f65 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -662,11 +662,23 @@ static void pmu_enable_counter(struct cci_pmu *cci_pmu, int idx)
 	pmu_write_register(cci_pmu, 1, idx, CCI_PMU_CNTR_CTRL);
 }
 
+static bool __maybe_unused
+pmu_counter_is_enabled(struct cci_pmu *cci_pmu, int idx)
+{
+	return (pmu_read_register(cci_pmu, idx, CCI_PMU_CNTR_CTRL) & 0x1) != 0;
+}
+
 static void pmu_set_event(struct cci_pmu *cci_pmu, int idx, unsigned long event)
 {
 	pmu_write_register(cci_pmu, event, idx, CCI_PMU_EVT_SEL);
 }
 
+static u32 __maybe_unused
+pmu_get_event(struct cci_pmu *cci_pmu, int idx)
+{
+	return pmu_read_register(cci_pmu, idx, CCI_PMU_EVT_SEL);
+}
+
 /*
  * Returns the number of programmable counters actually implemented
  * by the cci
-- 
1.7.9.5
