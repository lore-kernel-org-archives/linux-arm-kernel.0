From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 15 Nov 2014 22:50:29 +0300
Subject: [PATCH 1/2] usb: gadget: pxa25x_udc: prepare/unprepare clocks in
 pxa-ssp
Message-ID: <1416081030-28260-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change clk_enable/disable() calls to clk_prepare_enable() and
clk_disable_unrepapre().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/gadget/udc/pxa25x_udc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 42f7eeb..e4964ee 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -103,8 +103,8 @@ static const char ep0name [] = "ep0";
 
 /* IXP doesn't yet support <linux/clk.h> */
 #define clk_get(dev,name)	NULL
-#define clk_enable(clk)		do { } while (0)
-#define clk_disable(clk)	do { } while (0)
+#define clk_prepare_enable(clk)	do { } while (0)
+#define clk_disable_unprepare(clk)	do { } while (0)
 #define clk_put(clk)		do { } while (0)
 
 #endif
@@ -932,7 +932,7 @@ static int pullup(struct pxa25x_udc *udc)
 		if (!udc->active) {
 			udc->active = 1;
 			/* Enable clock for USB device */
-			clk_enable(udc->clk);
+			clk_prepare_enable(udc->clk);
 			udc_enable(udc);
 		}
 	} else {
@@ -945,7 +945,7 @@ static int pullup(struct pxa25x_udc *udc)
 			}
 			udc_disable(udc);
 			/* Disable clock for USB device */
-			clk_disable(udc->clk);
+			clk_disable_unprepare(udc->clk);
 			udc->active = 0;
 		}
 
-- 
2.1.1
