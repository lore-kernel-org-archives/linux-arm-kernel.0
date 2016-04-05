From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:45 -0600
Subject: [PATCH 04/11] coresight: etm4x: splitting etmv4 default configuration
In-Reply-To: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
References: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1459878832-15219-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Splitting and updating the default initialisation for each etmv4
configuration so that it can be called at the beginning of each
session rather than initialisation time only.

Since the trace ID isn't expected to change with every session,
moving it with the default tracer initialisation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 128 ++++++++++++--------------
 drivers/hwtracing/coresight/coresight-etm4x.h |  12 +++
 2 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 102e9aaf952b..2744413dedb2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/coresight.h>
+#include <linux/coresight-pmu.h>
 #include <linux/pm_wakeup.h>
 #include <linux/amba/bus.h>
 #include <linux/seq_file.h>
@@ -436,14 +437,20 @@ static void etm4_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm4_init_default_data(struct etmv4_drvdata *drvdata)
+static void etm4_set_default(struct etmv4_config *config)
 {
-	int i;
-	struct etmv4_config *config = &drvdata->config;
+	if (WARN_ON_ONCE(!config))
+		return;
 
-	config->pe_sel = 0x0;
-	config->cfg = (ETMv4_MODE_CTXID | ETM_MODE_VMID |
-			ETMv4_MODE_TIMESTAMP | ETM_MODE_RETURNSTACK);
+	/*
+	 * Make default initialisation trace everything
+	 *
+	 * Select the "always true" resource selector on the
+	 * "Enablign Event" line and configure address range comparator
+	 * '0' to trace all the possible address range.  From there
+	 * configure the "include/exclude" engine to include address
+	 * range comparator '0'.
+	 */
 
 	/* disable all events tracing */
 	config->eventctrl0 = 0x0;
@@ -452,78 +459,58 @@ static void etm4_init_default_data(struct etmv4_drvdata *drvdata)
 	/* disable stalling */
 	config->stall_ctrl = 0x0;
 
+	/* enable trace synchronization every 4096 bytes, if available */
+	config->syncfreq = 0xC;
+
 	/* disable timestamp event */
 	config->ts_ctrl = 0x0;
 
-	/* enable trace synchronization every 4096 bytes for trace */
-	if (drvdata->syncpr == false)
-		config->syncfreq = 0xC;
+	/* TRCVICTLR::EVENT = 0x01, select the always on logic */
+	config->vinst_ctrl |= BIT(0);
 
 	/*
-	 *  enable viewInst to trace everything with start-stop logic in
-	 *  started state
+	 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
+	 * in the started state
 	 */
-	config->vinst_ctrl |= BIT(0);
-	/* set initial state of start-stop logic */
-	if (drvdata->nr_addr_cmp)
-		config->vinst_ctrl |= BIT(9);
-
-	/* no address range filtering for ViewInst */
-	config->viiectlr = 0x0;
-	/* no start-stop filtering for ViewInst */
-	config->vissctlr = 0x0;
-
-	/* disable seq events */
-	for (i = 0; i < drvdata->nrseqstate-1; i++)
-		config->seq_ctrl[i] = 0x0;
-	config->seq_rst = 0x0;
-	config->seq_state = 0x0;
-
-	/* disable external input events */
-	config->ext_inp = 0x0;
-
-	for (i = 0; i < drvdata->nr_cntr; i++) {
-		config->cntrldvr[i] = 0x0;
-		config->cntr_ctrl[i] = 0x0;
-		config->cntr_val[i] = 0x0;
-	}
-
-	/* Resource selector pair 0 is always implemented and reserved */
-	config->res_idx = 0x2;
-	for (i = 2; i < drvdata->nr_resource * 2; i++)
-		config->res_ctrl[i] = 0x0;
+	config->vinst_ctrl |= BIT(9);
 
-	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
-		config->ss_ctrl[i] = 0x0;
-		config->ss_pe_cmp[i] = 0x0;
-	}
-
-	if (drvdata->nr_addr_cmp >= 1) {
-		config->addr_val[0] = (unsigned long)_stext;
-		config->addr_val[1] = (unsigned long)_etext;
-		config->addr_type[0] = ETM_ADDR_TYPE_RANGE;
-		config->addr_type[1] = ETM_ADDR_TYPE_RANGE;
-	}
-
-	for (i = 0; i < drvdata->numcidc; i++) {
-		config->ctxid_pid[i] = 0x0;
-		config->ctxid_vpid[i] = 0x0;
-	}
+	/*
+	 * Configure address range comparator '0' to encompass all
+	 * possible addresses.
+	 */
 
