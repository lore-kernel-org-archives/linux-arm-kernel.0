From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:38 -0600
Subject: [PATCH V2 21/30] coresight: etb10: implementing buffer update API
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-22-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing buffer API to update the location of the ETB
internal ring buffer once a trace session has ended.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 128 ++++++++++++++++++++++++++
 include/linux/coresight.h                     |  14 ++-
 2 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index ca2c4b42464d..8e469d097955 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -28,6 +28,7 @@
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
 #include <linux/mm.h>
+#include <linux/circ_buf.h>
 #include <linux/perf_event.h>
 
 #include <asm/local.h>
@@ -362,12 +363,139 @@ static void etb_reset_buffer(struct coresight_device *csdev,
 	local_set(&drvdata->in_use, 0);
 }
 
+static void etb_update_buffer(struct coresight_device *csdev,
+			      struct perf_output_handle *handle,
+			      void *sink_config)
+{
+	int i, cur;
+	u8 *buf_ptr;
+	u32 read_ptr, write_ptr, start;
+	u32 status, read_data, words;
+	unsigned long flags, offset;
+	struct cs_buffers *buf = sink_config;
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (!buf)
+		return;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (!drvdata->enable)
+		goto out;
+
+	etb_disable_hw(drvdata);
+	CS_UNLOCK(drvdata->base);
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
+		write_ptr &= ~ETB_FRAME_SIZE_WORDS;
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
+		words = drvdata->buffer_depth;
+		start = write_ptr;
+	} else {
+		words = CIRC_CNT(write_ptr, read_ptr, drvdata->buffer_depth);
+		start = read_ptr;
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
+	 *
+	 * Since metrics related to ETBs is in words, multiply by the
+	 * amount of byte per word to have the right units.
+	 */
+	if (!buf->snapshot && words * ETB_FRAME_SIZE_WORDS > handle->size) {
+		unsigned int capacity = drvdata->buffer_depth;
+
+		/* make sure new sizes are still multiples the frame size */
+		words = handle->size / ETB_FRAME_SIZE_WORDS;
+		/* advance the start pointer to get the latest trace data */
+		start += capacity - words;
+		/* wrap around if we've reach the end of the HW buffer */
+		start &= capacity - 1;
+		/* let the decoder know we've skipped ahead */
+		local_inc(&buf->lost);
+	}
+
+	/* finally tell HW where we want to start reading from */
+	writel_relaxed(start, drvdata->base + ETB_RAM_READ_POINTER);
+
+	cur = buf->cur;
+	offset = buf->offset;
+	for (i = 0; i < words; i++) {
+		buf_ptr = buf->addr[cur] + offset;
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
+		local_add(words * ETB_FRAME_SIZE_WORDS, &buf->data_size);
+
+	CS_LOCK(drvdata->base);
+	etb_enable_hw(drvdata);
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+}
+
 static const struct coresight_ops_sink etb_sink_ops = {
 	.enable		= etb_enable,
 	.disable	= etb_disable,
 	.setup_aux	= etb_setup_aux,
 	.set_buffer	= etb_set_buffer,
 	.reset_buffer	= etb_reset_buffer,
+	.update_buffer	= etb_update_buffer,
 };
 
 static const struct coresight_ops etb_cs_ops = {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 78202d5ea58a..cdf401d51998 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -186,11 +186,12 @@ struct coresight_device {
 /**
  * struct coresight_ops_sink - basic operations for a sink
  * Operations available for sinks
- * @enable:	enables the sink.
- * @disable:	disables the sink.
- * @setup_aux:	initialises perf's ring buffer for trace collection.
- * @set_buffer:	initialises buffer mechanic before a trace session.
- * @reset_buffer: finalises buffer mechanic after a trace session.
+ * @enable:		enables the sink.
+ * @disable:		disables the sink.
+ * @setup_aux:		initialises perf's ring buffer for trace collection.
+ * @set_buffer:		initialises buffer mechanic before a trace session.
+ * @reset_buffer:	finalises buffer mechanic after a trace session.
+ * @update_buffer:	update buffer pointers after a trace session.
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev);
@@ -203,6 +204,9 @@ struct coresight_ops_sink {
 	void (*reset_buffer)(struct coresight_device *csdev,
 			     struct perf_output_handle *handle,
 			     void *sink_config);
+	void (*update_buffer)(struct coresight_device *csdev,
+			      struct perf_output_handle *handle,
+			      void *sink_config);
 };
 
 /**
-- 
1.9.1
