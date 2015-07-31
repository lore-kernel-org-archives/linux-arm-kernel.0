From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 31 Jul 2015 09:37:28 -0600
Subject: [PATCH 08/10] coresight-etm4x: Support context-ID tracing when PID
 namespace is enabled
In-Reply-To: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
References: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1438357050-22486-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chunyan Zhang <zhang.chunyan@linaro.org>

Like ETTv3, ETMv4 also needs the similar modifications to support Context
ID tracing when PID namespace is enabled.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 21 +++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 9afbda54b013..254a81a4e6f4 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -506,8 +506,11 @@ static ssize_t reset_store(struct device *dev,
 	}
 
 	drvdata->ctxid_idx = 0x0;
-	for (i = 0; i < drvdata->numcidc; i++)
+	for (i = 0; i < drvdata->numcidc; i++) {
 		drvdata->ctxid_pid[i] = 0x0;
+		drvdata->ctxid_vpid[i] = 0x0;
+	}
+
 	drvdata->ctxid_mask0 = 0x0;
 	drvdata->ctxid_mask1 = 0x0;
 
@@ -1825,7 +1828,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = drvdata->ctxid_idx;
-	val = (unsigned long)drvdata->ctxid_pid[idx];
+	val = (unsigned long)drvdata->ctxid_vpid[idx];
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1835,7 +1838,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 			       const char *buf, size_t size)
 {
 	u8 idx;
-	unsigned long val;
+	unsigned long vpid, pid;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	/*
@@ -1845,12 +1848,15 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	 */
 	if (!drvdata->ctxid_size || !drvdata->numcidc)
 		return -EINVAL;
-	if (kstrtoul(buf, 16, &val))
+	if (kstrtoul(buf, 16, &vpid))
 		return -EINVAL;
 
+	pid = coresight_vpid_to_pid(vpid);
+
 	spin_lock(&drvdata->spinlock);
 	idx = drvdata->ctxid_idx;
-	drvdata->ctxid_pid[idx] = (u64)val;
+	drvdata->ctxid_pid[idx] = (u64)pid;
+	drvdata->ctxid_vpid[idx] = (u64)vpid;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -2513,8 +2519,11 @@ static void etm4_init_default_data(struct etmv4_drvdata *drvdata)
 		drvdata->addr_type[1] = ETM_ADDR_TYPE_RANGE;
 	}
 
-	for (i = 0; i < drvdata->numcidc; i++)
+	for (i = 0; i < drvdata->numcidc; i++) {
 		drvdata->ctxid_pid[i] = 0x0;
+		drvdata->ctxid_vpid[i] = 0x0;
+	}
+
 	drvdata->ctxid_mask0 = 0x0;
 	drvdata->ctxid_mask1 = 0x0;
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 1e8fb369daaf..c34100205ca9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -266,6 +266,8 @@
  * @ctxid_idx:	Context ID index selector.
  * @ctxid_size:	Size of the context ID field to consider.
  * @ctxid_pid:	Value of the context ID comparator.
+ * @ctxid_vpid:	Virtual PID seen by users if PID namespace is enabled, otherwise
+ *		the same value of ctxid_pid.
  * @ctxid_mask0:Context ID comparator mask for comparator 0-3.
  * @ctxid_mask1:Context ID comparator mask for comparator 4-7.
  * @vmid_idx:	VM ID index selector.
@@ -353,6 +355,7 @@ struct etmv4_drvdata {
 	u8				ctxid_idx;
 	u8				ctxid_size;
 	u64				ctxid_pid[ETMv4_MAX_CTXID_CMP];
+	u64				ctxid_vpid[ETMv4_MAX_CTXID_CMP];
 	u32				ctxid_mask0;
 	u32				ctxid_mask1;
 	u8				vmid_idx;
-- 
1.9.1
