From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 08 Jul 2015 11:05:21 +0200
Subject: [PATCH v2 3/5] usb: isp1760: udc: add missing
 usb_ep_set_maxpacket_limit()
In-Reply-To: <1436346323-31593-1-git-send-email-r.baldyga@samsung.com>
References: <1436346323-31593-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436346323-31593-4-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since maxpacket_limit was introduced all UDC drivers should use
usb_ep_set_maxpacket_limit() function instead of setting maxpacket value
manually. ep.maxpacket_limit contains actual maximum maxpacket value
supported by hardware which is needed by epautoconf.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/isp1760/isp1760-udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1760-udc.c
index 18ebf5b1..3699962 100644
--- a/drivers/usb/isp1760/isp1760-udc.c
+++ b/drivers/usb/isp1760/isp1760-udc.c
@@ -1382,11 +1382,11 @@ static void isp1760_udc_init_eps(struct isp1760_udc *udc)
 		 * This fits in the 8kB FIFO without double-buffering.
 		 */
 		if (ep_num == 0) {
-			ep->ep.maxpacket = 64;
+			usb_ep_set_maxpacket_limit(&ep->ep, 64);
 			ep->maxpacket = 64;
 			udc->gadget.ep0 = &ep->ep;
 		} else {
-			ep->ep.maxpacket = 512;
+			usb_ep_set_maxpacket_limit(&ep->ep, 512);
 			ep->maxpacket = 0;
 			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
 		}
-- 
1.9.1
