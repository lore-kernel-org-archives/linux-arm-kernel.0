From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Apr 2011 16:22:21 +0100
Subject: [RFC PATCH 03/15] ARM: perf: clean up event group validation
Message-ID: <mailman.73.1313415781.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, event group validation compares each event's 'pmu' pointer
against the static 'pmu' pointer. This limits the code to supporting
only 1 PMU.

This patch changes the behaviour to consider an event's group leader's
'pmu' pointer as canonical for validation. This should ease later
generalisation of the code to support multiple PMUs at once.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 753648c..dfde928 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -348,8 +348,9 @@ validate_event(struct cpu_hw_events *cpuc,
 	       struct perf_event *event)
 {
 	struct hw_perf_event fake_event = event->hw;
+	struct pmu *leader_pmu = event->group_leader->pmu;
 
-	if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
+	if (event->pmu != leader_pmu || event->state <= PERF_EVENT_STATE_OFF)
 		return 1;
 
 	return armpmu->get_event_idx(cpuc, &fake_event) >= 0;
-- 
1.7.0.4
