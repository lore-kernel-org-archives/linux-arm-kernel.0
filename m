From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 14 Jul 2015 11:39:06 +0200
Subject: [PATCH v2 18/48] usb: gadget: gr_udc: add ep capabilities support
In-Reply-To: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436866776-5004-19-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/gr_udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index c886887..8aa2593 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -2018,12 +2018,23 @@ static int gr_ep_init(struct gr_udc *dev, int num, int is_in, u32 maxplimit)
 
 		usb_ep_set_maxpacket_limit(&ep->ep, MAX_CTRL_PL_SIZE);
 		ep->bytes_per_buffer = MAX_CTRL_PL_SIZE;
+
+		ep->ep.caps.type_control = true;
 	} else {
 		usb_ep_set_maxpacket_limit(&ep->ep, (u16)maxplimit);
 		list_add_tail(&ep->ep.ep_list, &dev->gadget.ep_list);
+
+		ep->ep.caps.type_iso = true;
+		ep->ep.caps.type_bulk = true;
+		ep->ep.caps.type_int = true;
 	}
 	list_add_tail(&ep->ep_list, &dev->ep_list);
 
+	if (is_in)
+		ep->ep.caps.dir_in = true;
+	else
+		ep->ep.caps.dir_out = true;
+
 	ep->tailbuf = dma_alloc_coherent(dev->dev, ep->ep.maxpacket_limit,
 					 &ep->tailbuf_paddr, GFP_ATOMIC);
 	if (!ep->tailbuf)
-- 
1.9.1
