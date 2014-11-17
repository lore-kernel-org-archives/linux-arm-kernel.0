From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 17 Nov 2014 14:35:42 +0100
Subject: [PATCH v8 08/13] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <1416231347-27193-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1416231347-27193-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1416231347-27193-9-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a USB2 ChipIdea driver for ci13xxx, with optional PHY, clock
and DMA mask, to support USB2 ChipIdea controllers that don't need
specific functions.

Tested on the Marvell Berlin SoCs USB controllers.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Tested-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/usb/chipidea/Makefile       |   1 +
 drivers/usb/chipidea/ci_hdrc_usb2.c | 116 ++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 drivers/usb/chipidea/ci_hdrc_usb2.c

diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 2f099c7df7b5..1fc86a2ca22d 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -10,6 +10,7 @@ ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
 
 # Glue/Bridge layers go here
 
+obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_usb2.o
 obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_msm.o
 obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_zevio.o
 
diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
new file mode 100644
index 000000000000..61d8e55df1bd
--- /dev/null
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -0,0 +1,116 @@
+/*
+ * Copyright (C) 2014 Marvell Technology Group Ltd.
+ *
+ * Antoine Tenart <antoine.tenart@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/usb/chipidea.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/ulpi.h>
+
+#include "ci.h"
+
+struct ci_hdrc_usb2_priv {
+	struct platform_device	*ci_pdev;
+	struct clk		*clk;
+};
+
+static struct ci_hdrc_platform_data ci_default_pdata = {
+	.capoffset	= DEF_CAPOFFSET,
+	.flags		= CI_HDRC_DISABLE_STREAMING,
+};
+
+static int ci_hdrc_usb2_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ci_hdrc_usb2_priv *priv;
+	struct ci_hdrc_platform_data *ci_pdata = dev_get_platdata(dev);
+	int ret;
+
+	if (!ci_pdata)
+		ci_pdata = &ci_default_pdata;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (!IS_ERR(priv->clk)) {
+		ret = clk_prepare_enable(priv->clk);
+		if (ret) {
+			dev_err(dev, "failed to enable the clock: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		goto clk_err;
+
+	ci_pdata->name = dev_name(dev);
+
+	priv->ci_pdev = ci_hdrc_add_device(dev, pdev->resource,
+					   pdev->num_resources, ci_pdata);
+	if (IS_ERR(priv->ci_pdev)) {
+		ret = PTR_ERR(priv->ci_pdev);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev,
+				"failed to register ci_hdrc platform device: %d\n",
+				ret);
+		goto clk_err;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	pm_runtime_no_callbacks(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+
+clk_err:
+	if (!IS_ERR(priv->clk))
+		clk_disable_unprepare(priv->clk);
+	return ret;
+}
+
+static int ci_hdrc_usb2_remove(struct platform_device *pdev)
+{
+	struct ci_hdrc_usb2_priv *priv = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	ci_hdrc_remove_device(priv->ci_pdev);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct of_device_id ci_hdrc_usb2_of_match[] = {
+	{ .compatible = "chipidea,usb2" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ci_hdrc_usb2_of_match);
+
+static struct platform_driver ci_hdrc_usb2_driver = {
+	.probe	= ci_hdrc_usb2_probe,
+	.remove	= ci_hdrc_usb2_remove,
+	.driver	= {
+		.name		= "chipidea-usb2",
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(ci_hdrc_usb2_of_match),
+	},
+};
+module_platform_driver(ci_hdrc_usb2_driver);
+
+MODULE_DESCRIPTION("ChipIdea HDRC USB2 binding for ci13xxx");
+MODULE_AUTHOR("Antoine Tenart <antoine.tenart@free-electrons.com>");
+MODULE_LICENSE("GPL");
-- 
2.1.0
