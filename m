From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Aug 2010 16:22:33 +0100
Subject: [PATCH] ARM: perf: fix event validation
Message-ID: <1282922553-22500-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The validate_event function in the ARM perf events backend has the
following problems:

1.) Events that are disabled count towards the cost.
2.) Events associated with other PMUs [for example, software events or
    breakpoints] do not count towards the cost, but do fail validation,
    causing the group to fail.

This patch changes validate_event so that it ignores events in the
PERF_EVENT_STATE_OFF state or that are scheduled for other PMUs.

Cc: Jamie Iles <jamie.iles@picochip.com>
Reported-by: Pawe?? Moll <pawel.moll@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index e213925..ecbb028 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -319,8 +319,8 @@ validate_event(struct cpu_hw_events *cpuc,
 {
 	struct hw_perf_event fake_event = event->hw;
 
-	if (event->pmu && event->pmu != &pmu)
-		return 0;
+	if (event->pmu != &pmu || event->state <= PERF_EVENT_STATE_OFF)
+		return 1;
 
 	return armpmu->get_event_idx(cpuc, &fake_event) >= 0;
 }
-- 
1.6.3.3
