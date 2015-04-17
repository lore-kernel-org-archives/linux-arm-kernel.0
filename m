From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Apr 2015 10:58:58 +0200
Subject: [PATCH 11/13] coresight: funnel: retrieve and handle atclk
In-Reply-To: <1429261140-13910-1-git-send-email-linus.walleij@linaro.org>
References: <1429261140-13910-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1429261140-13910-12-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As can be seen from the datasheet of the CoreSight
Components, DDI0314 table A-6 the funnel has a clock signal
apart from the AHB interconnect ("amba_pclk", that we're
already handling) called ATCLK, ARM Trace Clock, that SoC
implementers may provide from an entirely different clock
source. So to model this correctly create an optional
path for handling ATCLK alongside the PCLK so we don't
break old platforms that only define PCLK ("amba_pclk") but
still makes it possible for SoCs that have both clock signals
(such as the DB8500) to fetch and prepare/enable/disable/
unprepare both clocks.

The ATCLK is enabled and disabled using the runtime PM
callbacks.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/coresight/coresight-funnel.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/coresight/coresight-funnel.c b/drivers/coresight/coresight-funnel.c
index 330de2c88759..36c14ca4b916 100644
--- a/drivers/coresight/coresight-funnel.c
+++ b/drivers/coresight/coresight-funnel.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
+#include <linux/clk.h>
 
 #include "coresight-priv.h"
 
@@ -35,12 +36,14 @@
  * struct funnel_drvdata - specifics associated to a funnel component
  * @base:	memory mapped base address for this component.
  * @dev:	the device entity associated to this component.
+ * @atclk:	optional clock for the core parts of the funnel.
  * @csdev:	component vitals needed by the framework.
  * @priority:	port selection order.
  */
 struct funnel_drvdata {
 	void __iomem		*base;
 	struct device		*dev;
+	struct clk		*atclk;
 	struct coresight_device	*csdev;
 	unsigned long		priority;
 };
@@ -168,6 +171,7 @@ ATTRIBUTE_GROUPS(coresight_funnel);
 
 static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 {
+	int ret;
 	void __iomem *base;
 	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
@@ -188,6 +192,12 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 		return -ENOMEM;
 
 	drvdata->dev = &adev->dev;
+	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
+	if (!IS_ERR(drvdata->atclk)) {
+		ret = clk_prepare_enable(drvdata->atclk);
+		if (ret)
+			return ret;
+	}
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -224,6 +234,34 @@ static int funnel_remove(struct amba_device *adev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int funnel_runtime_suspend(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct funnel_drvdata *drvdata = amba_get_drvdata(adev);
+
+	if (drvdata && !IS_ERR(drvdata->atclk))
+		clk_disable_unprepare(drvdata->atclk);
+
+	return 0;
+}
+
+static int funnel_runtime_resume(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct funnel_drvdata *drvdata = amba_get_drvdata(adev);
+
+	if (drvdata && !IS_ERR(drvdata->atclk))
+		clk_prepare_enable(drvdata->atclk);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops funnel_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(funnel_runtime_suspend, funnel_runtime_resume, NULL)
+};
+
 static struct amba_id funnel_ids[] = {
 	{
 		.id     = 0x0003b908,
@@ -236,6 +274,7 @@ static struct amba_driver funnel_driver = {
 	.drv = {
 		.name	= "coresight-funnel",
 		.owner	= THIS_MODULE,
+		.pm	= &funnel_dev_pm_ops,
 	},
 	.probe		= funnel_probe,
 	.remove		= funnel_remove,
-- 
1.9.3
