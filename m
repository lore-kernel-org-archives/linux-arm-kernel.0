From: Dinh.Nguyen@freescale.com (Dinh.Nguyen at freescale.com)
Date: Tue,  4 May 2010 10:03:01 -0500
Subject: [PATCH 2.6.34-rc6] mxc: gadget: Fix bitfield for calculating maximum
	packet size
Message-ID: <1272985381-4454-1-git-send-email-Dinh.Nguyen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <Dinh.Nguyen@freescale.com>

The max packet length bit mask used for isochronous endpoints
should be 0x7FF instead of 0x8FF. 0x8FF will actually clear
higher-order bits in the max packet length field.

This patch applies to 2.6.34-rc6.

Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index fa3d142..08a9a62 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -489,7 +489,7 @@ static int fsl_ep_enable(struct usb_ep *_ep,
 	case USB_ENDPOINT_XFER_ISOC:
 		/* Calculate transactions needed for high bandwidth iso */
 		mult = (unsigned char)(1 + ((max >> 11) & 0x03));
-		max = max & 0x8ff;	/* bit 0~10 */
+		max = max & 0x7ff;	/* bit 0~10 */
 		/* 3 transactions at most */
 		if (mult > 3)
 			goto en_done;
-- 
1.6.0.4
