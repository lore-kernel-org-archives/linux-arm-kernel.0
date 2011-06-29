From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Jun 2011 19:03:08 +0100
Subject: [PATCH] ARM: perf: do not start the PMU when no events are present
Message-ID: <1309370588-30537-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

armpmu_enable can be called in situations where no events are present
(for example, from the event rotation tick after a profiled task has
exited). In this case, we currently start the PMU anyway which may
leave it active inevitably without any events being monitored.

This patch adds a simple check to the enabling code so that we avoid
starting the PMU when no events are present.

Reported-by: Ashwin Chaugle <ashwinc@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index d53c0ab..2b5b142 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -583,7 +583,7 @@ static int armpmu_event_init(struct perf_event *event)
 static void armpmu_enable(struct pmu *pmu)
 {
 	/* Enable all of the perf events on hardware. */
-	int idx;
+	int idx, enabled = 0;
 	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
 
 	if (!armpmu)
@@ -596,9 +596,11 @@ static void armpmu_enable(struct pmu *pmu)
 			continue;
 
 		armpmu->enable(&event->hw, idx);
+		enabled = 1;
 	}
 
-	armpmu->start();
+	if (enabled)
+		armpmu->start();
 }
 
 static void armpmu_disable(struct pmu *pmu)
-- 
1.7.0.4
