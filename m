From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  1 May 2015 18:36:29 +0100
Subject: [PATCH 4/5] bus: arm-ccn: Do not group CCN events with other PMUs
In-Reply-To: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
References: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1430501790-26918-5-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Groups must not mix events from different PMUs (software events are
allowed). Unfortunately the core does not ensures that, so it is
necessary to validate the group at the PMU driver level.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 572360f..fb589d4 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -660,6 +660,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 	int valid, bit;
 	struct arm_ccn_component *source;
 	int i;
+	struct perf_event *sibling;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -762,6 +763,21 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 				node_xp, type, port);
 	}
 
+	/*
+	 * We must NOT create groups containing mixed PMUs, although software
+	 * events are acceptable (for example to create a CCN group
+	 * periodically read when a hrtimer aka cpu-clock leader triggers).
+	 */
+	if (event->group_leader->pmu != event->pmu &&
+			!is_software_event(event->group_leader))
+		return -EINVAL;
+
+	list_for_each_entry(sibling, &event->group_leader->sibling_list,
+			group_entry)
+		if (sibling->pmu != event->pmu &&
+				!is_software_event(sibling))
+			return -EINVAL;
+
 	/* Allocate the cycle counter */
 	if (type == CCN_TYPE_CYCLES) {
 		if (test_and_set_bit(CCN_IDX_PMU_CYCLE_COUNTER,
-- 
2.1.0
