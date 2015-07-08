From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 08 Jul 2015 11:05:23 +0200
Subject: [PATCH v2 5/5] usb: gadget: atmel_usba_udc: add missing ret value
 check
In-Reply-To: <1436346323-31593-1-git-send-email-r.baldyga@samsung.com>
References: <1436346323-31593-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436346323-31593-6-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing return value check. In case of error print debug message
and return error code.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 4095cce0..37d414e 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1989,6 +1989,10 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		ep->can_isoc = of_property_read_bool(pp, "atmel,can-isoc");
 
 		ret = of_property_read_string(pp, "name", &name);
+		if (ret) {
+			dev_err(&pdev->dev, "of_probe: name error(%d)\n", ret);
+			goto err;
+		}
 		ep->ep.name = name;
 
 		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
-- 
1.9.1
