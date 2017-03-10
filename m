From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 11:04:38 +0000
Subject: [PATCH 01/14] drivers/perf: arm_pmu: remove pointless PMU disabling
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489143891-11596-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently disable the PMU temporarily in armpmu_add(). We may have
required this historically, but the perf core always disables an event's
PMU when calling event::pmu::add(), so this is not necessary.

We don't do similarly in armpmu_del(), or elsewhere, so this is
unnecessary and inconsistent, and only serves to confuse the reader.

Remove the pointless disable, simplifying armpmu_add() in the process.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 8b0aaa9..2bbce3b 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -235,20 +235,15 @@ static void armpmu_start(struct perf_event *event, int flags)
 	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
-	int err = 0;
 
 	/* An event following a process won't be stopped earlier */
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
 		return -ENOENT;
 
-	perf_pmu_disable(event->pmu);
-
 	/* If we don't have a space for the counter then finish early. */
 	idx = armpmu->get_event_idx(hw_events, event);
-	if (idx < 0) {
-		err = idx;
-		goto out;
-	}
+	if (idx < 0)
+		return idx;
 
 	/*
 	 * If there is an event in the counter we are going to use then make
@@ -265,9 +260,7 @@ static void armpmu_start(struct perf_event *event, int flags)
 	/* Propagate our changes to the userspace mapping. */
 	perf_event_update_userpage(event);
 
-out:
-	perf_pmu_enable(event->pmu);
-	return err;
+	return 0;
 }
 
 static int
-- 
1.9.1
