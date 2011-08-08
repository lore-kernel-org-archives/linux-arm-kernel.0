From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:10 +0100
Subject: [PATCH 09/10] ARM: perf: allow armpmu to implement mode exclusion
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-10-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modern PMUs allow for mode exclusion, so we no longer wish to return
-EPERM if it is requested.

This patch provides a hook in the armpmu structure for implementing
mode exclusion. The hw_perf_event initialisation is slightly delayed so
that the backend code can update the structure if required.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |   44 +++++++++++++++++++++++------------------
 1 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 00e57f1..8a5e2ac 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -76,6 +76,8 @@ struct arm_pmu {
 	void		(*disable)(struct hw_perf_event *evt, int idx);
 	int		(*get_event_idx)(struct cpu_hw_events *cpuc,
 					 struct hw_perf_event *hwc);
+	int		(*set_event_filter)(struct hw_perf_event *evt,
+					    struct perf_event_attr *attr);
 	u32		(*read_counter)(int idx);
 	void		(*write_counter)(int idx, u32 val);
 	void		(*start)(void);
@@ -479,6 +481,13 @@ hw_perf_event_destroy(struct perf_event *event)
 }
 
 static int
+event_requires_mode_exclusion(struct perf_event_attr *attr)
+{
+	return attr->exclude_idle || attr->exclude_user ||
+	       attr->exclude_kernel || attr->exclude_hv;
+}
+
+static int
 __hw_perf_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -503,34 +512,31 @@ __hw_perf_event_init(struct perf_event *event)
 	}
 
 	/*
+	 * We don't assign an index until we actually place the event onto
+	 * hardware. Use -1 to signify that we haven't decided where to put it
+	 * yet. For SMP systems, each core has it's own PMU so we can't do any
+	 * clever allocation or constraints checking at this point.
+	 */
+	hwc->idx		= -1;
+	hwc->config_base	= 0;
+	hwc->config		= 0;
+	hwc->event_base		= 0;
+
+	/*
 	 * Check whether we need to exclude the counter from certain modes.
-	 * The ARM performance counters are on all of the time so if someone
-	 * has asked us for some excludes then we have to fail.
 	 */
-	if (event->attr.exclude_kernel || event->attr.exclude_user ||
-	    event->attr.exclude_hv || event->attr.exclude_idle) {
+	if ((!armpmu->set_event_filter ||
+	     armpmu->set_event_filter(hwc, &event->attr)) &&
+	     event_requires_mode_exclusion(&event->attr)) {
 		pr_debug("ARM performance counters do not support "
 			 "mode exclusion\n");
 		return -EPERM;
 	}
 
 	/*
-	 * We don't assign an index until we actually place the event onto
-	 * hardware. Use -1 to signify that we haven't decided where to put it
-	 * yet. For SMP systems, each core has it's own PMU so we can't do any
-	 * clever allocation or constraints checking at this point.
-	 */
-	hwc->idx = -1;
-
-	/*
-	 * Store the event encoding into the config_base field. config and
-	 * event_base are unused as the only 2 things we need to know are
-	 * the event mapping and the counter to use. The counter to use is
-	 * also the indx and the config_base is the event type.
+	 * Store the event encoding into the config_base field.
 	 */
-	hwc->config_base	    = (unsigned long)mapping;
-	hwc->config		    = 0;
-	hwc->event_base		    = 0;
+	hwc->config_base	    |= (unsigned long)mapping;
 
 	if (!hwc->sample_period) {
 		hwc->sample_period  = armpmu->max_period;
-- 
1.7.0.4
