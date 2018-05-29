From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 29 May 2018 14:15:28 +0100
Subject: [PATCH v2 03/12] coresight: tmc-etr: Do not clean trace buffer
In-Reply-To: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1527599737-28408-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We zero out the entire trace buffer used for ETR before it is enabled,
for helping with debugging. With the addition of scatter-gather mode,
the buffer could be bigger and non-contiguous.

Get rid of this step; if someone wants to debug, they can always add it
as and when needed.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f88342d..1de05c9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -13,9 +13,6 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl, sts;
 
-	/* Zero out the memory to help with debug */
-	memset(drvdata->vaddr, 0, drvdata->size);
-
 	CS_UNLOCK(drvdata->base);
 
 	/* Wait for TMCSReady bit to be set */
@@ -340,9 +337,8 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	if (drvdata->mode == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
-		 * buffer. The trace buffer is cleared in tmc_etr_enable_hw(),
-		 * so we don't have to explicitly clear it. Also, since the
-		 * tracer is still enabled drvdata::buf can't be NULL.
+		 * buffer. Since the tracer is still enabled drvdata::buf can't
+		 * be NULL.
 		 */
 		tmc_etr_enable_hw(drvdata);
 	} else {
-- 
2.7.4
