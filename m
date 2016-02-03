From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  3 Feb 2016 11:39:01 -0700
Subject: [PATCH V9 03/18] coresight: moving PM runtime operations to core
 framework
In-Reply-To: <1454524756-10628-1-git-send-email-mathieu.poirier@linaro.org>
References: <1454524756-10628-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1454524756-10628-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving PM runtime operations in Coresight devices enable() and
disable() API to the framework core when a path is setup.  That
way the runtime core doesn't have to be involved everytime a
path is enabled.  It also avoids calling runtime PM operations
in IRQ context.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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
index 92969dae739d..917562ecf82a 100644
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
index aae80e14508d..fe6791e0c66c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -349,7 +349,6 @@ static int etm_enable(struct coresight_device *csdev)
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
 
-	pm_runtime_get_sync(csdev->dev.parent);
 	spin_lock(&drvdata->spinlock);
 
 	/*
@@ -373,7 +372,6 @@ static int etm_enable(struct coresight_device *csdev)
 	return 0;
 err:
 	spin_unlock(&drvdata->spinlock);
-	pm_runtime_put(csdev->dev.parent);
 	return ret;
 }
 
@@ -422,7 +420,6 @@ static void etm_disable(struct coresight_device *csdev)
 
 	spin_unlock(&drvdata->spinlock);
 	put_online_cpus();
-	pm_runtime_put(csdev->dev.parent);
 
 	dev_info(drvdata->dev, "ETM tracing disabled\n");
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index d6a92c6d3a66..c2f518fbc9a8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -79,7 +79,6 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	if (!drvdata->enable)
 		return drvdata->trcid;
 
-	pm_runtime_get_sync(drvdata->dev);
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	CS_UNLOCK(drvdata->base);
@@ -88,7 +87,6 @@ static int etm4_trace_id(struct coresight_device *csdev)
 	CS_LOCK(drvdata->base);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(drvdata->dev);
 
 	return trace_id;
 }
@@ -194,7 +192,6 @@ static int etm4_enable(struct coresight_device *csdev)
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret;
 
-	pm_runtime_get_sync(drvdata->dev);
 	spin_lock(&drvdata->spinlock);
 
 	/*
@@ -214,7 +211,6 @@ static int etm4_enable(struct coresight_device *csdev)
 	return 0;
 err:
 	spin_unlock(&drvdata->spinlock);
-	pm_runtime_put(drvdata->dev);
 	return ret;
 }
 
@@ -263,8 +259,6 @@ static void etm4_disable(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	put_online_cpus();
 
-	pm_runtime_put(drvdata->dev);
-
 	dev_info(drvdata->dev, "ETM tracing disabled\n");
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 25e8ea140a09..fb2c679fbc44 100644
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
index 444815179460..286f90b50989 100644
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
index b77d700a3f0e..0ce98903992c 100644
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
index c4fa70ed14ce..b526396d80b6 100644
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
index ca50e73d9df7..0d8fce651ff7 100644
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
index 2ed48545df26..6b44928c1076 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -24,6 +24,7 @@
 #include <linux/coresight.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include "coresight-priv.h"
 
@@ -376,7 +377,8 @@ out:
 	/*
 	 * A path from this element to a sink has been found.  The elements
 	 * leading to the sink are already enqueued, all that is left to do
-	 * is add a node for this element.
+	 * is tell the PM runtime core we need this element and add a node
+	 * for it.
 	 */
 	node = kzalloc(sizeof(struct coresight_node), GFP_KERNEL);
 	if (!node)
@@ -384,6 +386,7 @@ out:
 
 	node->csdev = csdev;
 	list_add(&node->link, path);
+	pm_runtime_get_sync(csdev->dev.parent);
 
 	return 0;
 }
@@ -415,9 +418,13 @@ struct list_head *coresight_build_path(struct coresight_device *csdev)
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
