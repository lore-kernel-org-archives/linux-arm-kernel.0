From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 Apr 2016 11:14:03 -0600
Subject: [PATCH V3 06/18] coresight: tmc: cleaning up header file
In-Reply-To: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1461345255-11758-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch first move the TMC_STS_TMCREADY_BIT and
TMC_FFCR_FLUSHMAN_BIT defines to their respective section.
It also removes TMC_FFCR_FLUSHMAN, since the same result
can easily be obtained using the BIT() macro.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc.h | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index f9a6624ab531..07e2809d832b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -50,7 +50,7 @@ static void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 	ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
 	ffcr |= TMC_FFCR_STOP_ON_FLUSH;
 	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
-	ffcr |= TMC_FFCR_FLUSHMAN;
+	ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
 	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
 	/* Ensure flush completes */
 	if (coresight_timeout(drvdata->base,
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 49718b4a9788..5a60830c8db5 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -49,6 +49,7 @@
 /* TMC_CTL - 0x020 */
 #define TMC_CTL_CAPT_EN		BIT(0)
 /* TMC_STS - 0x00C */
+#define TMC_STS_TMCREADY_BIT	2
 #define TMC_STS_TRIGGERED	BIT(1)
 /* TMC_AXICTL - 0x110 */
 #define TMC_AXICTL_PROT_CTL_B0	BIT(0)
@@ -56,16 +57,14 @@
 #define TMC_AXICTL_SCT_GAT_MODE	BIT(7)
 #define TMC_AXICTL_WR_BURST_16	0xF00
 /* TMC_FFCR - 0x304 */
+#define TMC_FFCR_FLUSHMAN_BIT	6
 #define TMC_FFCR_EN_FMT		BIT(0)
 #define TMC_FFCR_EN_TI		BIT(1)
 #define TMC_FFCR_FON_FLIN	BIT(4)
 #define TMC_FFCR_FON_TRIG_EVT	BIT(5)
-#define TMC_FFCR_FLUSHMAN	BIT(6)
 #define TMC_FFCR_TRIGON_TRIGIN	BIT(8)
 #define TMC_FFCR_STOP_ON_FLUSH	BIT(12)
 
-#define TMC_STS_TMCREADY_BIT	2
-#define TMC_FFCR_FLUSHMAN_BIT	6
 
 enum tmc_config_type {
 	TMC_CONFIG_TYPE_ETB,
-- 
2.5.0
