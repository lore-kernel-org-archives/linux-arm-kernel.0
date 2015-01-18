From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 15:51:20 +0100
Subject: [PATCHv2 1/2] USB: gadget: atmel_usba_udc: Fixed vbus_prev initial
 state
In-Reply-To: <1421592681-28317-1-git-send-email-sylvain.rochet@finsecur.com>
References: <20150117110710.GB24176@gradator.net>
 <1421592681-28317-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421592681-28317-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If vbus gpio is high at init, we should set vbus_prev to true
accordingly to the current vbus state. Without that, we skip the first
vbus interrupt because the saved vbus state is not consistent.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index ce88237..e207d75 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1791,6 +1791,8 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 		toggle_bias(1);
 		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
 		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
+
+		udc->vbus_prev = 1;
 	}
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-- 
2.1.4
