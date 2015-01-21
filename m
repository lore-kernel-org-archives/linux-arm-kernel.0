From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Wed, 21 Jan 2015 20:31:11 +0100
Subject: [PATCHv5 1/4] USB: gadget: atmel_usba_udc: Fixed vbus_prev initial
 state
In-Reply-To: <1421868674-30757-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421868674-30757-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421868674-30757-2-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If vbus gpio is high at init, we should set vbus_prev to true
accordingly to the current vbus state. Without that, we skip the first
vbus interrupt because the saved vbus state is not consistent.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Fixes: 914a3f3b3754 ("USB: add atmel_usba_udc driver")
Cc: <stable@vger.kernel.org> #2.6.24+
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
