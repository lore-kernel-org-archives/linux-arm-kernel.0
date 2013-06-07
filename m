From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  7 Jun 2013 20:08:18 +0200
Subject: [RFC PATCH 32/50] usb: gadget: at91_udc: prepare clk before calling
 enable
In-Reply-To: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1370628498-2584-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/usb/gadget/at91_udc.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 073b938..ad03b6b 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -870,8 +870,8 @@ static void clk_on(struct at91_udc *udc)
 	if (udc->clocked)
 		return;
 	udc->clocked = 1;
-	clk_enable(udc->iclk);
-	clk_enable(udc->fclk);
+	clk_prepare_enable(udc->iclk);
+	clk_prepare_enable(udc->fclk);
 }
 
 static void clk_off(struct at91_udc *udc)
@@ -880,8 +880,8 @@ static void clk_off(struct at91_udc *udc)
 		return;
 	udc->clocked = 0;
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
-	clk_disable(udc->fclk);
-	clk_disable(udc->iclk);
+	clk_disable_unprepare(udc->fclk);
+	clk_disable_unprepare(udc->iclk);
 }
 
 /*
@@ -1782,12 +1782,12 @@ static int at91udc_probe(struct platform_device *pdev)
 	}
 
 	/* don't do anything until we have both gadget driver and VBUS */
-	clk_enable(udc->iclk);
+	clk_prepare_enable(udc->iclk);
 	at91_udp_write(udc, AT91_UDP_TXVC, AT91_UDP_TXVC_TXVDIS);
 	at91_udp_write(udc, AT91_UDP_IDR, 0xffffffff);
 	/* Clear all pending interrupts - UDP may be used by bootloader. */
 	at91_udp_write(udc, AT91_UDP_ICR, 0xffffffff);
-	clk_disable(udc->iclk);
+	clk_disable_unprepare(udc->iclk);
 
 	/* request UDC and maybe VBUS irqs */
 	udc->udp_irq = platform_get_irq(pdev, 0);
-- 
1.7.9.5
