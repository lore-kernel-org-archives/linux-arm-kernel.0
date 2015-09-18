From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:15 -0600
Subject: [RFC PATCH 01/20] coresight: etm3x: splitting 'etm_enable_hw()'
 operations
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When dealing with other kernel subsystems or automated tools it
is desirable to split the current etm_enable_hw() operation
in three: power up, configuration and enabling of the tracer.

That way it is possible to have more control on the operations
done by a tracer.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 167 +++++++++++++++++++++-----
 include/linux/coresight.h                     |  10 +-
 2 files changed, 146 insertions(+), 31 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index d630b7ece735..999c62a59c70 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -247,11 +247,12 @@ static void etm_set_default(struct etm_drvdata *drvdata)
 	drvdata->ctxid_mask = 0x0;
 }
 
-static void etm_enable_hw(void *info)
+static void etm_power_up_cpu(void *info)
 {
-	int i;
-	u32 etmcr;
-	struct etm_drvdata *drvdata = info;
+	struct coresight_device *csdev = info;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	WARN_ON(drvdata->cpu != smp_processor_id());
 
 	CS_UNLOCK(drvdata->base);
 
@@ -262,10 +263,65 @@ static void etm_enable_hw(void *info)
 	/* Make sure all registers are accessible */
 	etm_os_unlock(drvdata);
 
+	CS_LOCK(drvdata->base);
+}
+
+static int etm_power_up(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	/* tell the core we need this tracer */
+	pm_runtime_get_sync(csdev->dev.parent);
+
+	return smp_call_function_single(drvdata->cpu,
+					etm_power_up_cpu, csdev, 1);
+}
+
+static void etm_power_down_cpu(void *info)
+{
+	struct coresight_device *csdev = info;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	WARN_ON(drvdata->cpu != smp_processor_id());
+
+	CS_UNLOCK(drvdata->base);
+	etm_clr_pwrup(drvdata);
+	etm_set_pwrdwn(drvdata);
+	CS_LOCK(drvdata->base);
+}
+
+static void etm_power_down(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	smp_call_function_single(drvdata->cpu,
+				 etm_power_down_cpu, csdev, 1);
+
+	/* tell the core this tracer is no longer needed */
+	pm_runtime_put(csdev->dev.parent);
+}
+
+/**
+ * etm_configure_cpu - configure ETM registers
+ * @csdev - the etm that needs to be configure.
+ *
+ * Applies a configuration set to the ETM registers _without_ enabling the
+ * tracer.  This function needs to be executed on the CPU who's tracer is
+ * being configured.
+ */
+static void etm_configure_cpu(void *info)
+{
+	int i;
+	u32 etmcr;
+	struct coresight_device *csdev = info;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	WARN_ON(drvdata->cpu != smp_processor_id());
+
+	CS_UNLOCK(drvdata->base);
 	etm_set_prog(drvdata);
 
 	etmcr = etm_readl(drvdata, ETMCR);
-	etmcr &= (ETMCR_PWD_DWN | ETMCR_ETM_PRG);
 	etmcr |= drvdata->port_size;
 	etm_writel(drvdata, drvdata->ctrl | etmcr, ETMCR);
 	etm_writel(drvdata, drvdata->trigger_event, ETMTRIGGER);
@@ -306,13 +362,71 @@ static void etm_enable_hw(void *info)
 	/* No VMID comparator value selected */
 	etm_writel(drvdata, 0x0, ETMVMIDCVR);
 
-	/* Ensures trace output is enabled from this ETM */
-	etm_writel(drvdata, drvdata->ctrl | ETMCR_ETM_EN | etmcr, ETMCR);
+	etm_clr_prog(drvdata);
+	CS_LOCK(drvdata->base);
+}
+
+static int etm_configure(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	return smp_call_function_single(drvdata->cpu,
+					etm_configure_cpu, csdev, 1);
+}
+
+/**
+ * etm_trace_enable - enable ETM tracer
+ * @csdev	- the etm that needs to be enabled/disabled.
+ * @enable	- whether to enable or disable the tracer.
+ *
+ * Only enables the tracer - register configuration should have been made
+ * prior to calling this function.  This should be executed on the CPU who's
+ * tracer is being enabled.
+ */
+static int etm_trace_enable(struct coresight_device *csdev, bool enable)
+{
+	u32 etmcr;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	WARN_ON(drvdata->cpu != smp_processor_id());
+
+	/*
+	 * It is assumed that etm_configure_cpu() has been called.  As such
+	 * the ETM should be turned on, power applied to the trace registers
+	 * and all registers accessible.
+	 */
+	CS_UNLOCK(drvdata->base);
+	etm_set_prog(drvdata);
+
+	etmcr = etm_readl(drvdata, ETMCR);
+
+	enable ? (etmcr |= ETMCR_ETM_EN) :
+		 (etmcr &= ~ETMCR_ETM_EN);
+
+	etm_writel(drvdata, ETMCR_ETM_EN | etmcr, ETMCR);
 
 	etm_clr_prog(drvdata);
 	CS_LOCK(drvdata->base);
 
+	return 0;
+}
+
+static void etm_config_enable(void *info)
+{
+	struct coresight_device *csdev = info;
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock(&drvdata->spinlock);
+
+	etm_power_up_cpu(csdev);
+	etm_configure_cpu(csdev);
+	etm_trace_enable(csdev, true);
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+
+	drvdata->enable = true;
+	drvdata->sticky_enable = true;
+
+	spin_unlock(&drvdata->spinlock);
 }
 
 static int etm_trace_id(struct coresight_device *csdev)
