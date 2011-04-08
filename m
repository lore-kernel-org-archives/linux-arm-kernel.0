From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 08 Apr 2011 14:08:50 +0900
Subject: [PATCH 4/4 RESEND] USB: Add initial S5P EHCI driver
Message-ID: <1302239330-28669-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds host USB high speed driver for samsung S5P series. This
is initial driver and we need additional implementation to support some
functions like power management.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
Add missing Signed-off-by.

 drivers/usb/Kconfig         |    1 +
 drivers/usb/host/Kconfig    |    6 ++
 drivers/usb/host/ehci-hcd.c |    5 +
 drivers/usb/host/ehci-s5p.c |  201 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 213 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ehci-s5p.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 41b6e51..e0a9f2a 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -65,6 +65,7 @@ config USB_ARCH_HAS_EHCI
 	default y if ARCH_CNS3XXX
 	default y if ARCH_VT8500
 	default y if PLAT_SPEAR
+	default y if PLAT_S5P
 	default y if ARCH_MSM
 	default PCI
 
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 9483acd..0fe36a2 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -188,6 +188,12 @@ config USB_EHCI_SH
 	  Enables support for the on-chip EHCI controller on the SuperH.
 	  If you use the PCI EHCI controller, this option is not necessary.
 
+config USB_EHCI_S5P
+       boolean "S5P EHCI support"
+       depends on USB_EHCI_HCD && PLAT_S5P
+       help
+	 Enable support for the S5P SOC's on-chip EHCI controller.
+
 config USB_W90X900_EHCI
 	bool "W90X900(W90P910) EHCI support"
 	depends on USB_EHCI_HCD && ARCH_W90X900
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 78561d1..6b20b3b 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1265,6 +1265,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		tegra_ehci_driver
 #endif
 
+#ifdef CONFIG_USB_EHCI_S5P
+#include "ehci-s5p.c"
+#define PLATFORM_DRIVER		s5p_ehci_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
     !defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
new file mode 100644
index 0000000..0c18f28
--- /dev/null
+++ b/drivers/usb/host/ehci-s5p.c
@@ -0,0 +1,201 @@
+/*
+ * SAMSUNG S5P USB HOST EHCI Controller
+ *
+ * Copyright (C) 2011 Samsung Electronics Co.Ltd
+ * Author: Jingoo Han <jg1.han@samsung.com>
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
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
+#include <mach/regs-pmu.h>
+#include <plat/cpu.h>
+#include <plat/ehci.h>
+#include <plat/usb-phy.h>
+
+struct s5p_ehci_hcd {
+	struct device *dev;
+	struct usb_hcd *hcd;
+	struct clk *clk;
+};
+
+static const struct hc_driver s5p_ehci_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "S5P EHCI Host Controller",
+	.hcd_priv_size		= sizeof(struct ehci_hcd),
+
+	.irq			= ehci_irq,
+	.flags			= HCD_MEMORY | HCD_USB2,
+
+	.reset			= ehci_init,
+	.start			= ehci_run,
+	.stop			= ehci_stop,
+	.shutdown		= ehci_shutdown,
+
+	.get_frame_number	= ehci_get_frame,
+
+	.urb_enqueue		= ehci_urb_enqueue,
+	.urb_dequeue		= ehci_urb_dequeue,
+	.endpoint_disable	= ehci_endpoint_disable,
+	.endpoint_reset		= ehci_endpoint_reset,
+
+	.hub_status_data	= ehci_hub_status_data,
+	.hub_control		= ehci_hub_control,
+	.bus_suspend		= ehci_bus_suspend,
+	.bus_resume		= ehci_bus_resume,
+
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+
+	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
+};
+
+static int s5p_ehci_probe(struct platform_device *pdev)
+{
+	struct s5p_ehci_platdata *pdata;
+	struct s5p_ehci_hcd *s5p_ehci;
+	struct usb_hcd *hcd;
+	struct ehci_hcd *ehci;
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
+	s5p_ehci = kzalloc(sizeof(struct s5p_ehci_hcd), GFP_KERNEL);
+	if (!s5p_ehci)
+		return -ENOMEM;
+
+	s5p_ehci->dev = &pdev->dev;
+
+	hcd = usb_create_hcd(&s5p_ehci_hc_driver, &pdev->dev,
+					dev_name(&pdev->dev));
+	if (!hcd) {
+		dev_err(&pdev->dev, "Unable to create HCD\n");
+		err = -ENOMEM;
+		goto fail_hcd;
+	}
+
+	s5p_ehci->clk = clk_get(&pdev->dev, "usbhost");
+
+	if (IS_ERR(s5p_ehci->clk)) {
+		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
+		err = PTR_ERR(s5p_ehci->clk);
+		goto fail_clk;
+	}
+
+	err = clk_enable(s5p_ehci->clk);
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
+	ehci = hcd_to_ehci(hcd);
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
+
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = readl(&ehci->caps->hcs_params);
+
+	err = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add USB HCD\n");
+		goto fail;
+	}
+
+	platform_set_drvdata(pdev, s5p_ehci);
+
+	return 0;
+
+fail:
+	iounmap(hcd->regs);
+fail_io:
+	clk_disable(s5p_ehci->clk);
+fail_clken:
+	clk_put(s5p_ehci->clk);
+fail_clk:
+	usb_put_hcd(hcd);
+fail_hcd:
+	kfree(s5p_ehci);
+	return err;
+}
+
+static int s5p_ehci_remove(struct platform_device *pdev)
+{
+	struct s5p_ehci_platdata *pdata = pdev->dev.platform_data;
+	struct s5p_ehci_hcd *s5p_ehci = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = s5p_ehci->hcd;
+
+	usb_remove_hcd(hcd);
+
+	if (pdata && pdata->phy_exit)
+		pdata->phy_exit(pdev, S5P_USB_PHY_HOST);
+
+	iounmap(hcd->regs);
+
+	clk_disable(s5p_ehci->clk);
+	clk_put(s5p_ehci->clk);
+
+	usb_put_hcd(hcd);
+	kfree(s5p_ehci);
+
+	return 0;
+}
+
+static void s5p_ehci_shutdown(struct platform_device *pdev)
+{
+	struct s5p_ehci_hcd *s5p_ehci = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = s5p_ehci->hcd;
+
+	if (hcd->driver->shutdown)
+		hcd->driver->shutdown(hcd);
+}
+
+static struct platform_driver s5p_ehci_driver = {
+	.probe		= s5p_ehci_probe,
+	.remove		= s5p_ehci_remove,
+	.shutdown	= s5p_ehci_shutdown,
+	.driver = {
+		.name	= "s5p-ehci",
+		.owner	= THIS_MODULE,
+	}
+};
+
+MODULE_ALIAS("platform:s5p-ehci");
-- 
1.7.0.4
