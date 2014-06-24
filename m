From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 24 Jun 2014 12:35:16 +0200
Subject: [PATCH v2 07/12] usb: chipidea: add a generic driver
In-Reply-To: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a generic ChipIdea driver, with optional PHY and clock, to support
ChipIdea controllers that doesn't need specific functions.

Needed for the Marvell Berlin SoCs SUB controllers.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 drivers/usb/chipidea/Makefile          |   1 +
 drivers/usb/chipidea/ci_hdrc_generic.c | 108 +++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 drivers/usb/chipidea/ci_hdrc_generic.c

diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 2f099c7df7b5..c705f0fe7a00 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -20,4 +20,5 @@ endif
 
 ifneq ($(CONFIG_OF),)
 	obj-$(CONFIG_USB_CHIPIDEA)	+= usbmisc_imx.o ci_hdrc_imx.o
+	obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_generic.o
 endif
diff --git a/drivers/usb/chipidea/ci_hdrc_generic.c b/drivers/usb/chipidea/ci_hdrc_generic.c
new file mode 100644
index 000000000000..27520710a1f7
--- /dev/null
+++ b/drivers/usb/chipidea/ci_hdrc_generic.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2014 Marvell Technology Group Ltd.
+ *
+ * Antoine T?nart <antoine.tenart@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/usb/chipidea.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/ulpi.h>
+
+#include "ci.h"
+
+struct ci_hdrc_generic_priv {
+	struct platform_device	*ci_pdev;
+	struct clk		*clk;
+};
+
+static int ci_hdrc_generic_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ci_hdrc_generic_priv *priv;
+	struct ci_hdrc_platform_data ci_pdata = {
+		.name		= "ci_hdrc",
+		.capoffset	= DEF_CAPOFFSET,
+		.flags		= CI_HDRC_REQUIRE_TRANSCEIVER |
+				  CI_HDRC_DISABLE_STREAMING,
+	};
+	int ret;
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
+	ci_pdata.phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
+	if (IS_ERR(ci_pdata.phy))
+		/* PHY is optional */
+		ci_pdata.phy = NULL;
+
+	priv->ci_pdev = ci_hdrc_add_device(dev, pdev->resource,
+				     pdev->num_resources, &ci_pdata);
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
+	clk_disable_unprepare(priv->clk);
+	return ret;
+}
+
+static int ci_hdrc_generic_remove(struct platform_device *pdev)
+{
+	struct ci_hdrc_generic_priv *priv = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	ci_hdrc_remove_device(priv->ci_pdev);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct of_device_id ci_hdrc_generic_of_match[] = {
+	{ .compatible = "chipidea-usb" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ci_hdrc_generic_of_match);
+
+static struct platform_driver ci_hdrc_generic_driver = {
+	.probe	= ci_hdrc_generic_probe,
+	.remove	= ci_hdrc_generic_remove,
+	.driver	= {
+		.name		= "chipidea-usb",
+		.owner		= THIS_MODULE,
+		.of_match_table	= ci_hdrc_generic_of_match,
+	},
+};
+module_platform_driver(ci_hdrc_generic_driver);
+
+MODULE_DESCRIPTION("Generic ChipIdea HDRC USB binding");
+MODULE_AUTHOR("Antoine T?nart <antoine.tenart@free-electrons.com>");
+MODULE_LICENSE("GPL");
-- 
1.9.1
