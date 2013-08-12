From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 12 Aug 2013 09:22:59 +0800
Subject: [PATCH v15 13/13] usb: chipidea: udc: .pullup is valid only when vbus
 is there
In-Reply-To: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1376270579-13493-14-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For chipidea, the IP must know vbus before the controller
begins to run. So the .pullup should only be called when
the vbus is there.

Tested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/udc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 90c3572..6b4c2f2 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1511,6 +1511,9 @@ static int ci_udc_pullup(struct usb_gadget *_gadget, int is_on)
 {
 	struct ci_hdrc *ci = container_of(_gadget, struct ci_hdrc, gadget);
 
+	if (!ci->vbus_active)
+		return -EOPNOTSUPP;
+
 	if (is_on)
 		hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
 	else
-- 
1.7.1
