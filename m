From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 09 Jun 2016 11:44:29 +0200
Subject: [RFC v4 12/14] EXAMPLE CODE: usb: hub: Power sequence the ports on
 activation
In-Reply-To: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465465471-28740-13-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The autodetection of attached USB device might not work on certain
boards where the power is delivered externally.  These devices also might
require a hard reset.  Use pwrseq for that in USB hub.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/usb/core/hub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c421745b84aa..46d9f9aedacc 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/pwrseq.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -1663,6 +1664,15 @@ static int hub_configure(struct usb_hub *hub,
 
 	usb_hub_adjust_deviceremovable(hdev, hub->descriptor);
 
+	/* FIXME: When do the pre-power-on? */
+	/*
+	for (i = 0; i < maxchild; i++)
+		pwrseq_pre_power_on(hub->ports[i]->pwrseq);
+	*/
+
+	for (i = 0; i < maxchild; i++)
+		pwrseq_post_power_on(hub->ports[i]->pwrseq);
+
 	hub_activate(hub, HUB_INIT);
 	return 0;
 
-- 
1.9.1
