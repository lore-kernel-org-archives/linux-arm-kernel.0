From: balbi@ti.com (Felipe Balbi)
Date: Wed, 5 Nov 2014 22:55:59 -0600
Subject: [PATCH] usb: gadget: udc: pxa27x: fix build warning when !OF
Message-ID: <1415249759-6219-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in case kernel is built without CONFIG_OF there
will be a build warning (see below) due to of_match_ptr()
being defined to NULL.

Because of_match_ptr() is pretty pointless anyway,
let's just remove it and fix the warning.

drivers/usb/gadget/udc/pxa27x_udc.c:2403:28: warning: ?udc_pxa_dt_ids? defined but not used [-Wunused-variable]
 static struct of_device_id udc_pxa_dt_ids[] = {
                            ^
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 69e7b816..d1d8a9f 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2590,7 +2590,7 @@ static struct platform_driver udc_driver = {
 	.driver		= {
 		.name	= "pxa27x-udc",
 		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(udc_pxa_dt_ids),
+		.of_match_table = udc_pxa_dt_ids,
 	},
 	.probe		= pxa_udc_probe,
 	.remove		= pxa_udc_remove,
-- 
2.1.0.GIT
