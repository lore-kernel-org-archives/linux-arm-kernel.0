From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  3 May 2016 11:34:01 -0600
Subject: [PATCH 27/27] coresight: etb10: adjust read pointer only when needed
In-Reply-To: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
References: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1462296841-12327-28-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The read pointer (read_ptr) needs to be adjusted only if its value
has gone beyond the length of the memory buffer.

Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 92f942321e1e..4d20b0be0c0b 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -428,7 +428,8 @@ static void etb_update_buffer(struct coresight_device *csdev,
 		read_ptr = (write_ptr + drvdata->buffer_depth) -
 					to_read / ETB_FRAME_SIZE_WORDS;
 		/* Wrap around if need be*/
-		read_ptr &= ~(drvdata->buffer_depth - 1);
+		if (read_ptr > (drvdata->buffer_depth - 1))
+			read_ptr -= drvdata->buffer_depth;
 		/* let the decoder know we've skipped ahead */
 		local_inc(&buf->lost);
 	}
-- 
2.5.0
