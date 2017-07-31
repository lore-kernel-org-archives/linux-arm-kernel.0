From: panand@redhat.com (Pratyush Anand)
Date: Mon, 31 Jul 2017 16:10:29 +0530
Subject: [PATCH v3 1/5] hw_breakpoint: Add step_needed event attribute
In-Reply-To: <cover.1501496603.git.panand@redhat.com>
References: <cover.1501496603.git.panand@redhat.com>
Message-ID: <1d7ca935857f93bd09c82a2ff57a53e373211b7e.1501496603.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Architecture like ARM64 currently allows to use default hw breakpoint
single step handler only to perf. However, some other users like few
systemtap tests or kernel test in
samples/hw_breakpoint/data_breakpoint.c can also work with default step
handler implementation.

Therefore, this patch introduces a flag 'step_needed' in struct
hw_perf_event, so that arch specific code(specially on arm64) can make a
decision to enable single stepping.

Any architecture which is not using this field will not have any
side effect.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 include/linux/hw_breakpoint.h | 6 ++++++
 include/linux/perf_event.h    | 6 ++++++
 kernel/events/core.c          | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index 0464c85e63fd..b9ac9629bf74 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -38,6 +38,12 @@ static inline int hw_breakpoint_type(struct perf_event *bp)
 	return bp->attr.bp_type;
 }
 
+static inline bool
+hw_breakpoint_needs_single_step(struct perf_event *bp)
+{
+	return bp->hw.step_needed;
+}
+
 static inline unsigned long hw_breakpoint_len(struct perf_event *bp)
 {
 	return bp->attr.bp_len;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 24a635887f28..7da951f94b47 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -233,6 +233,12 @@ struct hw_perf_event {
 	 */
 	u64				freq_time_stamp;
 	u64				freq_count_stamp;
+	/*
+	 * A HW breakpoint user can either have it's own step handling
+	 * mechanism or it can use default step handling meachanism defined
+	 * by arch code. Set step_needed to use default mechanism.
+	 */
+	int				step_needed;
 #endif
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6c4e523dc1e2..66ce5574e778 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9444,9 +9444,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	} else if (is_write_backward(event)){
 		event->overflow_handler = perf_event_output_backward;
 		event->overflow_handler_context = NULL;
+		event->hw.step_needed = 1;
 	} else {
 		event->overflow_handler = perf_event_output_forward;
 		event->overflow_handler_context = NULL;
+		event->hw.step_needed = 1;
 	}
 
 	perf_event__state_init(event);
-- 
2.9.4
