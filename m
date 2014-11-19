From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 19 Nov 2014 17:19:05 +0800
Subject: [PATCH 1/2] usb: gadget: at91_udc: remove unused release function
Message-ID: <1416388746-7386-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the driver call usb_add_gadget_udc --> usb_add_gadget_udc_release
with NULL as release parameter, so it will use usb_udc_no_release.
So, the release in driver won't used, remove it.

And at the same time, in the usb_add_gadget_udc_release will set the
gadget name, so remove it also in driver.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 drivers/usb/gadget/udc/at91_udc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 9968f53..b179ab1 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1512,20 +1512,11 @@ static irqreturn_t at91_udc_irq (int irq, void *_udc)
 
 /*-------------------------------------------------------------------------*/
 
-static void nop_release(struct device *dev)
-{
-	/* nothing to free */
-}
-
 static struct at91_udc controller = {
 	.gadget = {
 		.ops	= &at91_udc_ops,
 		.ep0	= &controller.ep[0].ep,
 		.name	= driver_name,
-		.dev	= {
-			.init_name = "gadget",
-			.release = nop_release,
-		}
 	},
 	.ep[0] = {
 		.ep = {
-- 
2.1.0.24.g4109c28
