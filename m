From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 20 Oct 2012 16:17:32 +1300
Subject: [PATCH 1/2] USB: Update EHCI-platform driver to devicetree.
In-Reply-To: <1350703053-4661-1-git-send-email-linux@prisktech.co.nz>
References: <1350703053-4661-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1350703053-4661-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds devicetree support to the EHCI-platform driver,
and removes the now unneeded ehci-vt8500.c

Existing platform properties are maintained, with the exception
the power_(on/off) and suspend function pointers.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/usb/host/ehci-hcd.c      |    5 --
 drivers/usb/host/ehci-platform.c |   46 ++++++++++
 drivers/usb/host/ehci-vt8500.c   |  171 --------------------------------------
 3 files changed, 46 insertions(+), 176 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-vt8500.c

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 6bf6c42..42c8e84 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1274,11 +1274,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		cns3xxx_ehci_driver
 #endif
 
-#ifdef CONFIG_ARCH_VT8500
-#include "ehci-vt8500.c"
-#define	PLATFORM_DRIVER		vt8500_ehci_driver
-#endif
-
 #ifdef CONFIG_PLAT_SPEAR
 #include "ehci-spear.c"
 #define PLATFORM_DRIVER		spear_ehci_hcd_driver
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 764e010..7f962dc 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -19,6 +19,7 @@
  * Licensed under the GNU/GPL. See COPYING for details.
  */
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/usb/ehci_pdriver.h>
 
 static int ehci_platform_reset(struct usb_hcd *hcd)
@@ -78,14 +79,48 @@ static const struct hc_driver ehci_platform_hc_driver = {
 	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
 };
 
