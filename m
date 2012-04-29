From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 00:34:16 +0200
Subject: [PATCH 08/11] MXS: Add imx-otg driver
In-Reply-To: <1335738860-26623-1-git-send-email-marex@denx.de>
References: <1335738860-26623-1-git-send-email-marex@denx.de>
Message-ID: <1335738860-26623-9-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver handles claiming of clocks and memory areas. These are later
properly delegated to it's child devices, the USB Host (ehci-mxs) and
USB Gadget (ci13xxx-mxs).

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Liu JunJie-B08287 <B08287@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shi Make-B15407 <B15407@freescale.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/usb/otg/Kconfig   |    6 +
 drivers/usb/otg/Makefile  |    1 +
 drivers/usb/otg/imx-otg.c |  437 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 444 insertions(+)
 create mode 100644 drivers/usb/otg/imx-otg.c

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 5c87db0..e7c6325 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -116,6 +116,12 @@ config FSL_USB2_OTG
 	help
 	  Enable this to support Freescale USB OTG transceiver.
 
+config USB_IMX_COMPOSITE
+	bool
+	help
+	  Composite driver that handles clock and memory mapping for
+	  i.MX USB host and USB PHY.
+
 config USB_MV_OTG
 	tristate "Marvell USB OTG support"
 	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index 41aa509..7d2c631 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -20,4 +20,5 @@ obj-$(CONFIG_USB_MSM_OTG)	+= msm_otg.o
 obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
 fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
 obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
+obj-$(CONFIG_USB_IMX_COMPOSITE)	+= imx-otg.o
 obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
