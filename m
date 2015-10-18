From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:24 -0600
Subject: [PATCH V2 07/30] coresight: etm3x: moving etm_drvdata::enable to
 atomic field
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving etm_drvdata::enable to an atomic type that gives the
'state' of the tracer, i.e disabled, handled via sysFS or Perf.
That way a tracer can't be used if it is already marshaled by
another subsystem.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h         | 11 +++++++++--
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c |  4 ++--
 drivers/hwtracing/coresight/coresight-etm3x.c       | 21 +++++++++++++++------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 9317510d555f..0996537ff142 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -13,6 +13,7 @@
 #ifndef _CORESIGHT_CORESIGHT_ETM_H
 #define _CORESIGHT_CORESIGHT_ETM_H
 
+#include <asm/local.h>
 #include <linux/spinlock.h>
 #include "coresight-priv.h"
 
@@ -214,7 +215,7 @@ struct etm_config {
  * @port_size:	port size as reported by ETMCR bit 4-6 and 21.
  * @arch:	ETM/PTM version number.
  * @use_cpu14:	true if management registers need to be accessed via CP14.
- * @enable:	is this ETM/PTM currently tracing.
+ * @state:	this tracer's state, i.e sysFS, Perf or disabled.
  * @sticky_enable: true if ETM base configuration has been done.
  * @boot_enable:true if we should start tracing at boot time.
  * @os_unlock:	true if access to management registers is allowed.
@@ -238,7 +239,7 @@ struct etm_drvdata {
 	int				port_size;
 	u8				arch;
 	bool				use_cp14;
-	bool				enable;
+	local_t				state;
 	bool				sticky_enable;
 	bool				boot_enable;
 	bool				os_unlock;
@@ -253,6 +254,12 @@ struct etm_drvdata {
 	struct etm_config		*config;
 };
 
+enum etm_state {
+	ETM_STATE_DISABLED,
+	ETM_STATE_SYSFS,
+	ETM_STATE_PERF,
+};
+
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
 	ETM_ADDR_TYPE_SINGLE,
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 410d29e2b90c..bc8f04214567 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -811,7 +811,7 @@ static ssize_t cntr_val_show(struct device *dev,
 	if (WARN_ON_ONCE(!config))
 		return -EINVAL;
 
-	if (!drvdata->enable) {
+	if (!local_read(&drvdata->state)) {
 		spin_lock(&drvdata->spinlock);
 		for (i = 0; i < drvdata->nr_cntr; i++)
 			ret += sprintf(buf, "counter %d: %x\n",
@@ -1072,7 +1072,7 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	if (WARN_ON_ONCE(!config))
 		return -EINVAL;
 
-	if (!drvdata->enable) {
+	if (!local_read(&drvdata->state)) {
 		val = config->seq_curr_state;
 		goto out;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 3d7fa0b2acf9..3fe6433764d4 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -320,7 +320,7 @@ int etm_get_trace_id(struct etm_drvdata *drvdata)
 	if (!drvdata)
 		goto out;
 
-	if (!drvdata->enable)
+	if (!local_read(&drvdata->state))
 		return drvdata->traceid;
 
 	pm_runtime_get_sync(drvdata->dev);
@@ -354,6 +354,12 @@ static int sysfs_etm_enable(struct coresight_device *csdev)
 	pm_runtime_get_sync(csdev->dev.parent);
 	spin_lock(&drvdata->spinlock);
 
+	if (local_cmpxchg(&drvdata->state,
+			  ETM_STATE_DISABLED, ETM_STATE_SYSFS)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/*
 	 * Configure the ETM only if the CPU is online.  If it isn't online
 	 * hw configuration will take place when 'CPU_STARTING' is received
@@ -366,17 +372,20 @@ static int sysfs_etm_enable(struct coresight_device *csdev)
 			goto err;
 	}
 
-	drvdata->enable = true;
 	drvdata->sticky_enable = true;
 
 	spin_unlock(&drvdata->spinlock);
 
 	dev_info(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
-err:
+out:
 	spin_unlock(&drvdata->spinlock);
 	pm_runtime_put(csdev->dev.parent);
 	return ret;
+
+err:
+	local_set(&drvdata->state, ETM_STATE_DISABLED);
+	goto out;
 }
 
 static void etm_disable_hw(void *info)
@@ -425,7 +434,7 @@ static void sysfs_etm_disable(struct coresight_device *csdev)
 	 * ensures that register writes occur when cpu is powered.
 	 */
 	smp_call_function_single(drvdata->cpu, etm_disable_hw, drvdata, 1);
-	drvdata->enable = false;
+	local_set(&drvdata->state, ETM_STATE_DISABLED);
 
 	spin_unlock(&drvdata->spinlock);
 	put_online_cpus();
@@ -460,7 +469,7 @@ static int etm_cpu_callback(struct notifier_block *nfb, unsigned long action,
 			etmdrvdata[cpu]->os_unlock = true;
 		}
 
-		if (etmdrvdata[cpu]->enable)
+		if (local_read(&etmdrvdata[cpu]->state))
 			etm_enable_hw(etmdrvdata[cpu]);
 		spin_unlock(&etmdrvdata[cpu]->spinlock);
 		break;
@@ -473,7 +482,7 @@ static int etm_cpu_callback(struct notifier_block *nfb, unsigned long action,
 
 	case CPU_DYING:
 		spin_lock(&etmdrvdata[cpu]->spinlock);
-		if (etmdrvdata[cpu]->enable)
+		if (local_read(&etmdrvdata[cpu]->state))
 			etm_disable_hw(etmdrvdata[cpu]);
 		spin_unlock(&etmdrvdata[cpu]->spinlock);
 		break;
-- 
1.9.1
