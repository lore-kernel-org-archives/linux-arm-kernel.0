From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 24 Jan 2013 01:38:30 -0500
Subject: [V5 PATCH 06/26] usb: gadget: mv_udc: fix the value of tranceiver
In-Reply-To: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1359009530-28182-7-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usally we will use udc->tranceiver == NULL or
udc->tranceiver != NULL.
So when failed to get the udc->tranceiver by usb_get_phy(), we
directly set udc->tranceiver to be NULL.
Then the source code will not need macro IS_ERR_OR_NULL() for
udc->tranceiver judgement. It can reduce the line size and make
the judgement simple.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/gadget/mv_udc_core.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 910c4b5..c8cf959 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -1394,7 +1394,7 @@ static int mv_udc_start(struct usb_gadget *gadget,
 
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	if (!IS_ERR_OR_NULL(udc->transceiver)) {
+	if (udc->transceiver) {
 		retval = otg_set_peripheral(udc->transceiver->otg,
 					&udc->gadget);
 		if (retval) {
@@ -2174,9 +2174,14 @@ static int mv_udc_probe(struct platform_device *pdev)
 	udc->dev = pdev;
 
 #ifdef CONFIG_USB_OTG_UTILS
-	if (pdata->mode == MV_USB_MODE_OTG)
+	if (pdata->mode == MV_USB_MODE_OTG) {
 		udc->transceiver = devm_usb_get_phy(&pdev->dev,
 					USB_PHY_TYPE_USB2);
+		if (IS_ERR_OR_NULL(udc->transceiver)) {
+			udc->transceiver = NULL;
+			return -ENODEV;
+		}
+	}
 #endif
 
 	udc->clknum = pdata->clknum;
@@ -2319,7 +2324,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 	eps_init(udc);
 
 	/* VBUS detect: we can disable/enable clock on demand.*/
-	if (!IS_ERR_OR_NULL(udc->transceiver))
+	if (udc->transceiver)
 		udc->clock_gating = 1;
 	else if (pdata->vbus) {
 		udc->clock_gating = 1;
@@ -2386,7 +2391,7 @@ static int mv_udc_suspend(struct device *dev)
 	udc = dev_get_drvdata(dev);
 
 	/* if OTG is enabled, the following will be done in OTG driver*/
-	if (!IS_ERR_OR_NULL(udc->transceiver))
+	if (udc->transceiver)
 		return 0;
 
 	if (udc->pdata->vbus && udc->pdata->vbus->poll)
@@ -2421,7 +2426,7 @@ static int mv_udc_resume(struct device *dev)
 	udc = dev_get_drvdata(dev);
 
 	/* if OTG is enabled, the following will be done in OTG driver*/
-	if (!IS_ERR_OR_NULL(udc->transceiver))
+	if (udc->transceiver)
 		return 0;
 
 	if (!udc->clock_gating) {
-- 
1.7.4.1
