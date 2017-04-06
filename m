From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Apr 2017 17:18:11 +0100
Subject: [PATCH v2 1/6] perf/core: Keep AUX flags in the output handle
In-Reply-To: <1491495496-1524-1-git-send-email-will.deacon@arm.com>
References: <1491495496-1524-1-git-send-email-will.deacon@arm.com>
Message-ID: <1491495496-1524-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for adding more flags to perf AUX records, introduce a
separate API for setting the flags for a session, rather than appending
more bool arguments to perf_aux_output_end. This allows to set each
flag at the time a corresponding condition is detected, instead of
tracking it in each driver's private state.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: vince at deater.net
Link: http://lkml.kernel.org/r/20170220133352.17995-3-alexander.shishkin at linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/bts.c                      | 16 +++++------
 arch/x86/events/intel/pt.c                       | 17 ++++++------
 arch/x86/events/intel/pt.h                       |  1 -
 drivers/hwtracing/coresight/coresight-etb10.c    |  9 +++----
 drivers/hwtracing/coresight/coresight-etm-perf.c |  9 +++----
 drivers/hwtracing/coresight/coresight-priv.h     |  2 --
 drivers/hwtracing/coresight/coresight-tmc-etf.c  |  7 +++--
 include/linux/coresight.h                        |  2 +-
 include/linux/perf_event.h                       |  8 +++---
 kernel/events/ring_buffer.c                      | 34 ++++++++++++++++--------
 10 files changed, 56 insertions(+), 49 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 982c9e31daca..8ae8c5ce3a1f 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -63,7 +63,6 @@ struct bts_buffer {
 	unsigned int	cur_buf;
 	bool		snapshot;
 	local_t		data_size;
-	local_t		lost;
 	local_t		head;
 	unsigned long	end;
 	void		**data_pages;
@@ -199,7 +198,8 @@ static void bts_update(struct bts_ctx *bts)
 			return;
 
 		if (ds->bts_index >= ds->bts_absolute_maximum)
-			local_inc(&buf->lost);
+			perf_aux_output_flag(&bts->handle,
+			                     PERF_AUX_FLAG_TRUNCATED);
 
 		/*
 		 * old and head are always in the same physical buffer, so we
@@ -276,7 +276,7 @@ static void bts_event_start(struct perf_event *event, int flags)
 	return;
 
 fail_end_stop:
-	perf_aux_output_end(&bts->handle, 0, false);
+	perf_aux_output_end(&bts->handle, 0);
 
 fail_stop:
 	event->hw.state = PERF_HES_STOPPED;
@@ -319,9 +319,8 @@ static void bts_event_stop(struct perf_event *event, int flags)
 				bts->handle.head =
 					local_xchg(&buf->data_size,
 						   buf->nr_pages << PAGE_SHIFT);
-
-			perf_aux_output_end(&bts->handle, local_xchg(&buf->data_size, 0),
-					    !!local_xchg(&buf->lost, 0));
+			perf_aux_output_end(&bts->handle,
+			                    local_xchg(&buf->data_size, 0));
 		}
 
 		cpuc->ds->bts_index = bts->ds_back.bts_buffer_base;
@@ -484,8 +483,7 @@ int intel_bts_interrupt(void)
 	if (old_head == local_read(&buf->head))
 		return handled;
 
-	perf_aux_output_end(&bts->handle, local_xchg(&buf->data_size, 0),
-			    !!local_xchg(&buf->lost, 0));
+	perf_aux_output_end(&bts->handle, local_xchg(&buf->data_size, 0));
 
 	buf = perf_aux_output_begin(&bts->handle, event);
 	if (buf)
@@ -500,7 +498,7 @@ int intel_bts_interrupt(void)
 			 * cleared handle::event
 			 */
 			barrier();
-			perf_aux_output_end(&bts->handle, 0, false);
+			perf_aux_output_end(&bts->handle, 0);
 		}
 	}
 
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 5900471ee508..0218728be37a 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -753,7 +753,8 @@ static void pt_handle_status(struct pt *pt)
 		 */
 		if (!pt_cap_get(PT_CAP_topa_multiple_entries) ||
 		    buf->output_off == sizes(TOPA_ENTRY(buf->cur, buf->cur_idx)->size)) {
-			local_inc(&buf->lost);
+			perf_aux_output_flag(&pt->handle,
+			                     PERF_AUX_FLAG_TRUNCATED);
 			advance++;
 		}
 	}