-	config->ctxid_mask0 = 0x0;
-	config->ctxid_mask1 = 0x0;
+	/* First half of default address comparator: start at address 0 */
+	config->addr_val[ETM_DEFAULT_ADDR_COMP] = 0x0;
+	/* trace instruction addresses */
+	config->addr_acc[ETM_DEFAULT_ADDR_COMP] &= ~(BIT(0) | BIT(1));
+	/* EXLEVEL_NS, bits[12:15], only trace application and kernel space */
+	config->addr_acc[ETM_DEFAULT_ADDR_COMP] |= ETM_EXLEVEL_NS_HYP;
+	/* EXLEVEL_S, bits[11:8], don't trace anything in secure state */
+	config->addr_acc[ETM_DEFAULT_ADDR_COMP] |= (ETM_EXLEVEL_S_APP |
+						    ETM_EXLEVEL_S_OS |
+						    ETM_EXLEVEL_S_HYP);
+	config->addr_type[ETM_DEFAULT_ADDR_COMP] = ETM_ADDR_TYPE_RANGE;
 
-	for (i = 0; i < drvdata->numvmidc; i++)
-		config->vmid_val[i] = 0x0;
-	config->vmid_mask0 = 0x0;
-	config->vmid_mask1 = 0x0;
+	/*
+	 * Second half of default address comparator: go all
+	 * the way to the top.
+	*/
+	config->addr_val[ETM_DEFAULT_ADDR_COMP + 1] = ~0x0;
+	/* trace instruction addresses */
+	config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] &= ~(BIT(0) | BIT(1));
+	/* Address comparator type must be equal for both halves */
+	config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] =
+					config->addr_acc[ETM_DEFAULT_ADDR_COMP];
+	config->addr_type[ETM_DEFAULT_ADDR_COMP + 1] = ETM_ADDR_TYPE_RANGE;
 
 	/*
-	 * A trace ID value of 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits.  ETMv3.x has 0x10 so let's
-	 * start at 0x20.
+	 * Configure the ViewInst function to filter on address range
+	 * comparator '0'.
 	 */
-	drvdata->trcid = 0x20 + drvdata->cpu;
+	config->viiectlr = BIT(0);
+
+	/* no start-stop filtering for ViewInst */
+	config->vissctlr = 0x0;
 }
 
 static int etm4_cpu_callback(struct notifier_block *nfb, unsigned long action,
@@ -568,6 +555,11 @@ static struct notifier_block etm4_cpu_notifier = {
 	.notifier_call = etm4_cpu_callback,
 };
 
+static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
+{
+	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
+}
+
 static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret;
@@ -627,7 +619,9 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = -EINVAL;
 		goto err_arch_supported;
 	}
-	etm4_init_default_data(drvdata);
+
+	etm4_init_trace_id(drvdata);
+	etm4_set_default(&drvdata->config);
 
 	pm_runtime_put(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 709d96e63910..6ff499bfb2f2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -178,6 +178,18 @@
 #define ETMv4_MODE_ALL			0xFFFFFFF
 
 #define TRCSTATR_IDLE_BIT		0
+#define ETM_DEFAULT_ADDR_COMP		0
+
+/* secure state access levels */
+#define ETM_EXLEVEL_S_APP		BIT(8)
+#define ETM_EXLEVEL_S_OS		BIT(9)
+#define ETM_EXLEVEL_S_NA		BIT(10)
+#define ETM_EXLEVEL_S_HYP		BIT(11)
+/* non-secure state access levels */
+#define ETM_EXLEVEL_NS_APP		BIT(12)
+#define ETM_EXLEVEL_NS_OS		BIT(13)
+#define ETM_EXLEVEL_NS_HYP		BIT(14)
+#define ETM_EXLEVEL_NS_NA		BIT(15)
 
 /**
  * struct etmv4_config - configuration information related to an ETMv4
-- 
2.1.4
