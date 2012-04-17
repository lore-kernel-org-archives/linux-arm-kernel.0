From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Apr 2012 12:15:49 +0200
Subject: [PATCH 6/8] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <1334657751-27678-1-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
Message-ID: <1334657751-27678-7-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver will handle i.MX233/i.MX28 and I hope soon i.MX6Q. I tried to keep
this separate from the MXC EHCI to avoid further polution of the MXC EHCI,
though eventually these two might be merged.

NOTE: I still haven't figured out how to enable/disable the disconnection
detector, it can't be enabled all the time, so I toggle PHY stuff from this
driver, which I doubt is correct.

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
 drivers/usb/host/Kconfig    |    7 +
 drivers/usb/host/ehci-hcd.c |    5 +
 drivers/usb/host/ehci-mxs.c |  309 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 drivers/usb/host/ehci-mxs.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index f788eb8..85ed593 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -148,6 +148,13 @@ config USB_EHCI_MXC
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
+config USB_EHCI_MXS
+	bool "Support for Freescale i.MX28 on-chip EHCI USB controller"
+	depends on USB_EHCI_HCD && ARCH_MXS
+	select USB_EHCI_ROOT_HUB_TT
+	---help---
+	  Enable USB support for i.MX28.
+
 config USB_EHCI_HCD_OMAP
 	bool "EHCI support for OMAP3 and later chips"
 	depends on USB_EHCI_HCD && ARCH_OMAP
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 806cc95..d0df8be 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1263,6 +1263,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_mxc_driver
 #endif
 
+#ifdef CONFIG_USB_EHCI_MXS
+#include "ehci-mxs.c"
+#define PLATFORM_DRIVER		ehci_mxs_driver
+#endif
+
 #ifdef CONFIG_USB_EHCI_SH
 #include "ehci-sh.c"
 #define PLATFORM_DRIVER		ehci_hcd_sh_driver
