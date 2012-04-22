From: marex@denx.de (Marek Vasut)
Date: Sun, 22 Apr 2012 14:59:25 +0200
Subject: [PATCH 09/11] MXS: Add USB PHY driver
In-Reply-To: <1335099567-21056-1-git-send-email-marex@denx.de>
References: <1334771194-18688-1-git-send-email-marex@denx.de>
 <1335099567-21056-1-git-send-email-marex@denx.de>
Message-ID: <1335099567-21056-10-git-send-email-marex@denx.de>
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
 drivers/usb/otg/Kconfig   |   10 ++
 drivers/usb/otg/Makefile  |    1 +
 drivers/usb/otg/mxs-phy.c |  438 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 449 insertions(+)
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
index 7d2c631..b8d7d5c 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
 fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
 obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
 obj-$(CONFIG_USB_IMX_COMPOSITE)	+= imx-otg.o
+obj-$(CONFIG_USB_MXS_PHY)	+= mxs-phy.o
 obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
new file mode 100644
index 0000000..4f03515
--- /dev/null
+++ b/drivers/usb/otg/mxs-phy.c
@@ -0,0 +1,438 @@
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
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fsl/mxs-usb.h>
+#include <linux/gpio.h>
+
+#include <linux/usb.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/hcd.h>
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
+#define BM_USBPHY_CTRL_ENIRQDEVPLUGIN		(1 << 11)
+#define BM_USBPHY_CTRL_ENOTGIDDETECT		(1 << 7)
+#define BM_USBPHY_CTRL_ENDEVPLUGINDETECT	(1 << 4)
+#define BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ	(1 << 3)
+#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	(1 << 1)
+
+#define HW_USBPHY_STATUS			0x40
+
+#define BM_USBPHY_STATUS_OTGID_STATUS		(1 << 8)
+#define BM_USBPHY_STATUS_DEVPLUGIN_STATUS	(1 << 6)
+#define BM_USBPHY_STATUS_HOSTDISCON_STATUS	(1 << 3)
+
+/* FIXME */
+#define M28EVK_USBOTG_ENABLE	MXS_GPIO_NR(3, 12)
+
+struct mxs_usb_phy {
+	struct usb_phy		phy;
+
+	struct work_struct	work;
+
+	struct clk		*clk;
+	struct resource		*mem_res;
+	void __iomem		*mem;
+	int			irq;
+	int			gpio_vbus;
+	int			gpio_vbus_inverted;
+
+	enum usb_otg_state	new_state;
+
+	bool			host_mode;
+};
+
+static int mxs_usb_set_host(struct usb_otg *otg, struct usb_bus *host)
+{
+	struct usb_phy *x = otg->phy;
+	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
+
+	/* If the host provided is what we already have, just return. */
+	if (otg->host && otg->host == host)
+		return 0;
+
+	/* Otherwise start the state machine. */
+	if (host)
+		otg->host = host;
+	else
+		phy->new_state = OTG_STATE_UNDEFINED;
+
+	schedule_work(&phy->work);
+
+	return 0;
+}
+
+static int mxs_usb_set_peripheral(struct usb_otg *otg, struct usb_gadget *gg)
+{
+	struct usb_phy *x = otg->phy;
+	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
+
+	/* If the gadget provided is what we already have, just return. */
+	if (otg->gadget && otg->gadget == gg)
+		return 0;
+
+	/* Otherwise start the state machine. */
+	if (gg)
+		otg->gadget = gg;
+	else
+		phy->new_state = OTG_STATE_UNDEFINED;
+
+	schedule_work(&phy->work);
+
+	return 0;
+}
+
+static void mxs_usb_work(struct work_struct *w)
+{
+	struct mxs_usb_phy *phy = container_of(w, struct mxs_usb_phy, work);
+	struct usb_otg *otg = phy->phy.otg;
+	struct usb_hcd *hcd;
+
+	switch (otg->phy->state) {
+	case OTG_STATE_A_HOST:
+		if (phy->new_state == OTG_STATE_UNDEFINED) {
+			hcd = bus_to_hcd(otg->host);
+			usb_remove_hcd(hcd);
+			otg->phy->state = phy->new_state;
+			/* Turn off VBUS */
+			gpio_set_value(phy->gpio_vbus,
+				phy->gpio_vbus_inverted);
+		}
+		break;
+	case OTG_STATE_B_PERIPHERAL:
+		if (phy->new_state == OTG_STATE_UNDEFINED) {
+			usb_del_gadget_udc(otg->gadget);
+			otg->phy->state = phy->new_state;
+		}
+		break;
+	case OTG_STATE_UNDEFINED:
+		/* Check desired state. */
+		switch (phy->new_state) {
+		case OTG_STATE_A_HOST:
+			if (!otg->host)
+				break;
+			otg->phy->state = phy->new_state;
+
+			/* Turn on VBUS */
+			gpio_set_value(phy->gpio_vbus,
+				!phy->gpio_vbus_inverted);
+
+			hcd = bus_to_hcd(otg->host);
+			usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
+			break;
+		case OTG_STATE_B_PERIPHERAL:
+			if (!otg->gadget)
+				break;
+			otg->phy->state = phy->new_state;
+			usb_add_gadget_udc(phy->phy.dev, otg->gadget);
+			break;
+		default:
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int mxs_usb_phy_init(struct usb_phy *x)
+{
+	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
+	uint32_t val;
+
+	/* Enable clock to the PHY. */
+	clk_enable(phy->clk);
+
+	/* Reset the PHY block. */
+	mxs_reset_block(phy->mem + HW_USBPHY_CTRL);
+
+	/* Power up the PHY. */
+	writel(0, phy->mem + HW_USBPHY_PWD);
+
+	/* Enable FS/LS compatibility. */
+	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3;
+
+	if (phy->host_mode)
+		val |= BM_USBPHY_CTRL_ENHOSTDISCONDETECT;
+	else
+		val |= BM_USBPHY_CTRL_ENIRQDEVPLUGIN |
+			BM_USBPHY_CTRL_ENOTGIDDETECT |
+			BM_USBPHY_CTRL_ENDEVPLUGINDETECT;
+
+	writel(val, phy->mem + HW_USBPHY_CTRL_SET);
+
+	return 0;
+}
+
+static void mxs_usb_phy_shutdown(struct usb_phy *x)
+{
+	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
+
+	/* Gate off the PHY. */
+	writel(BM_USBPHY_CTRL_CLKGATE, phy->mem + HW_USBPHY_CTRL_SET);
+
+	/* Disable clock to the PHY. */
+	clk_disable(phy->clk);
+}
+
+static irqreturn_t mxs_phy_irq(int irq, void *data)
+{
+	struct mxs_usb_phy *phy = data;
+	uint32_t status = readl(phy->mem + HW_USBPHY_STATUS);
+
+	if (status & BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ)
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+			phy->mem + HW_USBPHY_CTRL_CLR);
+	else
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+			phy->mem + HW_USBPHY_CTRL_SET);
+
+	return IRQ_NONE;
+}
+
+static int __devinit mxs_phy_probe(struct platform_device *pdev)
+{
+	struct imx_usb_platform_data *pdata = pdev->dev.platform_data;
+	struct mxs_usb_phy *phy;
+	void *retp;
+	int ret;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform data supplied!\n");
+		return -ENODEV;
+	}
+
+	/* Allocate PHY driver's private date. */
+	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy) {
+		dev_err(&pdev->dev, "Failed to allocate USB PHY structure!\n");
+		ret = -ENOMEM;
+		goto err_resources;
+	}
+
+	/* Allocate OTG structure. */
+	phy->phy.otg = devm_kzalloc(&pdev->dev, sizeof(*phy->phy.otg),
+					GFP_KERNEL);
+	if (!phy->phy.otg) {
+		dev_err(&pdev->dev, "Failed to allocate USB OTG structure!\n");
+		ret = -ENOMEM;
+		goto err_resources;
+	}
+
+	/* Get memory area for PHY from resources. */
+	phy->mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!phy->mem_res) {
+		dev_err(&pdev->dev, "Specify memory area for this USB PHY!\n");
+		ret = -ENODEV;
+		goto err_resources;
+	}
+
+	/* Request the memory region for this USB PHY. */
+	retp = devm_request_mem_region(&pdev->dev, phy->mem_res->start,
+			resource_size(phy->mem_res), pdev->name);
+	if (!retp) {
+		dev_err(&pdev->dev, "USB PHY memory area already in use!\n");
+		ret = -EBUSY;
+		goto err_resources;
+	}
+
+	/* Map the memory region for USB PHY. */
+	phy->mem = devm_ioremap(&pdev->dev, phy->mem_res->start,
+				resource_size(phy->mem_res));
+	if (!phy->mem) {
+		dev_err(&pdev->dev, "Memory mapping of USB PHY failed!\n");
+		ret = -EFAULT;
+		goto err_resources;
+	}
+
+	/* Claim the PHY clock. */
+	phy->clk = clk_get(&pdev->dev, "phy");
+	if (!phy->clk) {
+		dev_err(&pdev->dev, "Failed to claim clock for USB PHY!\n");
+		ret = PTR_ERR(phy->clk);
+		goto err_resources;
+	}
+
+	/* Prepare PHY clock. */
+	ret = clk_prepare(phy->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to prepare clock for USB PHY!\n");
+		goto err_prepare_phy_clock;
+	}
+
+	/* Get IRQ for PHY from resources. */
+	phy->irq = platform_get_irq(pdev, 0);
+	if (phy->irq < 0) {
+		dev_err(&pdev->dev, "Specify IRQ for this USB Host!\n");
+		ret = -ENODEV;
+		goto err_get_phy_irq;
+	}
+
+	/*
+	 * Request the PHY IRQ, this IRQ line is shared between the
+	 * USB Host, USB Gadget and the PHY!
+	 */
+	ret = request_irq(phy->irq, mxs_phy_irq, IRQF_SHARED,
+						pdev->name, phy);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request IRQ!\n");
+		goto err_request_phy_irq;
+	}
+
+	ret = gpio_request_one(pdata->gpio_vbus, GPIOF_DIR_OUT, "USB Power");
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request USB Power GPIO!");
+		goto err_gpio;
+	}
+
+	/* Disable the VBUS. */
+	gpio_set_value(pdata->gpio_vbus, pdata->gpio_vbus_inverted);
+
+	/* Setup the PHY structures. */
+	phy->phy.dev		= &pdev->dev;
+	phy->phy.label		= "mxs-usb-phy";
+	phy->phy.init		= mxs_usb_phy_init;
+	phy->phy.shutdown	= mxs_usb_phy_shutdown;
+	phy->phy.state		= OTG_STATE_UNDEFINED;
+
+	if (pdata->host_mode)
+		phy->new_state	= OTG_STATE_A_HOST;
+	else
+		phy->new_state	= OTG_STATE_B_PERIPHERAL;
+
+	phy->phy.otg->phy	= &phy->phy;
+	phy->phy.otg->set_host	= mxs_usb_set_host;
+	phy->phy.otg->set_peripheral	= mxs_usb_set_peripheral;
+
+	phy->gpio_vbus		= pdata->gpio_vbus;
+	phy->gpio_vbus_inverted	= pdata->gpio_vbus_inverted;
+
+	platform_set_drvdata(pdev, phy);
+
+	ATOMIC_INIT_NOTIFIER_HEAD(&phy->phy.notifier);
+
+	INIT_WORK(&phy->work, mxs_usb_work);
+
+	/* Register the transceiver with kernel. */
+	ret = usb_set_transceiver(&phy->phy);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't register transceiver, (%d)\n", ret);
+		goto err_set_transceiver;
+	}
+
+	return 0;
+
+err_set_transceiver:
+	gpio_free(pdata->gpio_vbus);
+err_gpio:
+	free_irq(phy->irq, phy);
+err_request_phy_irq:
+err_get_phy_irq:
+	clk_unprepare(phy->clk);
+err_prepare_phy_clock:
+	clk_put(phy->clk);
+err_resources:
+	return ret;
+}
+
+static int __devexit mxs_phy_remove(struct platform_device *pdev)
+{
+	struct mxs_usb_phy *phy = platform_get_drvdata(pdev);
+
+	/* Stop the PHY work. */
+	cancel_work_sync(&phy->work);
+
+	/* Power down the PHY. */
+	mxs_usb_phy_shutdown(&phy->phy);
+
+	/* Remove the transceiver. */
+	usb_set_transceiver(NULL);
+
+	/* Shut off VBUS. */
+	gpio_set_value(phy->gpio_vbus, phy->gpio_vbus_inverted);
+	gpio_free(phy->gpio_vbus);
+
+	/* Free the IRQ requested by this device. */
+	free_irq(phy->irq, phy);
+
+	/* Free the IRQ requested by this device. */
+	free_irq(phy->irq, phy);
+
+	/* Stop the PHY clock. */
+	clk_disable_unprepare(phy->clk);
+	clk_put(phy->clk);
+
+	/* Free the rest. */
+	platform_set_drvdata(pdev, NULL);
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
+arch_initcall(mxs_phy_init);
+module_exit(mxs_phy_exit);
+
+MODULE_ALIAS("platform:mxs-usb-phy");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("Freescale i.MX28 USB PHY driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
