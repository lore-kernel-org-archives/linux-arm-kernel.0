From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:09 -0600
Subject: [PATCH 01/14] coresight: tmc: modifying naming convention
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the TMC architectural state machine, the 'stopped'
state is reached when bit 2 (TMCReady) of the TMC Status register
turns to '1'.  The code is correct but the naming convention isn't.

The 'Triggered' bit occupies position '1' of the TMC Status register
and has nothing to do with the indication of the TMC entering the
stopped state. As such renaming function "tmc_wait_for_triggered()"
and changing the #define to reflect what the code is really doing.

This patch has no effect other than clarifying the semantic.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index f0a67f984591..8a9e4d789bd8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -76,7 +76,7 @@
 #define TMC_FFCR_TRIGON_TRIGIN	BIT(8)
 #define TMC_FFCR_STOP_ON_FLUSH	BIT(12)
 
-#define TMC_STS_TRIGGERED_BIT	2
+#define TMC_STS_TMCREADY_BIT	2
 #define TMC_FFCR_FLUSHMAN_BIT	6
 
 enum tmc_config_type {
@@ -131,11 +131,11 @@ struct tmc_drvdata {
 	u32			trigger_cntr;
 };
 
-static void tmc_wait_for_ready(struct tmc_drvdata *drvdata)
+static void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
 	/* Ensure formatter, unformatter and hardware fifo are empty */
 	if (coresight_timeout(drvdata->base,
-			      TMC_STS, TMC_STS_TRIGGERED_BIT, 1)) {
+			      TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
 		dev_err(drvdata->dev,
 			"timeout observed when probing at offset %#x\n",
 			TMC_STS);
@@ -159,7 +159,7 @@ static void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 			TMC_FFCR);
 	}
 
-	tmc_wait_for_ready(drvdata);
+	tmc_wait_for_tmcready(drvdata);
 }
 
 static void tmc_enable_hw(struct tmc_drvdata *drvdata)
-- 
2.1.4
