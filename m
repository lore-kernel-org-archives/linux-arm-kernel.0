From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Apr 2012 04:07:46 +0200
Subject: [PATCH 07/10] MXS: Add USB PHY driver
In-Reply-To: <1334714869-19282-1-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334714869-19282-1-git-send-email-marex@denx.de>
Message-ID: <1334714869-19282-8-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver that controls the built-in USB PHY in the i.MX233/i.MX28. This
enables the PHY upon powerup and shuts it down on shutdown.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Lin Tony-B19295 <B19295@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Tony Lin <tony.lin@freescale.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/usb/otg/Kconfig   |   10 +++
 drivers/usb/otg/Makefile  |    1 +
 drivers/usb/otg/mxs-phy.c |  201 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 drivers/usb/otg/mxs-phy.c

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index e7c6325..1de1495 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -122,6 +122,16 @@ config USB_IMX_COMPOSITE
 	  Composite driver that handles clock and memory mapping for
 	  i.MX USB host and USB PHY.
 
+config USB_MXS_PHY
+	tristate "Freescale i.MX28 USB PHY support"
+	select USB_OTG_UTILS
+	select USB_IMX_COMPOSITE
+	help
+	  Say Y here if you want to build Freescale i.MX28 USB PHY
+	  driver in kernel.
+
+	  To compile this driver as a module, choose M here.
+
 config USB_MV_OTG
 	tristate "Marvell USB OTG support"
 	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index e3feaca..56700b3 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
 fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
 obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
 obj-$(CONFIG_USB_IMX_COMPOSITE)	+= imx-usb.o
+obj-$(CONFIG_USB_MXS_PHY)	+= mxs-phy.o
 obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
new file mode 100644
index 0000000..3c6c5a2
--- /dev/null
+++ b/drivers/usb/otg/mxs-phy.c
@@ -0,0 +1,201 @@
+/*
+ * drivers/usb/otg/mxs-phy.c
+ *
+ * Freescale i.MX28 USB PHY driver.
+ *
+ * Copyright (C) 2012 Marek Vasut <marex@denx.de>
+ * on behalf of DENX Software Engineering GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/usb/otg.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fsl_devices.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+#include <mach/mx28.h>
+
+#define HW_USBPHY_PWD				0x00
+
+#define HW_USBPHY_CTRL				0x30
+#define HW_USBPHY_CTRL_SET			0x34
+#define HW_USBPHY_CTRL_CLR			0x38
+#define HW_USBPHY_CTRL_TOG			0x3c
+
+#define BM_USBPHY_CTRL_SFTRST			(1 << 31)
+#define BM_USBPHY_CTRL_CLKGATE			(1 << 30)
+#define BM_USBPHY_CTRL_ENUTMILEVEL3		(1 << 15)
+#define BM_USBPHY_CTRL_ENUTMILEVEL2		(1 << 14)
+#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	(1 << 1)
+
+static int phy_init(struct usb_phy *x)
+{
+	struct imx_usb_data *data = x->dev->platform_data;
+	uint32_t val;
+
+	/* Enable clock to the PHY. */
+	clk_enable(data->clk);
+
+	/* Reset the PHY block. */
+	mxs_reset_block(data->mem + HW_USBPHY_CTRL);
+
+	/* Power up the PHY. */
+	writel(0, data->mem + HW_USBPHY_PWD);
+
+	/* Enable FS/LS compatibility and HS disconnection detector. */
+	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3 |
+		BM_USBPHY_CTRL_ENHOSTDISCONDETECT;
+	writel(val, data->mem + HW_USBPHY_CTRL_SET);
+
+	return 0;
+}
+
+static void phy_shutdown(struct usb_phy *x)
+{
+	struct imx_usb_data *data = x->dev->platform_data;
+
+	/* Gate off the PHY. */
+	writel(BM_USBPHY_CTRL_CLKGATE, data->mem + HW_USBPHY_CTRL_SET);
+
+	/* Disable clock to the PHY. */
+	clk_disable(data->clk);
+}
+
+static int phy_set_vbus(struct usb_otg *otg, bool enabled)
+{
+	struct usb_phy *x = otg->phy;
+	struct imx_usb_data *data = x->dev->platform_data;
+
+	if (enabled)
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+			data->mem + HW_USBPHY_CTRL_CLR);
+	else
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+			data->mem + HW_USBPHY_CTRL_SET);
+
+	return 0;
+}
+
+static int __devinit mxs_phy_probe(struct platform_device *pdev)
+{
+	struct imx_usb_data *data = pdev->dev.platform_data;
+	struct usb_phy *phy;
+	int ret;
+
+	if (!data) {
+		dev_err(&pdev->dev, "USB PHY platform data missing!\n");
+		return -ENODEV;
+	}
+
+	/* Allocate PHY driver's private date. */
+	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy) {
+		dev_err(&pdev->dev, "Failed to allocate USB PHY structure!\n");
+		ret = -ENOMEM;
+		goto err_alloc_phy;
+
+	}
+
+	phy->otg = kzalloc(sizeof(*phy->otg), GFP_KERNEL);
+	if (!phy->otg) {
+		dev_err(&pdev->dev, "Failed to allocate USB OTG structure!\n");
+		ret = -ENOMEM;
+		goto err_alloc_otg;
+	}
+
+	/* Setup the PHY structures. */
+	phy->dev		= &pdev->dev;
+	phy->label		= "mxs-usb-phy";
+	phy->init		= phy_init;
+	phy->shutdown		= phy_shutdown;
+	phy->state		= OTG_STATE_A_HOST;
+
+	phy->otg->phy		= phy;
+	phy->otg->set_vbus	= phy_set_vbus;
+
+	platform_set_drvdata(pdev, phy);
+
+	ATOMIC_INIT_NOTIFIER_HEAD(&phy->notifier);
+
+	/* Register the transceiver with kernel. */
+	ret = usb_set_transceiver(phy);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't register transceiver, (%d)\n", ret);
+		goto err_set_transceiver;
+	}
+
+	return 0;
+
+err_set_transceiver:
+	platform_set_drvdata(pdev, NULL);
+	kfree(phy->otg);
+err_alloc_otg:
+	kfree(phy);
+err_alloc_phy:
+	return ret;
+}
+
+static int __devexit mxs_phy_remove(struct platform_device *pdev)
+{
+	struct imx_usb_data *data = pdev->dev.platform_data;
+	struct usb_phy *phy = platform_get_drvdata(pdev);
+
+	/* Power down the PHY. */
+	phy_shutdown(phy);
+
+	/* Stop the PHY clock. */
+	clk_disable(data->clk);
+
+	/* Free the rest. */
+	usb_set_transceiver(NULL);
+	platform_set_drvdata(pdev, NULL);
+	kfree(phy);
+
+	return 0;
+}
+
+static struct platform_driver mxs_phy_driver = {
+	.probe		= mxs_phy_probe,
+	.remove		= __devexit_p(mxs_phy_remove),
+	.driver		= {
+		.name	= "mxs-usb-phy",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init mxs_phy_init(void)
+{
+	return platform_driver_register(&mxs_phy_driver);
+}
+
+static void __exit mxs_phy_exit(void)
+{
+	platform_driver_unregister(&mxs_phy_driver);
+}
+
+module_init(mxs_phy_init);
+module_exit(mxs_phy_exit);
+
+MODULE_ALIAS("platform:mxs-usb-phy");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("Freescale i.MX28 USB PHY driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
