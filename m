From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 22 Jan 2015 17:56:41 +0100
Subject: [PATCHv6 1/5] USB: gadget: atmel_usba_udc: Fixed vbus_prev initial
 state
In-Reply-To: <1421945805-31129-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421945805-31129-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421945805-31129-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If vbus gpio is high at init, we should set vbus_prev to true
accordingly to the current vbus state. Without that, we skip the first
vbus interrupt because the saved vbus state is not consistent.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 4b5b7fa..40e5fc7 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1807,6 +1807,8 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 		toggle_bias(udc, 1);
 		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 		usba_int_enb_set(udc, USBA_END_OF_RESET);
+
+		udc->vbus_prev = 1;
 	}
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-- 
2.1.4
