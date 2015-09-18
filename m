From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:24 -0600
Subject: [RFC PATCH 10/20] coresight: etb10: adding snapshot mode feature
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Snapshot mode works by accumulating traces in the ring buffer
until a user-space controlled event occurs.  Traces are allowed
to wrap around when the end of the ring buffer has been reached,
providing the latest and greatest information at all time.

This patch implements this feature by not checking for the end
of the ring buffer and setting the 'head' of the buffer to
the next available address.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 30 +++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 043e504837d3..b01861588243 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -341,9 +341,19 @@ static void etb_unset_buffer(struct coresight_device *csdev,
 {
 	struct cs_buffers *buf = perf_get_aux(handle);
 
-	if (buf)
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
 		perf_aux_output_end(handle, local_xchg(&buf->data_size, 0),
 				    local_xchg(&buf->lost, 0));
+	}
 }
 
 static void etb_update_buffer(struct coresight_device *csdev,
@@ -406,10 +416,14 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	 * ring buffer can currently handle.  If so adjust the start address
 	 * to take only the last traces.
 	 *
+	 * In snapshot mode we are looking to get the latest traces only and as
+	 * such, we don't care about not overwriting data that hasn't been
+	 * processed by user space.
+	 *
 	 * Since metrics related to ETBs is in words, multiply by the
 	 * amount of byte per word to have the right units.
 	 */
-	if (words * ETB_FRAME_SIZE_WORDS > handle->size) {
+	if (!buf->snapshot && words * ETB_FRAME_SIZE_WORDS > handle->size) {
 		unsigned int capacity = drvdata->buffer_depth;
 
 		/* make sure new sizes are still multiples the frame size */
@@ -449,8 +463,16 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	writel_relaxed(0x0, drvdata->base + ETB_RAM_READ_POINTER);
 	writel_relaxed(0x0, drvdata->base + ETB_RAM_WRITE_POINTER);
 
-	/* update ring buffer information */
-	local_add(words * ETB_FRAME_SIZE_WORDS, &buf->data_size);
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
 
 	CS_LOCK(drvdata->base);
 	etb_enable_hw(drvdata);
-- 
1.9.1
