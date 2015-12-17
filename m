From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 17 Dec 2015 17:49:16 +0000
Subject: [PATCH v4 09/12] arm-cci: Provide hook for writing to PMU counters
In-Reply-To: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1450374559-23315-10-git-send-email-suzuki.poulose@arm.com>
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
index 7207def..43f2523 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -136,6 +136,7 @@ struct cci_pmu_model {
 	struct event_range event_ranges[CCI_IF_MAX];
 	int (*validate_hw_event)(struct cci_pmu *, unsigned long);
 	int (*get_event_idx)(struct cci_pmu *, struct cci_pmu_hw_events *, unsigned long);
+	void (*write_counters)(struct cci_pmu *, unsigned long *, u32 val);
 };
 
 static struct cci_pmu_model cci_pmu_models[];
@@ -855,7 +856,15 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
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
@@ -870,7 +879,10 @@ static void __pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask, u
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
