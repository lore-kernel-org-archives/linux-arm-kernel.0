From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 21:26:42 -0500
Subject: [PATCH v2 09/11] usb: ohci-da8xx: Remove code that references mach
In-Reply-To: <1458181615-27782-1-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
Message-ID: <1458181615-27782-10-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Including mach/* is frowned upon in device drivers, so get rid of it.

This replaces usb20_clk and code that pokes CFGCHIP2 with a proper phy
driver.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: Uses the new phy driver instead of using a second clock.


 drivers/usb/host/ohci-da8xx.c | 90 +++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index e5c33bc..c648674 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -15,58 +15,40 @@
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-
-#include <mach/da8xx.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_data/usb-davinci.h>
 
 #ifndef CONFIG_ARCH_DAVINCI_DA8XX
 #error "This file is DA8xx bus glue.  Define CONFIG_ARCH_DAVINCI_DA8XX."
 #endif
 
-#define CFGCHIP2	DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG)
-
 static struct clk *usb11_clk;
-static struct clk *usb20_clk;
+static struct phy *usb11_phy;
 
 /* Over-current indicator change bitmask */
 static volatile u16 ocic_mask;
 
-static void ohci_da8xx_clock(int on)
+static int ohci_da8xx_enable(void)
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
+	int ret;
 
-		/* Enable USB 1.1 PHY */
-		cfgchip2 |= CFGCHIP2_USB1SUSPENDM;
-	} else {
-		clk_disable(usb11_clk);
-		if (!(cfgchip2 & CFGCHIP2_USB1PHYCLKMUX))
-			clk_disable(usb20_clk);
+	ret = clk_prepare_enable(usb11_clk);
+	if (ret)
+		return ret;
 
-		/* Disable USB 1.1 PHY */
-		cfgchip2 &= ~CFGCHIP2_USB1SUSPENDM;
+	ret = phy_power_on(usb11_phy);
+	if (ret) {
+		clk_disable_unprepare(usb11_clk);
+		return ret;
 	}
-	__raw_writel(cfgchip2, CFGCHIP2);
+
+	return 0;
+}
+
+static void ohci_da8xx_disable(void)
+{
+	phy_power_off(usb11_phy);
+	clk_disable_unprepare(usb11_clk);
 }
 
 /*
@@ -92,7 +74,9 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
 
 	dev_dbg(dev, "starting USB controller\n");
 
-	ohci_da8xx_clock(1);
+	result = ohci_da8xx_enable();
+	if (result < 0)
+		return result;
 
 	/*
 	 * DA8xx only have 1 port connected to the pins but the HC root hub
@@ -101,8 +85,10 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
 	ohci->num_ports = 1;
 
 	result = ohci_init(ohci);
-	if (result < 0)
+	if (result < 0) {
+		ohci_da8xx_disable();
 		return result;
+	}
 
 	/*
 	 * Since we're providing a board-specific root hub port power control
@@ -129,7 +115,7 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
 static void ohci_da8xx_stop(struct usb_hcd *hcd)
 {
 	ohci_stop(hcd);
-	ohci_da8xx_clock(0);
+	ohci_da8xx_disable();
 }
 
 static int ohci_da8xx_start(struct usb_hcd *hcd)
@@ -301,12 +287,18 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 		return -ENODEV;
 
 	usb11_clk = devm_clk_get(&pdev->dev, "usb11");
-	if (IS_ERR(usb11_clk))
+	if (IS_ERR(usb11_clk)) {
+		if (PTR_ERR(usb11_clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get clock.\n");
 		return PTR_ERR(usb11_clk);
+	}
 
-	usb20_clk = devm_clk_get(&pdev->dev, "usb20");
-	if (IS_ERR(usb20_clk))
-		return PTR_ERR(usb20_clk);
+	usb11_phy = devm_phy_get(&pdev->dev, "usbphy");
+	if (IS_ERR(usb11_phy)) {
+		if (PTR_ERR(usb11_phy) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get phy.\n");
+		return PTR_ERR(usb11_phy);
+	}
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd)
@@ -316,6 +308,7 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 	hcd->regs = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(hcd->regs)) {
 		error = PTR_ERR(hcd->regs);
+		dev_err(&pdev->dev, "failed to map ohci.\n");
 		goto err;
 	}
 	hcd->rsrc_start = mem->start;
@@ -397,7 +390,7 @@ static int ohci_da8xx_suspend(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	ohci_da8xx_clock(0);
+	ohci_da8xx_disable();
 	hcd->state = HC_STATE_SUSPENDED;
 
 	return ret;
@@ -407,14 +400,19 @@ static int ohci_da8xx_resume(struct platform_device *dev)
 {
 	struct usb_hcd	*hcd	= platform_get_drvdata(dev);
 	struct ohci_hcd	*ohci	= hcd_to_ohci(hcd);
+	int ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
-	ohci_da8xx_clock(1);
+	ret = ohci_da8xx_enable();
+	if (ret)
+		return ret;
+
 	dev->dev.power.power_state = PMSG_ON;
 	usb_hcd_resume_root_hub(hcd);
+
 	return 0;
 }
 #endif
-- 
1.9.1
