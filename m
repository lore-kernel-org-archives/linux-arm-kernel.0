From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 20 Jul 2012 04:07:55 +1200
Subject: [PATCH 2/2] ARM: vt8500: Add support for UHCI companion controller
In-Reply-To: <1342714075-15006-1-git-send-email-linux@prisktech.co.nz>
References: <1342714075-15006-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1342714075-15006-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the UHCI companion controller in arch-vt8500.
This patch is based almost entirely off uhci-grlib.c with
additions for device tree support.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/usb/host/Kconfig    |   11 +++-
 drivers/usb/host/uhci-hcd.c |    5 ++
 drivers/usb/host/uhci-of.c  |  158 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/host/uhci-of.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 83e58df..a79410b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -450,7 +450,7 @@ config USB_OHCI_LITTLE_ENDIAN
 
 config USB_UHCI_HCD
 	tristate "UHCI HCD (most Intel and VIA) support"
-	depends on USB && (PCI || SPARC_LEON)
+	depends on USB && (PCI || SPARC_LEON || ARCH_VT8500)
 	---help---
 	  The Universal Host Controller Interface is a standard by Intel for
 	  accessing the USB hardware in the PC (which is also called the USB
@@ -468,7 +468,14 @@ config USB_UHCI_HCD
 config USB_UHCI_SUPPORT_NON_PCI_HC
 	bool
 	depends on USB_UHCI_HCD
-	default y if SPARC_LEON
+	default y if (SPARC_LEON || ARCH_VT8500)
+
+config USB_UHCI_OF
+	bool "Generic Non-PCI UHCI Driver support"
+	depends on USB_UHCI_SUPPORT_NON_PCI_HC
+	default y if ARCH_VT8500
+	---help---
+	  Generic Non-PCI UHCI driver.
 
 config USB_UHCI_BIG_ENDIAN_MMIO
 	bool
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index e4db350..fd3721c 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -846,6 +846,11 @@ static const char hcd_name[] = "uhci_hcd";
 #define PLATFORM_DRIVER		uhci_grlib_driver
 #endif
 
+#ifdef CONFIG_USB_UHCI_OF
+#include "uhci-of.c"
+#define PLATFORM_DRIVER		uhci_of_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER)
 #error "missing bus glue for uhci-hcd"
 #endif
diff --git a/drivers/usb/host/uhci-of.c b/drivers/usb/host/uhci-of.c
new file mode 100644
index 0000000..21c558e
--- /dev/null
+++ b/drivers/usb/host/uhci-of.c
@@ -0,0 +1,158 @@
+/*
+ * Generic UHCI HCD (Host Controller Driver)
+ *
+ * Copyright (c) 2011 Tony Prisk <linux@prisktech.co.nz>
+ *
+ * This file is based on uhci-grlib.c
+ * (C) Copyright 2004-2007 Alan Stern, stern at rowland.harvard.edu
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static int uhci_of_init(struct usb_hcd *hcd)
+{
+	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
+
+	uhci->rh_numports = uhci_count_ports(hcd);
+
+	/* Set up pointers to to generic functions */
+	uhci->reset_hc = uhci_generic_reset_hc;
+	uhci->check_and_reset_hc = uhci_generic_check_and_reset_hc;
+
+	/* No special actions need to be taken for the functions below */
+	uhci->configure_hc = NULL;
+	uhci->resume_detect_interrupts_are_broken = NULL;
+	uhci->global_suspend_mode_is_broken = NULL;
+
+	/* Reset if the controller isn't already safely quiescent. */
+	check_and_reset_hc(uhci);
+	return 0;
+}
+
+static const struct hc_driver uhci_of_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"Generic UHCI Host Controller",
+	.hcd_priv_size =	sizeof(struct uhci_hcd),
+
+	/* Generic hardware linkage */
+	.irq =			uhci_irq,
+	.flags =		HCD_MEMORY | HCD_USB11,
+
+	/* Basic lifecycle operations */
+	.reset =		uhci_of_init,
+	.start =		uhci_start,
+#ifdef CONFIG_PM
+	.pci_suspend =		NULL,
+	.pci_resume =		NULL,
+	.bus_suspend =		uhci_rh_suspend,
+	.bus_resume =		uhci_rh_resume,
+#endif
+	.stop =			uhci_stop,
+
+	.urb_enqueue =		uhci_urb_enqueue,
+	.urb_dequeue =		uhci_urb_dequeue,
+
+	.endpoint_disable =	uhci_hcd_endpoint_disable,
+	.get_frame_number =	uhci_hcd_get_frame_number,
+
+	.hub_status_data =	uhci_hub_status_data,
+	.hub_control =		uhci_hub_control,
+};
+
+
+static int __devinit uhci_hcd_of_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct uhci_hcd	*uhci;
+	struct resource *res;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	hcd = usb_create_hcd(&uhci_of_hc_driver, &pdev->dev,
+			pdev->name);
+	if (!hcd)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_err("%s: request_mem_region failed\n", __func__);
+		ret = -EBUSY;
+		goto err_rmr;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_err("%s: ioremap failed\n", __func__);
+		ret = -ENOMEM;
+		goto err_irq;
+	}
+
+	uhci = hcd_to_uhci(hcd);
+
+	uhci->regs = hcd->regs;
+
+	ret = usb_add_hcd(hcd, pdev->resource[1].start, IRQF_DISABLED |
+								IRQF_SHARED);
+	if (ret)
+		goto err_uhci;
+
+	return 0;
+
+err_uhci:
+	iounmap(hcd->regs);
+err_irq:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err_rmr:
+	usb_put_hcd(hcd);
+
+	return ret;
+}
+
+static int uhci_hcd_of_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+/* Make sure the controller is quiescent and that we're not using it
+ * any more.  This is mainly for the benefit of programs which, like kexec,
+ * expect the hardware to be idle: not doing DMA or generating IRQs.
+ *
+ * This routine may be called in a damaged or failing kernel.  Hence we
+ * do not acquire the spinlock before shutting down the controller.
+ */
+static void uhci_hcd_of_shutdown(struct platform_device *op)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+
+	uhci_hc_died(hcd_to_uhci(hcd));
+}
+
+static const struct of_device_id of_uhci_ids[] = {
+	{ .compatible = "of-uhci", },
+	{}
+};
+
+static struct platform_driver uhci_of_driver = {
+	.probe		= uhci_hcd_of_probe,
+	.remove		= uhci_hcd_of_remove,
+	.shutdown	= uhci_hcd_of_shutdown,
+	.driver = {
+		.name = "of-uhci",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(of_uhci_ids),
+	},
+};
-- 
1.7.2.5
