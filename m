From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jan 2017 16:03:46 +0000
Subject: [RFC PATCH v2 07/10] perf: Directly pass PERF_AUX_* flags to
 perf_aux_output_end
In-Reply-To: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
Message-ID: <1484323429-15231-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for adding additional flags to perf AUX records, allow
the flags for a session to be passed directly to perf_aux_output_end,
rather than extend the function to take a bool for each one.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/x86/events/intel/bts.c                      | 11 ++++++-----
 arch/x86/events/intel/pt.c                       | 11 +++++++----
 drivers/hwtracing/coresight/coresight-etm-perf.c |  5 +++--
 include/linux/perf_event.h                       |  4 ++--
 kernel/events/ring_buffer.c                      | 12 +++++-------
 5 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 982c9e31daca..2aa63190f01e 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -276,7 +276,7 @@ static void bts_event_start(struct perf_event *event, int flags)
 	return;
 
 fail_end_stop:
-	perf_aux_output_end(&bts->handle, 0, false);
+	perf_aux_output_end(&bts->handle, 0, 0);
 
 fail_stop:
 	event->hw.state = PERF_HES_STOPPED;
@@ -319,9 +319,9 @@ static void bts_event_stop(struct perf_event *event, int flags)
 				bts->handle.head =
 					local_xchg(&buf->data_size,
 						   buf->nr_pages << PAGE_SHIFT);
-
 			perf_aux_output_end(&bts->handle, local_xchg(&buf->data_size, 0),
-					    !!local_xchg(&buf->lost, 0));
+					    local_xchg(&buf->lost, 0) ?
+					    PERF_AUX_FLAG_TRUNCATED : 0);
 		}
 
 		cpuc->ds->bts_index = bts->ds_back.bts_buffer_base;
@@ -485,7 +485,8 @@ int intel_bts_interrupt(void)
 		return handled;
 
 	perf_aux_output_end(&bts->handle, local_xchg(&buf->data_size, 0),
-			    !!local_xchg(&buf->lost, 0));
+			    local_xchg(&buf->lost, 0) ?
+			    PERF_AUX_FLAG_OVERWRITE : 0);
 
 	buf = perf_aux_output_begin(&bts->handle, event);
 	if (buf)
@@ -500,7 +501,7 @@ int intel_bts_interrupt(void)
 			 * cleared handle::event
 			 */
 			barrier();
-			perf_aux_output_end(&bts->handle, 0, false);
+			perf_aux_output_end(&bts->handle, 0, 0);
 		}
 	}
 
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 1c1b9fe705c8..e229f675114d 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1187,7 +1187,8 @@ void intel_pt_interrupt(void)
 	pt_update_head(pt);
 
 	perf_aux_output_end(&pt->handle, local_xchg(&buf->data_size, 0),
-			    local_xchg(&buf->lost, 0));
+			    local_xchg(&buf->lost, 0) ?
+			    PERF_AUX_FLAG_TRUNCATED : 0);
 
 	if (!event->hw.state) {
 		int ret;
@@ -1202,7 +1203,8 @@ void intel_pt_interrupt(void)
 		/* snapshot counters don't use PMI, so it's safe */
 		ret = pt_buffer_reset_markers(buf, &pt->handle);
 		if (ret) {
-			perf_aux_output_end(&pt->handle, 0, true);
+			perf_aux_output_end(&pt->handle, 0,
+					    PERF_AUX_FLAG_TRUNCATED);
 			return;
 		}
 
@@ -1274,7 +1276,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 	return;
 
 fail_end_stop:
-	perf_aux_output_end(&pt->handle, 0, true);
+	perf_aux_output_end(&pt->handle, 0, PERF_AUX_FLAG_TRUNCATED);
 fail_stop:
 	hwc->state = PERF_HES_STOPPED;
 }
@@ -1316,7 +1318,8 @@ static void pt_event_stop(struct perf_event *event, int mode)
 				local_xchg(&buf->data_size,
 					   buf->nr_pages << PAGE_SHIFT);
 		perf_aux_output_end(&pt->handle, local_xchg(&buf->data_size, 0),
-				    local_xchg(&buf->lost, 0));
+				    local_xchg(&buf->lost, 0) ?
+				    PERF_AUX_FLAG_TRUNCATED : 0);
 	}
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 17741969026e..4a425b2f62ee 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -301,7 +301,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	return;
 
 fail_end_stop:
-	perf_aux_output_end(handle, 0, true);
+	perf_aux_output_end(handle, 0, PERF_AUX_FLAG_TRUNCATED);
 fail:
 	event->hw.state = PERF_HES_STOPPED;
 	goto out;
@@ -350,7 +350,8 @@ static void etm_event_stop(struct perf_event *event, int mode)
 						    event_data->snk_config,
 						    &lost);
 
-		perf_aux_output_end(handle, size, lost);
+		perf_aux_output_end(handle, size,
+				    lost ? PERF_AUX_FLAG_TRUNCATED : 0);
 	}
 
 	/* Disabling the path make its elements available to other sessions */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4741ecdb9817..473e052e6208 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -847,7 +847,7 @@ perf_cgroup_from_task(struct task_struct *task, struct perf_event_context *ctx)
 extern void *perf_aux_output_begin(struct perf_output_handle *handle,
 				   struct perf_event *event);
 extern void perf_aux_output_end(struct perf_output_handle *handle,
-				unsigned long size, bool truncated);
+				unsigned long size, u64 flags);
 extern int perf_aux_output_skip(struct perf_output_handle *handle,
 				unsigned long size);
 extern void *perf_get_aux(struct perf_output_handle *handle);
@@ -1265,7 +1265,7 @@ perf_aux_output_begin(struct perf_output_handle *handle,
 		      struct perf_event *event)				{ return NULL; }
 static inline void
 perf_aux_output_end(struct perf_output_handle *handle, unsigned long size,
-		    bool truncated)					{ }
+		    u64 flags)						{ }
 static inline int
 perf_aux_output_skip(struct perf_output_handle *handle,
 		     unsigned long size)				{ return -EINVAL; }
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 64158071690c..2c8af2e75953 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -410,15 +410,11 @@ EXPORT_SYMBOL_GPL(perf_aux_output_begin);
  * transaction must be stopped and therefore drop the AUX reference count.
  */
 void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size,
-			 bool truncated)
+			 u64 flags)
 {
 	struct ring_buffer *rb = handle->rb;
-	bool wakeup = truncated;
+	bool wakeup = !!flags;
 	unsigned long aux_head;
-	u64 flags = 0;
-
-	if (truncated)
-		flags |= PERF_AUX_FLAG_TRUNCATED;
 
 	/* in overwrite mode, driver provides aux_head via handle */
 	if (rb->aux_overwrite) {
@@ -427,6 +423,8 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size,
 		aux_head = handle->head;
 		local_set(&rb->aux_head, aux_head);
 	} else {
+		flags &= ~PERF_AUX_FLAG_OVERWRITE;
+
 		aux_head = local_read(&rb->aux_head);
 		local_add(size, &rb->aux_head);
 	}
@@ -447,7 +445,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size,
 	}
 
 	if (wakeup) {
-		if (truncated)
+		if (flags & PERF_AUX_FLAG_TRUNCATED)
 			handle->event->pending_disable = 1;
 		perf_output_wakeup(handle);
 	}
-- 
2.1.4
