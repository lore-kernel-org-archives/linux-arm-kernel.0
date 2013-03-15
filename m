From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 17:00:26 +0000
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <Pine.LNX.4.44L0.1303151220500.1414-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303151220500.1414-100000@iolanthe.rowland.org>
Message-ID: <201303151700.27231.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Alan Stern wrote:
> Roger just submitted my patch to split out ehci-omap.

Ok, if we can merge that for 3.9, the main issue will be resolved, because
an OMAP+Orion config is much more interesting in practice than adding
VT8500 to the mix.

An alternative for VT8500 would be to remove drivers/usb/host/ehci-vt8500.c
completely and use the generic ehci-platform.c bus glue with added DT
support, as the patch below that I just hacked up. Not sure if that
anyone would prefer that over the hot-fix for 3.9, but it's possibly
a better solution in the long run.

> What happened to Manjunath Goudar?  I haven't heard from him since his 
> first round of submissions a month ago.  Fixing them up shouldn't be 
> too much work.

He's still around and working on his patches for 3.10. I'm currently working
with him to resolve a few of the remaining problems in his series and he
will post the lot soon.

> As far as I can tell, your scheme should be okay for now.  It would be 
> good to hear from other people, though.
> 
> I'd guess that the only reason it wasn't done this way from the
> beginning is that nobody considered the possibility of building a
> multi-platform driver.

Right. It's been a long way until it became possible on ARM. The four
PowerPC bus glues have already been mutually exclusive like this all
the time.

	Arnd


---
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index ca75063..2e4ddd4 100644
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
@@ -41,17 +43,21 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 	int retval;
 
-	hcd->has_tt = pdata->has_tt;
-	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
-	ehci->big_endian_desc = pdata->big_endian_desc;
-	ehci->big_endian_mmio = pdata->big_endian_mmio;
+	ehci->caps = hcd->regs;
+
+	if (pdata) {
+		hcd->has_tt = pdata->has_tt;
+		ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
+		ehci->big_endian_desc = pdata->big_endian_desc;
+		ehci->big_endian_mmio = pdata->big_endian_mmio;
+	 	ehci->caps += pdata->caps_offset;
+	}
 
-	ehci->caps = hcd->regs + pdata->caps_offset;
 	retval = ehci_setup(hcd);
 	if (retval)
 		return retval;
 
-	if (pdata->no_io_watchdog)
+	if (pdata && pdata->no_io_watchdog)
 		ehci->need_io_watchdog = 0;
 	return 0;
 }
@@ -70,11 +76,6 @@ static int ehci_platform_probe(struct platform_device *dev)
 	int irq;
 	int err = -ENOMEM;
 
-	if (!pdata) {
-		WARN_ON(1);
-		return -ENODEV;
-	}
-
 	if (usb_disabled())
 		return -ENODEV;
 
@@ -89,12 +90,17 @@ static int ehci_platform_probe(struct platform_device *dev)
 		return -ENXIO;
 	}
 
-	if (pdata->power_on) {
+	if (pdata && pdata->power_on) {
 		err = pdata->power_on(dev);
 		if (err < 0)
 			return err;
 	}
 
+	if (!dev->dev.dma_mask) {
+		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+		dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	}
+
 	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
 			     dev_name(&dev->dev));
 	if (!hcd) {
@@ -121,7 +127,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 err_put_hcd:
 	usb_put_hcd(hcd);
 err_power:
-	if (pdata->power_off)
+	if (pdata && pdata->power_off)
 		pdata->power_off(dev);
 
 	return err;
@@ -136,7 +142,7 @@ static int ehci_platform_remove(struct platform_device *dev)
 	usb_put_hcd(hcd);
 	platform_set_drvdata(dev, NULL);
 
-	if (pdata->power_off)
+	if (pdata && pdata->power_off)
 		pdata->power_off(dev);
 
 	return 0;
@@ -155,7 +161,7 @@ static int ehci_platform_suspend(struct device *dev)
 
 	ret = ehci_suspend(hcd, do_wakeup);
 
-	if (pdata->power_suspend)
+	if (pdata && pdata->power_suspend)
 		pdata->power_suspend(pdev);
 
 	return ret;
@@ -168,7 +174,7 @@ static int ehci_platform_resume(struct device *dev)
 	struct platform_device *pdev =
 		container_of(dev, struct platform_device, dev);
 
-	if (pdata->power_on) {
+	if (pdata && pdata->power_on) {
 		int err = pdata->power_on(pdev);
 		if (err < 0)
 			return err;
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
 
