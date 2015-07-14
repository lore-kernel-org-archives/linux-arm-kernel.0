From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 14 Jul 2015 11:38:59 +0200
Subject: [PATCH v2 11/48] usb: gadget: bdc: add ep capabilities support
In-Reply-To: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436866776-5004-12-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/bdc/bdc_ep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index b04980c..f9a8f57 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -1952,12 +1952,18 @@ static int init_ep(struct bdc *bdc, u32 epnum, u32 dir)
 	ep->bdc = bdc;
 	ep->dir = dir;
 
+	if (dir)
+		ep->usb_ep.caps.dir_in = true;
+	else
+		ep->usb_ep.caps.dir_out = true;
+
 	/* ep->ep_num is the index inside bdc_ep */
 	if (epnum == 1) {
 		ep->ep_num = 1;
 		bdc->bdc_ep_array[ep->ep_num] = ep;
 		snprintf(ep->name, sizeof(ep->name), "ep%d", epnum - 1);
 		usb_ep_set_maxpacket_limit(&ep->usb_ep, EP0_MAX_PKT_SIZE);
+		ep->usb_ep.caps.type_control = true;
 		ep->comp_desc = NULL;
 		bdc->gadget.ep0 = &ep->usb_ep;
 	} else {
@@ -1971,6 +1977,9 @@ static int init_ep(struct bdc *bdc, u32 epnum, u32 dir)
 			 dir & 1 ? "in" : "out");
 
 		usb_ep_set_maxpacket_limit(&ep->usb_ep, 1024);
+		ep->usb_ep.caps.type_iso = true;
+		ep->usb_ep.caps.type_bulk = true;
+		ep->usb_ep.caps.type_int = true;
 		ep->usb_ep.max_streams = 0;
 		list_add_tail(&ep->usb_ep.ep_list, &bdc->gadget.ep_list);
 	}
-- 
1.9.1
