From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Apr 2011 13:00:07 +0100
Subject: [RFC PATCH 01/15] perf: provide PMU when initing events
Message-ID: <mailman.71.1313415780.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, an event's 'pmu' field is set after pmu::event_init() is
called. This means that pmu::event_init() must figure out which struct
pmu the event was initialised from. This makes it difficult to
consolidate common event initialisation code for similar PMUs, and
very difficult to implement drivers for PMUs which can have multiple
instances (e.g. a USB controller PMU, a GPU PMU, etc).

This patch sets the 'pmu' field before initialising the event, allowing
event init code to identify the struct pmu instance easily. In the
event of failure to initialise an event, the event is destroyed via
kfree() without calling perf_event::destroy(), so this shouldn't
result in bad behaviour even if the destroy field was set before
failure to initialise was noted.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 kernel/events/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b8785e2..68c8017 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5715,6 +5715,7 @@ struct pmu *perf_init_event(struct perf_event *event)
 	pmu = idr_find(&pmu_idr, event->attr.type);
 	rcu_read_unlock();
 	if (pmu) {
+		event->pmu = pmu;
 		ret = pmu->event_init(event);
 		if (ret)
 			pmu = ERR_PTR(ret);
@@ -5722,6 +5723,7 @@ struct pmu *perf_init_event(struct perf_event *event)
 	}
 
 	list_for_each_entry_rcu(pmu, &pmus, entry) {
+		event->pmu = pmu;
 		ret = pmu->event_init(event);
 		if (!ret)
 			goto unlock;
@@ -5848,8 +5850,6 @@ done:
 		return ERR_PTR(err);
 	}
 
-	event->pmu = pmu;
-
 	if (!event->parent) {
 		if (event->attach_state & PERF_ATTACH_TASK)
 			jump_label_inc(&perf_sched_events);
-- 
1.7.0.4
