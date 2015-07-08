From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 08 Jul 2015 13:08:59 +0200
Subject: [PATCH 15/37] usb: gadget: fsl_udc_core: add ep capabilities support
In-Reply-To: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436353761-7107-16-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index c60022b..aab5221 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2313,6 +2313,19 @@ static int struct_ep_setup(struct fsl_udc *udc, unsigned char index,
 	ep->ep.ops = &fsl_ep_ops;
 	ep->stopped = 0;
 
+	if (index == 0) {
+		ep->ep.caps.type_control = true;
+	} else {
+		ep->ep.caps.type_iso = true;
+		ep->ep.caps.type_bulk = true;
+		ep->ep.caps.type_int = true;
+	}
+
+	if (index & 1)
+		ep->ep.caps.dir_in = true;
+	else
+		ep->ep.caps.dir_out = true;
+
 	/* for ep0: maxP defined in desc
 	 * for other eps, maxP is set by epautoconfig() called by gadget layer
 	 */
-- 
1.9.1
