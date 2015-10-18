From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:26 -0600
Subject: [PATCH V2 09/30] coresight: etm3x: changing default trace
 configuration
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changing default configuration to include the entire address
range rather than just the kernel.  That way traces are more
inclusive and it is easier to narrow down if needed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  2 ++
 drivers/hwtracing/coresight/coresight-etm3x.c | 29 ++++++++++++---------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 0996537ff142..f33aeb4e545d 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -146,6 +146,7 @@
  * @startstop_ctrl: setting for register ETMTSSCR.
  * @enable_event: setting for register ETMTEEVR.
  * @enable_ctrl1: setting for register ETMTECR1.
+ * @enable_ctrl2: setting for register ETMTECR2.
  * @fifofull_level: setting for register ETMFFLR.
  * @addr_idx:	index for the address comparator selection.
  * @addr_val:	value for address comparator register.
@@ -179,6 +180,7 @@ struct etm_config {
 	u32				startstop_ctrl;
 	u32				enable_event;
 	u32				enable_ctrl1;
+	u32				enable_ctrl2;
 	u32				fifofull_level;
 	u8				addr_idx;
 	u32				addr_val[ETM_MAX_ADDR_CMP];
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index e199746bba05..8bd161584f85 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -567,26 +567,23 @@ static void etm_init_arch_data(void *info)
 
 static void etm_init_default_data(struct etm_config *config)
 {
-	u32 flags = (1 << 0 | /* instruction execute*/
-		     3 << 3 | /* ARM instruction */
-		     0 << 5 | /* No data value comparison */
-		     0 << 7 | /* No exact mach */
-		     0 << 8 | /* Ignore context ID */
-		     0 << 10); /* Security ignored */
-
 	if (WARN_ON_ONCE(!config))
 		return;
 
-	config->ctrl = (ETMCR_CYC_ACC | ETMCR_TIMESTAMP_EN);
-	config->enable_ctrl1 = ETMTECR1_ADDR_COMP_1;
-	config->addr_val[0] = (u32) _stext;
-	config->addr_val[1] = (u32) _etext;
-	config->addr_acctype[0] = flags;
-	config->addr_acctype[1] = flags;
-	config->addr_type[0] = ETM_ADDR_TYPE_RANGE;
-	config->addr_type[1] = ETM_ADDR_TYPE_RANGE;
-
 	etm_set_default(config);
+
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
 }
 
 static void etm_init_trace_id(struct etm_drvdata *drvdata)
-- 
1.9.1
