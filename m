From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2017 11:33:27 +0100
Subject: [PATCH, RESEND] usb: gadget: udc: atmel: fix debug output
Message-ID: <20170222103348.3947633-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug output now contains the wrong variable, as seen from the compiler
warning:

drivers/usb/gadget/udc/atmel_usba_udc.c: In function 'usba_ep_enable':
drivers/usb/gadget/udc/atmel_usba_udc.c:632:550: error: 'ept_cfg' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  DBG(DBG_ERR, "%s: EPT_CFG = 0x%lx (maxpacket = %lu)\n",

This changes the debug output the same way as the other code.

Fixes: 741d2558bf0a ("usb: gadget: udc: atmel: Update endpoint allocation scheme")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Originally sent on Feb 1, but this was never picked up. Resending it now,
as it is one of the few remaining build regressions in linux-next compared
to linux-4.10.

 drivers/usb/gadget/udc/atmel_usba_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 11bbce28bc23..2035906b8ced 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -610,7 +610,7 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
 {
 	struct usba_ep *ep = to_usba_ep(_ep);
 	struct usba_udc *udc = ep->udc;
-	unsigned long flags, ept_cfg, maxpacket;
+	unsigned long flags, maxpacket;
 	unsigned int nr_trans;
 
 	DBG(DBG_GADGET, "%s: ep_enable: desc=%p\n", ep->ep.name, desc);
@@ -630,7 +630,7 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
 	ep->is_in = 0;
 
 	DBG(DBG_ERR, "%s: EPT_CFG = 0x%lx (maxpacket = %lu)\n",
-			ep->ep.name, ept_cfg, maxpacket);
+			ep->ep.name, ep->ept_cfg, maxpacket);
 
 	if (usb_endpoint_dir_in(desc)) {
 		ep->is_in = 1;
-- 
2.9.0
