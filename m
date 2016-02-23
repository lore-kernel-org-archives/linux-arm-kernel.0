From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:49:45 +0000
Subject: [PATCH 03/13] arm-cci: Group writes to counter
In-Reply-To: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1456224595-3282-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper to group the writes to PMU counter, this will be
used to delay setting the event period to pmu::pmu_enable()

Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 5fb1c06..6a76ac7 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -771,6 +771,21 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
 		pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
 }
 
+static void __maybe_unused
+pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
+{
+	int i;
+	struct cci_pmu_hw_events *cci_hw = &cci_pmu->hw_events;
+
+	for_each_set_bit(i, mask, cci_pmu->num_cntrs) {
+		struct perf_event *event = cci_hw->events[i];
+
+		if (WARN_ON(!event))
+			continue;
+		pmu_write_counter(event, local64_read(&event->hw.prev_count));
+	}
+}
+
 static u64 pmu_event_update(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-- 
1.7.9.5
