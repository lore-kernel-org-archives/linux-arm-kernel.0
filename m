From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Tue,  6 Jan 2015 09:37:09 -0700
Subject: [PATCH 5/9] coresight-tpiu: Adding runtime PM awareness
In-Reply-To: <1420562233-2015-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420562233-2015-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420562233-2015-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Using the runtime API whenever HW access is required.  As
such and by associating a coresight component to a power
domain in the device tree, faults associated to accessing
unpowered devices are mitigated.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-tpiu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-tpiu.c b/drivers/coresight/coresight-tpiu.c
index ae101082791a..199244700c99 100644
--- a/drivers/coresight/coresight-tpiu.c
+++ b/drivers/coresight/coresight-tpiu.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
+#include <linux/pm_runtime.h>
 
 #include "coresight-priv.h"
 
@@ -78,6 +79,7 @@ static int tpiu_enable(struct coresight_device *csdev)
 	if (ret)
 		return ret;
 
+	pm_runtime_get_sync(drvdata->dev);
 	tpiu_enable_hw(drvdata);
 
 	dev_info(drvdata->dev, "TPIU enabled\n");
@@ -101,7 +103,7 @@ static void tpiu_disable(struct coresight_device *csdev)
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	tpiu_disable_hw(drvdata);
-
+	pm_runtime_put_sync(drvdata->dev);
 	clk_disable_unprepare(drvdata->clk);
 
 	dev_info(drvdata->dev, "TPIU disabled\n");
@@ -171,6 +173,9 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+
 	dev_info(dev, "TPIU initialized\n");
 	return 0;
 }
-- 
1.9.1
