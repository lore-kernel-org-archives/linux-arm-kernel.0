From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Dec 2015 13:59:08 -0700
Subject: [PATCH V7 12/24] coresight: etm3x: consolidating initial config
In-Reply-To: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1450472361-426-13-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is really no point in having two functions to take care
of doing the initial tracer configuration.  As such moving
everything to 'etm_set_default()'.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 37 ++++++++++-----------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index c97232ab7564..9293e71a075a 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -41,7 +41,6 @@ module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 /* The number of ETM/PTM currently registered */
 static int etm_count;
 static struct etm_drvdata *etmdrvdata[NR_CPUS];
-static void etm_init_default_data(struct etm_config *config);
 
 /*
  * Memory mapped writes to clear os lock are not supported on some processors
@@ -194,6 +193,19 @@ void etm_set_default(struct etm_config *config)
 	if (WARN_ON_ONCE(!config))
 		return;
 
+	/*
+	 * Taken verbatim from the TRM:
+	 *
+	 * To trace all memory:
+	 *  set bit [24] in register 0x009, the ETMTECR1, to 1
+	 *  set all other bits in register 0x009, the ETMTECR1, to 0
+	 *  set all bits in register 0x007, the ETMTECR2, to 0
+	 *  set register 0x008, the ETMTEEVR, to 0x6F (TRUE).
+	 */
+	config->enable_ctrl1 = BIT(24);
+	config->enable_ctrl2 = 0x0;
+	config->enable_event = ETM_HARD_WIRE_RES_A;
+
 	config->trigger_event = ETM_DEFAULT_EVENT_VAL;
 	config->enable_event = ETM_HARD_WIRE_RES_A;
 
@@ -579,27 +591,6 @@ static void etm_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm_init_default_data(struct etm_config *config)
-{
-	if (WARN_ON_ONCE(!config))
-		return;
-
-	etm_set_default(config);
-
-	/*
-	 * Taken verbatim from the TRM:
-	 *
-	 * To trace all memory:
-	 *  set bit [24] in register 0x009, the ETMTECR1, to 1
-	 *  set all other bits in register 0x009, the ETMTECR1, to 0
-	 *  set all bits in register 0x007, the ETMTECR2, to 0
-	 *  set register 0x008, the ETMTEEVR, to 0x6F (TRUE).
-	 */
-	config->enable_ctrl1 = BIT(24);
-	config->enable_ctrl2 = 0x0;
-	config->enable_event = ETM_HARD_WIRE_RES_A;
-}
-
 static void etm_init_trace_id(struct etm_drvdata *drvdata)
 {
 	/*
@@ -676,7 +667,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	etm_init_trace_id(drvdata);
-	etm_init_default_data(&drvdata->config);
+	etm_set_default(&drvdata->config);
 
 	desc->type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
-- 
2.1.4
