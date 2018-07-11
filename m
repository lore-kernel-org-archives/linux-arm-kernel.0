From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 11 Jul 2018 15:16:38 +0100
Subject: [PATCH 5/6] coresight: perf: Remove reset_buffer call back for sinks
In-Reply-To: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
References: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531318599-8840-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now we issue an update_buffer() and reset_buffer() call backs
in succession when we stop tracing an event. The update_buffer is
supposed to check the status of the buffer and make sure the ring buffer
is updated with the trace data. And we store information about the
size of the data collected only to be consumed by the reset_buffer
callback which always follows the update_buffer. This was originally
designed for handling future IPs which could trigger a buffer overflow
interrupt. This patch gets rid of the reset_buffer callback altogether
and performs the actions in update_buffer, making it return the size
collected. We can always add the support for handling the overflow
interrupt case later.

This removes some not-so pretty hack (storing the new head in the
size field for snapshot mode) and cleans it up a little bit.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c    | 56 +++++------------------
 drivers/hwtracing/coresight/coresight-etm-perf.c |  9 +---
 drivers/hwtracing/coresight/coresight-tmc-etf.c  | 58 +++++-------------------
 include/linux/coresight.h                        |  5 +-
 4 files changed, 26 insertions(+), 102 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 73878a6..a729a7b 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -315,37 +315,7 @@ static int etb_set_buffer(struct coresight_device *csdev,
 	return ret;
 }
 
