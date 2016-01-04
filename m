From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  4 Jan 2016 11:54:47 +0000
Subject: [PATCH v5 08/11] arm-cci: Provide hook for writing to PMU counters
In-Reply-To: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1451908490-2615-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a hook for writing to CCI PMU counters. This callback
can be used for CCI models which requires some extra work
to program the PMU counter values. To accommodate group writes
and single counter writes, the call back accepts a bitmask
of the counter indices which need to be programmed with the
given value.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 2f1fcf0..47c9581 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -134,6 +134,7 @@ struct cci_pmu_model {
 	struct event_range event_ranges[CCI_IF_MAX];
 	int (*validate_hw_event)(struct cci_pmu *, unsigned long);
 	int (*get_event_idx)(struct cci_pmu *, struct cci_pmu_hw_events *, unsigned long);
+	void (*write_counters)(struct cci_pmu *, unsigned long *, u32 val);
 };
 
 static struct cci_pmu_model cci_pmu_models[];
@@ -846,7 +847,15 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
 		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
 		return;
 	}
-	__pmu_write_counter(cci_pmu, value, idx);
+
+	if (cci_pmu->model->write_counters) {
+		unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];
+
+		memset(mask, 0, BITS_TO_LONGS(cci_pmu->num_cntrs) * sizeof(unsigned long));
+		set_bit(idx, mask);
+		cci_pmu->model->write_counters(cci_pmu, mask, value);
+	} else
+		__pmu_write_counter(cci_pmu, value, idx);
 }
 
 /* Write a value to a given set of counters */
@@ -861,7 +870,10 @@ static void __pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask, u
 static void __maybe_unused
 pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask, u32 value)
 {
-	__pmu_write_counters(cci_pmu, mask, value);
+	if (cci_pmu->model->write_counters)
+		cci_pmu->model->write_counters(cci_pmu, mask, value);
+	else
+		__pmu_write_counters(cci_pmu, mask, value);
 }
 
 static u64 pmu_event_update(struct perf_event *event)
-- 
1.7.9.5
