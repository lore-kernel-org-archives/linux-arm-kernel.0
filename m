From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:19 -0600
Subject: [RFC PATCH 05/20] coresight: etm3x: adapting default tracer setting
 for perf
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The perf command line tool has options to trace in kernel or
user space mode.  As such configuring tracers to trace the
entire address range, leaving to the perf mechanic the task
of collecting traces in accordance with the requested mode.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  2 ++
 drivers/hwtracing/coresight/coresight-etm3x.c | 36 +++++++++++----------------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index b4481eb29304..b149a565bc32 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -165,6 +165,7 @@
  * @startstop_ctrl: setting for register ETMTSSCR.
  * @enable_event: setting for register ETMTEEVR.
  * @enable_ctrl1: setting for register ETMTECR1.
+ * @enable_ctrl2: setting for register ETMTECR2.
  * @fifofull_level: setting for register ETMFFLR.
  * @addr_idx:	index for the address comparator selection.
  * @addr_val:	value for address comparator register.
@@ -219,6 +220,7 @@ struct etm_drvdata {
 	u32				startstop_ctrl;
 	u32				enable_event;
 	u32				enable_ctrl1;
+	u32				enable_ctrl2;
 	u32				fifofull_level;
 	u8				addr_idx;
 	u32				addr_val[ETM_MAX_ADDR_CMP];
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 3cdf0bcddb41..c6880c1ade55 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -220,6 +220,17 @@ static void etm_set_default(struct etm_drvdata *drvdata)
 	int i;
 
 	drvdata->trigger_event = ETM_DEFAULT_EVENT_VAL;
+	/*
+	 * Taken verbatim from the TRM:
+	 *
+	 * To trace all memory:
+	 *  set bit [24] in register 0x009, the ETMTECR1, to 1
+	 *  set all other bits in register 0x009, the ETMTECR1, to 0
+	 *  set all bits in register 0x007, the ETMTECR2, to 0
+	 *  set register 0x008, the ETMTEEVR, to 0x6F (TRUE).
+	 */
+	drvdata->enable_ctrl1 = BIT(24);
+	drvdata->enable_ctrl2 = 0x0;
 	drvdata->enable_event = ETM_HARD_WIRE_RES_A;
 
 	drvdata->seq_12_event = ETM_DEFAULT_EVENT_VAL;
@@ -1881,7 +1892,7 @@ static void etm_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm_init_default_data(struct etm_drvdata *drvdata)
+static void etm_init_trace_id(struct etm_drvdata *drvdata)
 {
 	/*
 	 * A trace ID of value 0 is invalid, so let's start at some
@@ -1889,13 +1900,6 @@ static void etm_init_default_data(struct etm_drvdata *drvdata)
 	 */
 	static int etm3x_traceid = 0x10;
 
-	u32 flags = (1 << 0 | /* instruction execute*/
-		     3 << 3 | /* ARM instruction */
-		     0 << 5 | /* No data value comparison */
-		     0 << 7 | /* No exact mach */
-		     0 << 8 | /* Ignore context ID */
-		     0 << 10); /* Security ignored */
-
 	/*
 	 * Initial configuration only - guarantees sources handled by
 	 * this driver have a unique ID@startup time but not between
@@ -1903,18 +1907,6 @@ static void etm_init_default_data(struct etm_drvdata *drvdata)
 	 * framework.
 	 */
 	drvdata->traceid = etm3x_traceid++;
-	drvdata->ctrl = (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN);
-	drvdata->enable_ctrl1 = ETMTECR1_ADDR_COMP_1;
-	if (drvdata->nr_addr_cmp >= 2) {
-		drvdata->addr_val[0] = (u32) _stext;
-		drvdata->addr_val[1] = (u32) _etext;
-		drvdata->addr_acctype[0] = flags;
-		drvdata->addr_acctype[1] = flags;
-		drvdata->addr_type[0] = ETM_ADDR_TYPE_RANGE;
-		drvdata->addr_type[1] = ETM_ADDR_TYPE_RANGE;
-	}
-
-	etm_set_default(drvdata);
 }
 
 static int etm_probe(struct amba_device *adev, const struct amba_id *id)
@@ -1985,7 +1977,9 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = -EINVAL;
 		goto err_arch_supported;
 	}
-	etm_init_default_data(drvdata);
+
+	etm_init_trace_id(drvdata);
+	etm_set_default(drvdata);
 
 	desc->type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
-- 
1.9.1