+static u64 ehci_dma_mask = DMA_BIT_MASK(32);
+
 static int __devinit ehci_platform_probe(struct platform_device *dev)
 {
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
 	struct usb_ehci_pdata *pdata = dev->dev.platform_data;
+	struct device_node *np = dev->dev.of_node;
 	int irq;
 	int err = -ENOMEM;
 
+	/* Are we being initialized from a DT-probed device? */
+	if (np) {
+		/*
+		 * No platform data is being passed, so initalize pdata.
+		 * Limitation: we can't support power_on, power_off or
+		 * power_suspend function pointers from DT.
+		 * TODO: The missing functions could be replaced with
+		 * power sequence handlers.
+		 */
+		pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
+		dev->dev.platform_data = pdata;
+
+		/* Read the optional properties from DT node */
+		of_property_read_u32(np, "caps-offset", &pdata->caps_offset);
+		if (of_property_read_bool(np, "has-tt"))
+			pdata->has_tt = 1;
+		if (of_property_read_bool(np, "has-synopsys-hc-bug"))
+			pdata->has_synopsys_hc_bug = 1;
+		if (of_property_read_bool(np, "big-endian-desc"))
+			pdata->big_endian_desc = 1;
+		if (of_property_read_bool(np, "big-endian-mmio"))
+			pdata->big_endian_mmio = 1;
+
+		/* Right now device-tree probed devices don't get dma_mask set.
+		 * Since shared usb code relies on it, set it here for now.
+		 * Once we have dma capability bindings this can go away.
+		 */
+		if (!dev->dev.dma_mask)
+			dev->dev.dma_mask = &ehci_dma_mask;
+	}
+
 	if (!pdata) {
 		WARN_ON(1);
 		return -ENODEV;
@@ -215,6 +250,16 @@ static const struct platform_device_id ehci_platform_table[] = {
 	{ "ehci-platform", 0 },
 	{ }
 };
+
+#ifdef CONFIG_OF
+static const struct of_device_id ehci_platform_ids[] = {
+	{ .compatible = "ehci-platform", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, ehci_platform_ids);
+#endif
+
 MODULE_DEVICE_TABLE(platform, ehci_platform_table);
 
 static const struct dev_pm_ops ehci_platform_pm_ops = {
@@ -231,5 +276,6 @@ static struct platform_driver ehci_platform_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "ehci-platform",
 		.pm	= &ehci_platform_pm_ops,
+		.of_match_table = of_match_ptr(ehci_platform_ids),
 	}
 };
diff --git a/drivers/usb/host/ehci-vt8500.c b/drivers/usb/host/ehci-vt8500.c
deleted file mode 100644
index d3c9a3e..0000000
--- a/drivers/usb/host/ehci-vt8500.c
+++ /dev/null
@@ -1,171 +0,0 @@
-/*
- * drivers/usb/host/ehci-vt8500.c
- *
- * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
- *
- * Based on ehci-au1xxx.c
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/of.h>
-#include <linux/platform_device.h>
-
-static int ehci_update_device(struct usb_hcd *hcd, struct usb_device *udev)
-{
-	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
-	int rc = 0;
-
-	if (!udev->parent) /* udev is root hub itself, impossible */
-		rc = -1;
-	/* we only support lpm device connected to root hub yet */
-	if (ehci->has_lpm && !udev->parent->parent) {
-		rc = ehci_lpm_set_da(ehci, udev->devnum, udev->portnum);
-		if (!rc)
-			rc = ehci_lpm_check(ehci, udev->portnum);
-	}
-	return rc;
-}
-
-static const struct hc_driver vt8500_ehci_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "VT8500 EHCI",
-	.hcd_priv_size		= sizeof(struct ehci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
-
-	/*
-	 * basic lifecycle operations
-	 */
-	.reset			= ehci_setup,
-	.start			= ehci_run,
-	.stop			= ehci_stop,
-	.shutdown		= ehci_shutdown,
-
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue		= ehci_urb_enqueue,
-	.urb_dequeue		= ehci_urb_dequeue,
-	.endpoint_disable	= ehci_endpoint_disable,
-	.endpoint_reset		= ehci_endpoint_reset,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number	= ehci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data	= ehci_hub_status_data,
-	.hub_control		= ehci_hub_control,
-	.bus_suspend		= ehci_bus_suspend,
-	.bus_resume		= ehci_bus_resume,
-	.relinquish_port	= ehci_relinquish_port,
-	.port_handed_over	= ehci_port_handed_over,
-
-	/*
-	 * call back when device connected and addressed
-	 */
-	.update_device =	ehci_update_device,
-
-	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
-};
-
-static u64 vt8500_ehci_dma_mask = DMA_BIT_MASK(32);
-
-static int vt8500_ehci_drv_probe(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd;
-	struct ehci_hcd *ehci;
-	struct resource *res;
-	int ret;
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	/*
-	 * Right now device-tree probed devices don't get dma_mask set.
-	 * Since shared usb code relies on it, set it here for now.
-	 * Once we have dma capability bindings this can go away.
-	 */
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &vt8500_ehci_dma_mask;
-
-	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
-		pr_debug("resource[1] is not IORESOURCE_IRQ");
-		return -ENOMEM;
-	}
-	hcd = usb_create_hcd(&vt8500_ehci_hc_driver, &pdev->dev, "VT8500");
-	if (!hcd)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->rsrc_start = res->start;
-	hcd->rsrc_len = resource_size(res);
-
-	hcd->regs = devm_request_and_ioremap(&pdev->dev, res);
-	if (!hcd->regs) {
-		pr_debug("ioremap failed");
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	ehci = hcd_to_ehci(hcd);
-	ehci->caps = hcd->regs;
-
-	ret = usb_add_hcd(hcd, pdev->resource[1].start,
-			  IRQF_SHARED);
-	if (ret == 0) {
-		platform_set_drvdata(pdev, hcd);
-		return ret;
-	}
-
-err1:
-	usb_put_hcd(hcd);
-	return ret;
-}
-
-static int vt8500_ehci_drv_remove(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-
-	usb_remove_hcd(hcd);
-	usb_put_hcd(hcd);
-	platform_set_drvdata(pdev, NULL);
-
-	return 0;
-}
-
-static const struct of_device_id vt8500_ehci_ids[] = {
-	{ .compatible = "via,vt8500-ehci", },
-	{ .compatible = "wm,prizm-ehci", },
-	{}
-};
-
-static struct platform_driver vt8500_ehci_driver = {
-	.probe		= vt8500_ehci_drv_probe,
-	.remove		= vt8500_ehci_drv_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
-	.driver = {
-		.name	= "vt8500-ehci",
-		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(vt8500_ehci_ids),
-	}
-};
-
-MODULE_ALIAS("platform:vt8500-ehci");
-MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
-- 
1.7.9.5
