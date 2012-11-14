From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 12:55:33 +0100
Subject: [PATCH 2/6] usb: chipidea: usbmisc: rename file,
 struct and functions to usbmisc_imx
In-Reply-To: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352894137-2050-3-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver will be used for every Freescale SoC which has this misc
memory layout to control the basic usb handling. So better name this
driver, function and struct names in a more generic way.

Reported-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/chipidea/usbmisc_imx.c   |  163 ++++++++++++++++++++++++++++++++++
 drivers/usb/chipidea/usbmisc_imx6q.c |  163 ----------------------------------
 2 files changed, 163 insertions(+), 163 deletions(-)
 create mode 100644 drivers/usb/chipidea/usbmisc_imx.c
 delete mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
new file mode 100644
index 0000000..9145e04
--- /dev/null
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -0,0 +1,163 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include "ci13xxx_imx.h"
+
+#define USB_DEV_MAX 4
+
+#define BM_OVER_CUR_DIS		BIT(7)
+
+struct imx_usbmisc {
+	void __iomem *base;
+	spinlock_t lock;
+	struct clk *clk;
+	struct usbmisc_usb_device usbdev[USB_DEV_MAX];
+};
+
+static struct imx_usbmisc *usbmisc;
+
+static struct usbmisc_usb_device *get_usbdev(struct device *dev)
+{
+	int i, ret;
+
+	for (i = 0; i < USB_DEV_MAX; i++) {
+		if (usbmisc->usbdev[i].dev == dev)
+			return &usbmisc->usbdev[i];
+		else if (!usbmisc->usbdev[i].dev)
+			break;
+	}
+
+	if (i >= USB_DEV_MAX)
+		return ERR_PTR(-EBUSY);
+
+	ret = usbmisc_get_init_data(dev, &usbmisc->usbdev[i]);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &usbmisc->usbdev[i];
+}
+
+static int usbmisc_imx6q_init(struct device *dev)
+{
+
+	struct usbmisc_usb_device *usbdev;
+	unsigned long flags;
+	u32 reg;
+
+	usbdev = get_usbdev(dev);
+	if (IS_ERR(usbdev))
+		return PTR_ERR(usbdev);
+
+	if (usbdev->disable_oc) {
+		spin_lock_irqsave(&usbmisc->lock, flags);
+		reg = readl(usbmisc->base + usbdev->index * 4);
+		writel(reg | BM_OVER_CUR_DIS,
+			usbmisc->base + usbdev->index * 4);
+		spin_unlock_irqrestore(&usbmisc->lock, flags);
+	}
+
+	return 0;
+}
+
+static const struct usbmisc_ops imx6q_usbmisc_ops = {
+	.init = usbmisc_imx6q_init,
+};
+
+static const struct of_device_id usbmisc_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-usbmisc"},
+	{ /* sentinel */ }
+};
+
+static int __devinit usbmisc_imx_probe(struct platform_device *pdev)
+{
+	struct resource	*res;
+	struct imx_usbmisc *data;
+	int ret;
+
+	if (usbmisc)
+		return -EBUSY;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&data->lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!data->base)
+		return -EADDRNOTAVAIL;
+
+	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk)) {
+		dev_err(&pdev->dev,
+			"failed to get clock, err=%ld\n", PTR_ERR(data->clk));
+		return PTR_ERR(data->clk);
+	}
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"clk_prepare_enable failed, err=%d\n", ret);
+		return ret;
+	}
+
+	usbmisc = data;
+	ret = usbmisc_set_ops(&imx6q_usbmisc_ops);
+	if (ret) {
+		usbmisc = NULL;
+		clk_disable_unprepare(data->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devexit usbmisc_imx_remove(struct platform_device *pdev)
+{
+	usbmisc_unset_ops(&imx6q_usbmisc_ops);
+	clk_disable_unprepare(usbmisc->clk);
+	usbmisc = NULL;
+	return 0;
+}
+
+static struct platform_driver usbmisc_imx_driver = {
+	.probe = usbmisc_imx_probe,
+	.remove = __devexit_p(usbmisc_imx_remove),
+	.driver = {
+		.name = "usbmisc_imx",
+		.owner = THIS_MODULE,
+		.of_match_table = usbmisc_imx_dt_ids,
+	 },
+};
+
+int __init usbmisc_imx_drv_init(void)
+{
+	return platform_driver_register(&usbmisc_imx_driver);
+}
+subsys_initcall(usbmisc_imx_drv_init);
+
+void __exit usbmisc_imx_drv_exit(void)
+{
+	platform_driver_unregister(&usbmisc_imx_driver);
+}
+module_exit(usbmisc_imx_drv_exit);
+
+MODULE_ALIAS("platform:usbmisc-imx");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("driver for imx usb non-core registers");
+MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
diff --git a/drivers/usb/chipidea/usbmisc_imx6q.c b/drivers/usb/chipidea/usbmisc_imx6q.c
deleted file mode 100644
index edc0edd..0000000
--- a/drivers/usb/chipidea/usbmisc_imx6q.c
+++ /dev/null
@@ -1,163 +0,0 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#include <linux/module.h>
-#include <linux/of_platform.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include "ci13xxx_imx.h"
-
-#define USB_DEV_MAX 4
-
-#define BM_OVER_CUR_DIS		BIT(7)
-
-struct imx6q_usbmisc {
-	void __iomem *base;
-	spinlock_t lock;
-	struct clk *clk;
-	struct usbmisc_usb_device usbdev[USB_DEV_MAX];
-};
-
-static struct imx6q_usbmisc *usbmisc;
-
-static struct usbmisc_usb_device *get_usbdev(struct device *dev)
-{
-	int i, ret;
-
-	for (i = 0; i < USB_DEV_MAX; i++) {
-		if (usbmisc->usbdev[i].dev == dev)
-			return &usbmisc->usbdev[i];
-		else if (!usbmisc->usbdev[i].dev)
-			break;
-	}
-
-	if (i >= USB_DEV_MAX)
-		return ERR_PTR(-EBUSY);
-
-	ret = usbmisc_get_init_data(dev, &usbmisc->usbdev[i]);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return &usbmisc->usbdev[i];
-}
-
-static int usbmisc_imx6q_init(struct device *dev)
-{
-
-	struct usbmisc_usb_device *usbdev;
-	unsigned long flags;
-	u32 reg;
-
-	usbdev = get_usbdev(dev);
-	if (IS_ERR(usbdev))
-		return PTR_ERR(usbdev);
-
-	if (usbdev->disable_oc) {
-		spin_lock_irqsave(&usbmisc->lock, flags);
-		reg = readl(usbmisc->base + usbdev->index * 4);
-		writel(reg | BM_OVER_CUR_DIS,
-			usbmisc->base + usbdev->index * 4);
-		spin_unlock_irqrestore(&usbmisc->lock, flags);
-	}
-
-	return 0;
-}
-
-static const struct usbmisc_ops imx6q_usbmisc_ops = {
-	.init = usbmisc_imx6q_init,
-};
-
-static const struct of_device_id usbmisc_imx6q_dt_ids[] = {
-	{ .compatible = "fsl,imx6q-usbmisc"},
-	{ /* sentinel */ }
-};
-
-static int __devinit usbmisc_imx6q_probe(struct platform_device *pdev)
-{
-	struct resource	*res;
-	struct imx6q_usbmisc *data;
-	int ret;
-
-	if (usbmisc)
-		return -EBUSY;
-
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	spin_lock_init(&data->lock);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!data->base)
-		return -EADDRNOTAVAIL;
-
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk)) {
-		dev_err(&pdev->dev,
-			"failed to get clock, err=%ld\n", PTR_ERR(data->clk));
-		return PTR_ERR(data->clk);
-	}
-
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"clk_prepare_enable failed, err=%d\n", ret);
-		return ret;
-	}
-
-	usbmisc = data;
-	ret = usbmisc_set_ops(&imx6q_usbmisc_ops);
-	if (ret) {
-		usbmisc = NULL;
-		clk_disable_unprepare(data->clk);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int __devexit usbmisc_imx6q_remove(struct platform_device *pdev)
-{
-	usbmisc_unset_ops(&imx6q_usbmisc_ops);
-	clk_disable_unprepare(usbmisc->clk);
-	usbmisc = NULL;
-	return 0;
-}
-
-static struct platform_driver usbmisc_imx6q_driver = {
-	.probe = usbmisc_imx6q_probe,
-	.remove = __devexit_p(usbmisc_imx6q_remove),
-	.driver = {
-		.name = "usbmisc_imx6q",
-		.owner = THIS_MODULE,
-		.of_match_table = usbmisc_imx6q_dt_ids,
-	 },
-};
-
-int __init usbmisc_imx6q_drv_init(void)
-{
-	return platform_driver_register(&usbmisc_imx6q_driver);
-}
-subsys_initcall(usbmisc_imx6q_drv_init);
-
-void __exit usbmisc_imx6q_drv_exit(void)
-{
-	platform_driver_unregister(&usbmisc_imx6q_driver);
-}
-module_exit(usbmisc_imx6q_drv_exit);
-
-MODULE_ALIAS("platform:usbmisc-imx6q");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("driver for imx6q usb non-core registers");
-MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
-- 
1.7.10.4
