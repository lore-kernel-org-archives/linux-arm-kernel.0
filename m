From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 15 Nov 2014 22:50:30 +0300
Subject: [PATCH 2/2] usb: gadget: pxa27x_udc: prepare/unprepare clocks in
 pxa-ssp
In-Reply-To: <1416081030-28260-1-git-send-email-dbaryshkov@gmail.com>
References: <1416081030-28260-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416081030-28260-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change clk_enable/disable() calls to clk_prepare_enable() and
clk_disable_unrepapre().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 4868369..e03c61d 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -1701,7 +1701,7 @@ static void udc_disable(struct pxa_udc *udc)
 	udc_writel(udc, UDCICR1, 0);
 
 	udc_clear_mask_UDCCR(udc, UDCCR_UDE);
-	clk_disable(udc->clk);
+	clk_disable_unprepare(udc->clk);
 
 	ep0_idle(udc);
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
@@ -1761,7 +1761,7 @@ static void udc_enable(struct pxa_udc *udc)
 	udc_writel(udc, UDCICR1, 0);
 	udc_clear_mask_UDCCR(udc, UDCCR_UDE);
 
-	clk_enable(udc->clk);
+	clk_prepare_enable(udc->clk);
 
 	ep0_idle(udc);
 	udc->gadget.speed = USB_SPEED_FULL;
-- 
2.1.1
