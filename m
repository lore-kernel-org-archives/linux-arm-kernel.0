From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 08 Jul 2015 13:08:58 +0200
Subject: [PATCH 14/37] usb: gadget: fsl_qe_udc: add ep capabilities support
In-Reply-To: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436353761-7107-15-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index e0822f1..5fb6f8b 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -2417,6 +2417,17 @@ static int qe_ep_config(struct qe_udc *udc, unsigned char pipe_num)
 	strcpy(ep->name, ep_name[pipe_num]);
 	ep->ep.name = ep_name[pipe_num];
 
+	if (pipe_num == 0) {
+		ep->ep.caps.type_control = true;
+	} else {
+		ep->ep.caps.type_iso = true;
+		ep->ep.caps.type_bulk = true;
+		ep->ep.caps.type_int = true;
+	}
+
+	ep->ep.caps.dir_in = true;
+	ep->ep.caps.dir_out = true;
+
 	ep->ep.ops = &qe_ep_ops;
 	ep->stopped = 1;
 	usb_ep_set_maxpacket_limit(&ep->ep, (unsigned short) ~0);
-- 
1.9.1
