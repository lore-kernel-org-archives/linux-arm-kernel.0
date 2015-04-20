From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Apr 2015 14:58:59 +0200
Subject: [PATCH 06/13 v2] coresight: funnel: let runtime PM handle core clock
In-Reply-To: <1429534746-3068-1-git-send-email-linus.walleij@linaro.org>
References: <1429534746-3068-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1429534746-3068-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This uses runtime PM to manage the PCLK ("amba_pclk") instead
of screwing around with the framework by going in and taking
a copy from the amba device. The amba bus core will uprepare
and disable the clock when the device is unused when
CONFIG_PM is selected, else the clock will be always on.

Prior to this patch, as the AMBA primecell bus code enables
the PCLK, it would be left on after probe as
clk_disable_unprepare() was not called. Now the runtime PM
callbacks will make sure the PCLK is properly disabled
after probe.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebased on the coresight git tree.
- Added Ulf's review tag.
---
 drivers/hwtracing/coresight/coresight-funnel.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 3db36f70b666..330de2c88759 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
-#include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
 
@@ -36,14 +36,12 @@
  * @base:	memory mapped base address for this component.
  * @dev:	the device entity associated to this component.
  * @csdev:	component vitals needed by the framework.
- * @clk:	the clock this component is associated to.
  * @priority:	port selection order.
  */
 struct funnel_drvdata {
 	void __iomem		*base;
 	struct device		*dev;
 	struct coresight_device	*csdev;
-	struct clk		*clk;
 	unsigned long		priority;
 };
 
@@ -67,12 +65,8 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 			 int outport)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	int ret;
-
-	ret = clk_prepare_enable(drvdata->clk);
-	if (ret)
-		return ret;
 
+	pm_runtime_get_sync(drvdata->dev);
 	funnel_enable_hw(drvdata, inport);
 
 	dev_info(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
@@ -98,8 +92,7 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	funnel_disable_hw(drvdata, inport);
-
-	clk_disable_unprepare(drvdata->clk);
+	pm_runtime_put(drvdata->dev);
 
 	dev_info(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
 }
@@ -153,16 +146,14 @@ static u32 get_funnel_ctrl_hw(struct funnel_drvdata *drvdata)
 static ssize_t funnel_ctrl_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int ret;
 	u32 val;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	ret = clk_prepare_enable(drvdata->clk);
-	if (ret)
-		return ret;
+	pm_runtime_get_sync(drvdata->dev);
 
 	val = get_funnel_ctrl_hw(drvdata);
-	clk_disable_unprepare(drvdata->clk);
+
+	pm_runtime_put(drvdata->dev);
 
 	return sprintf(buf, "%#x\n", val);
 }
@@ -205,8 +196,7 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 
 	drvdata->base = base;
-
-	drvdata->clk = adev->pclk;
+	pm_runtime_put(&adev->dev);
 
 	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
 	if (!desc)
-- 
1.9.3
