From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 20:11:26 +0000
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <Pine.LNX.4.44L0.1303151335470.1414-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303151335470.1414-100000@iolanthe.rowland.org>
Message-ID: <201303152011.26414.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Alan Stern wrote:
> On Fri, 15 Mar 2013, Arnd Bergmann wrote:
> > @@ -89,12 +90,17 @@ static int ehci_platform_probe(struct platform_device *dev)
> >  		return -ENXIO;
> >  	}
> >  
> > -	if (pdata->power_on) {
> > +	if (pdata && pdata->power_on) {
> >  		err = pdata->power_on(dev);
> >  		if (err < 0)
> >  			return err;
> >  	}
> 
> Instead of adding these tests for non-NULL pdata all over the place, 
> you could define a static structure with default settings and store a 
> pointer to it if pdata wasn't set initially.

Yes, good idea. Here is a new version. Maybe Alexey or Tony can verify if
that works for them on wm8850. That should be independent of the decision
into which kernel to merge this patch.

	Arnd

8<------
>From 016f7ecd1bce61c18d621acf746776491cc8487e Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2013 23:12:28 +0100
Subject: [PATCH] USB: EHCI: DT support for generic bus glue

This lets us use the ehci-generic driver on platforms without special
requirements for their ehci controllers. In particular, this is true
for the vt8500/wm8x50 platforms, which currently have a separate
driver that causes problems with multiplatform configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-hcd.c      |   5 --
 drivers/usb/host/ehci-platform.c |  25 +++--
 drivers/usb/host/ehci-vt8500.c   | 150 -------------------------------
 3 files changed, 19 insertions(+), 161 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index c750d71..9dfcef6 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1292,11 +1292,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_octeon_driver
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
index ca75063..e7777af 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -18,11 +18,13 @@
  *
  * Licensed under the GNU/GPL. See COPYING for details.
  */
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/hrtimer.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -62,22 +64,26 @@ static const struct ehci_driver_overrides platform_overrides __initdata = {
 	.reset =	ehci_platform_reset,
 };
 
+static struct usb_ehci_pdata ehci_platform_defaults;
+
 static int ehci_platform_probe(struct platform_device *dev)
 {
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
-	struct usb_ehci_pdata *pdata = dev->dev.platform_data;
+	struct usb_ehci_pdata *pdata;
 	int irq;
 	int err = -ENOMEM;
 
-	if (!pdata) {
-		WARN_ON(1);
-		return -ENODEV;
-	}
-
 	if (usb_disabled())
 		return -ENODEV;
 
+	if (!dev->dev.platform_data) {
+		dev->dev.platform_data = &ehci_platform_defaults;
+		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+		dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	}
+	pdata = dev->dev.platform_data;
+
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
 		dev_err(&dev->dev, "no irq provided");
@@ -183,6 +189,12 @@ static int ehci_platform_resume(struct device *dev)
 #define ehci_platform_resume	NULL
 #endif /* CONFIG_PM */
 
+static const struct of_device_id vt8500_ehci_ids[] = {
+	{ .compatible = "via,vt8500-ehci", },
+	{ .compatible = "wm,prizm-ehci", },
+	{}
+};
+
 static const struct platform_device_id ehci_platform_table[] = {
 	{ "ehci-platform", 0 },
 	{ }
@@ -203,6 +215,7 @@ static struct platform_driver ehci_platform_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "ehci-platform",
 		.pm	= &ehci_platform_pm_ops,
+		.of_match_table = of_match_ptr(vt8500_ehci_ids),
 	}
 };
 
diff --git a/drivers/usb/host/ehci-vt8500.c b/drivers/usb/host/ehci-vt8500.c
deleted file mode 100644
index 7ecf709..0000000
--- a/drivers/usb/host/ehci-vt8500.c
+++ /dev/null
@@ -1,150 +0,0 @@
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
-#include <linux/err.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
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
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hcd->regs)) {
-		ret = PTR_ERR(hcd->regs);
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
