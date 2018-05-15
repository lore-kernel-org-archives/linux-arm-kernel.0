From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 15 May 2018 11:13:36 -0600
Subject: [PATCH 2/3] coresight: etm4x: Don't use contextID with PID namespaces
In-Reply-To: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
References: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1526404417-32507-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As with ETM3x, the ETM4x tracers can trigger trace acquisition based on
contextID value, something that isn't useful when PID namespaces are
enabled.  Indeed the PID value of a process has a different representation
in the kernel and the PID namespace, making the feature confusing and
potentially leaking internal kernel information.

As such simply return an error when the feature is being used from a
PID namespace other than the default one.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 47 +++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h      |  3 --
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 4eb8da785ce0..a0365e23678e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/pid_namespace.h>
 #include <linux/pm_runtime.h>
 #include <linux/sysfs.h>
 #include "coresight-etm4x.h"
@@ -250,10 +251,8 @@ static ssize_t reset_store(struct device *dev,
 	}
 
 	config->ctxid_idx = 0x0;
-	for (i = 0; i < drvdata->numcidc; i++) {
+	for (i = 0; i < drvdata->numcidc; i++)
 		config->ctxid_pid[i] = 0x0;
-		config->ctxid_vpid[i] = 0x0;
-	}
 
 	config->ctxid_mask0 = 0x0;
 	config->ctxid_mask1 = 0x0;
@@ -1637,9 +1636,16 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	/*
+	 * Don't use contextID tracing if coming from a PID namespace.  See
+	 * comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
 	spin_lock(&drvdata->spinlock);
 	idx = config->ctxid_idx;
-	val = (unsigned long)config->ctxid_vpid[idx];
+	val = (unsigned long)config->ctxid_pid[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1649,26 +1655,35 @@ static ssize_t ctxid_pid_store(struct device *dev,
 			       const char *buf, size_t size)
 {
 	u8 idx;
-	unsigned long vpid, pid;
+	unsigned long pid;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
 	/*
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
+	/*
 	 * only implemented when ctxid tracing is enabled, i.e. at least one
 	 * ctxid comparator is implemented and ctxid is greater than 0 bits
 	 * in length
 	 */
 	if (!drvdata->ctxid_size || !drvdata->numcidc)
 		return -EINVAL;
-	if (kstrtoul(buf, 16, &vpid))
+	if (kstrtoul(buf, 16, &pid))
 		return -EINVAL;
 
-	pid = coresight_vpid_to_pid(vpid);
-
 	spin_lock(&drvdata->spinlock);
 	idx = config->ctxid_idx;
 	config->ctxid_pid[idx] = (u64)pid;
-	config->ctxid_vpid[idx] = (u64)vpid;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1682,6 +1697,13 @@ static ssize_t ctxid_masks_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	/*
+	 * Don't use contextID tracing if coming from a PID namespace.  See
+	 * comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
 	spin_lock(&drvdata->spinlock);
 	val1 = config->ctxid_mask0;
 	val2 = config->ctxid_mask1;
@@ -1699,6 +1721,13 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	/*
+	 * Don't use contextID tracing if coming from a PID namespace.  See
+	 * comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
+	/*
 	 * only implemented when ctxid tracing is enabled, i.e. at least one
 	 * ctxid comparator is implemented and ctxid is greater than 0 bits
 	 * in length
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index b7c4a6f6c6b9..52786e9d8926 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -230,8 +230,6 @@
  * @addr_type:	Current status of the comparator register.
  * @ctxid_idx:	Context ID index selector.
  * @ctxid_pid:	Value of the context ID comparator.
- * @ctxid_vpid:	Virtual PID seen by users if PID namespace is enabled, otherwise
- *		the same value of ctxid_pid.
  * @ctxid_mask0:Context ID comparator mask for comparator 0-3.
  * @ctxid_mask1:Context ID comparator mask for comparator 4-7.
  * @vmid_idx:	VM ID index selector.
@@ -274,7 +272,6 @@ struct etmv4_config {
 	u8				addr_type[ETM_MAX_SINGLE_ADDR_CMP];
 	u8				ctxid_idx;
 	u64				ctxid_pid[ETMv4_MAX_CTXID_CMP];
-	u64				ctxid_vpid[ETMv4_MAX_CTXID_CMP];
 	u32				ctxid_mask0;
 	u32				ctxid_mask1;
 	u8				vmid_idx;
-- 
2.7.4
