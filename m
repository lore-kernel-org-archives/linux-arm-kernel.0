From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  1 May 2018 10:10:38 +0100
Subject: [PATCH v2 08/27] coresight: tmc-etr: Do not clean trace buffer
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1525165857-11096-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We zero out the entire trace buffer used for ETR before it is enabled,
for helping with debugging. Since we could be restoring an already used
buffer in perf mode, this could destroy the data. Get rid of this step;
if someone wants to debug, they can always add it as and when needed.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 53a17a8..fc1ff3f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -41,9 +41,6 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
 	u32 axictl, sts;
 
-	/* Zero out the memory to help with debug */
-	memset(drvdata->vaddr, 0, drvdata->size);
-
 	/*
 	 * If this ETR is connected to a CATU, enable it before we turn
 	 * this on
@@ -354,9 +351,8 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
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
