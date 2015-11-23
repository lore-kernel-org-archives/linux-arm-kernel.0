From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 23 Nov 2015 11:33:07 -0700
Subject: [RESEND PATCH V4 15/26] coresight: etm3x: implementing
 perf_enable/disable() API
In-Reply-To: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
References: <1448303598-11249-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1448303598-11249-16-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That way traces can be enabled and disabled automatically
from the Perf subystem using the PMU abstraction.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 47 ++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index dd319ef0f1ac..4ff3e1419fde 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -372,8 +372,10 @@ static void etm_enable_hw(void *info)
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
@@ -413,9 +415,6 @@ static void etm_enable_hw(void *info)
 	/* No VMID comparator value selected */
 	etm_writel(drvdata, 0x0, ETMVMIDCVR);
 
-	/* Ensures trace output is enabled from this ETM */
-	etm_writel(drvdata, config->ctrl | ETMCR_ETM_EN | etmcr, ETMCR);
-
 	etm_clr_prog(drvdata);
 	CS_LOCK(drvdata->base);
 
@@ -488,6 +487,18 @@ static void etm_set_config(struct coresight_device *csdev, void *config)
 	drvdata->config = config;
 }
 
+static int etm_enable_perf(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
+		return -EINVAL;
+
+	etm_enable_hw(drvdata);
+
+	return 0;
+}
+
 static int etm_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -534,6 +545,9 @@ static int etm_enable(struct coresight_device *csdev, u32 mode)
 	case CS_MODE_SYSFS:
 		ret = etm_enable_sysfs(csdev);
 		break;
+	case CS_MODE_PERF:
+		ret = etm_enable_perf(csdev);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -573,6 +587,28 @@ static void etm_disable_hw(void *info)
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
+static void etm_disable_perf(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
+		return;
+
+	CS_UNLOCK(drvdata->base);
+
+	/* Setting the prog bit disables tracing immediately */
+	etm_set_prog(drvdata);
+	/* Get ready for another session */
+	drvdata->config = NULL;
+	/*
+	 * There is no way to know when the tracer will be used again so
+	 * power down the tracer.
+	 */
+	etm_set_pwrdwn(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
 static void etm_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -616,6 +652,9 @@ static void etm_disable(struct coresight_device *csdev)
 	case CS_MODE_SYSFS:
 		etm_disable_sysfs(csdev);
 		break;
+	case CS_MODE_PERF:
+		etm_disable_perf(csdev);
+		break;
 	default:
 		WARN_ON_ONCE(mode);
 		return;
-- 
1.9.1
