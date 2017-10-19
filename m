From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 18:15:51 +0100
Subject: [PATCH 15/17] coresight: etr_buf: Add helper for padding an area of
 trace data
In-Reply-To: <20171019171553.24056-1-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
Message-ID: <20171019171553.24056-16-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a helper to insert barrier packets for a given
size (aligned to packet size) at given offset in an etr_buf. This
will be used later for perf mode when we try to start in the
middle of an SG buffer.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 52 ++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f8e654e1f5b2..229c36b7266c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -999,18 +999,58 @@ static ssize_t tmc_etr_buf_get_data(struct etr_buf *etr_buf,
 	return etr_buf->ops->get_data(etr_buf, (u64)offset, len, bufpp);
 }
 
+/*
+ * tmc_etr_buf_insert_barrier_packets : Insert barrier packets at @offset upto
+ * @size of bytes in the given buffer. @size should be aligned to the barrier
+ * packet size.
+ *
+ * Returns the new @offset after filling the barriers on success. Otherwise
+ * returns error.
+ */
 static inline s64
-tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
+tmc_etr_buf_insert_barrier_packets(struct etr_buf *etr_buf,
+				   u64 offset, u64 size)
 {
 	ssize_t len;
 	char *bufp;
 
-	len = tmc_etr_buf_get_data(etr_buf, offset,
-				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
-	if (WARN_ON(len <= CORESIGHT_BARRIER_PKT_SIZE))
+	if ((size % CORESIGHT_BARRIER_PKT_SIZE) ||
+	    (offset % CORESIGHT_BARRIER_PKT_SIZE))
 		return -EINVAL;
-	coresight_insert_barrier_packet(bufp);
-	return offset + CORESIGHT_BARRIER_PKT_SIZE;
+	do {
+		len = tmc_etr_buf_get_data(etr_buf, offset, size, &bufp);
+		if (WARN_ON(len <= 0))
+			return -EINVAL;
+		/*
+		 * We are guaranteed that @bufp will point to a linear range
+		 * of @len bytes, where @len <= @size.
+		 */
+		size -= len;
+		offset += len;
+		while (len >= CORESIGHT_BARRIER_PKT_SIZE) {
+			coresight_insert_barrier_packet(bufp);
+			bufp += CORESIGHT_BARRIER_PKT_SIZE;
+			len -= CORESIGHT_BARRIER_PKT_SIZE;
+		}
+
+		/*
+		 * Normally we shouldn't have any left over here, as the trace
+		 * should always be aligned to ETR Frame size.
+		 */
+		WARN_ON(len);
+		/* If we reached the end of the buffer, wrap around */
+		if (offset == etr_buf->size)
+			offset -= etr_buf->size;
+	} while (size);
+
+	return offset;
+}
+
+static inline s64
+tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
+{
+	return tmc_etr_buf_insert_barrier_packets(etr_buf, offset,
+					  CORESIGHT_BARRIER_PKT_SIZE);
 }
 
 /*
-- 
2.13.6
