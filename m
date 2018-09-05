From: leo.yan@linaro.org (Leo Yan)
Date: Wed,  5 Sep 2018 15:55:44 +0800
Subject: [PATCH 2/2] coresight: tmc: Fix writing barrier packets for ring
 buffer
In-Reply-To: <1536134144-2764-1-git-send-email-leo.yan@linaro.org>
References: <1536134144-2764-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1536134144-2764-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When tmc driver updates ring buffer and detects the ETB RAM has a wrap
around, in the head of ring buffer the first four words is filled trace
data by reading out RRD register, but the driver simply discards the
first four words and leave the memory to store the barrier packets with
value 0x7fff,ffff.  As result we get below data content in the buffer:

  +--------+--------+--------+--------+--------+--------+--------+
  | trace0 | trace1 | trace2 | trace3 | trace4 | trace5 |  ...   |
  |   v    |   v    |   v    |   v    |        |        |        |
  | barrier| barrier| barrier| barrier|        |        |        |
  +--------+--------+--------+--------+--------+--------+--------+

On the other hand, the ring buffer actually has enough space for saving
both barrier packets and trace data from ETB RAM.  Ideally we should
save both barrier packets and complete trace data in the ETB RAM for the
wrap around case.  So below is the ideal data content we can get: the
first four words are for barrier packets and then save trace data from
reading the first word from RRD register.

  +--------+--------+--------+--------+--------+--------+--------+
  | barrier| barrier| barrier| barrier| trace0 | trace1 |  ...   |
  +--------+--------+--------+--------+--------+--------+--------+

To achieve this purpose, this patch introduces a variable 'barrier_sz'
to present the barrier packets length is to be written into the ring
buffer.  There have two cases that we will lose trace data so need to
insert the barrier packets between two discontinuous trace data block;
the first one case is the ETB RAM is in full state, another case is the
ring buffer has no enough space for trace data at this time.

We firstly need to reserve memory space in the ring buffer for barrier
packets and the left memory space can be used to save trace data. This
patch caps the value 'barrier_sz' so ensure barrier length is not longer
than ring buffer and calculate the rest memory space for 'to_read' for
trace data recording.

At the data saving stage, the patch firstly saves barrier packets
without reading RRD register so that will not lose trace data; after
that it will save trace data by accessing RRD register.  At the end, the
read data length is the sum value of barrier length 'barrier_sz' plus
trace data length 'to_read'.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 34 +++++++++++++++++--------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e310613..9c599c9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -387,7 +387,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	const u32 *barrier;
 	u32 *buf_ptr;
 	u64 read_ptr, write_ptr;
-	u32 status, to_read;
+	u32 status, to_read, barrier_sz = 0;
 	unsigned long offset;
 	struct cs_buffers *buf = sink_config;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -419,11 +419,18 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	}
 
 	/*
-	 * The TMC RAM buffer may be bigger than the space available in the
-	 * perf ring buffer (handle->size).  If so advance the RRP so that we
-	 * get the latest trace data.
+	 * Drop some trace data when the TMC RAM buffer is full or bigger than
+	 * perf ring buffer.  For this case the trace data is discontinuous
+	 * thus need to inser barrier packets.
 	 */
-	if (to_read > handle->size) {
+	barrier_sz = CORESIGHT_BARRIER_PKT_SIZE;
+
+	/*
+	 * The sum of trace data and inserted barriers may be bigger than the
+	 * space available in the perf ring buffer (handle->size).  If so
+	 * advance the RRP so that we get the latest trace data.
+	 */
+	if (to_read + barrier_sz > handle->size) {
 		u32 mask = 0;
 
 		/*
@@ -445,11 +452,15 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 			break;
 		}
 
+		/* Make sure barrier isn't out of bound */
+		barrier_sz = min_t(u32, barrier_sz, handle->size);
+
 		/*
-		 * Make sure the new size is aligned in accordance with the
+		 * Firstly reserve the memory for inserted barrier packets;
+		 * make sure the new size is aligned in accordance with the
 		 * requirement explained above.
 		 */
-		to_read = handle->size & mask;
+		to_read = (handle->size - barrier_sz) & mask;
 		/* Move the RAM read pointer up */
 		read_ptr = (write_ptr + drvdata->size) - to_read;
 		/* Make sure we are still within our limits */
@@ -468,13 +479,14 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	barrier = barrier_pkt;
 
 	/* for every byte to read */
-	for (i = 0; i < to_read; i += 4) {
+	for (i = 0; i < to_read + barrier_sz; i += 4) {
 		buf_ptr = buf->data_pages[cur] + offset;
-		*buf_ptr = readl_relaxed(drvdata->base + TMC_RRD);
 
-		if (lost && *barrier) {
+		if (i < barrier_sz) {
 			*buf_ptr = *barrier;
 			barrier++;
+		} else {
+			*buf_ptr = readl_relaxed(drvdata->base + TMC_RRD);
 		}
 
 		offset += 4;
@@ -495,7 +507,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
 	if (buf->snapshot)
 		local_set(&buf->data_size, (cur * PAGE_SIZE) + offset);
 	else
-		local_add(to_read, &buf->data_size);
+		local_add(to_read + barrier_sz, &buf->data_size);
 
 	CS_LOCK(drvdata->base);
 }
-- 
2.7.4
