From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 29 Nov 2015 19:14:28 -0700
Subject: [PATCH V5 07/26] coresight: moving PM runtime operations to core
 framework
In-Reply-To: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
References: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1448849687-5724-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving PM runtime operations in Coresight devices enable() and
disable() API to the framework core when a path is setup.  That
way the runtime core doesn't have to be involved everytime a
path is enabled.  It also avoids calling runtime PM operations
in IRQ context.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c           | 4 ----
 drivers/hwtracing/coresight/coresight-etm3x.c           | 3 ---
 drivers/hwtracing/coresight/coresight-etm4x.c           | 6 ------
 drivers/hwtracing/coresight/coresight-funnel.c          | 2 --
 drivers/hwtracing/coresight/coresight-replicator-qcom.c | 4 ----
 drivers/hwtracing/coresight/coresight-replicator.c      | 2 --
 drivers/hwtracing/coresight/coresight-tmc.c             | 5 -----
 drivers/hwtracing/coresight/coresight-tpiu.c            | 2 --
 drivers/hwtracing/coresight/coresight.c                 | 9 ++++++++-
 9 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 77d0f9c1118d..1301edc44629 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -137,8 +137,6 @@ static int etb_enable(struct coresight_device *csdev)
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	unsigned long flags;
 
-	pm_runtime_get_sync(drvdata->dev);
-
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	etb_enable_hw(drvdata);
 	drvdata->enable = true;
@@ -247,8 +245,6 @@ static void etb_disable(struct coresight_device *csdev)
 	drvdata->enable = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	pm_runtime_put(drvdata->dev);
-
 	dev_info(drvdata->dev, "ETB disabled\n");
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 9ee692a5c482..f3c9846d0f7f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -358,7 +358,6 @@ static int etm_enable(struct coresight_device *csdev)
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
 
-	pm_runtime_get_sync(csdev->dev.parent);
 	spin_lock(&drvdata->spinlock);
 
 	/*
@@ -382,7 +381,6 @@ static int etm_enable(struct coresight_device *csdev)
 	return 0;
 err:
 	spin_unlock(&drvdata->spinlock);
-	pm_runtime_put(csdev->dev.parent);
 	return ret;
 }
 
@@ -439,7 +437,6 @@ static void etm_disable(struct coresight_device *csdev)
 
 	spin_unlock(&drvdata->spinlock);
 	put_online_cpus();
-	pm_runtime_put(csdev->dev.parent);
 
 	dev_info(drvdata->dev, "ETM tracing disabled\n");
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index a6707642bb23..1c6e32dd6e49 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -72,7 +72,6 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	if (!drvdata->enable)
 		return drvdata->trcid;
 
-	pm_runtime_get_sync(drvdata->dev);
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	CS_UNLOCK(drvdata->base);
@@ -81,7 +80,6 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	CS_LOCK(drvdata->base);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(drvdata->dev);
 
 	return trace_id;
 }
@@ -187,7 +185,6 @@ static int etm4_enable(struct coresight_device *csdev)
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
 
-	pm_runtime_get_sync(drvdata->dev);
 	spin_lock(&drvdata->spinlock);
 
 	/*
@@ -207,7 +204,6 @@ static int etm4_enable(struct coresight_device *csdev)
 	return 0;
 err:
 	spin_unlock(&drvdata->spinlock);
-	pm_runtime_put(drvdata->dev);
 	return ret;
 }
 
@@ -256,8 +252,6 @@ static void etm4_disable(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	put_online_cpus();
 
-	pm_runtime_put(drvdata->dev);
-
 	dev_info(drvdata->dev, "ETM tracing disabled\n");
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 2e36bde7fcb4..a47bba361833 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -69,7 +69,6 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	pm_runtime_get_sync(drvdata->dev);
 	funnel_enable_hw(drvdata, inport);
 
 	dev_info(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
@@ -95,7 +94,6 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	funnel_disable_hw(drvdata, inport);
-	pm_runtime_put(drvdata->dev);
 
 	dev_info(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
 }
diff --git a/drivers/hwtracing/coresight/coresight-replicator-qcom.c b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
index 584059e9e866..8149087e8966 100644
--- a/drivers/hwtracing/coresight/coresight-replicator-qcom.c
+++ b/drivers/hwtracing/coresight/coresight-replicator-qcom.c
@@ -48,8 +48,6 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	pm_runtime_get_sync(drvdata->dev);
-
 	CS_UNLOCK(drvdata->base);
 
 	/*
@@ -86,8 +84,6 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
-	pm_runtime_put(drvdata->dev);
-
 	dev_info(drvdata->dev, "REPLICATOR disabled\n");
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 963ac197c253..a0fbb2e05389 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -41,7 +41,6 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	pm_runtime_get_sync(drvdata->dev);
 	dev_info(drvdata->dev, "REPLICATOR enabled\n");
 	return 0;
 }
@@ -51,7 +50,6 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	pm_runtime_put(drvdata->dev);
 	dev_info(drvdata->dev, "REPLICATOR disabled\n");
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index a57c7ec1661f..5e2a71767870 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -242,12 +242,9 @@ static int tmc_enable(struct tmc_drvdata *drvdata, enum tmc_mode mode)
 {
 	unsigned long flags;
 
-	pm_runtime_get_sync(drvdata->dev);
-
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-		pm_runtime_put(drvdata->dev);
 		return -EBUSY;
 	}
 
@@ -381,8 +378,6 @@ out:
 	drvdata->enable = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	pm_runtime_put(drvdata->dev);
-
 	dev_info(drvdata->dev, "TMC disabled\n");
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 7214efd10db5..e19b86e61c38 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -74,7 +74,6 @@ static int tpiu_enable(struct coresight_device *csdev)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	pm_runtime_get_sync(csdev->dev.parent);
 	tpiu_enable_hw(drvdata);
 
 	dev_info(drvdata->dev, "TPIU enabled\n");
@@ -98,7 +97,6 @@ static void tpiu_disable(struct coresight_device *csdev)
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	tpiu_disable_hw(drvdata);
-	pm_runtime_put(csdev->dev.parent);
 
 	dev_info(drvdata->dev, "TPIU disabled\n");
 }
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 74beba461aa2..e63e42410ad2 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -24,6 +24,7 @@
 #include <linux/coresight.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include "coresight-priv.h"
 
@@ -361,7 +362,8 @@ out:
 	/*
 	 * A path from this element to a sink has been found.  The elements
 	 * leading to the sink are already enqueued, all that is left to do
-	 * is add a node for this element.
+	 * is tell the PM runtime core we need this element and add a node
+	 * for it.
 	 */
 	node = kzalloc(sizeof(struct coresight_node), GFP_KERNEL);
 	if (!node)
@@ -369,6 +371,7 @@ out:
 
 	node->csdev = csdev;
 	list_add(&node->link, path);
+	pm_runtime_get_sync(csdev->dev.parent);
 
 	return 0;
 }
@@ -400,9 +403,13 @@ struct list_head *coresight_build_path(struct coresight_device *csdev)
  */
 void coresight_release_path(struct list_head *path)
 {
+	struct coresight_device *csdev;
 	struct coresight_node *nd, *next;
 
 	list_for_each_entry_safe(nd, next, path, link) {
+		csdev = nd->csdev;
+
+		pm_runtime_put_sync(csdev->dev.parent);
 		list_del(&nd->link);
 		kfree(nd);
 	}
-- 
2.1.4
