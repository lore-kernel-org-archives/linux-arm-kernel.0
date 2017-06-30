From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 30 Jun 2017 11:41:57 -0600
Subject: [PATCH 3/5] coresight: Add barrier packet for synchronisation
In-Reply-To: <1498844519-8845-1-git-send-email-mathieu.poirier@linaro.org>
References: <1498844519-8845-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1498844519-8845-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a buffer overflow happens the synchronisation patckets usually
present at the beginning of the buffer are lost, a situation that
prevents the decoder from knowing the context of the traces being
decoded.

This patch adds a barrier packet to be used by sink IPs when a buffer
overflow condition is detected.  These barrier packets are then used
by the decoding library as markers to force re-synchronisation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 22 +++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-priv.h    |  2 ++
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 26 ++++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 12 ++++++++++++
 drivers/hwtracing/coresight/coresight.c         |  8 ++++++++
 5 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 50f4846e6271..42360306f049 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -200,8 +200,10 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
 
 static void etb_dump_hw(struct etb_drvdata *drvdata)
 {
+	bool lost = false;
 	int i;
 	u8 *buf_ptr;
+	const u32 *barrier;
 	u32 read_data, depth;
 	u32 read_ptr, write_ptr;
 	u32 frame_off, frame_endoff;
@@ -223,16 +225,24 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	}
 
 	if ((readl_relaxed(drvdata->base + ETB_STATUS_REG)
-		      & ETB_STATUS_RAM_FULL) == 0)
+		      & ETB_STATUS_RAM_FULL) == 0) {
 		writel_relaxed(0x0, drvdata->base + ETB_RAM_READ_POINTER);
-	else
+	} else {
 		writel_relaxed(write_ptr, drvdata->base + ETB_RAM_READ_POINTER);
+		lost = true;
+	}
 
 	depth = drvdata->buffer_depth;
 	buf_ptr = drvdata->buf;
+	barrier = barrier_pkt;
 	for (i = 0; i < depth; i++) {
 		read_data = readl_relaxed(drvdata->base +
 					  ETB_RAM_READ_DATA_REG);
+		if (lost && *barrier) {
+			read_data = *barrier;
+			barrier++;
+		}
+
 		*(u32 *)buf_ptr = read_data;
 		buf_ptr += 4;
 	}
@@ -354,6 +364,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 	bool lost = false;
 	int i, cur;
 	u8 *buf_ptr;
+	const u32 *barrier;
 	u32 read_ptr, write_ptr, capacity;
 	u32 status, read_data, to_read;
 	unsigned long offset;
@@ -438,10 +449,17 @@ static void etb_update_buffer(struct coresight_device *csdev,
 
 	cur = buf->cur;
 	offset = buf->offset;
+	barrier = barrier_pkt;
+
 	for (i = 0; i < to_read; i += 4) {
 		buf_ptr = buf->data_pages[cur] + offset;
 		read_data = readl_relaxed(drvdata->base +
 					  ETB_RAM_READ_DATA_REG);
+		if (lost && *barrier) {
+			read_data = *barrier;
+			barrier++;
+		}
+
 		*(u32 *)buf_ptr = read_data;
 		buf_ptr += 4;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 5f662d82052c..3e25b1dd1a1a 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -56,6 +56,8 @@ static ssize_t name##_show(struct device *_dev,				\
 }									\
 static DEVICE_ATTR_RO(name)
 
+extern const u32 barrier_pkt[5];
+
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
 	ETM_ADDR_TYPE_SINGLE,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 2e0fb5b9372c..d189b28bd5c4 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -43,17 +43,34 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
+	bool lost = false;
 	char *bufp;
-	u32 read_data;
+	const u32 *barrier;
+	u32 read_data, status;
 	int i;
 
+	/*
+	 * Get a hold of the status register and see if a wrap around
+	 * has occurred.
+	 */
+	status = readl_relaxed(drvdata->base + TMC_STS);
+	if (status & TMC_STS_FULL)
+		lost = true;
+
 	bufp = drvdata->buf;
 	drvdata->len = 0;
+	barrier = barrier_pkt;
 	while (1) {
 		for (i = 0; i < drvdata->memwidth; i++) {
 			read_data = readl_relaxed(drvdata->base + TMC_RRD);
 			if (read_data == 0xFFFFFFFF)
 				return;
+
+			if (lost && *barrier) {
+				read_data = *barrier;
+				barrier++;
+			}
+
 			memcpy(bufp, &read_data, 4);
 			bufp += 4;
 			drvdata->len += 4;
@@ -371,6 +388,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 {
 	bool lost = false;
 	int i, cur;
+	const u32 *barrier;
 	u32 *buf_ptr;
 	u32 read_ptr, write_ptr;
 	u32 status, to_read;
@@ -451,12 +469,18 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	cur = buf->cur;
 	offset = buf->offset;
+	barrier = barrier_pkt;
 
 	/* for every byte to read */
 	for (i = 0; i < to_read; i += 4) {
 		buf_ptr = buf->data_pages[cur] + offset;
 		*buf_ptr = readl_relaxed(drvdata->base + TMC_RRD);
 
+		if (lost && *barrier) {
+			*buf_ptr = *barrier;
+			barrier++;
+		}
+
 		offset += 4;
 		if (offset >= PAGE_SIZE) {
 			offset = 0;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 5d312699b3b9..b8fb981de7b6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -59,6 +59,8 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 {
+	const u32 *barrier;
+	u32 *temp;
 	u32 rwp, val;
 
 	rwp = readl_relaxed(drvdata->base + TMC_RWP);
@@ -71,6 +73,16 @@ static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 	if (val & TMC_STS_FULL) {
 		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
 		drvdata->len = drvdata->size;
+
+		barrier = barrier_pkt;
+		temp = (u32 *)drvdata->buf;
+
+		while (*barrier) {
+			*temp = *barrier;
+			temp++;
+			barrier++;
+		}
+
 	} else {
 		drvdata->buf = drvdata->vaddr;
 		drvdata->len = rwp - drvdata->paddr;
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 6a0202b7384f..b8091bef21dc 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -53,6 +53,14 @@ static DEFINE_PER_CPU(struct list_head *, tracer_path);
  */
 static struct list_head *stm_path;
 
+/*
+ * When losing synchronisation a new barrier packet needs to be inserted at the
+ * beginning of the data collected in a buffer.  That way the decoder knows that
+ * it needs to look for another sync sequence.
+ */
+const u32 barrier_pkt[5] = {0x7fffffff, 0x7fffffff,
+			    0x7fffffff, 0x7fffffff, 0x0};
+
 static int coresight_id_match(struct device *dev, void *data)
 {
 	int trace_id, i_trace_id;
-- 
2.7.4
