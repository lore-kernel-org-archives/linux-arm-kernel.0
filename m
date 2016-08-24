From: johnyoun@synopsys.com (John Youn)
Date: Wed, 24 Aug 2016 16:19:54 -0700
Subject: [RFT PATCH v2 1/4] usb: dwc2: gadget: Only initialize device if in
 device mode
In-Reply-To: <cover.1471991702.git.johnyoun@synopsys.com>
References: <cover.1471991702.git.johnyoun@synopsys.com>
Message-ID: <bf1fc5cb1a534a0d3e64694e0e8382a337b147f0.1471991702.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In dwc2_hsotg_udc_start(), don't initialize the controller for device
mode unless we are actually in device mode.

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
