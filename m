From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Nov 2011 15:47:45 +0000
Subject: [PATCH] ARM: perf: initialise used_mask for fake PMU during validation
Message-ID: <1321544865-16060-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When validating an event group, we call pmu->get_event_idx for each
group member in order to check that the group can be scheduled as a
unit on an empty PMU.

As a result of 3fc2c830 ("ARM: perf: remove event limit from
pmu_hw_events"), the used_mask member of struct cpu_hw_events must be
setup explicitly, something which we don't do for the fake cpu_hw_events
used for validation.

This patch sets up an empty used_mask for the fake validation
cpu_hw_events, preventing NULL deferences when trying to get the event
index.

Reported-by: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 24e2347..e508066 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -343,8 +343,14 @@ validate_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
 	struct pmu_hw_events fake_pmu;
+	DECLARE_BITMAP(fake_used_mask, ARMPMU_MAX_HWEVENTS);
 
-	memset(&fake_pmu, 0, sizeof(fake_pmu));
+	/*
+	 * Initialise the fake PMU. We only need to populate the
+	 * used_mask for the purposes of validation.
+	 */
+	memset(fake_used_mask, 0, sizeof(fake_used_mask));
+	fake_pmu.used_mask = fake_used_mask;
 
 	if (!validate_event(&fake_pmu, leader))
 		return -ENOSPC;
-- 
1.7.4.1
