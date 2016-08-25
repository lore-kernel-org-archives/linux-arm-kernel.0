From: johnyoun@synopsys.com (John Youn)
Date: Thu, 25 Aug 2016 14:26:36 -0700
Subject: [RFT PATCH v3 1/3] usb: dwc2: gadget: Only initialize device if in
 device mode
In-Reply-To: <cover.1472160194.git.johnyoun@synopsys.com>
References: <cover.1472160194.git.johnyoun@synopsys.com>
Message-ID: <64471143a4dd89251db46a9f1e14f9720ba67bd0.1472160194.git.johnyoun@synopsys.com>
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
index af46adf..358ba5a 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3475,8 +3475,11 @@ static int dwc2_hsotg_udc_start(struct usb_gadget *gadget,
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
