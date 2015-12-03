From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu,  3 Dec 2015 14:04:51 -0700
Subject: [PATCH V6 15/26] coresight: etm3x: implementing perf_enable/disable()
 API
In-Reply-To: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
References: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1449176702-13213-16-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That way traces can be enabled and disabled automatically
from the Perf subystem using the PMU abstraction.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 47 ++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index cda28e0211f5..fbd04979e21c 100644
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
 
@@ -495,6 +494,18 @@ static void etm_set_config(struct coresight_device *csdev, void *config)
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
@@ -541,6 +552,9 @@ static int etm_enable(struct coresight_device *csdev, u32 mode)
 	case CS_MODE_SYSFS:
 		ret = etm_enable_sysfs(csdev);
 		break;
+	case CS_MODE_PERF:
+		ret = etm_enable_perf(csdev);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -579,6 +593,28 @@ static void etm_disable_hw(void *info)
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
@@ -624,6 +660,9 @@ static void etm_disable(struct coresight_device *csdev)
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
2.1.4
