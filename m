From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:49:48 +0000
Subject: [PATCH 06/13] arm-cci: write_counter: Remove redundant check
In-Reply-To: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456224595-3282-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pmu_write_counter() is now only called from pmu_write_counters(),
which does so for each set index in the given mask, bounded by
cci_pmu->num_cntrs. So, there is no need for an extra check to
make sure the given counter is valid inside pmu_write_counter.
This patch gets rid of that.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 629c9e0..420c30c 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -814,16 +814,9 @@ static u32 pmu_read_counter(struct perf_event *event)
 	return value;
 }
 
-static void pmu_write_counter(struct perf_event *event, u32 value)
+static void pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
 {
-	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
-	struct hw_perf_event *hw_counter = &event->hw;
-	int idx = hw_counter->idx;
-
-	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx)))
-		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
-	else
-		pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
+	pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
 }
 
 static void pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
@@ -836,7 +829,7 @@ static void pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
 
 		if (WARN_ON(!event))
 			continue;
-		pmu_write_counter(event, local64_read(&event->hw.prev_count));
+		pmu_write_counter(cci_pmu, local64_read(&event->hw.prev_count), i);
 	}
 }
 
-- 
1.7.9.5
