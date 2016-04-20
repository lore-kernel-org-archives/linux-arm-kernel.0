From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 20 Apr 2016 15:22:33 -0600
Subject: [PATCH] coresight: etb10: fixing the right amount of words to read
Message-ID: <1461187353-17894-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch rectifies the amount of words to read when the internal
buffer is deemed bigger than the amount of space available in the
perf ring buffer.

The amount to read is set to the amount of space in the perf ring
buffer rather than being subtracted by it.

Reported-by: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index a974c39171a9..4d2427600f09 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -440,7 +440,7 @@ static void etb_update_buffer(struct coresight_device *csdev,
 		u32 mask = ~(ETB_FRAME_SIZE_WORDS - 1);
 
 		/* The new read pointer must be frame size aligned */
-		to_read -= handle->size & mask;
+		to_read = handle->size & mask;
 		/*
 		 * Move the RAM read pointer up, keeping in mind that
 		 * everything is in frame size units.
-- 
2.5.0
