From: johnyoun@synopsys.com (John Youn)
Date: Thu, 01 Sep 2016 14:07:51 -0700
Subject: [RFT PATCH v4 1/3] usb: dwc2: gadget: Only initialize device if in
 device mode
In-Reply-To: <cover.1472763969.git.johnyoun@synopsys.com>
References: <cover.1472763969.git.johnyoun@synopsys.com>
Message-ID: <ea433e9d1f683bc65939eb9eaab2b8597c9ede4a.1472763969.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In dwc2_hsotg_udc_start(), don't initialize the controller for device
mode unless we are actually in device mode.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: John Youn <johnyoun@synopsys.com>
---
 drivers/usb/dwc2/gadget.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 94bd19a..4cd6403 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3466,8 +3466,11 @@ static int dwc2_hsotg_udc_start(struct usb_gadget *gadget,
 		otg_set_peripheral(hsotg->uphy->otg, &hsotg->gadget);
 
 	spin_lock_irqsave(&hsotg->lock, flags);
-	dwc2_hsotg_init(hsotg);
-	dwc2_hsotg_core_init_disconnected(hsotg, false);
+	if (dwc2_hw_is_device(hsotg)) {
+		dwc2_hsotg_init(hsotg);
+		dwc2_hsotg_core_init_disconnected(hsotg, false);
+	}
+
 	hsotg->enabled = 0;
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-- 
2.9.0
