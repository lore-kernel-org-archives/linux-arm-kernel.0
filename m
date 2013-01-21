From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 21 Jan 2013 05:07:27 -0500
Subject: [V4 PATCH 09/26] usb: gadget: mv_udc: use PHY driver for udc
In-Reply-To: <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
References: <xiechao.mail@gmail.com>
 <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1358762864-9249-10-git-send-email-chao.xie@marvell.com>
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
 drivers/usb/gadget/mv_udc_core.c |   23 ++++++++---------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc.h b/drivers/usb/gadget/mv_udc.h
index 9073436..4851b2b 100644
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
 
+	struct mv_usb2_phy	*phy;
 	struct usb_phy		*transceiver;
 
 	struct mv_usb_platform_data     *pdata;
diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index c8cf959..76fcfc7 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -35,6 +35,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/platform_data/mv_usb.h>
+#include <linux/usb/mv_usb2.h>
 #include <asm/unaligned.h>
 
 #include "mv_udc.h"
@@ -1121,8 +1122,8 @@ static int mv_udc_enable_internal(struct mv_udc *udc)
 
 	dev_dbg(&udc->dev->dev, "enable udc\n");
 	udc_clock_enable(udc);
-	if (udc->pdata->phy_init) {
-		retval = udc->pdata->phy_init(udc->phy_regs);
+	if (udc->phy->init) {
+		retval = udc->phy->init(udc->phy);
 		if (retval) {
 			dev_err(&udc->dev->dev,
 				"init phy error %d\n", retval);
@@ -1147,8 +1148,8 @@ static void mv_udc_disable_internal(struct mv_udc *udc)
 {
 	if (udc->active) {
 		dev_dbg(&udc->dev->dev, "disable udc\n");
-		if (udc->pdata->phy_deinit)
-			udc->pdata->phy_deinit(udc->phy_regs);
+		if (udc->phy->shutdown)
+			udc->phy->shutdown(udc->phy);
 		udc_clock_disable(udc);
 		udc->active = 0;
 	}
@@ -2194,7 +2195,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 		}
 	}
 
-	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "capregs");
+	r = platform_get_resource(udc->dev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
 		dev_err(&pdev->dev, "no I/O memory resource defined\n");
 		return -ENODEV;
@@ -2207,17 +2208,9 @@ static int mv_udc_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	r = platform_get_resource_byname(udc->dev, IORESOURCE_MEM, "phyregs");
-	if (r == NULL) {
-		dev_err(&pdev->dev, "no phy I/O memory resource defined\n");
+	udc->phy = mv_usb2_get_phy();
+	if (udc->phy == NULL)
 		return -ENODEV;
-	}
-
-	udc->phy_regs = ioremap(r->start, resource_size(r));
-	if (udc->phy_regs == NULL) {
-		dev_err(&pdev->dev, "failed to map phy I/O memory\n");
-		return -EBUSY;
-	}
 
 	/* we will acces controller register, so enable the clk */
 	retval = mv_udc_enable_internal(udc);
-- 
1.7.4.1
