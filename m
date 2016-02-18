From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 17 Feb 2016 17:52:00 -0700
Subject: [PATCH 18/21] coresight: etb10: implementing AUX API
In-Reply-To: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
References: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1455756723-8456-19-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding an ETB10 specific AUX area operations to be used
by the perf framework when events are initialised.

Part of this operation involves modeling the mmap'ed area
based on the specific ways a sink buffer gathers information.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 234 ++++++++++++++++++++++++++
 include/linux/coresight.h                     |  21 ++-
 2 files changed, 253 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 79099f95ba3f..a2eb6bdeaafa 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -28,6 +28,11 @@
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
+#include <linux/circ_buf.h>
+#include <linux/mm.h>
+#include <linux/perf_event.h>
+
+#include <asm/local.h>
 
 #include "coresight-priv.h"
 
@@ -65,6 +70,26 @@
 #define ETB_FRAME_SIZE_WORDS	4
 
 /**
+ * struct cs_buffer - keep track of a recording session' specifics
+ * @cur:	index of the current buffer
+ * @nr_pages:	max number of pages granted to us
+ * @offset:	offset within the current buffer
+ * @data_size:	how much we collected in this run
+ * @lost:	other than zero if we had a HW buffer wrap around
+ * @snapshot:	is this run in snapshot mode
+ * @data_pages:	a handle the ring buffer
+ */
+struct cs_buffers {
+	unsigned int		cur;
+	unsigned int		nr_pages;
+	unsigned long		offset;
+	local_t			data_size;
+	local_t			lost;
+	bool			snapshot;
+	void			**data_pages;
+};
+
+/**
  * struct etb_drvdata - specifics associated to an ETB component
  * @base:	memory mapped base address for this component.
  * @dev:	the device entity associated to this component.
@@ -265,9 +290,218 @@ static void etb_disable(struct coresight_device *csdev)
 	dev_info(drvdata->dev, "ETB disabled\n");
 }
 
+static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
+			      void **pages, int nr_pages, bool overwrite)
+{
+	int node;
+	struct cs_buffers *buf;
+
+	if (cpu == -1)
+		cpu = smp_processor_id();
+	node = cpu_to_node(cpu);
+
+	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
+	if (!buf)
+		return NULL;
+
+	buf->snapshot = overwrite;
+	buf->nr_pages = nr_pages;
+	buf->data_pages = pages;
+
+	return buf;
+}
+
+static void etb_free_buffer(void *config)
+{
+	struct cs_buffers *buf = config;
+
+	kfree(buf);
+}
+
+static int etb_set_buffer(struct coresight_device *csdev,
+			  struct perf_output_handle *handle,
+			  void *sink_config)
+{
+	int ret = 0;
+	unsigned long head;
+	struct cs_buffers *buf = sink_config;
+
+	/* wrap head around to the amount of space we have */
+	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
+
+	/* find the page to write to */
+	buf->cur = head / PAGE_SIZE;
+
+	/* and offset within that page */
+	buf->offset = head % PAGE_SIZE;
+
+	local_set(&buf->data_size, 0);
+
+	return ret;
+}
+
+static unsigned long etb_reset_buffer(struct coresight_device *csdev,
+				      struct perf_output_handle *handle,
+				      void *sink_config, bool *lost)
+{
+	unsigned long size = 0;
+	struct cs_buffers *buf = sink_config;
+
+	if (buf) {
+		/*
+		 * In snapshot mode ->data_size holds the new address of the
+		 * ring buffer's head.  The size itself is the whole address
+		 * range since we want the latest information.
+		 */
+		if (buf->snapshot)
+			handle->head = local_xchg(&buf->data_size,
+						  buf->nr_pages << PAGE_SHIFT);
+
+		/*
+		 * Tell the tracer PMU how much we got in this run and if
+		 * something went wrong along the way.  Nobody else can use
+		 * this cs_buffers instance until we are done.  As such
+		 * resetting parameters here and squaring off with the ring
+		 * buffer API in the tracer PMU is fine.
+		 */
+		*lost = !!local_xchg(&buf->lost, 0);
+		size = local_xchg(&buf->data_size, 0);
+	}
+
+	return size;
+}
+
+static void etb_update_buffer(struct coresight_device *csdev,
+			      struct perf_output_handle *handle,
+			      void *sink_config)
+{
+	int i, cur;
+	u8 *buf_ptr;
+	u32 read_ptr, write_ptr, capacity;
+	u32 status, read_data, to_read;
+	unsigned long offset;
+	struct cs_buffers *buf = sink_config;
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (!buf)
+		return;
+
+	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
+
+	CS_UNLOCK(drvdata->base);
+	etb_disable_hw(drvdata);
+
+	/* unit is in words, not bytes */
+	read_ptr = readl_relaxed(drvdata->base + ETB_RAM_READ_POINTER);
+	write_ptr = readl_relaxed(drvdata->base + ETB_RAM_WRITE_POINTER);
+
+	/*
+	 * Entries should be aligned to the frame size.  If they are not
+	 * go back to the last alignement point to give decoding tools a
+	 * chance to fix things.
+	 */
+	if (write_ptr % ETB_FRAME_SIZE_WORDS) {
+		dev_err(drvdata->dev,
+			"write_ptr: %lu not aligned to formatter frame size\n",
+			(unsigned long)write_ptr);
+
+		write_ptr &= ~(ETB_FRAME_SIZE_WORDS - 1);
+		local_inc(&buf->lost);
+	}
+
+	/*
+	 * Get a hold of the status register and see if a wrap around
+	 * has occurred.  If so adjust things accordingly.  Otherwise
+	 * start at the beginning and go until the write pointer has
+	 * been reached.
+	 */
+	status = readl_relaxed(drvdata->base + ETB_STATUS_REG);
+	if (status & ETB_STATUS_RAM_FULL) {
+		local_inc(&buf->lost);
+		to_read = capacity;
+		read_ptr = write_ptr;
+	} else {
+		to_read = CIRC_CNT(write_ptr, read_ptr, drvdata->buffer_depth);
+		to_read *= ETB_FRAME_SIZE_WORDS;
+	}
+
+	/*
+	 * Make sure we don't overwrite data that hasn't been consumed yet.
+	 * It is entirely possible that the HW buffer has more data than the
+	 * ring buffer can currently handle.  If so adjust the start address
+	 * to take only the last traces.
+	 *
+	 * In snapshot mode we are looking to get the latest traces only and as
+	 * such, we don't care about not overwriting data that hasn't been
+	 * processed by user space.
+	 */
+	if (!buf->snapshot && to_read > handle->size) {
+		u32 mask = ~(ETB_FRAME_SIZE_WORDS - 1);
+
+		/* The new read pointer must be frame size aligned */
+		to_read -= handle->size & mask;
+		/*
+		 * Move the RAM read pointer up, keeping in mind that
+		 * everything is in frame size units.
+		 */
+		read_ptr = (write_ptr + drvdata->buffer_depth) -
+					to_read / ETB_FRAME_SIZE_WORDS;
+		/* Wrap around if need be*/
+		read_ptr &= ~(drvdata->buffer_depth - 1);
+		/* let the decoder know we've skipped ahead */
+		local_inc(&buf->lost);
+	}
+
+	/* finally tell HW where we want to start reading from */
+	writel_relaxed(read_ptr, drvdata->base + ETB_RAM_READ_POINTER);
+
+	cur = buf->cur;
+	offset = buf->offset;
+	for (i = 0; i < to_read; i += 4) {
+		buf_ptr = buf->data_pages[cur] + offset;
+		read_data = readl_relaxed(drvdata->base +
+					  ETB_RAM_READ_DATA_REG);
+		*buf_ptr++ = read_data >> 0;
+		*buf_ptr++ = read_data >> 8;
+		*buf_ptr++ = read_data >> 16;
+		*buf_ptr++ = read_data >> 24;
+
+		offset += 4;
+		if (offset >= PAGE_SIZE) {
+			offset = 0;
+			cur++;
+			/* wrap around at the end of the buffer */
+			cur &= buf->nr_pages - 1;
+		}
+	}
+
+	/* reset ETB buffer for next run */
+	writel_relaxed(0x0, drvdata->base + ETB_RAM_READ_POINTER);
+	writel_relaxed(0x0, drvdata->base + ETB_RAM_WRITE_POINTER);
+
+	/*
+	 * In snapshot mode all we have to do is communicate to
+	 * perf_aux_output_end() the address of the current head.  In full
+	 * trace mode the same function expects a size to move rb->aux_head
+	 * forward.
+	 */
+	if (buf->snapshot)
+		local_set(&buf->data_size, (cur * PAGE_SIZE) + offset);
+	else
+		local_add(to_read, &buf->data_size);
+
+	etb_enable_hw(drvdata);
+	CS_LOCK(drvdata->base);
+}
+
 static const struct coresight_ops_sink etb_sink_ops = {
 	.enable		= etb_enable,
 	.disable	= etb_disable,
+	.alloc_buffer	= etb_alloc_buffer,
+	.free_buffer	= etb_free_buffer,
+	.set_buffer	= etb_set_buffer,
+	.reset_buffer	= etb_reset_buffer,
+	.update_buffer	= etb_update_buffer,
 };
 
 static const struct coresight_ops etb_cs_ops = {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 9fa92dcdd2ea..385d62e64abb 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -182,12 +182,29 @@ struct coresight_device {
 /**
  * struct coresight_ops_sink - basic operations for a sink
  * Operations available for sinks
- * @enable:	enables the sink.
- * @disable:	disables the sink.
+ * @enable:		enables the sink.
+ * @disable:		disables the sink.
+ * @alloc_buffer:	initialises perf's ring buffer for trace collection.
+ * @free_buffer:	release memory allocated in @get_config.
+ * @set_buffer:		initialises buffer mechanic before a trace session.
+ * @reset_buffer:	finalises buffer mechanic after a trace session.
+ * @update_buffer:	update buffer pointers after a trace session.
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev, u32 mode);
 	void (*disable)(struct coresight_device *csdev);
+	void *(*alloc_buffer)(struct coresight_device *csdev, int cpu,
+			      void **pages, int nr_pages, bool overwrite);
+	void (*free_buffer)(void *config);
+	int (*set_buffer)(struct coresight_device *csdev,
+			  struct perf_output_handle *handle,
+			  void *sink_config);
+	unsigned long (*reset_buffer)(struct coresight_device *csdev,
+				      struct perf_output_handle *handle,
+				      void *sink_config, bool *lost);
+	void (*update_buffer)(struct coresight_device *csdev,
+			      struct perf_output_handle *handle,
+			      void *sink_config);
 };
 
 /**
-- 
2.1.4
