From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:34 -0400
Subject: [PATCh V10 03/12] usb: gadget: mv_udc: use PHY driver for udc
In-Reply-To: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
References: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1368424303-10629-4-git-send-email-chao.xie@marvell.com>
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
 drivers/usb/gadget/mv_udc_core.c |   50 +++++++++++++-------------------------
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc.h b/drivers/usb/gadget/mv_udc.h
index be77f20..02f36fe 100644
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
index c2a5702..a6beef6 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -35,6 +35,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/platform_data/mv_usb.h>
+#include <linux/usb/mv_usb2.h>
 #include <asm/unaligned.h>
 
 #include "mv_udc.h"
@@ -1083,15 +1084,14 @@ static int mv_udc_enable_internal(struct mv_udc *udc)
 
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
@@ -1109,8 +1109,7 @@ static void mv_udc_disable_internal(struct mv_udc *udc)
 {
 	if (udc->active) {
 		dev_dbg(&udc->dev->dev, "disable udc\n");
-		if (udc->pdata->phy_deinit)
-			udc->pdata->phy_deinit(udc->phy_regs);
+		usb_phy_shutdown(udc->phy);
 		udc_clock_disable(udc);
 		udc->active = 0;
 	}
@@ -2124,17 +2123,10 @@ static int mv_udc_probe(struct platform_device *pdev)
 	udc->dev = pdev;
 
 	if (pdata->mode == MV_USB_MODE_OTG) {
-		udc->transceiver = devm_usb_get_phy(&pdev->dev,
-					USB_PHY_TYPE_USB2);
-		if (IS_ERR(udc->transceiver)) {
-			retval = PTR_ERR(udc->transceiver);
-
-			if (retval == -ENXIO)
-				return retval;
-
-			udc->transceiver = NULL;
-			return -EPROBE_DEFER;
-		}
+		udc->transceiver = devm_usb_get_phy_dev(&pdev->dev,
+					MV_USB2_OTG_PHY_INDEX);
+		if (IS_ERR_OR_NULL(udc->transceiver))
+			return PTR_ERR(udc->transceiver);
 	}
 
 	/* udc only have one sysclk. */
@@ -2142,7 +2134,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 	if (IS_ERR(udc->clk))
 		return PTR_ERR(udc->clk);
 
-	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "capregs");
+	r = platform_get_resource(udc->dev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		return -ENODEV;
@@ -2155,17 +2147,9 @@ static int mv_udc_probe(struct platform_device *pdev)
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