@@ -846,8 +847,10 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 
 	/* can't stop in the middle of an output region */
 	if (buf->output_off + handle->size + 1 <
-	    sizes(TOPA_ENTRY(buf->cur, buf->cur_idx)->size))
+	    sizes(TOPA_ENTRY(buf->cur, buf->cur_idx)->size)) {
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 		return -EINVAL;
+	}
 
 
 	/* single entry ToPA is handled by marking all regions STOP=1 INT=1 */
@@ -1192,8 +1195,7 @@ void intel_pt_interrupt(void)
 
 	pt_update_head(pt);
 
-	perf_aux_output_end(&pt->handle, local_xchg(&buf->data_size, 0),
-			    local_xchg(&buf->lost, 0));
+	perf_aux_output_end(&pt->handle, local_xchg(&buf->data_size, 0));
 
 	if (!event->hw.state) {
 		int ret;
@@ -1208,7 +1210,7 @@ void intel_pt_interrupt(void)
 		/* snapshot counters don't use PMI, so it's safe */
 		ret = pt_buffer_reset_markers(buf, &pt->handle);
 		if (ret) {
-			perf_aux_output_end(&pt->handle, 0, true);
+			perf_aux_output_end(&pt->handle, 0);
 			return;
 		}
 
@@ -1280,7 +1282,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 	return;
 
 fail_end_stop:
-	perf_aux_output_end(&pt->handle, 0, true);
+	perf_aux_output_end(&pt->handle, 0);
 fail_stop:
 	hwc->state = PERF_HES_STOPPED;
 }
@@ -1321,8 +1323,7 @@ static void pt_event_stop(struct perf_event *event, int mode)
 			pt->handle.head =
 				local_xchg(&buf->data_size,
 					   buf->nr_pages << PAGE_SHIFT);
-		perf_aux_output_end(&pt->handle, local_xchg(&buf->data_size, 0),
-				    local_xchg(&buf->lost, 0));
+		perf_aux_output_end(&pt->handle, local_xchg(&buf->data_size, 0));
 	}
 }
 
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 53473c21b554..b528e8f373e4 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -143,7 +143,6 @@ struct pt_buffer {
 	size_t			output_off;
 	unsigned long		nr_pages;
 	local_t			data_size;
-	local_t			lost;
 	local64_t		head;
 	bool			snapshot;
 	unsigned long		stop_pos, intr_pos;
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d7325c6534ad..979ea6ec7902 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -321,7 +321,7 @@ static int etb_set_buffer(struct coresight_device *csdev,
 
 static unsigned long etb_reset_buffer(struct coresight_device *csdev,
 				      struct perf_output_handle *handle,
-				      void *sink_config, bool *lost)
+				      void *sink_config)
 {
 	unsigned long size = 0;
 	struct cs_buffers *buf = sink_config;
@@ -343,7 +343,6 @@ static unsigned long etb_reset_buffer(struct coresight_device *csdev,
 		 * resetting parameters here and squaring off with the ring
 		 * buffer API in the tracer PMU is fine.
 		 */
-		*lost = !!local_xchg(&buf->lost, 0);
 		size = local_xchg(&buf->data_size, 0);
 	}
 
@@ -385,7 +384,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 			(unsigned long)write_ptr);
 
 		write_ptr &= ~(ETB_FRAME_SIZE_WORDS - 1);
-		local_inc(&buf->lost);
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 	}
 
 	/*
@@ -396,7 +395,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	 */
 	status = readl_relaxed(drvdata->base + ETB_STATUS_REG);
 	if (status & ETB_STATUS_RAM_FULL) {
-		local_inc(&buf->lost);
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 		to_read = capacity;
 		read_ptr = write_ptr;
 	} else {
@@ -429,7 +428,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 		if (read_ptr > (drvdata->buffer_depth - 1))
 			read_ptr -= drvdata->buffer_depth;
 		/* let the decoder know we've skipped ahead */
-		local_inc(&buf->lost);
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 	}
 
 	/* finally tell HW where we want to start reading from */
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 26cfac3e6de7..288a423c1b27 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -302,7 +302,8 @@ static void etm_event_start(struct perf_event *event, int flags)
 	return;
 
 fail_end_stop:
