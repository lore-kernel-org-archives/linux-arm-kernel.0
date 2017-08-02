From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:21:58 -0600
Subject: [PATCH 04/26] coresight: etb10: Move etb_disable_hw() outside of lock
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function etb_disable_hw() is already taking care of unlocking and locking
the coresight access register and as such doesn't need to be placed
within the unlock/lock of function etb_update_buffer().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 42360306f049..d0d186575c5d 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -376,8 +376,8 @@ static void etb_update_buffer(struct coresight_device *csdev,
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
-	CS_UNLOCK(drvdata->base);
 	etb_disable_hw(drvdata);
+	CS_UNLOCK(drvdata->base);
 
 	/* unit is in words, not bytes */
 	read_ptr = readl_relaxed(drvdata->base + ETB_RAM_READ_POINTER);
-- 
2.7.4
