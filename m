From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 15 Nov 2011 15:31:56 +0900
Subject: [PATCH 3/3] USB: Add S5P OHCI diver
Message-ID: <1321338716-15593-1-git-send-email-jg1.han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USB OHCI driver for Samsung S5P SoCs.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/usb/Kconfig         |    1 +
 drivers/usb/host/Kconfig    |    6 +
 drivers/usb/host/ohci-hcd.c |    5 +
 drivers/usb/host/ohci-s5p.c |  273 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 285 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ohci-s5p.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 791f11b..39a4876 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -48,6 +48,7 @@ config USB_ARCH_HAS_OHCI
 	default y if ARCH_DAVINCI_DA8XX
 	default y if ARCH_CNS3XXX
 	default y if PLAT_SPEAR
+	default y if PLAT_S5P
 	# PPC:
 	default y if STB03xxx
 	default y if PPC_MPC52xx
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 060e0e2..11460c6 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -371,6 +371,12 @@ config USB_OHCI_SH
 	  Enables support for the on-chip OHCI controller on the SuperH.
 	  If you use the PCI OHCI controller, this option is not necessary.
 
+config USB_OHCI_S5P
+	boolean "S5P OHCI support"
+	depends on USB_OHCI_HCD && PLAT_S5P
+	help
+	 Enable support for the S5P SOC's on-chip OHCI controller.
+
 config USB_CNS3XXX_OHCI
 	bool "Cavium CNS3XXX OHCI Module"
 	depends on USB_OHCI_HCD && ARCH_CNS3XXX
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 34efd47..c3c9648 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1008,6 +1008,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_s3c2410_driver
 #endif
 
+#ifdef CONFIG_USB_OHCI_S5P
+#include "ohci-s5p.c"
+#define PLATFORM_DRIVER		s5p_ohci_driver
+#endif
+
 #ifdef CONFIG_USB_OHCI_HCD_OMAP1
 #include "ohci-omap.c"
 #define OMAP1_PLATFORM_DRIVER	ohci_hcd_omap_driver
