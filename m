From: chao.xie@marvell.com (Chao Xie)
Date: Wed, 20 Feb 2013 23:07:12 -0500
Subject: [V8 PATCH 02/16] usb: gadget: mv_udc: use PHY driver for udc
In-Reply-To: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1361419646-9052-3-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originaly, udc driver will call the callbacks in platform data
for PHY initialization and shut down.
With PHY driver, it will call the APIs provided by PHY driver
for PHY initialization and shut down. It removes the callbacks
in platform data, and at same time it removes one block in the
way of enabling device tree for udc driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/gadget/mv_udc.h      |    2 +-
 drivers/usb/gadget/mv_udc_core.c |   45 ++++++++++++++-----------------------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc.h b/drivers/usb/gadget/mv_udc.h
index 9073436..f339df4 100644
--- a/drivers/usb/gadget/mv_udc.h
+++ b/drivers/usb/gadget/mv_udc.h
@@ -180,7 +180,6 @@ struct mv_udc {
 
 	struct mv_cap_regs __iomem	*cap_regs;
 	struct mv_op_regs __iomem	*op_regs;
-	void __iomem                    *phy_regs;
 	unsigned int			max_eps;
 	struct mv_dqh			*ep_dqh;
 	size_t				ep_dqh_size;
@@ -217,6 +216,7 @@ struct mv_udc {
 	struct work_struct	vbus_work;
 	struct workqueue_struct *qwork;
 
+	struct usb_phy		*phy;
 	struct usb_phy		*transceiver;
 
 	struct mv_usb_platform_data     *pdata;
diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index c8cf959..4876d2f 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -35,6 +35,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/platform_data/mv_usb.h>
+#include <linux/usb/mv_usb2.h>
 #include <asm/unaligned.h>
 
 #include "mv_udc.h"
@@ -1121,15 +1122,14 @@ static int mv_udc_enable_internal(struct mv_udc *udc)
 
 	dev_dbg(&udc->dev->dev, "enable udc\n");
 	udc_clock_enable(udc);
-	if (udc->pdata->phy_init) {
-		retval = udc->pdata->phy_init(udc->phy_regs);
-		if (retval) {
-			dev_err(&udc->dev->dev,
-				"init phy error %d\n", retval);
-			udc_clock_disable(udc);
-			return retval;
-		}
+	retval = usb_phy_init(udc->phy);
+	if (retval) {
+		dev_err(&udc->dev->dev,
+			"init phy error %d\n", retval);
+		udc_clock_disable(udc);
+		return retval;
 	}
+
 	udc->active = 1;
 
 	return 0;
@@ -1147,8 +1147,7 @@ static void mv_udc_disable_internal(struct mv_udc *udc)
 {
 	if (udc->active) {
 		dev_dbg(&udc->dev->dev, "disable udc\n");
-		if (udc->pdata->phy_deinit)
-			udc->pdata->phy_deinit(udc->phy_regs);
+		usb_phy_shutdown(udc->phy);
 		udc_clock_disable(udc);
 		udc->active = 0;
 	}
@@ -2175,12 +2174,10 @@ static int mv_udc_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_USB_OTG_UTILS
 	if (pdata->mode == MV_USB_MODE_OTG) {
-		udc->transceiver = devm_usb_get_phy(&pdev->dev,
-					USB_PHY_TYPE_USB2);
-		if (IS_ERR_OR_NULL(udc->transceiver)) {
-			udc->transceiver = NULL;
-			return -ENODEV;
-		}
+		udc->transceiver = devm_usb_get_phy_dev(&pdev->dev,
+					MV_USB2_OTG_PHY_INDEX);
+		if (IS_ERR_OR_NULL(udc->transceiver))
+			return PTR_ERR(udc->transceiver);
 	}
 #endif
 
@@ -2194,7 +2191,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 		}
 	}
 
-	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "capregs");
+	r = platform_get_resource(udc->dev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		return -ENODEV;
@@ -2207,17 +2204,9 @@ static int mv_udc_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "phyregs");
-	if (r == NULL) {
-		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
-		return -ENODEV;
-	}
-
-	udc->phy_regs = ioremap(r->start, resource_size(r));
-	if (udc->phy_regs == NULL) {
-		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
-		return -EBUSY;
-	}
+	udc->phy = devm_usb_get_phy_dev(&pdev->dev, MV_USB2_PHY_INDEX);
+	if (IS_ERR_OR_NULL(udc->phy))
+		return PTR_ERR(udc->phy);
 
 	/* we will acces controller register, so enable the clk */
 	retval = mv_udc_enable_internal(udc);
-- 
1.7.4.1
