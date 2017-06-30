From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 30 Jun 2017 11:41:55 -0600
Subject: [PATCH 1/5] coresight: Correct buffer lost increment
In-Reply-To: <1498844519-8845-1-git-send-email-mathieu.poirier@linaro.org>
References: <1498844519-8845-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1498844519-8845-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many conditions may cause synchronisation to be lost when updating
the perf ring buffer but the end result is still the same: synchronisation
is lost.  As such there is no need to increment the lost count for each
condition, just once will suffice.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 10 +++++++---
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  8 ++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d5b96423e1a5..d9c233135d6d 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -353,6 +353,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 			      struct perf_output_handle *handle,
 			      void *sink_config)
 {
+	bool lost = false;
 	int i, cur;
 	u8 *buf_ptr;
 	u32 read_ptr, write_ptr, capacity;
@@ -384,7 +385,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 			(unsigned long)write_ptr);
 
 		write_ptr &= ~(ETB_FRAME_SIZE_WORDS - 1);
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		lost = true;
 	}
 
 	/*
@@ -395,7 +396,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	 */
 	status = readl_relaxed(drvdata->base + ETB_STATUS_REG);
 	if (status & ETB_STATUS_RAM_FULL) {
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		lost = true;
 		to_read = capacity;
 		read_ptr = write_ptr;
 	} else {
@@ -428,9 +429,12 @@ static void etb_update_buffer(struct coresight_device *csdev,
 		if (read_ptr > (drvdata->buffer_depth - 1))
 			read_ptr -= drvdata->buffer_depth;
 		/* let the decoder know we've skipped ahead */
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		lost = true;
 	}
 
+	if (lost)
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+
 	/* finally tell HW where we want to start reading from */
 	writel_relaxed(read_ptr, drvdata->base + ETB_RAM_READ_POINTER);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e3b9fb82eb8d..2e0fb5b9372c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -369,6 +369,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 				  struct perf_output_handle *handle,
 				  void *sink_config)
 {
+	bool lost = false;
 	int i, cur;
 	u32 *buf_ptr;
 	u32 read_ptr, write_ptr;
@@ -397,7 +398,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	 */
 	status = readl_relaxed(drvdata->base + TMC_STS);
 	if (status & TMC_STS_FULL) {
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		lost = true;
 		to_read = drvdata->size;
 	} else {
 		to_read = CIRC_CNT(write_ptr, read_ptr, drvdata->size);
@@ -442,9 +443,12 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 			read_ptr -= drvdata->size;
 		/* Tell the HW */
 		writel_relaxed(read_ptr, drvdata->base + TMC_RRP);
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		lost = true;
 	}
 
+	if (lost)
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+
 	cur = buf->cur;
 	offset = buf->offset;
 
-- 
2.7.4
