From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  6 Jan 2015 14:47:01 +0100
Subject: [PATCH v2 4/5] usb: atmel_usba_udc: Mask status with enabled irqs
In-Reply-To: <1420552022-8422-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1420552022-8422-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1420552022-8422-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid interpreting useless status flags when we're not waiting for such
events by masking the status variable with the interrupt enabled register
value.

Reported-by: Patrice VILCHEZ <patrice.vilchez@atmel.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 55c8dde..bc3a532 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1612,12 +1612,14 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 
 	spin_lock(&udc->lock);
 
-	status = usba_readl(udc, INT_STA);
+	status = usba_readl(udc, INT_STA) & usba_readl(udc, INT_ENB);
 	DBG(DBG_INT, "irq, status=%#08x\n", status);
 
 	if (status & USBA_DET_SUSPEND) {
 		toggle_bias(udc, 0);
 		usba_writel(udc, INT_CLR, USBA_DET_SUSPEND);
+		usba_writel(udc, INT_ENB,
+			    usba_readl(udc, INT_ENB) | USBA_WAKE_UP);
 		udc->bias_pulse_needed = true;
 		DBG(DBG_BUS, "Suspend detected\n");
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN
@@ -1631,6 +1633,8 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	if (status & USBA_WAKE_UP) {
 		toggle_bias(udc, 1);
 		usba_writel(udc, INT_CLR, USBA_WAKE_UP);
+		usba_writel(udc, INT_ENB,
+			    usba_readl(udc, INT_ENB) & ~USBA_WAKE_UP);
 		DBG(DBG_BUS, "Wake Up CPU detected\n");
 	}
 
-- 
1.9.1
