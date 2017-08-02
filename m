From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:02 -0600
Subject: [PATCH 08/26] coresight: ptm: Adds trace return stack option
 programming for PTM.
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Leach <mike.leach@linaro.org>

Adds handling to program the return stack option into PTM hardware if
specified in the perf command line.

If option is not supported by the hardware then it will be ignored.
This allows capture to move between core/ETM combinations that have the
hardware support to those that do not.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  1 +
 drivers/hwtracing/coresight/coresight-etm3x.c | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index ad063d7444e1..70b0a248c321 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -106,6 +106,7 @@
 #define ETMTECR1_START_STOP	BIT(25)
 /* ETMCCER - 0x1E8 */
 #define ETMCCER_TIMESTAMP	BIT(22)
+#define ETMCCER_RETSTACK	BIT(23)
 
 #define ETM_MODE_EXCLUDE	BIT(0)
 #define ETM_MODE_CYCACC		BIT(1)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 9d8bd4e36b32..9c010eb9497f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -310,7 +310,9 @@ void etm_config_trace_mode(struct etm_config *config)
 	config->addr_type[1] = ETM_ADDR_TYPE_RANGE;
 }
 
-#define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN)
+#define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | \
+				 ETMCR_TIMESTAMP_EN | \
+				 ETMCR_RETURN_STACK)
 
 static int etm_parse_event_config(struct etm_drvdata *drvdata,
 				  struct perf_event *event)
@@ -341,14 +343,24 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 		etm_config_trace_mode(config);
 
 	/*
-	 * At this time only cycle accurate and timestamp options are
-	 * available.
+	 * At this time only cycle accurate, return stack  and timestamp
+	 * options are available.
 	 */
 	if (attr->config & ~ETM3X_SUPPORTED_OPTIONS)
 		return -EINVAL;
 
 	config->ctrl = attr->config;
 
+	/*
+	 * Possible to have cores with PTM (supports ret stack) and ETM
+	 * (never has ret stack) on the same SoC. So if we have a request
+	 * for return stack that can't be honoured on this core then
+	 * clear the bit - trace will still continue normally
+	 */
+	if ((config->ctrl & ETMCR_RETURN_STACK) &&
+	    !(drvdata->etmccer & ETMCCER_RETSTACK))
+		config->ctrl &= ~ETMCR_RETURN_STACK;
+
 	return 0;
 }
 
-- 
2.7.4