-static unsigned long etb_reset_buffer(struct coresight_device *csdev,
-				      struct perf_output_handle *handle,
-				      void *sink_config)
-{
-	unsigned long size = 0;
-	struct cs_buffers *buf = sink_config;
-
-	if (buf) {
-		/*
-		 * In snapshot mode ->data_size holds the new address of the
-		 * ring buffer's head.  The size itself is the whole address
-		 * range since we want the latest information.
-		 */
-		if (buf->snapshot)
-			handle->head = local_xchg(&buf->data_size,
-						  buf->nr_pages << PAGE_SHIFT);
-
-		/*
-		 * Tell the tracer PMU how much we got in this run and if
-		 * something went wrong along the way.  Nobody else can use
-		 * this cs_buffers instance until we are done.  As such
-		 * resetting parameters here and squaring off with the ring
-		 * buffer API in the tracer PMU is fine.
-		 */
-		size = local_xchg(&buf->data_size, 0);
-	}
-
-	return size;
-}
-
-static void etb_update_buffer(struct coresight_device *csdev,
+static unsigned long etb_update_buffer(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
 			      void *sink_config)
 {
@@ -354,13 +324,13 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	u8 *buf_ptr;
 	const u32 *barrier;
 	u32 read_ptr, write_ptr, capacity;
-	u32 status, read_data, to_read;
-	unsigned long offset;
+	u32 status, read_data;
+	unsigned long offset, to_read;
 	struct cs_buffers *buf = sink_config;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	if (!buf)
-		return;
+		return 0;
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
@@ -465,18 +435,17 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	writel_relaxed(0x0, drvdata->base + ETB_RAM_WRITE_POINTER);
 
 	/*
-	 * In snapshot mode all we have to do is communicate to
-	 * perf_aux_output_end() the address of the current head.  In full
-	 * trace mode the same function expects a size to move rb->aux_head
-	 * forward.
+	 * In snapshot mode we have to update the handle->head to point
+	 * to the new location.
 	 */
-	if (buf->snapshot)
-		local_set(&buf->data_size, (cur * PAGE_SIZE) + offset);
-	else
-		local_add(to_read, &buf->data_size);
-
+	if (buf->snapshot) {
+		handle->head = (cur * PAGE_SIZE) + offset;
+		to_read = buf->nr_pages << PAGE_SHIFT;
+	}
 	etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
+
+	return to_read;
 }
 
 static const struct coresight_ops_sink etb_sink_ops = {
@@ -485,7 +454,6 @@ static const struct coresight_ops_sink etb_sink_ops = {
 	.alloc_buffer	= etb_alloc_buffer,
 	.free_buffer	= etb_free_buffer,
 	.set_buffer	= etb_set_buffer,
-	.reset_buffer	= etb_reset_buffer,
 	.update_buffer	= etb_update_buffer,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6776956..c305228 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -331,15 +331,8 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		if (!sink_ops(sink)->update_buffer)
 			return;
 
-		sink_ops(sink)->update_buffer(sink, handle,
+		size = sink_ops(sink)->update_buffer(sink, handle,
 					      event_data->snk_config);
-
-		if (!sink_ops(sink)->reset_buffer)
-			return;
-
-		size = sink_ops(sink)->reset_buffer(sink, handle,
-						    event_data->snk_config);
-
 		perf_aux_output_end(handle, size);
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 434003a..31a98f9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -349,36 +349,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
 	return ret;
 }
 
-static unsigned long tmc_reset_etf_buffer(struct coresight_device *csdev,
-					  struct perf_output_handle *handle,
-					  void *sink_config)
-{
-	long size = 0;
-	struct cs_buffers *buf = sink_config;
-
-	if (buf) {
-		/*
-		 * In snapshot mode ->data_size holds the new address of the
-		 * ring buffer's head.  The size itself is the whole address
-		 * range since we want the latest information.
-		 */
-		if (buf->snapshot)
-			handle->head = local_xchg(&buf->data_size,
-						  buf->nr_pages << PAGE_SHIFT);
-		/*
-		 * Tell the tracer PMU how much we got in this run and if
-		 * something went wrong along the way.  Nobody else can use
-		 * this cs_buffers instance until we are done.  As such
-		 * resetting parameters here and squaring off with the ring
-		 * buffer API in the tracer PMU is fine.
-		 */
-		size = local_xchg(&buf->data_size, 0);
-	}
-
-	return size;
-}
-
-static void tmc_update_etf_buffer(struct coresight_device *csdev,
+static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 				  struct perf_output_handle *handle,
 				  void *sink_config)
 {
@@ -387,17 +358,17 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	const u32 *barrier;
 	u32 *buf_ptr;
 	u64 read_ptr, write_ptr;
-	u32 status, to_read;
-	unsigned long offset;
+	u32 status;
+	unsigned long offset, to_read;
 	struct cs_buffers *buf = sink_config;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	if (!buf)
-		return;
+		return 0;
 
 	/* This shouldn't happen */
 	if (WARN_ON_ONCE(drvdata->mode != CS_MODE_PERF))
-		return;
+		return 0;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -486,18 +457,14 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 		}
 	}
 
-	/*
-	 * In snapshot mode all we have to do is communicate to
-	 * perf_aux_output_end() the address of the current head.  In full
-	 * trace mode the same function expects a size to move rb->aux_head
-	 * forward.
-	 */
-	if (buf->snapshot)
-		local_set(&buf->data_size, (cur * PAGE_SIZE) + offset);
-	else
-		local_add(to_read, &buf->data_size);
-
+	/* In snapshot mode we have to update the head */
+	if (buf->snapshot) {
+		handle->head = (cur * PAGE_SIZE) + offset;
+		to_read = buf->nr_pages << PAGE_SHIFT;
+	}
 	CS_LOCK(drvdata->base);
+
+	return to_read;
 }
 
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
@@ -506,7 +473,6 @@ static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.alloc_buffer	= tmc_alloc_etf_buffer,
 	.free_buffer	= tmc_free_etf_buffer,
 	.set_buffer	= tmc_set_etf_buffer,
-	.reset_buffer	= tmc_reset_etf_buffer,
 	.update_buffer	= tmc_update_etf_buffer,
 };
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d828a6e..47bb0ba 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -203,10 +203,7 @@ struct coresight_ops_sink {
 	int (*set_buffer)(struct coresight_device *csdev,
 			  struct perf_output_handle *handle,
 			  void *sink_config);
-	unsigned long (*reset_buffer)(struct coresight_device *csdev,
-				      struct perf_output_handle *handle,
-				      void *sink_config);
-	void (*update_buffer)(struct coresight_device *csdev,
+	unsigned long (*update_buffer)(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
 			      void *sink_config);
 };
-- 
2.7.4