diff --git a/drivers/usb/host/ohci-s5p.c b/drivers/usb/host/ohci-s5p.c
new file mode 100644
index 0000000..5b9824b
--- /dev/null
+++ b/drivers/usb/host/ohci-s5p.c
@@ -0,0 +1,273 @@
+/*
+ * SAMSUNG S5P USB HOST OHCI Controller
+ *
+ * Copyright (C) 2011 Samsung Electronics Co.Ltd
+ * Author: Jingoo Han <jg1.han@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <plat/ohci.h>
+#include <plat/usb-phy.h>
+
+struct s5p_ohci_hcd {
+	struct device *dev;
+	struct usb_hcd *hcd;
+	struct clk *clk;
+};
+
+static int ohci_s5p_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int ret;
+
+	ohci_dbg(ohci, "ohci_s5p_start, ohci:%p", ohci);
+
+	ret = ohci_init(ohci);
+	if (ret < 0)
+		return ret;
+
+	ret = ohci_run(ohci);
+	if (ret < 0) {
+		err("can't start %s", hcd->self.bus_name);
+		ohci_stop(hcd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct hc_driver s5p_ohci_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "S5P OHCI Host Controller",
+	.hcd_priv_size		= sizeof(struct ohci_hcd),
+
+	.irq			= ohci_irq,
+	.flags			= HCD_MEMORY|HCD_USB11,
+
+	.start			= ohci_s5p_start,
+	.stop			= ohci_stop,
+	.shutdown		= ohci_shutdown,
+
+	.get_frame_number	= ohci_get_frame,
+
+	.urb_enqueue		= ohci_urb_enqueue,
+	.urb_dequeue		= ohci_urb_dequeue,
+	.endpoint_disable	= ohci_endpoint_disable,
+
+	.hub_status_data	= ohci_hub_status_data,
+	.hub_control		= ohci_hub_control,
+#ifdef	CONFIG_PM
+	.bus_suspend		= ohci_bus_suspend,
+	.bus_resume		= ohci_bus_resume,
+#endif
+	.start_port_reset	= ohci_start_port_reset,
+};
+
+static int __devinit s5p_ohci_probe(struct platform_device *pdev)
+{
+	struct s5p_ohci_platdata *pdata;
+	struct s5p_ohci_hcd *s5p_ohci;
+	struct usb_hcd *hcd;
+	struct ohci_hcd *ohci;
+	struct resource *res;
+	int irq;
+	int err;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform data defined\n");
+		return -EINVAL;
+	}
+
+	s5p_ohci = kzalloc(sizeof(struct s5p_ohci_hcd), GFP_KERNEL);
+	if (!s5p_ohci)
+		return -ENOMEM;
+
+	s5p_ohci->dev = &pdev->dev;
+
+	hcd = usb_create_hcd(&s5p_ohci_hc_driver, &pdev->dev,
+					dev_name(&pdev->dev));
+	if (!hcd) {
+		dev_err(&pdev->dev, "Unable to create HCD\n");
+		err = -ENOMEM;
+		goto fail_hcd;
+	}
+
+	s5p_ohci->hcd = hcd;
+	s5p_ohci->clk = clk_get(&pdev->dev, "usbhost");
+
+	if (IS_ERR(s5p_ohci->clk)) {
+		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
+		err = PTR_ERR(s5p_ohci->clk);
+		goto fail_clk;
+	}
+
+	err = clk_enable(s5p_ohci->clk);
+	if (err)
+		goto fail_clken;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get I/O memory\n");
+		err = -ENXIO;
+		goto fail_io;
+	}
+
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+	hcd->regs = ioremap(res->start, resource_size(res));
+	if (!hcd->regs) {
+		dev_err(&pdev->dev, "Failed to remap I/O memory\n");
+		err = -ENOMEM;
+		goto fail_io;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (!irq) {
+		dev_err(&pdev->dev, "Failed to get IRQ\n");
+		err = -ENODEV;
+		goto fail;
+	}
+
+	if (pdata->phy_init)
+		pdata->phy_init(pdev, S5P_USB_PHY_HOST);
+
+	ohci = hcd_to_ohci(hcd);
+	ohci_hcd_init(ohci);
+
+	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add USB HCD\n");
+		goto fail;
+	}
+
+	platform_set_drvdata(pdev, s5p_ohci);
+
+	return 0;
+
+fail:
+	iounmap(hcd->regs);
+fail_io:
+	clk_disable(s5p_ohci->clk);
+fail_clken:
+	clk_put(s5p_ohci->clk);
+fail_clk:
+	usb_put_hcd(hcd);
+fail_hcd:
+	kfree(s5p_ohci);
+	return err;
+}
+
+static int __devexit s5p_ohci_remove(struct platform_device *pdev)
+{
+	struct s5p_ohci_platdata *pdata = pdev->dev.platform_data;
+	struct s5p_ohci_hcd *s5p_ohci = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = s5p_ohci->hcd;
+
+	usb_remove_hcd(hcd);
+
+	if (pdata && pdata->phy_exit)
+		pdata->phy_exit(pdev, S5P_USB_PHY_HOST);
+
+	iounmap(hcd->regs);
+
+	clk_disable(s5p_ohci->clk);
+	clk_put(s5p_ohci->clk);
+
+	usb_put_hcd(hcd);
+	kfree(s5p_ohci);
+
+	return 0;
+}
+
+static void s5p_ohci_shutdown(struct platform_device *pdev)
+{
+	struct s5p_ohci_hcd *s5p_ohci = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = s5p_ohci->hcd;
+
+	if (hcd->driver->shutdown)
+		hcd->driver->shutdown(hcd);
+}
+
+#ifdef CONFIG_PM
+static int s5p_ohci_suspend(struct device *dev)
+{
+	struct s5p_ohci_hcd *s5p_ohci = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = s5p_ohci->hcd;
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s5p_ohci_platdata *pdata = pdev->dev.platform_data;
+	unsigned long flags;
+	int rc = 0;
+
+	/* Root hub was already suspended. Disable irq emission and
+	 * mark HW unaccessible, bail out if RH has been resumed. Use
+	 * the spinlock to properly synchronize with possible pending
+	 * RH suspend or resume activity.
+	 *
+	 * This is still racy as hcd->state is manipulated outside of
+	 * any locks =P But that will be a different fix.
+	 */
+	spin_lock_irqsave(&ohci->lock, flags);
+	if (hcd->state != HC_STATE_SUSPENDED && hcd->state != HC_STATE_HALT) {
+		rc = -EINVAL;
+		goto fail;
+	}
+
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+	if (pdata && pdata->phy_exit)
+		pdata->phy_exit(pdev, S5P_USB_PHY_HOST);
+fail:
+	spin_unlock_irqrestore(&ohci->lock, flags);
+
+	return rc;
+}
+
+static int s5p_ohci_resume(struct device *dev)
+{
+	struct s5p_ohci_hcd *s5p_ohci = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = s5p_ohci->hcd;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s5p_ohci_platdata *pdata = pdev->dev.platform_data;
+
+	if (pdata && pdata->phy_init)
+		pdata->phy_init(pdev, S5P_USB_PHY_HOST);
+
+	/* Mark hardware accessible again as we are out of D3 state by now */
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+	ohci_finish_controller_resume(hcd);
+
+	return 0;
+}
+#else
+#define s5p_ohci_suspend	NULL
+#define s5p_ohci_resume		NULL
+#endif
+
+static const struct dev_pm_ops s5p_ohci_pm_ops = {
+	.suspend	= s5p_ohci_suspend,
+	.resume		= s5p_ohci_resume,
+};
+
+static struct platform_driver s5p_ohci_driver = {
+	.probe		= s5p_ohci_probe,
+	.remove		= __devexit_p(s5p_ohci_remove),
+	.shutdown	= s5p_ohci_shutdown,
+	.driver = {
+		.name	= "s5p-ohci",
+		.owner	= THIS_MODULE,
+		.pm	= &s5p_ohci_pm_ops,
+	}
+};
+
+MODULE_ALIAS("platform:s5p-ohci");
+MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
-- 
1.7.1
