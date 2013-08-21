From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 21 Aug 2013 11:42:24 +0300
Subject: [patch] usb: gadget: double unlocks on error in atmel_usba_start()
Message-ID: <20130821084224.GM5240@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "goto out" statements were wrong.  We aren't holding any locks at
that point so we should return directly.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I can't compile this.

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 40d2338..2cb52e0 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1772,7 +1772,7 @@ out:
 static int atmel_usba_start(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver)
 {
-	int ret = 0;
+	int ret;
 	struct usba_udc *udc = container_of(gadget, struct usba_udc, gadget);
 	unsigned long flags;
 
@@ -1784,11 +1784,11 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 
 	ret = clk_prepare_enable(udc->pclk);
 	if (ret)
-		goto out;
+		return ret;
 	ret = clk_prepare_enable(udc->hclk);
 	if (ret) {
 		clk_disable_unprepare(udc->pclk);
-		goto out;
+		return ret;
 	}
 
 	DBG(DBG_GADGET, "registered driver `%s'\n", driver->driver.name);
@@ -1804,11 +1804,9 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
 	}
-
-out:
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-	return ret;
+	return 0;
 }
 
 static int atmel_usba_stop(struct usb_gadget *gadget,
