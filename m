From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 18:15:49 +0100
Subject: [PATCH 13/17] coresight etr: Do not clean ETR trace buffer
In-Reply-To: <20171019171553.24056-1-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
Message-ID: <20171019171553.24056-14-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We zero out the entire trace buffer used for ETR before it
is enabled, for helping with debugging. Since we could be
restoring a session in perf mode, this could destroy the data.
Get rid of this step, if someone wants to debug, they can always
add it as and when needed.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 31353fc34b53..849684f85443 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -971,8 +971,6 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 		return;
 
 	drvdata->etr_buf = etr_buf;
-	/* Zero out the memory to help with debug */
-	memset(etr_buf->vaddr, 0, etr_buf->size);
 
 	CS_UNLOCK(drvdata->base);
 
@@ -1267,9 +1265,8 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	if (drvdata->mode == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
-		 * buffer. The trace buffer is cleared in tmc_etr_enable_hw(),
-		 * so we don't have to explicitly clear it. Also, since the
-		 * tracer is still enabled drvdata::buf can't be NULL.
+		 * buffer. Since the tracer is still enabled drvdata::buf can't
+		 * be NULL.
 		 */
 		tmc_etr_enable_hw(drvdata, drvdata->sysfs_buf);
 	} else {
-- 
2.13.6
