From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 24 Jan 2013 01:38:35 -0500
Subject: [V5 PATCH 11/26] usb: otg: mv_otg: use PHY driver for otg
In-Reply-To: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1359009530-28182-12-git-send-email-chao.xie@marvell.com>
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
 drivers/usb/otg/mv_otg.c |   33 ++++++++++++---------------------
 drivers/usb/otg/mv_otg.h |    2 +-
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/otg/mv_otg.c b/drivers/usb/otg/mv_otg.c
index da2d60c..cc45ef2 100644
--- a/drivers/usb/otg/mv_otg.c
+++ b/drivers/usb/otg/mv_otg.c
@@ -25,6 +25,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/mv_usb2.h>
 #include <linux/platform_data/mv_usb.h>
 
 #include "mv_otg.h"
@@ -261,8 +262,8 @@ static int mv_otg_enable_internal(struct mv_otg *mvotg)
 	dev_dbg(&mvotg->pdev->dev, "otg enabled\n");
 
 	otg_clock_enable(mvotg);
-	if (mvotg->pdata->phy_init) {
-		retval = mvotg->pdata->phy_init(mvotg->phy_regs);
+	if (mvotg->mvphy->init) {
+		retval = mvotg->mvphy->init(mvotg->mvphy);
 		if (retval) {
 			dev_err(&mvotg->pdev->dev,
 				"init phy error %d\n", retval);
@@ -288,8 +289,8 @@ static void mv_otg_disable_internal(struct mv_otg *mvotg)
 {
 	if (mvotg->active) {
 		dev_dbg(&mvotg->pdev->dev, "otg disabled\n");
-		if (mvotg->pdata->phy_deinit)
-			mvotg->pdata->phy_deinit(mvotg->phy_regs);
+		if (mvotg->mvphy->shutdown)
+			mvotg->mvphy->shutdown(mvotg->mvphy);
 		otg_clock_disable(mvotg);
 		mvotg->active = 0;
 	}
@@ -741,23 +742,8 @@ static int mv_otg_probe(struct platform_device *pdev)
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
@@ -770,6 +756,11 @@ static int mv_otg_probe(struct platform_device *pdev)
 		retval = -EFAULT;
 		goto err_destroy_workqueue;
 	}
+	mvotg->mvphy = mv_usb2_get_phy();
+	if (mvotg->mvphy == NULL) {
+		retval = -ENODEV;
+		goto err_destroy_workqueue;
+	}
 
 	/* we will acces controller register, so enable the udc controller */
 	retval = mv_otg_enable_internal(mvotg);
diff --git a/drivers/usb/otg/mv_otg.h b/drivers/usb/otg/mv_otg.h
index 8a9e351..7b9629a 100644
--- a/drivers/usb/otg/mv_otg.h
+++ b/drivers/usb/otg/mv_otg.h
@@ -137,10 +137,10 @@ struct mv_otg_regs {
 
 struct mv_otg {
 	struct usb_phy phy;
+	struct mv_usb2_phy *mvphy;
 	struct mv_otg_ctrl otg_ctrl;
 
 	/* base address */
-	void __iomem *phy_regs;
 	void __iomem *cap_regs;
 	struct mv_otg_regs __iomem *op_regs;
 
-- 
1.7.4.1
