From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:23 -0600
Subject: [RFC PATCH 09/20] coresight: etb10: implementing buffer update API
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementing buffer API to update the location of the ETB
internal ring buffer once a trace session has ended.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 113 ++++++++++++++++++++++++++
 include/linux/coresight.h                     |   3 +
 2 files changed, 116 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 3239036f4609..043e504837d3 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -346,12 +346,125 @@ static void etb_unset_buffer(struct coresight_device *csdev,
 				    local_xchg(&buf->lost, 0));
 }
 
+static void etb_update_buffer(struct coresight_device *csdev,
+			      struct perf_output_handle *handle)
+{
+	int i, cur;
+	u8 *buf_ptr;
+	u32 read_ptr, write_ptr, start;
+	u32 status, read_data, words;
+	unsigned long flags, offset;
+	struct cs_buffers *buf = perf_get_aux(handle);
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
+		words = write_ptr - read_ptr;
+		start = 0;
+	}
+
+	/*
+	 * Make sure we don't overwrite data that hasn't been consumed yet.
+	 * It is entirely possible that the HW buffer has more data than the
+	 * ring buffer can currently handle.  If so adjust the start address
+	 * to take only the last traces.
+	 *
+	 * Since metrics related to ETBs is in words, multiply by the
+	 * amount of byte per word to have the right units.
+	 */
+	if (words * ETB_FRAME_SIZE_WORDS > handle->size) {
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
+	/* update ring buffer information */
+	local_add(words * ETB_FRAME_SIZE_WORDS, &buf->data_size);
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
 	.unset_buffer	= etb_unset_buffer,
+	.update_buffer	= etb_update_buffer,
 };
 
 static const struct coresight_ops etb_cs_ops = {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 25bdce345ec3..48c3b9df0ae0 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -187,6 +187,7 @@ struct coresight_device {
  * @enable:	enables the sink.
  * @disable:	disables the sink.
  * @setup_aux:	initialises perf's ring buffer for trace collection.
+ * @update_buffer: update buffer pointers after a trace session.
  * @set_buffer:	initialises buffer mechanic before a trace session.
  * @unset_buffer: finalises buffer mechanic after a trace session.
  */
@@ -195,6 +196,8 @@ struct coresight_ops_sink {
 	void (*disable)(struct coresight_device *csdev);
 	void *(*setup_aux)(struct coresight_device *csdev, int cpu,
 			   void **pages, int nr_pages, bool overwrite);
+	void (*update_buffer)(struct coresight_device *csdev,
+			      struct perf_output_handle *handle);
 	int (*set_buffer)(struct coresight_device *csdev,
 			  struct perf_event *event,
 			  struct perf_output_handle *handle);
-- 
1.9.1
