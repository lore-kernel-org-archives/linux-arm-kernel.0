From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 15 May 2018 11:13:35 -0600
Subject: [PATCH 1/3] coresight: etm3x: Don't use contextID with PID namespaces
In-Reply-To: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
References: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1526404417-32507-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tracers can trigger trace acquisition based on contextID value, something
that isn't useful when PID namespaces are enabled.  Indeed the PID value
of a process has a different representation in the kernel and the PID
namespace, making the feature confusing and potentially leaking internal
kernel information.

As such simply return an error when the feature is being used from a
PID namespace other than the default one.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h        |  3 --
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 43 +++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm3x.c      |  4 +-
 3 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index e8b4549e30e2..79e1ad860d8a 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -168,8 +168,6 @@
  * @seq_curr_state: current value of the sequencer register.
  * @ctxid_idx: index for the context ID registers.
  * @ctxid_pid: value for the context ID to trigger on.
- * @ctxid_vpid:	Virtual PID seen by users if PID namespace is enabled, otherwise
- *		the same value of ctxid_pid.
  * @ctxid_mask: mask applicable to all the context IDs.
  * @sync_freq:	Synchronisation frequency.
  * @timestamp_event: Defines an event that requests the insertion
@@ -202,7 +200,6 @@ struct etm_config {
 	u32				seq_curr_state;
 	u8				ctxid_idx;
 	u32				ctxid_pid[ETM_MAX_CTXID_CMP];
-	u32				ctxid_vpid[ETM_MAX_CTXID_CMP];
 	u32				ctxid_mask;
 	u32				sync_freq;
 	u32				timestamp_event;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 9435c1481f61..75487b3fad86 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/pid_namespace.h>
 #include <linux/pm_runtime.h>
 #include <linux/sysfs.h>
 #include "coresight-etm.h"
@@ -1025,8 +1026,15 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
+	/*
+	 * Don't use contextID tracing if coming from a PID namespace.  See
+	 * comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
 	spin_lock(&drvdata->spinlock);
-	val = config->ctxid_vpid[config->ctxid_idx];
+	val = config->ctxid_pid[config->ctxid_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -1037,19 +1045,28 @@ static ssize_t ctxid_pid_store(struct device *dev,
 			       const char *buf, size_t size)
 {
 	int ret;
-	unsigned long vpid, pid;
+	unsigned long pid;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	ret = kstrtoul(buf, 16, &vpid);
+	/*
+	 * When contextID tracing is enabled the tracers will insert the
+	 * value found in the contextID register in the trace stream.  But if
+	 * a process is in a namespace the PID of that process as seen from the
+	 * namespace won't be what the kernel sees, something that makes the
+	 * feature confusing and can potentially leak kernel only information.
+	 * As such refuse to use the feature if @current is not in the initial
+	 * PID namespace.
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
+	ret = kstrtoul(buf, 16, &pid);
 	if (ret)
 		return ret;
 
-	pid = coresight_vpid_to_pid(vpid);
-
 	spin_lock(&drvdata->spinlock);
 	config->ctxid_pid[config->ctxid_idx] = pid;
-	config->ctxid_vpid[config->ctxid_idx] = vpid;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -1063,6 +1080,13 @@ static ssize_t ctxid_mask_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
+	/*
+	 * Don't use contextID tracing if coming from a PID namespace.  See
+	 * comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
 	val = config->ctxid_mask;
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -1076,6 +1100,13 @@ static ssize_t ctxid_mask_store(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
+	/*
+	 * Don't use contextID tracing if coming from a PID namespace.  See
+	 * comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 15ed64d51a5b..7c74263c333d 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -230,10 +230,8 @@ void etm_set_default(struct etm_config *config)
 
 	config->seq_curr_state = 0x0;
 	config->ctxid_idx = 0x0;
-	for (i = 0; i < ETM_MAX_CTXID_CMP; i++) {
+	for (i = 0; i < ETM_MAX_CTXID_CMP; i++)
 		config->ctxid_pid[i] = 0x0;
-		config->ctxid_vpid[i] = 0x0;
-	}
 
 	config->ctxid_mask = 0x0;
 	/* Setting default to 1024 as per TRM recommendation */
-- 
2.7.4
