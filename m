From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:36 -0400
Subject: [PATCh V10 05/12] usb: phy: phy-mv-usb: use USB2 PHY driver for otg
In-Reply-To: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
References: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1368424303-10629-6-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originaly, otg driver will call the callbacks in platform data
for PHY initialization and shut down.
With PHY driver, it will call the APIs provided by PHY driver
for PHY initialization and shutdown. It removes the callbacks
in platform data, and at same time it removes one block in the
way of enabling device tree for otg driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/phy/phy-mv-usb.c |   53 ++++++++++++++++++-----------------------
 drivers/usb/phy/phy-mv-usb.h |    2 +-
 2 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/phy/phy-mv-usb.c b/drivers/usb/phy/phy-mv-usb.c
index c987bbe..9938904 100644
--- a/drivers/usb/phy/phy-mv-usb.c
+++ b/drivers/usb/phy/phy-mv-usb.c
@@ -25,6 +25,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/mv_usb2.h>
 #include <linux/platform_data/mv_usb.h>
 
 #include "phy-mv-usb.h"
@@ -255,15 +256,14 @@ static int mv_otg_enable_internal(struct mv_otg *mvotg)
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
+			"failed to initialize phy %d\n", retval);
+		otg_clock_disable(mvotg);
+		return retval;
 	}
+
 	mvotg->active = 1;
 
 	return 0;
@@ -282,8 +282,7 @@ static void mv_otg_disable_internal(struct mv_otg *mvotg)
 {
 	if (mvotg->active) {
 		dev_dbg(&mvotg->pdev->dev, "otg disabled\n");
-		if (mvotg->pdata->phy_deinit)
-			mvotg->pdata->phy_deinit(mvotg->phy_regs);
+		usb_phy_shutdown(mvotg->outer_phy);
 		otg_clock_disable(mvotg);
 		mvotg->active = 0;
 	}
@@ -715,6 +714,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 	/* OTG common part */
 	mvotg->pdev = pdev;
 	mvotg->phy.dev = &pdev->dev;
+	mvotg->phy.type = USB_PHY_TYPE_USB2;
 	mvotg->phy.otg = otg;
 	mvotg->phy.label = driver_name;
 	mvotg->phy.state = OTG_STATE_UNDEFINED;
@@ -727,23 +727,8 @@ static int mv_otg_probe(struct platform_device *pdev)
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
@@ -757,6 +742,14 @@ static int mv_otg_probe(struct platform_device *pdev)
 		goto err_destroy_workqueue;
 	}
 
+	mvotg->outer_phy = devm_usb_get_phy_dev(&pdev->dev, MV_USB2_PHY_INDEX);
+	if (IS_ERR_OR_NULL(mvotg->outer_phy)) {
+		retval = PTR_ERR(mvotg->outer_phy);
+		if (retval != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "can not find outer phy\n");
+		goto err_destroy_workqueue;
+	}
+
 	/* we will acces controller register, so enable the udc controller */
 	retval = mv_otg_enable_internal(mvotg);
 	if (retval) {
@@ -816,7 +809,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	retval = usb_add_phy(&mvotg->phy, USB_PHY_TYPE_USB2);
+	retval = usb_add_phy_dev(&mvotg->phy);
 	if (retval < 0) {
 		dev_err(&pdev->dev, "can't register transceiver, %d\n",
 			retval);
@@ -827,7 +820,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 	if (retval < 0) {
 		dev_dbg(&pdev->dev,
 			"Can't register sysfs attr group: %d\n", retval);
-		goto err_remove_phy;
+		goto err_remove_otg_phy;
 	}
 
 	spin_lock_init(&mvotg->wq_lock);
@@ -842,7 +835,7 @@ static int mv_otg_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_remove_phy:
+err_remove_otg_phy:
 	usb_remove_phy(&mvotg->phy);
 err_disable_clk:
 	mv_otg_disable_internal(mvotg);
diff --git a/drivers/usb/phy/phy-mv-usb.h b/drivers/usb/phy/phy-mv-usb.h
index 551da6e..6df6219 100644
--- a/drivers/usb/phy/phy-mv-usb.h
+++ b/drivers/usb/phy/phy-mv-usb.h
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
