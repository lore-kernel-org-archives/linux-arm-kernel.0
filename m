From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 11 Jul 2013 14:27:20 +0800
Subject: [PATCH v12 12/13] usb: chipidea: udc: .pullup is valid when vbus is
 on at CI_HDRC_PULLUP_ON_VBUS
In-Reply-To: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1373524041-10482-13-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the flag CI_HDRC_PULLUP_ON_VBUS is set, .pullup should only be
called when the vbus is active. When the CI_HDRC_PULLUP_ON_VBUS
is set, the controller only begins to run when the vbus is on,
So, it is only meaningful software set pullup/pulldown after
the controller begins to run.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/udc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 45abf4d..b7ead5f 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1514,6 +1514,10 @@ static int ci_udc_pullup(struct usb_gadget *_gadget, int is_on)
 {
 	struct ci_hdrc *ci = container_of(_gadget, struct ci_hdrc, gadget);
 
+	if ((ci->platdata->flags & CI_HDRC_PULLUP_ON_VBUS)
+			&& !ci->vbus_active)
+		return -EOPNOTSUPP;
+
 	if (is_on)
 		hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
 	else
-- 
1.7.0.4
