From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 12 Aug 2013 09:22:47 +0800
Subject: [PATCH v15 01/13] usb: chipidea: move vbus regulator operation to core
In-Reply-To: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1376270579-13493-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vbus regulator is a common element for USB vbus operation,
So, move it from glue layer to core.

Tested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |   26 ++------------------------
 drivers/usb/chipidea/core.c        |   23 +++++++++++++++++++++++
 include/linux/usb/chipidea.h       |    1 +
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 35008e3..bd1fe25 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -19,7 +19,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/usb/chipidea.h>
 #include <linux/clk.h>
-#include <linux/regulator/consumer.h>
 
 #include "ci.h"
 #include "ci_hdrc_imx.h"
@@ -31,7 +30,6 @@ struct ci_hdrc_imx_data {
 	struct usb_phy *phy;
 	struct platform_device *ci_pdev;
 	struct clk *clk;
-	struct regulator *reg_vbus;
 };
 
 static const struct usbmisc_ops *usbmisc_ops;
@@ -134,20 +132,6 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	/* we only support host now, so enable vbus here */
-	data->reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
-	if (!IS_ERR(data->reg_vbus)) {
-		ret = regulator_enable(data->reg_vbus);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vbus regulator, err=%d\n",
-				ret);
-			goto err_clk;
-		}
-	} else {
-		data->reg_vbus = NULL;
-	}
-
 	pdata.phy = data->phy;
 
 	if (!pdev->dev.dma_mask)
@@ -160,7 +144,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev,
 				"usbmisc init failed, ret=%d\n", ret);
-			goto err;
+			goto err_clk;
 		}
 	}
 
@@ -172,7 +156,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register ci_hdrc platform device, err=%d\n",
 			ret);
-		goto err;
+		goto err_clk;
 	}
 
 	if (usbmisc_ops && usbmisc_ops->post) {
@@ -193,9 +177,6 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
-err:
-	if (data->reg_vbus)
-		regulator_disable(data->reg_vbus);
 err_clk:
 	clk_disable_unprepare(data->clk);
 	return ret;
@@ -208,9 +189,6 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	ci_hdrc_remove_device(data->ci_pdev);
 
-	if (data->reg_vbus)
-		regulator_disable(data->reg_vbus);
-
 	if (data->phy)
 		usb_phy_shutdown(data->phy);
 
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 3126c03..26f6599 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -65,6 +65,7 @@
 #include <linux/usb/chipidea.h>
 #include <linux/usb/of.h>
 #include <linux/phy.h>
+#include <linux/regulator/consumer.h>
 
 #include "ci.h"
 #include "udc.h"
@@ -342,6 +343,24 @@ static irqreturn_t ci_irq(int irq, void *data)
 	return ret;
 }
 
+static int ci_get_platdata(struct device *dev,
+		struct ci_hdrc_platform_data *platdata)
+{
+	/* Get the vbus regulator */
+	platdata->reg_vbus = devm_regulator_get(dev, "vbus");
+	if (PTR_ERR(platdata->reg_vbus) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (PTR_ERR(platdata->reg_vbus) == -ENODEV) {
+		platdata->reg_vbus = NULL; /* no vbus regualator is needed */
+	} else if (IS_ERR(platdata->reg_vbus)) {
+		dev_err(dev, "Getting regulator error: %ld\n",
+			PTR_ERR(platdata->reg_vbus));
+		return PTR_ERR(platdata->reg_vbus);
+	}
+
+	return 0;
+}
+
 static DEFINE_IDA(ci_ida);
 
 struct platform_device *ci_hdrc_add_device(struct device *dev,
@@ -351,6 +370,10 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	struct platform_device *pdev;
 	int id, ret;
 
+	ret = ci_get_platdata(dev, platdata);
+	if (ret)
+		return ERR_PTR(ret);
+
 	id = ida_simple_get(&ci_ida, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		return ERR_PTR(id);
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 2562994..ce4e1aa 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -24,6 +24,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
 	void	(*notify_event) (struct ci_hdrc *ci, unsigned event);
+	struct regulator	*reg_vbus;
 };
 
 /* Default offset of capability registers */
-- 
1.7.1
