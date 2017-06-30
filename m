From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 30 Jun 2017 11:41:56 -0600
Subject: [PATCH 2/5] coresight: etb10: Remove useless conversion to LE
In-Reply-To: <1498844519-8845-1-git-send-email-mathieu.poirier@linaro.org>
References: <1498844519-8845-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1498844519-8845-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Internal CoreSight components are rendering trace data in little-endian
format.  As such there is no need to convert the data once more, hence
removing the extra step.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d9c233135d6d..50f4846e6271 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -233,10 +233,8 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	for (i = 0; i < depth; i++) {
 		read_data = readl_relaxed(drvdata->base +
 					  ETB_RAM_READ_DATA_REG);
-		*buf_ptr++ = read_data >> 0;
-		*buf_ptr++ = read_data >> 8;
-		*buf_ptr++ = read_data >> 16;
-		*buf_ptr++ = read_data >> 24;
+		*(u32 *)buf_ptr = read_data;
+		buf_ptr += 4;
 	}
 
 	if (frame_off) {
@@ -444,10 +442,8 @@ static void etb_update_buffer(struct coresight_device *csdev,
 		buf_ptr = buf->data_pages[cur] + offset;
 		read_data = readl_relaxed(drvdata->base +
 					  ETB_RAM_READ_DATA_REG);
-		*buf_ptr++ = read_data >> 0;
-		*buf_ptr++ = read_data >> 8;
-		*buf_ptr++ = read_data >> 16;
-		*buf_ptr++ = read_data >> 24;
+		*(u32 *)buf_ptr = read_data;
+		buf_ptr += 4;
 
 		offset += 4;
 		if (offset >= PAGE_SIZE) {
-- 
2.7.4
