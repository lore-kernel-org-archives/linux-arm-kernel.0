From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Apr 2012 19:46:32 +0200
Subject: [PATCH 08/10] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <1334771194-18688-1-git-send-email-marex@denx.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-1-git-send-email-marex@denx.de>
Message-ID: <1334771194-18688-9-git-send-email-marex@denx.de>
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
 drivers/usb/host/Kconfig    |    7 ++
 drivers/usb/host/ehci-hcd.c |    5 +
 drivers/usb/host/ehci-mxs.c |  228 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
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
index 0000000..f3d23de
--- /dev/null
+++ b/drivers/usb/host/ehci-mxs.c
@@ -0,0 +1,228 @@
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
+#include <linux/fsl_devices.h>
+
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+#include <mach/mx28.h>
+
+#include <asm/mach-types.h>
+
+/* Called during probe() after chip reset completes */
+static int ehci_mxs_setup(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+	hcd->has_tt = 1;
+	ehci_setup(hcd);
+	ehci_port_power(ehci, 0);
+
+	return 0;
+}
+
+static irqreturn_t mxs_ehci_irq(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	struct usb_phy *phy = usb_get_transceiver();
+	uint32_t status;
+	static uint32_t discon;
+
+	if (phy && phy->otg && phy->otg->set_vbus) {
+		status = ehci_readl(ehci, &ehci->regs->status);
+		status = !!(status & STS_PCD);
+		if (status != discon) {
+			discon = status;
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
+	struct device *dev = &pdev->dev;
+	struct imx_usb *data = pdev->dev.platform_data;
+	struct usb_hcd *hcd;
+	struct ehci_hcd *ehci;
+	struct usb_phy *phy;
+	int ret;
+
+	dev_info(dev, "Initializing i.MX28 USB Controller\n");
+
+	if (!data) {
+		dev_err(dev, "USB Host platform data missing!\n");
+		return -ENODEV;
+	}
+
+	/* Create HCD controller instance. */
+	hcd = usb_create_hcd(&ehci_mxs_hc_driver, dev, dev_name(dev));
+	if (!hcd) {
+		dev_err(dev, "Failed to create HCD instance!\n");
+		return -ENOMEM;
+	}
+
+	hcd->rsrc_start = data->mem_res->start;
+	hcd->rsrc_len = resource_size(data->mem_res);
+	hcd->regs = data->mem;
+	hcd->irq = data->irq;
+
+	clk_enable(data->clk);
+
+	/* Wait for the controller to stabilize. */
+	mdelay(10);
+
+	ehci = hcd_to_ehci(hcd);
+
+	/* EHCI registers start at offset 0x100 */
+	ehci->caps = hcd->regs + 0x100;
+	ehci->regs = hcd->regs + 0x100 +
+		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
+
+	platform_set_drvdata(pdev, hcd);
+
+	/* Initialize the transceiver */
+#ifdef CONFIG_USB_OTG_UTILS
+	phy = usb_get_transceiver();
+	if (!phy) {
+		dev_err(dev, "Unable to find transceiver.\n");
+		ret = -ENODEV;
+		goto err_phy;
+	}
+
+	ret = otg_set_host(phy->otg, &hcd->self);
+	if (ret < 0) {
+		dev_err(dev, "Unable to set transceiver host\n");
+		ret = -ENODEV;
+		goto err_phy_set_host;
+	}
+
+	ret = usb_phy_init(phy);
+	if (ret < 0) {
+		dev_err(dev, "Unable init transceiver\n");
+		ret = -ENODEV;
+		goto err_phy_init;
+	}
+#else
+	dev_info(dev, "USB_MXS_PHY must have CONFIG_USB_OTG_UTILS enabled\n");
+	goto err_phy;
+#endif
+
+	/* Set up the PORTSCx register */
+	ehci_writel(ehci, 0, &ehci->regs->port_status[0]);
+
+	return 0;
+
+err_phy_init:
+err_phy_set_host:
+#ifdef CONFIG_USB_OTG_UTILS
+	if (phy)
+		usb_put_transceiver(phy);
+#endif
+err_phy:
+	clk_disable(data->clk);
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int __exit ehci_mxs_drv_remove(struct platform_device *pdev)
+{
+	struct imx_usb *data = pdev->dev.platform_data;
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct usb_phy *phy = usb_get_transceiver();
+
+	if (phy)
+		usb_phy_shutdown(phy);
+
+	usb_remove_hcd(hcd);
+	usb_put_hcd(hcd);
+	platform_set_drvdata(pdev, NULL);
+	clk_disable(data->clk);
+
+	return 0;
+}
+
+static struct platform_driver ehci_mxs_driver = {
+	.probe		= ehci_mxs_drv_probe,
+	.remove		= __exit_p(ehci_mxs_drv_remove),
+	.driver		= {
+		   .name	= "mxs-ehci",
+	},
+};
+
+MODULE_ALIAS("platform:mxs-ehci");
-- 
1.7.9.5
