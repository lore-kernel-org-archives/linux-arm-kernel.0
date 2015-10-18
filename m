From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:30 -0600
Subject: [PATCH V2 13/30] coresight: etm3x: implementing perf_enable/disable()
 API
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-14-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That way traces can be enable and disabled automatically
from the Perf subystem using the PMU abstraction.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 50 ++++++++++++++++++++++++---
 include/linux/coresight.h                     |  4 +++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 0994bf0a8334..f565554744fe 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -369,8 +369,10 @@ static void etm_enable_hw(void *info)
 	etm_set_prog(drvdata);
 
 	etmcr = etm_readl(drvdata, ETMCR);
-	etmcr &= (ETMCR_PWD_DWN | ETMCR_ETM_PRG);
+	/* Clear setting from a previous run if need be */
+	etmcr &= ~ETM3X_SUPPORTED_OPTIONS;
 	etmcr |= drvdata->port_size;
+	etmcr |= ETMCR_ETM_EN;
 	etm_writel(drvdata, config->ctrl | etmcr, ETMCR);
 	etm_writel(drvdata, config->trigger_event, ETMTRIGGER);
 	etm_writel(drvdata, config->startstop_ctrl, ETMTSSCR);
@@ -410,9 +412,6 @@ static void etm_enable_hw(void *info)
 	/* No VMID comparator value selected */
 	etm_writel(drvdata, 0x0, ETMVMIDCVR);
 
-	/* Ensures trace output is enabled from this ETM */
-	etm_writel(drvdata, config->ctrl | ETMCR_ETM_EN | etmcr, ETMCR);
-
 	etm_clr_prog(drvdata);
 	CS_LOCK(drvdata->base);
 
@@ -485,6 +484,47 @@ static void perf_etm_set_config(struct coresight_device *csdev, void *config)
 	drvdata->config = config;
 }
 
+static int perf_etm_enable(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
+		return -EINVAL;
+
+	if (local_cmpxchg(&drvdata->state,
+			  ETM_STATE_DISABLED, ETM_STATE_PERF))
+		return -EBUSY;
+
+	etm_enable_hw(drvdata);
+
+	return 0;
+}
+
+static int perf_etm_disable(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
+		return -EINVAL;
+
+	CS_UNLOCK(drvdata->base);
+
+	/* setting the prog bit disables tracing immediately */
+	etm_set_prog(drvdata);
+	/* Get ready for another session */
+	drvdata->config = NULL;
+	/*
+	 * There is no way to know when the tracer will be used again so
+	 * power down the tracer.
+	 */
+	etm_set_pwrdwn(drvdata);
+	local_set(&drvdata->state, ETM_STATE_DISABLED);
+
+	CS_LOCK(drvdata->base);
+
+	return 0;
+}
+
 static int sysfs_etm_enable(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -587,6 +627,8 @@ static const struct coresight_ops_source etm_source_ops = {
 	.trace_id		= etm_trace_id,
 	.perf_get_config	= perf_etm_get_config,
 	.perf_set_config	= perf_etm_set_config,
+	.perf_enable		= perf_etm_enable,
+	.perf_disable		= perf_etm_disable,
 	.sysfs_enable		= sysfs_etm_enable,
 	.sysfs_disable		= sysfs_etm_disable,
 };
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 32463da877eb..b853d722346b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -211,6 +211,8 @@ struct coresight_ops_link {
 			to the HW.
  * @perf_get_config:	builds the ETM configuration after event' specifics.
  * @perf_set_config:	associate a tracer with a configuration..
+ * @perf_enable:	enables tracing for a source, from Perf.
+ * @perf_disable:	disables tracing for a source, from Perf.
  * @sysfs_enable:	enables tracing for a source, from sysFS.
  * @sysfs_disable:	disables tracing for a source, from sysFS.
  */
@@ -220,6 +222,8 @@ struct coresight_ops_source {
 	void *(*perf_get_config)(struct coresight_device *csdev,
 				 struct perf_event *event);
 	void (*perf_set_config)(struct coresight_device *csdev, void *config);
+	int (*perf_enable)(struct coresight_device *csdev);
+	int (*perf_disable)(struct coresight_device *csdev);
 	int (*sysfs_enable)(struct coresight_device *csdev);
 	void (*sysfs_disable)(struct coresight_device *csdev);
 };
-- 
1.9.1
