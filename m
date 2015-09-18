From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:18 -0600
Subject: [RFC PATCH 04/20] coresight: etm3x: using chip logic to start/stop
 traces
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driving the external ETMEN pins to start and stop trace
collection isn't reliable when doing rapid, successive
trace collection runs.

Using the internal event enable register logic to control
tracing is much more dependable.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 4ce9cfc06e93..3cdf0bcddb41 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -323,6 +323,7 @@ static void etm_configure_cpu(void *info)
 
 	etmcr = etm_readl(drvdata, ETMCR);
 	etmcr |= drvdata->port_size;
+	etmcr |= ETMCR_ETM_EN;
 	etm_writel(drvdata, drvdata->ctrl | etmcr, ETMCR);
 	etm_writel(drvdata, drvdata->trigger_event, ETMTRIGGER);
 	etm_writel(drvdata, drvdata->startstop_ctrl, ETMTSSCR);
@@ -397,7 +398,7 @@ static bool etm_is_enabled(struct coresight_device *csdev)
  */
 static int etm_trace_enable(struct coresight_device *csdev, bool enable)
 {
-	u32 etmcr;
+	u32 etmteevr;
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	WARN_ON(drvdata->cpu != smp_processor_id());
@@ -410,13 +411,16 @@ static int etm_trace_enable(struct coresight_device *csdev, bool enable)
 	CS_UNLOCK(drvdata->base);
 	etm_set_prog(drvdata);
 
-	etmcr = etm_readl(drvdata, ETMCR);
-
-	enable ? (etmcr |= ETMCR_ETM_EN) :
-		 (etmcr &= ~ETMCR_ETM_EN);
-
-	etm_writel(drvdata, ETMCR_ETM_EN | etmcr, ETMCR);
+	etmteevr = etm_readl(drvdata, ETMTEEVR);
+	if (enable) {
+		/* boolean function bits all set to '0' selects resource A */
+		etmteevr &= ~(BIT(16) | BIT(15) | BIT(14));
+	} else {
+		/* boolean function bit 14 negate resource selection A */
+		etmteevr |= BIT(14);
+	}
 
+	etm_writel(drvdata, etmteevr, ETMTEEVR);
 	etm_clr_prog(drvdata);
 	CS_LOCK(drvdata->base);
 
-- 
1.9.1
