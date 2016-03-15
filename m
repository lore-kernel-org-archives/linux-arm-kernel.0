From: david@lechnology.com (David Lechner)
Date: Tue, 15 Mar 2016 17:37:52 -0500
Subject: [PATCH 4/5] usb: ohci-da8xx: Remove clock code that references mach
In-Reply-To: <1458081473-8223-1-git-send-email-david@lechnology.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
Message-ID: <1458081473-8223-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Including mach/* is frowned upon in device drivers, so get rid of it.

This replaces usb20_clk with usb11_phy_clk that represents the 48MHz usb
phy clock. The interaction with the usb20 (musb) subsystem does no belong
here and has been implemented in da830.c/da850.c with the rest of the
da8xx clock code.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/usb/host/ohci-da8xx.c | 81 ++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index e5c33bc..37fa3fb 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -16,57 +16,43 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 
-#include <mach/da8xx.h>
 #include <linux/platform_data/usb-davinci.h>
 
 #ifndef CONFIG_ARCH_DAVINCI_DA8XX
 #error "This file is DA8xx bus glue.  Define CONFIG_ARCH_DAVINCI_DA8XX."
 #endif
 
-#define CFGCHIP2	DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG)
+#define USB1SUSPENDM	(1 << 7)
 
 static struct clk *usb11_clk;
-static struct clk *usb20_clk;
+static struct clk *usb11_phy_clk;
+static __iomem u32 *cfgchip2;
 
 /* Over-current indicator change bitmask */
 static volatile u16 ocic_mask;
 
-static void ohci_da8xx_clock(int on)
+static void ohci_da8xx_enable(void)
 {
-	u32 cfgchip2;
-
-	cfgchip2 = __raw_readl(CFGCHIP2);
-	if (on) {
-		clk_enable(usb11_clk);
-
-		/*
-		 * If USB 1.1 reference clock is sourced from USB 2.0 PHY, we
-		 * need to enable the USB 2.0 module clocking, start its PHY,
-		 * and not allow it to stop the clock during USB 2.0 suspend.
-		 */
-		if (!(cfgchip2 & CFGCHIP2_USB1PHYCLKMUX)) {
-			clk_enable(usb20_clk);
-
-			cfgchip2 &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
-			cfgchip2 |= CFGCHIP2_PHY_PLLON;
-			__raw_writel(cfgchip2, CFGCHIP2);
-
-			pr_info("Waiting for USB PHY clock good...\n");
-			while (!(__raw_readl(CFGCHIP2) & CFGCHIP2_PHYCLKGD))
-				cpu_relax();
-		}
+	u32 val;
 
-		/* Enable USB 1.1 PHY */
-		cfgchip2 |= CFGCHIP2_USB1SUSPENDM;
-	} else {
-		clk_disable(usb11_clk);
-		if (!(cfgchip2 & CFGCHIP2_USB1PHYCLKMUX))
-			clk_disable(usb20_clk);
+	clk_prepare_enable(usb11_clk);
+	clk_prepare_enable(usb11_phy_clk);
 
-		/* Disable USB 1.1 PHY */
-		cfgchip2 &= ~CFGCHIP2_USB1SUSPENDM;
-	}
-	__raw_writel(cfgchip2, CFGCHIP2);
+	val = __raw_readl(cfgchip2);
+	val |= USB1SUSPENDM;
+	__raw_writel(val, cfgchip2);
+}
+
+static void ohci_da8xx_disable(void)
+{
+	u32 val;
+
+	val = __raw_readl(cfgchip2);
+	val &= ~USB1SUSPENDM;
+	__raw_writel(val, cfgchip2);
+
+	clk_disable_unprepare(usb11_phy_clk);
+	clk_disable_unprepare(usb11_clk);
 }
 
 /*
@@ -92,7 +78,7 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
 
 	dev_dbg(dev, "starting USB controller\n");
 
-	ohci_da8xx_clock(1);
+	ohci_da8xx_enable();
 
 	/*
 	 * DA8xx only have 1 port connected to the pins but the HC root hub
@@ -129,7 +115,7 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
 static void ohci_da8xx_stop(struct usb_hcd *hcd)
 {
 	ohci_stop(hcd);
-	ohci_da8xx_clock(0);
+	ohci_da8xx_disable();
 }
 
 static int ohci_da8xx_start(struct usb_hcd *hcd)
@@ -304,9 +290,9 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 	if (IS_ERR(usb11_clk))
 		return PTR_ERR(usb11_clk);
 
-	usb20_clk = devm_clk_get(&pdev->dev, "usb20");
-	if (IS_ERR(usb20_clk))
-		return PTR_ERR(usb20_clk);
+	usb11_phy_clk = devm_clk_get(&pdev->dev, "usb11_phy");
+	if (IS_ERR(usb11_phy_clk))
+		return PTR_ERR(usb11_phy_clk);
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd)
@@ -316,11 +302,20 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 	hcd->regs = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(hcd->regs)) {
 		error = PTR_ERR(hcd->regs);
+		dev_err(&pdev->dev, "failed to map ohci.\n");
 		goto err;
 	}
 	hcd->rsrc_start = mem->start;
 	hcd->rsrc_len = resource_size(mem);
 
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cfgchip2 = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(cfgchip2)) {
+		error = PTR_ERR(cfgchip2);
+		dev_err(&pdev->dev, "failed to map cfgchip2.\n");
+		goto err;
+	}
+
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
 	irq = platform_get_irq(pdev, 0);
@@ -397,7 +392,7 @@ static int ohci_da8xx_suspend(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	ohci_da8xx_clock(0);
+	ohci_da8xx_disable();
 	hcd->state = HC_STATE_SUSPENDED;
 
 	return ret;
@@ -412,7 +407,7 @@ static int ohci_da8xx_resume(struct platform_device *dev)
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
-	ohci_da8xx_clock(1);
+	ohci_da8xx_enable();
 	dev->dev.power.power_state = PMSG_ON;
 	usb_hcd_resume_root_hub(hcd);
 	return 0;
-- 
1.9.1
