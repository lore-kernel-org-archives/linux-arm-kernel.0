From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 May 2015 17:12:23 +0100
Subject: [PATCH 1/7] perf: allow for PMU-specific event filtering
In-Reply-To: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
References: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431533549-27715-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In certain circumstances it may not be possible to schedule particular
events due to constraints other than a lack of hardware counters (e.g.
on big.LITTLE systems where CPUs support different events). The core
perf event code does not distinguish these cases and pessimistically
assumes that any failure to schedule an event means that it is not worth
attempting to schedule later events, even if some hardware counters are
still unused.

When an event a pmu cannot schedule exists in a flexible group list it
can unnecessarily prevent event groups following it in the list from
being scheduled (until it is rotated to the end of the list). This means
some events are scheduled for only a portion of the time they could be,
and for short running programs no events may be scheduled if the list is
initially sorted in an unfortunate order.

This patch adds a new (optional) filter_match function pointer to struct
pmu which a pmu driver can use to tell perf core when an event matches
pmu-specific scheduling requirements. This plugs into the existing
event_filter_match logic, and makes it possible to avoid the scheduling
problem described above. When no filter is provided by the PMU, the
existing behaviour is retained.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 include/linux/perf_event.h | 5 +++++
 kernel/events/core.c       | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61992cf..67c719c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -304,6 +304,11 @@ struct pmu {
 	 * Free pmu-private AUX data structures
 	 */
 	void (*free_aux)		(void *aux); /* optional */
+
+	/*
+	 * Filter events for PMU-specific reasons.
+	 */
+	int (*filter_match)		(struct perf_event *event); /* optional */
 };
 
 /**
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 81aa3a4..aaeb449 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1506,11 +1506,17 @@ static int __init perf_workqueue_init(void)
 
 core_initcall(perf_workqueue_init);
 
+static inline int pmu_filter_match(struct perf_event *event)
+{
+	struct pmu *pmu = event->pmu;
+	return pmu->filter_match ? pmu->filter_match(event) : 1;
+}
+
 static inline int
 event_filter_match(struct perf_event *event)
 {
 	return (event->cpu == -1 || event->cpu == smp_processor_id())
-	    && perf_cgroup_match(event);
+	    && perf_cgroup_match(event) && pmu_filter_match(event);
 }
 
 static void
-- 
1.9.1
