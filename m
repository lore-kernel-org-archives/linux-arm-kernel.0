From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 28 Feb 2014 15:34:01 +0100
Subject: [PATCH] usb: gadget: atmel_usba: Fix crashed during stopping when
 DEBUG is enabled
Message-ID: <1393598066-4016-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug trace in the atmel_usba_stop function made the assumption
that the driver pointer passed in parameter was not NULL. Since the
commit "usb: gadget: udc-core: fix a regression during gadget driver
unbinding", it was no more always true. This lead to a kernel crash.

This commit now use the driver pointer stored in udc which fixes this
issue.

Since the commit which have triggered this issue was backported to the
3.2 stable branch, then this one should also be backported to the same
kernel.

Cc: stable at vger.kernel.org # v3.2+
Fixes: 511f3c5326ea (usb: gadget: udc-core: fix a regression during gadget driver unbinding)
---
 drivers/usb/gadget/atmel_usba_udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 52771d4c44bc..167843de2d8a 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1827,12 +1827,12 @@ static int atmel_usba_stop(struct usb_gadget *gadget,
 	toggle_bias(0);
 	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 
-	udc->driver = NULL;
-
 	clk_disable_unprepare(udc->hclk);
 	clk_disable_unprepare(udc->pclk);
 
-	DBG(DBG_GADGET, "unregistered driver `%s'\n", driver->driver.name);
+	DBG(DBG_GADGET, "unregistered driver `%s'\n", udc->driver->driver.name);
+
+	udc->driver = NULL;
 
 	return 0;
 }
-- 
1.8.1.2
