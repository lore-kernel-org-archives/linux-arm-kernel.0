From: amstan@chromium.org (Alexandru M Stan)
Date: Tue, 22 Sep 2015 13:10:51 -0700
Subject: [PATCH] usb: dwc2: Fix NULL qh in dwc2_queue_transaction
In-Reply-To: <1442952651-4341-1-git-send-email-amstan@chromium.org>
References: <1442952651-4341-1-git-send-email-amstan@chromium.org>
Message-ID: <1442952651-4341-2-git-send-email-amstan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a usb device disconnects in a certain way, dwc2_queue_transaction
still gets called after dwc2_hcd_cleanup_channels.

dwc2_hcd_cleanup_channels does "channel->qh = NULL;" but
dwc2_queue_transaction still wants to dereference qh.
This adds a check for a null qh.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
---
 drivers/usb/dwc2/hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index f845c41..d745128 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -1004,7 +1004,7 @@ static int dwc2_queue_transaction(struct dwc2_hsotg *hsotg,
 {
 	int retval = 0;
 
-	if (hsotg->core_params->dma_enable > 0) {
+	if (hsotg->core_params->dma_enable > 0 && chan->qh) {
 		if (hsotg->core_params->dma_desc_enable > 0) {
 			if (!chan->xfer_started ||
 			    chan->ep_type == USB_ENDPOINT_XFER_ISOC) {
-- 
2.6.0.rc0.131.gf624c3d
