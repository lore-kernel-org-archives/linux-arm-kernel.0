From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 18 Jul 2016 13:51:25 -0600
Subject: [PATCH 04/10] coresight: etm4x: split default and filter configuration
In-Reply-To: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
References: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1468871491-10997-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Splitting the steps involved in the configuration of a tracer.
The first part is generic and can be reused for both sysFS and
Perf methods.

The second part pertains to the configuration of filters
themselves where the source of the information used to
configure the filters will vary depending on the access
methods.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 36 ++++++++++++++++-----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 1fe1f0e86daf..9978cf7a5600 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -565,21 +565,8 @@ static void etm4_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm4_set_default(struct etmv4_config *config)
+static void etm4_set_default_config(struct etmv4_config *config)
 {
-	if (WARN_ON_ONCE(!config))
-		return;
-
-	/*
-	 * Make default initialisation trace everything
-	 *
-	 * Select the "always true" resource selector on the
-	 * "Enablign Event" line and configure address range comparator
-	 * '0' to trace all the possible address range.  From there
-	 * configure the "include/exclude" engine to include address
-	 * range comparator '0'.
-	 */
-
 	/* disable all events tracing */
 	config->eventctrl0 = 0x0;
 	config->eventctrl1 = 0x0;
@@ -595,7 +582,10 @@ static void etm4_set_default(struct etmv4_config *config)
 
 	/* TRCVICTLR::EVENT = 0x01, select the always on logic */
 	config->vinst_ctrl |= BIT(0);
+}
 
+static void etm4_set_default_filter(struct etmv4_config *config)
+{
 	/*
 	 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
 	 * in the started state
@@ -641,6 +631,24 @@ static void etm4_set_default(struct etmv4_config *config)
 	config->vissctlr = 0x0;
 }
 
+static void etm4_set_default(struct etmv4_config *config)
+{
+	if (WARN_ON_ONCE(!config))
+		return;
+
+	/*
+	 * Make default initialisation trace everything
+	 *
+	 * Select the "always true" resource selector on the
+	 * "Enablign Event" line and configure address range comparator
+	 * '0' to trace all the possible address range.  From there
+	 * configure the "include/exclude" engine to include address
+	 * range comparator '0'.
+	 */
+	etm4_set_default_config(config);
+	etm4_set_default_filter(config);
+}
+
 void etm4_config_trace_mode(struct etmv4_config *config)
 {
 	u32 addr_acc, mode;
-- 
2.7.4
