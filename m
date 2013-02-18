From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 18 Feb 2013 01:10:25 -0500
Subject: [V7 PATCH 03/16] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
References: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1361167838-22929-4-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originaly, ehci driver will call the callbacks in platform data
for PHY initialization and shut down.
With PHY driver, it will call the APIs provided by PHY driver
for PHY initialization and shut down. It removes the callbacks
in platform data, and at same time it removes one block in the
way of enabling device tree for ehci driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-mv.c |   46 ++++++++++++++-----------------------------
 1 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 3065809..1d5fd0b 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -15,17 +15,18 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/mv_usb2.h>
 #include <linux/platform_data/mv_usb.h>
 
 #define CAPLENGTH_MASK         (0xff)
 
 struct ehci_hcd_mv {
 	struct usb_hcd *hcd;
+	struct usb_phy *phy;
 
 	/* Which mode does this ehci running OTG/Host ? */
 	int mode;
 
-	void __iomem *phy_regs;
 	void __iomem *cap_regs;
 	void __iomem *op_regs;
 
@@ -56,22 +57,15 @@ static void ehci_clock_disable(struct ehci_hcd_mv *ehci_mv)
 
 static int mv_ehci_enable(struct ehci_hcd_mv *ehci_mv)
 {
-	int retval;
-
 	ehci_clock_enable(ehci_mv);
-	if (ehci_mv->pdata->phy_init) {
-		retval = ehci_mv->pdata->phy_init(ehci_mv->phy_regs);
-		if (retval)
-			return retval;
-	}
 
-	return 0;
+	return usb_phy_init(ehci_mv->phy);
 }
 
 static void mv_ehci_disable(struct ehci_hcd_mv *ehci_mv)
 {
-	if (ehci_mv->pdata->phy_deinit)
-		ehci_mv->pdata->phy_deinit(ehci_mv->phy_regs);
+	usb_phy_shutdown(ehci_mv->phy);
+
 	ehci_clock_disable(ehci_mv);
 }
 
@@ -184,22 +178,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		}
 	}
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phyregs");
-	if (r == NULL) {
-		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
-		retval = -ENODEV;
-		goto err_clear_drvdata;
-	}
-
-	ehci_mv->phy_regs = devm_ioremap(&pdev->dev, r->start,
-					 resource_size(r));
-	if (ehci_mv->phy_regs == 0) {
-		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
-		retval = -EFAULT;
-		goto err_clear_drvdata;
-	}
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "capregs");
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		retval = -ENODEV;
@@ -214,6 +193,13 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_clear_drvdata;
 	}
 
+	ehci_mv->phy = devm_usb_get_phy_dev(&pdev->dev, MV_USB2_PHY_INDEX);
+	if (IS_ERR_OR_NULL(ehci_mv->phy)) {
+		ehci_mv->phy = NULL;
+		retval = -ENODEV;
+		goto err_clear_drvdata;
+	}
+
 	retval = mv_ehci_enable(ehci_mv);
 	if (retval) {
 		dev_err(&pdev->dev, "init phy error %d\n", retval);
@@ -241,7 +227,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	ehci_mv->mode = pdata->mode;
 	if (ehci_mv->mode == MV_USB_MODE_OTG) {
 #ifdef CONFIG_USB_OTG_UTILS
-		ehci_mv->otg = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
+		ehci_mv->otg = devm_usb_get_phy_dev(&pdev->dev,
+						MV_USB2_OTG_PHY_INDEX);
 		if (IS_ERR_OR_NULL(ehci_mv->otg)) {
 			dev_err(&pdev->dev,
 				"unable to find transceiver\n");
@@ -275,9 +262,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->private_init)
-		pdata->private_init(ehci_mv->op_regs, ehci_mv->phy_regs);
-
 	dev_info(&pdev->dev,
 		 "successful find EHCI device with regs 0x%p irq %d"
 		 " working in %s mode\n", hcd->regs, hcd->irq,
-- 
1.7.4.1
