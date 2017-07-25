From: nleeder@codeaurora.org (Neil Leeder)
Date: Tue, 25 Jul 2017 16:22:14 -0400
Subject: [PATCH v2] perf: qcom_l2: fix column exclusion check
Message-ID: <1501014134-15682-1-git-send-email-nleeder@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The check for column exclusion did not verify that the event being
checked was an L2 event, and not a software event.
Software events should not be checked for column exclusion.
This resulted in a group with both software and L2 events sometimes
incorrectly rejecting the L2 event for column exclusion and
not counting it.

Add a check for PMU type before applying column exclusion logic.

Fixes: 21bdbb7102ed ("perf: add qcom l2 cache perf events driver")
Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---

Same code as v1, just added the tags to the commit text.

 drivers/perf/qcom_l2_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index c259848..b242cce 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -546,6 +546,7 @@ static int l2_cache_event_init(struct perf_event *event)
 	}
 
 	if ((event != event->group_leader) &&
+	    !is_software_event(event->group_leader) &&
 	    (L2_EVT_GROUP(event->group_leader->attr.config) ==
 	     L2_EVT_GROUP(event->attr.config))) {
 		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
@@ -558,6 +559,7 @@ static int l2_cache_event_init(struct perf_event *event)
 	list_for_each_entry(sibling, &event->group_leader->sibling_list,
 			    group_entry) {
 		if ((sibling != event) &&
+		    !is_software_event(sibling) &&
 		    (L2_EVT_GROUP(sibling->attr.config) ==
 		     L2_EVT_GROUP(event->attr.config))) {
 			dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