-	perf_aux_output_end(handle, 0, true);
+	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+	perf_aux_output_end(handle, 0);
 fail:
 	event->hw.state = PERF_HES_STOPPED;
 	goto out;
@@ -310,7 +311,6 @@ static void etm_event_start(struct perf_event *event, int flags)
 
 static void etm_event_stop(struct perf_event *event, int mode)
 {
-	bool lost;
 	int cpu = smp_processor_id();
 	unsigned long size;
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
@@ -348,10 +348,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
 			return;
 
 		size = sink_ops(sink)->reset_buffer(sink, handle,
-						    event_data->snk_config,
-						    &lost);
+						    event_data->snk_config);
 
-		perf_aux_output_end(handle, size, lost);
+		perf_aux_output_end(handle, size);
 	}
 
 	/* Disabling the path make its elements available to other sessions */
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index ef9d8e93e3b2..5f662d82052c 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -76,7 +76,6 @@ enum cs_mode {
  * @nr_pages:	max number of pages granted to us
  * @offset:	offset within the current buffer
  * @data_size:	how much we collected in this run
- * @lost:	other than zero if we had a HW buffer wrap around
  * @snapshot:	is this run in snapshot mode
  * @data_pages:	a handle the ring buffer
  */
@@ -85,7 +84,6 @@ struct cs_buffers {
 	unsigned int		nr_pages;
 	unsigned long		offset;
 	local_t			data_size;
-	local_t			lost;
 	bool			snapshot;
 	void			**data_pages;
 };
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 1549436e2492..aec61a6d5c63 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -329,7 +329,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
 
 static unsigned long tmc_reset_etf_buffer(struct coresight_device *csdev,
 					  struct perf_output_handle *handle,
-					  void *sink_config, bool *lost)
+					  void *sink_config)
 {
 	long size = 0;
 	struct cs_buffers *buf = sink_config;
@@ -350,7 +350,6 @@ static unsigned long tmc_reset_etf_buffer(struct coresight_device *csdev,
 		 * resetting parameters here and squaring off with the ring
 		 * buffer API in the tracer PMU is fine.
 		 */
-		*lost = !!local_xchg(&buf->lost, 0);
 		size = local_xchg(&buf->data_size, 0);
 	}
 
@@ -389,7 +388,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	 */
 	status = readl_relaxed(drvdata->base + TMC_STS);
 	if (status & TMC_STS_FULL) {
-		local_inc(&buf->lost);
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 		to_read = drvdata->size;
 	} else {
 		to_read = CIRC_CNT(write_ptr, read_ptr, drvdata->size);
@@ -434,7 +433,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 			read_ptr -= drvdata->size;
 		/* Tell the HW */
 		writel_relaxed(read_ptr, drvdata->base + TMC_RRP);
-		local_inc(&buf->lost);
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 	}
 
 	cur = buf->cur;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 2a5982c37dfb..035c16c9a505 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -201,7 +201,7 @@ struct coresight_ops_sink {
 			  void *sink_config);
 	unsigned long (*reset_buffer)(struct coresight_device *csdev,
 				      struct perf_output_handle *handle,
-				      void *sink_config, bool *lost);
+				      void *sink_config);
 	void (*update_buffer)(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
 			      void *sink_config);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 000fdb211c7d..7f8cf0eba230 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -801,6 +801,7 @@ struct perf_output_handle {
 	struct ring_buffer		*rb;
 	unsigned long			wakeup;
 	unsigned long			size;
+	u64				aux_flags;
 	union {
 		void			*addr;
 		unsigned long		head;
@@ -849,10 +850,11 @@ perf_cgroup_from_task(struct task_struct *task, struct perf_event_context *ctx)
 extern void *perf_aux_output_begin(struct perf_output_handle *handle,
 				   struct perf_event *event);
 extern void perf_aux_output_end(struct perf_output_handle *handle,
-				unsigned long size, bool truncated);
+				unsigned long size);
 extern int perf_aux_output_skip(struct perf_output_handle *handle,
 				unsigned long size);
 extern void *perf_get_aux(struct perf_output_handle *handle);
+extern void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags);
 
 extern int perf_pmu_register(struct pmu *pmu, const char *name, int type);
 extern void perf_pmu_unregister(struct pmu *pmu);
