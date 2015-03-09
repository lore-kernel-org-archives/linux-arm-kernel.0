From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  9 Mar 2015 12:46:32 +0000
Subject: [PATCH 3/3] arm-cci: Reject groups spanning multiple HW PMUs
In-Reply-To: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1425905192-10509-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Invalidate an event if the group has a hardware event from
a different PMU as we cannot schedule all of them in the same
context. The perf core code won't check the group consistency
until after pmu_event_init().

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 84fd660..68ef6f2 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -660,12 +660,21 @@ static void cci_pmu_del(struct perf_event *event, int flags)
 }
 
 static int
-validate_event(struct cci_pmu_hw_events *hw_events,
-	       struct perf_event *event)
+validate_event(struct pmu *cci_pmu,
+               struct cci_pmu_hw_events *hw_events,
+               struct perf_event *event)
 {
 	if (is_software_event(event))
 		return 1;
 
+	/*
+	 * Reject groups spanning multiple HW PMUs (e.g. CPU + CCI). The
+	 * core perf code won't check that the pmu->ctx == leader->ctx
+	 * until after pmu->event_init(event).
+	 */
+	if (event->pmu != cci_pmu)
+		return 0;
+
 	if (event->state < PERF_EVENT_STATE_OFF)
 		return 1;
 
@@ -687,15 +696,15 @@ validate_group(struct perf_event *event)
 		.used_mask = CPU_BITS_NONE,
 	};
 
-	if (!validate_event(&fake_pmu, leader))
+	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
 
 	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
-		if (!validate_event(&fake_pmu, sibling))
+		if (!validate_event(event->pmu, &fake_pmu, sibling))
 			return -EINVAL;
 	}
 
-	if (!validate_event(&fake_pmu, event))
+	if (!validate_event(event->pmu, &fake_pmu, event))
 		return -EINVAL;
 
 	return 0;
-- 
1.7.9.5
