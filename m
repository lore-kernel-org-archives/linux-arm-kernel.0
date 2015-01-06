From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Tue,  6 Jan 2015 09:37:08 -0700
Subject: [PATCH 4/9] coresight-tmc: Adding runtime PM awareness
In-Reply-To: <1420562233-2015-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420562233-2015-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420562233-2015-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Using the runtime API whenever HW access is required.  As
such and by associating a coresight component to a power
domain in the device tree, faults associated to accessing
unpowered devices are mitigated.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-tmc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-tmc.c b/drivers/coresight/coresight-tmc.c
index ce2c293f1707..274907717a33 100644
--- a/drivers/coresight/coresight-tmc.c
+++ b/drivers/coresight/coresight-tmc.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
+#include <linux/pm_runtime.h>
 
 #include "coresight-priv.h"
 
@@ -249,9 +250,11 @@ static int tmc_enable(struct tmc_drvdata *drvdata, enum tmc_mode mode)
 	if (ret)
 		return ret;
 
+	pm_runtime_get_sync(drvdata->dev);
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		pm_runtime_put_sync(drvdata->dev);
 		clk_disable_unprepare(drvdata->clk);
 		return -EBUSY;
 	}
@@ -385,7 +388,7 @@ static void tmc_disable(struct tmc_drvdata *drvdata, enum tmc_mode mode)
 out:
 	drvdata->enable = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
+	pm_runtime_put_sync(drvdata->dev);
 	clk_disable_unprepare(drvdata->clk);
 
 	dev_info(drvdata->dev, "TMC disabled\n");
@@ -717,6 +720,9 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		goto err_misc_register;
 
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+
 	dev_info(dev, "TMC initialized\n");
 	return 0;
 
-- 
1.9.1