@@ -1267,8 +1269,8 @@ static inline void *
 perf_aux_output_begin(struct perf_output_handle *handle,
 		      struct perf_event *event)				{ return NULL; }
 static inline void
-perf_aux_output_end(struct perf_output_handle *handle, unsigned long size,
-		    bool truncated)					{ }
+perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
+									{ }
 static inline int
 perf_aux_output_skip(struct perf_output_handle *handle,
 		     unsigned long size)				{ return -EINVAL; }
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 257fa460b846..9654e55c38d6 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -297,6 +297,19 @@ ring_buffer_init(struct ring_buffer *rb, long watermark, int flags)
 		rb->paused = 1;
 }
 
+void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags)
+{
+	/*
+	 * OVERWRITE is determined by perf_aux_output_end() and can't
+	 * be passed in directly.
+	 */
+	if (WARN_ON_ONCE(flags & PERF_AUX_FLAG_OVERWRITE))
+		return;
+
+	handle->aux_flags |= flags;
+}
+EXPORT_SYMBOL_GPL(perf_aux_output_flag);
+
 /*
  * This is called before hardware starts writing to the AUX area to
  * obtain an output handle and make sure there's room in the buffer.
@@ -360,6 +373,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 	handle->event = event;
 	handle->head = aux_head;
 	handle->size = 0;
+	handle->aux_flags = 0;
 
 	/*
 	 * In overwrite mode, AUX data stores do not depend on aux_tail,
@@ -408,34 +422,32 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
  * of the AUX buffer management code is that after pmu::stop(), the AUX
  * transaction must be stopped and therefore drop the AUX reference count.
  */
-void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size,
-			 bool truncated)
+void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 {
 	struct ring_buffer *rb = handle->rb;
-	bool wakeup = truncated;
+	bool wakeup = !!handle->aux_flags;
 	unsigned long aux_head;
-	u64 flags = 0;
-
-	if (truncated)
-		flags |= PERF_AUX_FLAG_TRUNCATED;
 
 	/* in overwrite mode, driver provides aux_head via handle */
 	if (rb->aux_overwrite) {
-		flags |= PERF_AUX_FLAG_OVERWRITE;
+		handle->aux_flags |= PERF_AUX_FLAG_OVERWRITE;
 
 		aux_head = handle->head;
 		local_set(&rb->aux_head, aux_head);
 	} else {
+		handle->aux_flags &= ~PERF_AUX_FLAG_OVERWRITE;
+
 		aux_head = local_read(&rb->aux_head);
 		local_add(size, &rb->aux_head);
 	}
 
-	if (size || flags) {
+	if (size || handle->aux_flags) {
 		/*
 		 * Only send RECORD_AUX if we have something useful to communicate
 		 */
 
-		perf_event_aux_event(handle->event, aux_head, size, flags);
+		perf_event_aux_event(handle->event, aux_head, size,
+		                     handle->aux_flags);
 	}
 
 	aux_head = rb->user_page->aux_head = local_read(&rb->aux_head);
@@ -446,7 +458,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size,
 	}
 
 	if (wakeup) {
-		if (truncated)
+		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
 			handle->event->pending_disable = 1;
 		perf_output_wakeup(handle);
 	}
-- 
2.1.4
