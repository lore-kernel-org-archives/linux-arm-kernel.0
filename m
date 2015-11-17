From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 17 Nov 2015 18:03:26 +0000
Subject: [PATCHv3 4/5] arm-cci: Add hooks for pmu_write_counter
In-Reply-To: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1447783407-18027-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for model specific methods to write to the PMU
event counter. This will be used by CCI500/550 PMUs.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 91a9d5d..88b612f 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -126,6 +126,7 @@ struct cci_pmu_model {
 	struct event_range event_ranges[CCI_IF_MAX];
 	int (*validate_hw_event)(struct cci_pmu *, unsigned long);
 	int (*get_event_idx)(struct cci_pmu *, struct cci_pmu_hw_events *, unsigned long);
+	void (*write_counter)(struct cci_pmu *, u32, int);
 };
 
 static struct cci_pmu_model cci_pmu_models[];
@@ -829,16 +830,25 @@ static u32 pmu_read_counter(struct perf_event *event)
 	return value;
 }
 
+static void __pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
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
+		return;
+	}
+	if (cci_pmu->model->write_counter)
+		cci_pmu->model->write_counter(cci_pmu, value, idx);
 	else
-		pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
+		__pmu_write_counter(cci_pmu, value, idx);
 }
 
 static u64 pmu_event_update(struct perf_event *event)
-- 
1.7.9.5
