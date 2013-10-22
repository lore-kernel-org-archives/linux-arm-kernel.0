From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 13:58:36 +0800
Subject: [Patch v2 02/14] usb: phy-mxs: Add platform judgement code
In-Reply-To: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382421528-17897-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs-phy has three versions until now, each versions have
some differences among PHY operations. the 1st version is
for mx23/mx28 SoC, The 2nd version is for mx6q and mx6dl, the
3rd version is for mx6sl and later mx6 platform.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   65 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index fdd33b4..a0628d6 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012-2013 Freescale Semiconductor, Inc.
  * Copyright (C) 2012 Marek Vasut <marex@denx.de>
  * on behalf of DENX Software Engineering GmbH
  *
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/of_device.h>
 
 #define DRIVER_NAME "mxs_phy"
 
@@ -34,12 +35,57 @@
 #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
 #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
 
+#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
+
+enum imx_phy_type {
+	IMX6Q_USB_PHY,
+	IMX6SL_USB_PHY,
+	IMX23_USB_PHY,
+};
+
 struct mxs_phy {
 	struct usb_phy phy;
 	struct clk *clk;
+	enum imx_phy_type devtype;
 };
 
-#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
+static inline int is_mx6q_phy(struct mxs_phy *data)
+{
+	return data->devtype == IMX6Q_USB_PHY;
+}
+
+static inline int is_mx6sl_phy(struct mxs_phy *data)
+{
+	return data->devtype == IMX6SL_USB_PHY;
+}
+
+static inline int is_mx23_phy(struct mxs_phy *data)
+{
+	return data->devtype == IMX23_USB_PHY;
+}
+
+static struct platform_device_id imx_phy_devtype[] = {
+	{
+		.name = "usb-phy-imx6q",
+		.driver_data = IMX6Q_USB_PHY,
+	}, {
+		.name = "usb-phy-imx6sl",
+		.driver_data = IMX6SL_USB_PHY,
+	}, {
+		.name = "usb-phy-imx23",
+		.driver_data = IMX23_USB_PHY,
+	}, {
+		/* sentinel */
+	}
+};
+
+static const struct of_device_id mxs_phy_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-usbphy", .data = &imx_phy_devtype[IMX6Q_USB_PHY], },
+	{ .compatible = "fsl,imx6sl-usbphy", .data = &imx_phy_devtype[IMX6SL_USB_PHY], },
+	{ .compatible = "fsl,imx23-usbphy", .data = &imx_phy_devtype[IMX23_USB_PHY], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);
 
 static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
 {
@@ -131,6 +177,14 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct mxs_phy *mxs_phy;
 	int ret;
+	const struct of_device_id *of_id =
+			of_match_device(mxs_phy_dt_ids, &pdev->dev);
+
+	/* This driver is DT-only version now */
+	if (!of_id)
+		return -ENXIO;
+
+	pdev->id_entry = of_id->data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
@@ -163,6 +217,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	ATOMIC_INIT_NOTIFIER_HEAD(&mxs_phy->phy.notifier);
 
 	mxs_phy->clk = clk;
+	mxs_phy->devtype = pdev->id_entry->driver_data;
 
 	platform_set_drvdata(pdev, &mxs_phy->phy);
 
@@ -182,12 +237,6 @@ static int mxs_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mxs_phy_dt_ids[] = {
-	{ .compatible = "fsl,imx23-usbphy", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);
-
 static struct platform_driver mxs_phy_driver = {
 	.probe = mxs_phy_probe,
 	.remove = mxs_phy_remove,
-- 
1.7.1
