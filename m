From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:10 -0600
Subject: [PATCH 02/14] coresight: tmc: waiting for TMCReady bit before
 programming
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the TRM before programming the TMC in circular
buffer mode (and that for any configuration, ETB, ETR, ETF),
the TMCReady bit in the status register has to be set.

This patch adds a check to make sure the state machine is in
a state where it can be configured, and complains otherwise.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 8a9e4d789bd8..f4ba837a0810 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -179,6 +179,9 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 	CS_UNLOCK(drvdata->base);
 
+	/* Wait for TMCSReady bit to be set */
+	tmc_wait_for_tmcready(drvdata);
+
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
 		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
@@ -200,6 +203,9 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 
 	CS_UNLOCK(drvdata->base);
 
+	/* Wait for TMCSReady bit to be set */
+	tmc_wait_for_tmcready(drvdata);
+
 	writel_relaxed(drvdata->size / 4, drvdata->base + TMC_RSZ);
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
 
@@ -229,6 +235,9 @@ static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
+	/* Wait for TMCSReady bit to be set */
+	tmc_wait_for_tmcready(drvdata);
+
 	writel_relaxed(TMC_MODE_HARDWARE_FIFO, drvdata->base + TMC_MODE);
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI,
 		       drvdata->base + TMC_FFCR);
-- 
2.1.4
