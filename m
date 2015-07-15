From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:31:53 +0200
Subject: [PATCH v3 06/46] usb: dwc2: gadget: add ep capabilities support
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-7-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/dwc2/gadget.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 4d47b7c..8771b66 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3289,6 +3289,19 @@ static void s3c_hsotg_initep(struct dwc2_hsotg *hsotg,
 	usb_ep_set_maxpacket_limit(&hs_ep->ep, epnum ? 1024 : EP0_MPS_LIMIT);
 	hs_ep->ep.ops = &s3c_hsotg_ep_ops;
 
+	if (epnum == 0) {
+		hs_ep->ep.caps.type_control = true;
+	} else {
+		hs_ep->ep.caps.type_iso = true;
+		hs_ep->ep.caps.type_bulk = true;
+		hs_ep->ep.caps.type_int = true;
+	}
+
+	if (dir_in)
+		hs_ep->ep.caps.dir_in = true;
+	else
+		hs_ep->ep.caps.dir_out = true;
+
 	/*
 	 * if we're using dma, we need to set the next-endpoint pointer
 	 * to be something valid.
-- 
1.9.1
