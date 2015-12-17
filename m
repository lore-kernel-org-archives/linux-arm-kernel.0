From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 17 Dec 2015 17:49:10 +0000
Subject: [PATCH v4 03/12] arm-cci: Group writes to counter
In-Reply-To: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1450374559-23315-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper to group the writes to PMU counter, this will be
used by the transaction hooks.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index ce0d3ef..f6b8717 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -785,6 +785,21 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
 	__pmu_write_counter(cci_pmu, value, idx);
 }
 
+/* Write a value to a given set of counters */
+static void __pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask, u32 value)
+{
+	int i;
+
+	for_each_set_bit(i, mask, cci_pmu->num_cntrs)
+		__pmu_write_counter(cci_pmu, value, i);
+}
+
+static void __maybe_unused
+pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask, u32 value)
+{
+	__pmu_write_counters(cci_pmu, mask, value);
+}
+
 static u64 pmu_event_update(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-- 
1.7.9.5