diff --git a/drivers/usb/otg/imx-otg.c b/drivers/usb/otg/imx-otg.c
new file mode 100644
index 0000000..f8bf4c4
--- /dev/null
+++ b/drivers/usb/otg/imx-otg.c
@@ -0,0 +1,437 @@
+/*
+ * drivers/usb/otg/imx-otg.c
+ *
+ * Freescale i.MX USB composite driver.
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
+#include <linux/usb/mxs-usb.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <linux/usb.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/ehci_def.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+/*
+ * Allocate platform device with the DMA mask, this is borrowed from
+ * arch/arm/mach-mxs/devices.c
+ */
+static struct platform_device *__devinit add_platform_device(
+		const char *name, int id,
+		const void *data, size_t size_data, u64 dmamask)
+{
+	int ret = -ENOMEM;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev)
+		goto err;
+
+	if (dmamask) {
+		/*
+		 * This memory isn't freed when the device is put,
+		 * I don't have a nice idea for that though.  Conceptually
+		 * dma_mask in struct device should not be a pointer.
+		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
+		 */
+		pdev->dev.dma_mask =
+			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
+		if (!pdev->dev.dma_mask)
+			/* ret is still -ENOMEM; */
+			goto err;
+
+		*pdev->dev.dma_mask = dmamask;
+		pdev->dev.coherent_dma_mask = dmamask;
+	}
+
+	if (data) {
+		ret = platform_device_add_data(pdev, data, size_data);
+		if (ret)
+			goto err;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+err:
+		if (dmamask)
+			kfree(pdev->dev.dma_mask);
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
+
+	return pdev;
+}
+
+static int imx_otg_set_host(struct usb_otg *otg, struct usb_bus *host)
+{
+	struct imx_otg_priv *priv = container_of(otg, struct imx_otg_priv, otg);
+
+	if (host) {
+		BUG_ON(otg->host);
+		otg->host = host;
+	} else {
+		BUG_ON(!otg->host);
+	}
+
+	schedule_work(&priv->work);
+
+	return 0;
+}
+
+static int imx_otg_set_peripheral(struct usb_otg *otg, struct usb_gadget *gg)
+{
+	struct imx_otg_priv *priv = container_of(otg, struct imx_otg_priv, otg);
+
+	if (gg) {
+		BUG_ON(otg->gadget);
+		otg->gadget = gg;
+	} else {
+		BUG_ON(!otg->gadget);
+	}
+
+	schedule_work(&priv->work);
+
+	return 0;
+}
+
+static void imx_otg_work(struct work_struct *w)
+{
+	struct imx_otg_priv *priv = container_of(w, struct imx_otg_priv, work);
+	struct usb_hcd *hcd;
+
+sm:
+	switch (priv->cur_state) {
+	case OTG_STATE_A_HOST:
+		if ((priv->new_state == OTG_STATE_B_PERIPHERAL) ||
+			(priv->new_state == OTG_STATE_UNDEFINED)) {
+			hcd = bus_to_hcd(priv->otg.host);
+			usb_remove_hcd(hcd);
+			priv->cur_state = OTG_STATE_UNDEFINED;
+			/* Turn off VBUS */
+			gpio_set_value(priv->gpio_vbus,
+				priv->gpio_vbus_inverted);
+		}
+		if (priv->new_state == OTG_STATE_B_PERIPHERAL)
+			goto sm;
+		break;
+	case OTG_STATE_B_PERIPHERAL:
+		if ((priv->new_state == OTG_STATE_A_HOST) ||
+			(priv->new_state == OTG_STATE_UNDEFINED)) {
+			usb_del_gadget_udc(priv->otg.gadget);
+			priv->cur_state = OTG_STATE_UNDEFINED;
+		}
+		if (priv->new_state == OTG_STATE_A_HOST)
+			goto sm;
+		break;
+	case OTG_STATE_UNDEFINED:
+		/* Check desired state. */
+		switch (priv->new_state) {
+		case OTG_STATE_A_HOST:
+			if (!priv->otg.host)
+				break;
+			priv->cur_state = priv->new_state;
+
+			/* Turn on VBUS */
+			gpio_set_value(priv->gpio_vbus,
+				!priv->gpio_vbus_inverted);
+
+			hcd = bus_to_hcd(priv->otg.host);
+			usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
+			break;
+		case OTG_STATE_B_PERIPHERAL:
+			if (!priv->otg.gadget)
+				break;
+			priv->cur_state = priv->new_state;
+			usb_add_gadget_udc(priv->dev, priv->otg.gadget);
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
+static irqreturn_t imx_otg_irq(int irq, void *irqdata)
+{
+	/* We do nothing during wakeup so far */
+	return IRQ_NONE;
+}
+
+static int __devinit imx_usb_probe(struct platform_device *pdev)
+{
+	struct imx_usb_platform_data *pdata = pdev->dev.platform_data;
+	struct imx_otg_priv *priv;
+	struct imx_otg *data;
+	struct usb_phy *phy;
+	struct usb_otg *otg;
+	int ret;
+	void *retp = NULL;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform data supplied!\n");
+		return -ENODEV;
+	}
+
+	phy = usb_get_transceiver();
+	if (!phy)
+		return -EPROBE_DEFER;
+
+	/*
+	 * Until further notice, this claims all necessary resources.
+	 */
+
+	/* Claim the VBUS GPIO */
+	ret = gpio_request_one(pdata->gpio_vbus, GPIOF_DIR_OUT, "USB Power");
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request USB Power GPIO!");
+		ret = -EINVAL;
+		goto err_alloc_data;
+	}
+
+	/* Disable the VBUS. */
+	gpio_set_value(pdata->gpio_vbus, pdata->gpio_vbus_inverted);
+
+	/* Allocate driver's private date. */
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		dev_err(&pdev->dev, "Failed to allocate OTG nodes data!\n");
+		ret = -ENOMEM;
+		goto err_alloc_data;
+	}
+
+	priv = &data->priv;
+
+	/* Configure the OTG structure. */
+	otg				= &priv->otg;
+	otg->phy			= phy;
+	otg->set_host			= imx_otg_set_host;
+	otg->set_peripheral		= imx_otg_set_peripheral;
+	phy->otg			= otg;
+
+	priv->dev			= &pdev->dev;
+	priv->gpio_vbus			= pdata->gpio_vbus;
+	priv->gpio_vbus_inverted	= pdata->gpio_vbus_inverted;
+	priv->cur_state			= OTG_STATE_UNDEFINED;
+	priv->new_state			= OTG_STATE_UNDEFINED;
+
+	/* We do NOT support OTG yet */
+	if (pdata->host_mode && !pdata->gadget_mode)
+		priv->new_state	= OTG_STATE_A_HOST;
+	else if (pdata->gadget_mode)
+		priv->new_state	= OTG_STATE_B_PERIPHERAL;
+
+	INIT_WORK(&priv->work, imx_otg_work);
+
+	/* Claim the Host clock. */
+	data->clk = clk_get(&pdev->dev, "usb");
+	if (IS_ERR(data->clk)) {
+		dev_err(&pdev->dev, "Failed to claim clock for USB Host\n");
+		ret = PTR_ERR(data->clk);
+		goto err_alloc_data;
+	}
+
+	/* Prepare Host clock. */
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable clock for USB Host.\n");
+		goto err_prepare_host_clock;
+	}
+
+	/* Get memory area for EHCI host from resources. */
+	data->mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!data->mem_res) {
+		dev_err(&pdev->dev, "Specify memory area for this USB Host!\n");
+		ret = -ENODEV;
+		goto err_get_host_resource;
+	}
+
+	/* Request the memory region for this USB Host. */
+	retp = devm_request_mem_region(&pdev->dev, data->mem_res->start,
+			resource_size(data->mem_res), pdev->name);
+	if (!retp) {
+		dev_err(&pdev->dev, "USB Host memory area already in use!\n");
+		ret = -EBUSY;
+		goto err_get_host_resource;
+	}
+
+	/* Map the memory region for USB Host. */
+	data->mem = devm_ioremap(&pdev->dev, data->mem_res->start,
+				resource_size(data->mem_res));
+	if (!data->mem) {
+		dev_err(&pdev->dev, "Memory mapping of USB Host failed!\n");
+		ret = -EFAULT;
+		goto err_get_host_resource;
+	}
+
+	/* Get IRQ for EHCI host from resources. */
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0) {
+		dev_err(&pdev->dev, "Specify IRQ for this USB Host!\n");
+		ret = -ENODEV;
+		goto err_get_host_resource;
+	}
+
+	/* Get IRQ for PHY wakeup from resources. */
+	data->irq_wakeup = platform_get_irq(pdev, 1);
+	if (data->irq_wakeup < 0) {
+		dev_err(&pdev->dev, "Specify wakeup IRQ for this USB Host!\n");
+		ret = -ENODEV;
+		goto err_get_host_resource;
+	}
+
+	/* Request the Wakeup IRQ. */
+	ret = devm_request_irq(&pdev->dev, data->irq_wakeup, imx_otg_irq,
+				IRQF_SHARED, "imx-otg-wakeup-irq", data);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request IRQ!\n");
+		goto err_get_host_resource;
+	}
+
+	/*
+	 * Now finally probe the Host driver!
+	 */
+	if (pdata->gadget_mode) {
+		data->pdev_gadget = add_platform_device("ci13xxx-mxs", -1,
+							data, sizeof(*data),
+							DMA_BIT_MASK(32));
+		if (!data->pdev_gadget) {
+			dev_err(&pdev->dev, "Failed registering Host!\n");
+			ret = -ENODEV;
+			goto err_register_gadget;
+		}
+	}
+
+	if (pdata->host_mode) {
+		data->pdev_host = add_platform_device("mxs-ehci", -1,
+							data, sizeof(*data),
+							DMA_BIT_MASK(32));
+		if (!data->pdev_host) {
+			dev_err(&pdev->dev, "Failed registering Host!\n");
+			ret = -ENODEV;
+			goto err_get_host_resource;
+		}
+	}
+
+	/*
+	 * Initialize the transceiver
+	 */
+	phy = usb_get_transceiver();
+	if (!phy) {
+		dev_err(&pdev->dev, "Unable to find transceiver.\n");
+		ret = -ENODEV;
+		goto err_phy;
+	}
+
+	ret = usb_phy_init(phy);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable init transceiver\n");
+		ret = -ENODEV;
+		goto err_phy_init;
+	}
+
+	/* Kick in the state machine. */
+	schedule_work(&priv->work);
+
+	return 0;
+
+err_phy_init:
+	if (phy)
+		usb_put_transceiver(phy);
+err_phy:
+	if (data->pdev_gadget)
+		platform_device_unregister(data->pdev_gadget);
+err_register_gadget:
+	if (data->pdev_host)
+		platform_device_unregister(data->pdev_host);
+err_get_host_resource:
+	clk_disable_unprepare(data->clk);
+err_prepare_host_clock:
+	clk_put(data->clk);
+err_alloc_data:
+	return ret;
+}
+
+static int __devexit imx_usb_remove(struct platform_device *pdev)
+{
+	struct imx_otg *data = platform_get_drvdata(pdev);
+	struct imx_otg_priv *priv = &data->priv;
+
+	/* Stop the PHY work. */
+	cancel_work_sync(&priv->work);
+
+	/* Shut off VBUS. */
+	gpio_set_value(priv->gpio_vbus, priv->gpio_vbus_inverted);
+	gpio_free(priv->gpio_vbus);
+
+	/* Deregister both Gadget and Host driver. */
+	if (data->pdev_gadget)
+		platform_device_unregister(data->pdev_gadget);
+
+	if (data->pdev_host)
+		platform_device_unregister(data->pdev_host);
+
+	/* Stop the clock. */
+	clk_disable_unprepare(data->clk);
+	clk_put(data->clk);
+
+	return 0;
+}
+
+static struct platform_driver imx_usb_driver = {
+	.probe		= imx_usb_probe,
+	.remove		= __devexit_p(imx_usb_remove),
+	.driver		= {
+		.name	= "imx-otg",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init imx_usb_init(void)
+{
+	return platform_driver_register(&imx_usb_driver);
+}
+
+static void __exit imx_usb_exit(void)
+{
+	platform_driver_unregister(&imx_usb_driver);
+}
+
+module_init(imx_usb_init);
+module_exit(imx_usb_exit);
+
+MODULE_ALIAS("platform:imx-otg");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("Freescale i.MX USB composite driver");
+MODULE_LICENSE("GPL");
-- 
1.7.10
