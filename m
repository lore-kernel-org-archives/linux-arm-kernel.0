From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 08 Jul 2015 13:09:05 +0200
Subject: [PATCH 21/37] usb: gadget: mv_u3d_core: add ep capabilities support
In-Reply-To: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436353761-7107-22-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/mv_u3d_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index ea35a24..4c48969 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -1324,6 +1324,9 @@ static int mv_u3d_eps_init(struct mv_u3d *u3d)
 	ep->ep.ops = &mv_u3d_ep_ops;
 	ep->wedge = 0;
 	usb_ep_set_maxpacket_limit(&ep->ep, MV_U3D_EP0_MAX_PKT_SIZE);
+	ep->ep.caps.type_control = true;
+	ep->ep.caps.dir_in = true;
+	ep->ep.caps.dir_out = true;
 	ep->ep_num = 0;
 	ep->ep.desc = &mv_u3d_ep0_desc;
 	INIT_LIST_HEAD(&ep->queue);
@@ -1339,14 +1342,20 @@ static int mv_u3d_eps_init(struct mv_u3d *u3d)
 		if (i & 1) {
 			snprintf(name, sizeof(name), "ep%din", i >> 1);
 			ep->direction = MV_U3D_EP_DIR_IN;
+			ep->ep.caps.dir_in = true;
 		} else {
 			snprintf(name, sizeof(name), "ep%dout", i >> 1);
 			ep->direction = MV_U3D_EP_DIR_OUT;
+			ep->ep.caps.dir_out = true;
 		}
 		ep->u3d = u3d;
 		strncpy(ep->name, name, sizeof(ep->name));
 		ep->ep.name = ep->name;
 
+		ep->ep.caps.type_iso = true;
+		ep->ep.caps.type_bulk = true;
+		ep->ep.caps.type_int = true;
+
 		ep->ep.ops = &mv_u3d_ep_ops;
 		usb_ep_set_maxpacket_limit(&ep->ep, (unsigned short) ~0);
 		ep->ep_num = i / 2;
-- 
1.9.1
