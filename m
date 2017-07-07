From: panand@redhat.com (Pratyush Anand)
Date: Fri,  7 Jul 2017 17:33:57 +0530
Subject: [PATCH V2 1/4] hw_breakpoint: Add step_needed event attribute
In-Reply-To: <cover.1499416107.git.panand@redhat.com>
References: <cover.1499416107.git.panand@redhat.com>
Message-ID: <9d4f76f3a0bffe93a6d5146c9b53ee7b985f22da.1499416107.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Architecture like ARM64 currently allows to use default hw breakpoint
single step handler only to perf. However, some other users like few
systemtap tests or kernel test in
samples/hw_breakpoint/data_breakpoint.c can also work with default step
handler implementation. At the same time, some other like GDB/ptrace may
implement their own step handler.

Therefore, this patch introduces a new perf_event_attr bit field, so
that arch specific code(specially on arm64) can make a decision to
enable single stepping.

Any architecture which is not using this field will not have any
side effect.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 include/linux/hw_breakpoint.h         | 6 ++++++
 include/uapi/linux/perf_event.h       | 3 ++-
 kernel/events/core.c                  | 2 ++
 tools/include/uapi/linux/perf_event.h | 3 ++-
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index 0464c85e63fd..6173ae048cbc 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -38,6 +38,12 @@ static inline int hw_breakpoint_type(struct perf_event *bp)
 	return bp->attr.bp_type;
 }
 
+static inline bool
+hw_breakpoint_needs_single_step(struct perf_event *bp)
+{
+	return bp->attr.step_needed;
+}
+
 static inline unsigned long hw_breakpoint_len(struct perf_event *bp)
 {
 	return bp->attr.bp_len;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b1c0b187acfe..00935808de0d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -345,7 +345,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				step_needed    :  1, /* Use arch step handler */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6c4e523dc1e2..220e26941475 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9444,9 +9444,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	} else if (is_write_backward(event)){
 		event->overflow_handler = perf_event_output_backward;
 		event->overflow_handler_context = NULL;
+		event->attr.step_needed = 1;
 	} else {
 		event->overflow_handler = perf_event_output_forward;
 		event->overflow_handler_context = NULL;
+		event->attr.step_needed = 1;
 	}
 
 	perf_event__state_init(event);
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b1c0b187acfe..00935808de0d 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -345,7 +345,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				step_needed    :  1, /* Use arch step handler */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
-- 
2.9.3
