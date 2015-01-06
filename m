From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Tue,  6 Jan 2015 09:37:07 -0700
Subject: [PATCH 3/9] coresight-funnel: Adding runtime PM awareness
In-Reply-To: <1420562233-2015-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420562233-2015-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420562233-2015-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Using the runtime API whenever HW access is required.  As
such and by associating a coresight component to a power
domain in the device tree, faults associated to accessing
unpowered devices are mitigated.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-funnel.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-funnel.c b/drivers/coresight/coresight-funnel.c
index 2108edffe1f4..b655ecfb23c6 100644
--- a/drivers/coresight/coresight-funnel.c
+++ b/drivers/coresight/coresight-funnel.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
+#include <linux/pm_runtime.h>
 
 #include "coresight-priv.h"
 
@@ -73,6 +74,7 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 	if (ret)
 		return ret;
 
+	pm_runtime_get_sync(drvdata->dev);
 	funnel_enable_hw(drvdata, inport);
 
 	dev_info(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
@@ -98,7 +100,7 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	funnel_disable_hw(drvdata, inport);
-
+	pm_runtime_put_sync(drvdata->dev);
 	clk_disable_unprepare(drvdata->clk);
 
 	dev_info(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
@@ -161,8 +163,10 @@ static ssize_t funnel_ctrl_show(struct device *dev,
 	if (ret)
 		return ret;
 
+	pm_runtime_get_sync(drvdata->dev);
 	val = get_funnel_ctrl_hw(drvdata);
 	clk_disable_unprepare(drvdata->clk);
+	pm_runtime_put_sync(drvdata->dev);
 
 	return sprintf(buf, "%#x\n", val);
 }
@@ -222,6 +226,9 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+
 	dev_info(dev, "FUNNEL initialized\n");
 	return 0;
 }
-- 
1.9.1
