From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 18 Feb 2013 01:10:26 -0500
Subject: [V7 PATCH 04/16] usb: otg: mv_otg: use PHY driver for otg
In-Reply-To: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
References: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1361167838-22929-5-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originaly, otg driver will call the callbacks in platform data
for PHY initialization and shut down.
With PHY driver, it will call the APIs provided by PHY driver
for PHY initialization and shut down. It removes the callbacks
in platform data, and at same time it removes one block in the
way of enabling device tree for otg driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/otg/mv_otg.c |   51 ++++++++++++++++++----------------------------
 drivers/usb/otg/mv_otg.h |    2 +-
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/otg/mv_otg.c b/drivers/usb/otg/mv_otg.c
index b6a9be3..d59080b 100644
--- a/drivers/usb/otg/mv_otg.c
+++ b/drivers/usb/otg/mv_otg.c
@@ -25,6 +25,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/mv_usb2.h>
 #include <linux/platform_data/mv_usb.h>
 
 #include "mv_otg.h"
@@ -261,14 +262,12 @@ static int mv_otg_enable_internal(struct mv_otg *mvotg)
 	dev_dbg(&mvotg->pdev->dev, "otg enabled\n");
 
 	otg_clock_enable(mvotg);
-	if (mvotg->pdata->phy_init) {
-		retval = mvotg->pdata->phy_init(mvotg->phy_regs);
-		if (retval) {
-			dev_err(&mvotg->pdev->dev,
-				"init phy error %d\n", retval);
-			otg_clock_disable(mvotg);
-			return retval;
-		}
+	retval = usb_phy_init(mvotg->outer_phy);
+	if (retval) {
+		dev_err(&mvotg->pdev->dev,
+			"init phy error %d\n", retval);
+		otg_clock_disable(mvotg);
+		return retval;
 	}
 	mvotg->active = 1;
 
@@ -288,8 +287,7 @@ static void mv_otg_disable_internal(struct mv_otg *mvotg)
 {
 	if (mvotg->active) {
 		dev_dbg(&mvotg->pdev->dev, "otg disabled\n");
-		if (mvotg->pdata->phy_deinit)
-			mvotg->pdata->phy_deinit(mvotg->phy_regs);
+		usb_phy_shutdown(mvotg->outer_phy);
 		otg_clock_disable(mvotg);
 		mvotg->active = 0;
 	}
@@ -672,7 +670,6 @@ int mv_otg_remove(struct platform_device *pdev)
 
 	mv_otg_disable(mvotg);
 
-	usb_remove_phy(&mvotg->phy);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
@@ -741,23 +738,8 @@ static int mv_otg_probe(struct platform_device *pdev)
 	for (i = 0; i < OTG_TIMER_NUM; i++)
 		init_timer(&mvotg->otg_ctrl.timer[i]);
 
-	r = platform_get_resource_byname(mvotg->pdev,
-					 IORESOURCE_MEM, "phyregs");
-	if (r == NULL) {
-		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
-		retval = -ENODEV;
-		goto err_destroy_workqueue;
-	}
-
-	mvotg->phy_regs = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (mvotg->phy_regs == NULL) {
-		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
-		retval = -EFAULT;
-		goto err_destroy_workqueue;
-	}
-
-	r = platform_get_resource_byname(mvotg->pdev,
-					 IORESOURCE_MEM, "capregs");
+	r = platform_get_resource(mvotg->pdev,
+					 IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		retval = -ENODEV;
@@ -770,6 +752,13 @@ static int mv_otg_probe(struct platform_device *pdev)
 		retval = -EFAULT;
 		goto err_destroy_workqueue;
 	}
+	mvotg->outer_phy = devm_usb_get_phy_dev(&pdev->dev, 0);
+	if (IS_ERR_OR_NULL(mvotg->outer_phy)) {
+		mvotg->outer_phy = NULL;
+		retval = -ENODEV;
+		dev_err(&pdev->dev, "can not find outer phy\n");
+		goto err_destroy_workqueue;
+	}
 
 	/* we will acces controller register, so enable the udc controller */
 	retval = mv_otg_enable_internal(mvotg);
@@ -830,7 +819,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	retval = usb_add_phy(&mvotg->phy, USB_PHY_TYPE_USB2);
+	retval = usb_add_phy_dev(&mvotg->phy);
 	if (retval < 0) {
 		dev_err(&pdev->dev, "can't register transceiver, %d\n",
 			retval);
@@ -841,7 +830,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 	if (retval < 0) {
 		dev_dbg(&pdev->dev,
 			"Can't register sysfs attr group: %d\n", retval);
-		goto err_remove_phy;
+		goto err_remove_otg_phy;
 	}
 
 	spin_lock_init(&mvotg->wq_lock);
@@ -856,7 +845,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_remove_phy:
+err_remove_otg_phy:
 	usb_remove_phy(&mvotg->phy);
 err_disable_clk:
 	mv_otg_disable_internal(mvotg);
diff --git a/drivers/usb/otg/mv_otg.h b/drivers/usb/otg/mv_otg.h
index 8a9e351..65e7fd1 100644
--- a/drivers/usb/otg/mv_otg.h
+++ b/drivers/usb/otg/mv_otg.h
@@ -137,10 +137,10 @@ struct mv_otg_regs {
 
 struct mv_otg {
 	struct usb_phy phy;
+	struct usb_phy *outer_phy;
 	struct mv_otg_ctrl otg_ctrl;
 
 	/* base address */
-	void __iomem *phy_regs;
 	void __iomem *cap_regs;
 	struct mv_otg_regs __iomem *op_regs;
 
-- 
1.7.4.1