diff --git a/drivers/usb/host/ehci-mxs.c b/drivers/usb/host/ehci-mxs.c
new file mode 100644
index 0000000..906738e
--- /dev/null
+++ b/drivers/usb/host/ehci-mxs.c
@@ -0,0 +1,309 @@
+/*
+ * Freescale i.MX28 EHCI driver
+ *
+ * Copyright (c) 2012 Marek Vasut <marex@denx.de>
+ * on behalf of DENX Software Engineering GmbH
+ *
+ * Based on MXC EHCI driver:
+ *
+ * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+#include <linux/slab.h>
+
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+#include <mach/mx28.h>
+
+#include <asm/mach-types.h>
+
+#define MXC_EHCI_MODE_ULPI	(2 << 30)
+
+struct ehci_mxs_priv {
+	struct clk	*usbclk;
+	struct usb_hcd	*hcd;
+	struct usb_phy	*phy;
+	bool		discon;
+};
+
+/* Called during probe() after chip reset completes */
+static int ehci_mxs_setup(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int retval;
+
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	/* Cache this readonly data; minimize chip reads. */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+
+	hcd->has_tt = 1;
+
+	retval = ehci_halt(ehci);
+	if (retval)
+		return retval;
+
+	/* Data structure init. */
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
+	ehci->sbrn = 0x20;
+
+	ehci_reset(ehci);
+
+	ehci_port_power(ehci, 0);
+
+	return 0;
+}
+
+static irqreturn_t mxs_ehci_irq(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	struct device *dev = hcd->self.controller;
+	struct ehci_mxs_priv *ehci_mxs = dev_get_drvdata(dev);
+	struct usb_phy *phy = ehci_mxs->phy;
+	u32 status;
+
+	if (phy && phy->otg && phy->otg->set_vbus) {
+		status = ehci_readl(ehci, &ehci->regs->status);
+		status = !!(status & STS_PCD);
+		if (status != ehci_mxs->discon) {
+			ehci_mxs->discon = status;
+			phy->otg->set_vbus(phy->otg, status);
+		}
+	}
+
+	return ehci_irq(hcd);
+}
+
+static const struct hc_driver ehci_mxs_hc_driver = {
+	.description	= hcd_name,
+	.product_desc	= "Freescale i.MX28 On-Chip EHCI Host Controller",
+	.hcd_priv_size	= sizeof(struct ehci_hcd),
+
+	/*
+	 * Generic hardware linkage
+	 */
+	.irq		= mxs_ehci_irq,
+	.flags		= HCD_USB2 | HCD_MEMORY,
+
+	/*
+	 * Basic lifecycle operations
+	 */
+	.reset		= ehci_mxs_setup,
+	.start		= ehci_run,
+	.stop		= ehci_stop,
+	.shutdown	= ehci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue		= ehci_urb_enqueue,
+	.urb_dequeue		= ehci_urb_dequeue,
+	.endpoint_disable	= ehci_endpoint_disable,
+	.endpoint_reset		= ehci_endpoint_reset,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number	= ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data	= ehci_hub_status_data,
+	.hub_control		= ehci_hub_control,
+	.bus_suspend		= ehci_bus_suspend,
+	.bus_resume		= ehci_bus_resume,
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+
+	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
+};
+
+static int ehci_mxs_drv_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res;
+	int irq, ret;
+	struct ehci_mxs_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct ehci_hcd *ehci;
+
+	dev_info(&pdev->dev, "Initializing i.MX28 USB Controller\n");
+
+	/* Get IRQ from platform data via resources. */
+	irq = platform_get_irq(pdev, 0);
+
+	/* Create HCD controller instance. */
+	hcd = usb_create_hcd(&ehci_mxs_hc_driver, dev, dev_name(dev));
+	if (!hcd) {
+		dev_err(dev, "Failed to create HCD instance!\n");
+		return -ENOMEM;
+	}
+
+	/* Allocate private data for this instance. */
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(dev, "Failed to allocate private data!\n");
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	/* Get memory area where this controller resides from resources. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "Specify memory area for this controller!\n");
+		ret = -ENODEV;
+		goto err_get_resource;
+	}
+
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		dev_dbg(dev, "controller already in use\n");
+		ret = -EBUSY;
+		goto err_request_mem;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		dev_err(dev, "error mapping memory\n");
+		ret = -EFAULT;
+		goto err_ioremap;
+	}
+
+	/* enable clocks */
+	priv->usbclk = clk_get(dev, "usb");
+	if (IS_ERR(priv->usbclk)) {
+		ret = PTR_ERR(priv->usbclk);
+		goto err_clk;
+	}
+	clk_prepare_enable(priv->usbclk);
+
+	/* Wait for the controller to stabilize. */
+	mdelay(10);
+
+	/* Initialize the transceiver */
+#ifdef CONFIG_USB_OTG_UTILS
+	priv->phy = usb_get_transceiver();
+	if (!priv->phy) {
+		dev_err(&pdev->dev, "Unable to find transceiver.\n");
+		ret = -ENODEV;
+		goto err_add;
+	}
+
+	ret = usb_phy_init(priv->phy);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable init transceiver\n");
+		ret = -ENODEV;
+		goto err_put_tx;
+	}
+#else
+	dev_info(&pdev->dev,
+		"USB_MXS_PHY must have CONFIG_USB_OTG_UTILS enabled\n");
+	goto err_add;
+#endif
+
+	ehci = hcd_to_ehci(hcd);
+
+	/* EHCI registers start at offset 0x100 */
+	ehci->caps = hcd->regs + 0x100;
+	ehci->regs = hcd->regs + 0x100 +
+		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
+
+	/* Set up the PORTSCx register */
+	ehci_writel(ehci, MXC_EHCI_MODE_ULPI, &ehci->regs->port_status[0]);
+
+	priv->discon = false;
+	priv->hcd = hcd;
+	platform_set_drvdata(pdev, priv);
+
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto err_add;
+
+	return 0;
+
+#ifdef CONFIG_USB_OTG_UTILS
+err_put_tx:
+	usb_put_transceiver(priv->phy);
+#endif
+err_add:
+	clk_disable_unprepare(priv->usbclk);
+	clk_put(priv->usbclk);
+err_clk:
+	iounmap(hcd->regs);
+err_ioremap:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err_request_mem:
+err_get_resource:
+	kfree(priv);
+err_alloc:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int __exit ehci_mxs_drv_remove(struct platform_device *pdev)
+{
+	struct ehci_mxs_priv *priv = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = priv->hcd;
+
+	if (priv->phy)
+		usb_phy_shutdown(priv->phy);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	platform_set_drvdata(pdev, NULL);
+
+	clk_disable_unprepare(priv->usbclk);
+	clk_put(priv->usbclk);
+	kfree(priv);
+
+	return 0;
+}
+
+static void ehci_mxs_drv_shutdown(struct platform_device *pdev)
+{
+	struct ehci_mxs_priv *priv = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = priv->hcd;
+
+	if (hcd->driver->shutdown)
+		hcd->driver->shutdown(hcd);
+}
+
+static struct platform_driver ehci_mxs_driver = {
+	.probe		= ehci_mxs_drv_probe,
+	.remove		= __exit_p(ehci_mxs_drv_remove),
+	.shutdown	= ehci_mxs_drv_shutdown,
+	.driver		= {
+		   .name	= "mxs-ehci",
+	},
+};
+
+MODULE_ALIAS("platform:mxs-ehci");
-- 
1.7.9.5
