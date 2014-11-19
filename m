From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 19 Nov 2014 17:19:06 +0800
Subject: [PATCH 2/2] usb: gadget: atmel_usba_udc: remove release function
In-Reply-To: <1416388746-7386-1-git-send-email-voice.shen@atmel.com>
References: <1416388746-7386-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1416388746-7386-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the driver call usb_add_gadget_udc --> usb_add_gadget_udc_release
with NULL as release parameter, so it will use usb_udc_no_release.
So, the release in driver won't used, remove it.

And at the same time, in the usb_add_gadget_udc_release will set the
gadget name, so remove it also in driver.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 1529926..8c29d09 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1007,19 +1007,10 @@ static struct usb_endpoint_descriptor usba_ep0_desc = {
 	.bInterval = 1,
 };
 
-static void nop_release(struct device *dev)
-{
-
-}
-
 static struct usb_gadget usba_gadget_template = {
 	.ops		= &usba_udc_ops,
 	.max_speed	= USB_SPEED_HIGH,
 	.name		= "atmel_usba_udc",
-	.dev	= {
-		.init_name	= "gadget",
-		.release	= nop_release,
-	},
 };
 
 /*
-- 
2.1.0.24.g4109c28
