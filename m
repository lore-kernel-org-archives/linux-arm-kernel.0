From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 12 Aug 2013 09:22:49 +0800
Subject: [PATCH v15 03/13] usb: chipidea: udc: otg_set_peripheral is useless
 for some chipidea users
In-Reply-To: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1376270579-13493-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is useless at below cases:
- If we implement both usb host and device at chipidea driver.
- If we don't need phy->otg.

Tested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/udc.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index e475fcd..116c762 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1805,7 +1805,12 @@ static int udc_start(struct ci_hdrc *ci)
 	if (ci->transceiver) {
 		retval = otg_set_peripheral(ci->transceiver->otg,
 						&ci->gadget);
-		if (retval)
+		/*
+		 * If we implement all USB functions using chipidea drivers,
+		 * it doesn't need to call above API, meanwhile, if we only
+		 * use gadget function, calling above API is useless.
+		 */
+		if (retval && retval != -ENOTSUPP)
 			goto put_transceiver;
 	}
 
-- 
1.7.1