@@ -339,11 +453,8 @@ static int etm_trace_id(struct coresight_device *csdev)
 
 static int etm_enable(struct coresight_device *csdev)
 {
-	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
-
-	pm_runtime_get_sync(csdev->dev.parent);
-	spin_lock(&drvdata->spinlock);
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	/*
 	 * Configure the ETM only if the CPU is online.  If it isn't online
@@ -352,34 +463,28 @@ static int etm_enable(struct coresight_device *csdev)
 	 */
 	if (cpu_online(drvdata->cpu)) {
 		ret = smp_call_function_single(drvdata->cpu,
-					       etm_enable_hw, drvdata, 1);
+					       etm_config_enable, csdev, 1);
 		if (ret)
 			goto err;
 	}
 
-	drvdata->enable = true;
-	drvdata->sticky_enable = true;
-
-	spin_unlock(&drvdata->spinlock);
-
 	dev_info(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
 err:
-	spin_unlock(&drvdata->spinlock);
-	pm_runtime_put(csdev->dev.parent);
 	return ret;
 }
 
-static void etm_disable_hw(void *info)
+static void etm_disable_powerdown(void *info)
 {
 	int i;
 	struct etm_drvdata *drvdata = info;
 
+	spin_lock(&drvdata->spinlock);
 	CS_UNLOCK(drvdata->base);
 	etm_set_prog(drvdata);
 
-	/* Program trace enable to low by using always false event */
-	etm_writel(drvdata, ETM_HARD_WIRE_RES_A | ETM_EVENT_NOT_A, ETMTEEVR);
+	etm_trace_enable(drvdata->csdev, false);
+	drvdata->enable = false;
 
 	/* Read back sequencer and counters for post trace analysis */
 	drvdata->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
@@ -387,8 +492,9 @@ static void etm_disable_hw(void *info)
 	for (i = 0; i < drvdata->nr_cntr; i++)
 		drvdata->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
-	etm_set_pwrdwn(drvdata);
+	etm_power_down(drvdata->csdev);
 	CS_LOCK(drvdata->base);
+	spin_unlock(&drvdata->spinlock);
 
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
 }
@@ -404,26 +510,27 @@ static void etm_disable(struct coresight_device *csdev)
 	 * DYING hotplug callback is serviced by the ETM driver.
 	 */
 	get_online_cpus();
-	spin_lock(&drvdata->spinlock);
 
 	/*
 	 * Executing etm_disable_hw on the cpu whose ETM is being disabled
 	 * ensures that register writes occur when cpu is powered.
 	 */
-	smp_call_function_single(drvdata->cpu, etm_disable_hw, drvdata, 1);
-	drvdata->enable = false;
+	smp_call_function_single(drvdata->cpu,
+				 etm_disable_powerdown, drvdata, 1);
 
-	spin_unlock(&drvdata->spinlock);
 	put_online_cpus();
-	pm_runtime_put(csdev->dev.parent);
 
 	dev_info(drvdata->dev, "ETM tracing disabled\n");
 }
 
 static const struct coresight_ops_source etm_source_ops = {
 	.trace_id	= etm_trace_id,
+	.configure	= etm_configure,
+	.trace_enable	= etm_trace_enable,
 	.enable		= etm_enable,
 	.disable	= etm_disable,
+	.poweron	= etm_power_up,
+	.poweroff	= etm_power_down,
 };
 
 static const struct coresight_ops etm_cs_ops = {
@@ -1659,7 +1766,7 @@ static int etm_cpu_callback(struct notifier_block *nfb, unsigned long action,
 		}
 
 		if (etmdrvdata[cpu]->enable)
-			etm_enable_hw(etmdrvdata[cpu]);
+			etm_config_enable(etmdrvdata[cpu]->csdev);
 		spin_unlock(&etmdrvdata[cpu]->spinlock);
 		break;
 
@@ -1672,7 +1779,7 @@ static int etm_cpu_callback(struct notifier_block *nfb, unsigned long action,
 	case CPU_DYING:
 		spin_lock(&etmdrvdata[cpu]->spinlock);
 		if (etmdrvdata[cpu]->enable)
-			etm_disable_hw(etmdrvdata[cpu]);
+			etm_disable_powerdown(etmdrvdata[cpu]->csdev);
 		spin_unlock(&etmdrvdata[cpu]->spinlock);
 		break;
 	}
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a7cabfa23b55..70f3dafa5194 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -206,14 +206,22 @@ struct coresight_ops_link {
  * struct coresight_ops_source - basic operations for a source
  * Operations available for sources.
  * @trace_id:	returns the value of the component's trace ID as known
-		to the HW.
+ *		to the HW.
+ * @configure:	performs configuration for a source but doesn't enable it.
+ * @trace_enable: enable/disable tracing on a source.
  * @enable:	enables tracing for a source.
  * @disable:	disables tracing for a source.
+ * @poweron:	switch on power to a source.
+ * @poweroff:	switch off power to a source.
  */
 struct coresight_ops_source {
 	int (*trace_id)(struct coresight_device *csdev);
+	int (*configure)(struct coresight_device *csdev);
+	int (*trace_enable)(struct coresight_device *csdev, bool enable);
 	int (*enable)(struct coresight_device *csdev);
 	void (*disable)(struct coresight_device *csdev);
+	int (*poweron)(struct coresight_device *csdev);
+	void (*poweroff)(struct coresight_device *csdev);
 };
 
 struct coresight_ops {
-- 
1.9.1
