From: chao.xie@marvell.com (Chao Xie)
Date: Wed,  6 Feb 2013 02:23:38 -0500
Subject: [V6 PATCH 03/16] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
References: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1360135431-27280-4-git-send-email-chao.xie@marvell.com>
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
 drivers/usb/host/ehci-mv.c |   37 +++++++++++++------------------------
 1 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 3065809..be504fd 100644
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
+	struct mv_usb2_phy *mvphy;
 
 	/* Which mode does this ehci running OTG/Host ? */
 	int mode;
 
-	void __iomem *phy_regs;
 	void __iomem *cap_regs;
 	void __iomem *op_regs;
 
@@ -59,8 +60,8 @@ static int mv_ehci_enable(struct ehci_hcd_mv *ehci_mv)
 	int retval;
 
 	ehci_clock_enable(ehci_mv);
-	if (ehci_mv->pdata->phy_init) {
-		retval = ehci_mv->pdata->phy_init(ehci_mv->phy_regs);
+	if (ehci_mv->mvphy->init) {
+		retval = ehci_mv->mvphy->init(ehci_mv->mvphy);
 		if (retval)
 			return retval;
 	}
@@ -70,8 +71,8 @@ static int mv_ehci_enable(struct ehci_hcd_mv *ehci_mv)
 
 static void mv_ehci_disable(struct ehci_hcd_mv *ehci_mv)
 {
-	if (ehci_mv->pdata->phy_deinit)
-		ehci_mv->pdata->phy_deinit(ehci_mv->phy_regs);
+	if (ehci_mv->mvphy->shutdown)
+		ehci_mv->mvphy->shutdown(ehci_mv->mvphy);
 	ehci_clock_disable(ehci_mv);
 }
 
@@ -184,22 +185,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
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
@@ -214,6 +200,12 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		goto err_clear_drvdata;
 	}
 
+	ehci_mv->mvphy = mv_usb2_get_phy();
+	if (ehci_mv->mvphy == NULL) {
+		retval = -ENODEV;
+		goto err_clear_drvdata;
+	}
+
 	retval = mv_ehci_enable(ehci_mv);
 	if (retval) {
 		dev_err(&pdev->dev, "init phy error %d\n", retval);
@@ -275,9 +267,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
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
