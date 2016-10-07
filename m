From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:50 +0200
Subject: [PATCH/RFT 05/12] USB: ohci-da8xx: Fix probe for devices with no
 vbus/oci gpio
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-6-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

Some boards dont have gpios assigened for vbus or oci.

Allow these boards to enumerate usb without declaring the set_power
and/or the ocic_notify callbacks in platform data.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 3c85d6c..9d9f8e3 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -215,7 +215,7 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				temp ? "Set" : "Clear", wIndex, "POWER");
 
 			if (!pdata->set_power)
-				return -EPIPE;
+				return 0;
 
 			return pdata->set_power(wIndex, temp) ? -EPIPE : 0;
 		case USB_PORT_FEAT_C_OVER_CURRENT:
@@ -343,10 +343,12 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 
 	if (pdata->ocic_notify) {
 		error = pdata->ocic_notify(ohci_da8xx_ocic_handler);
-		if (!error)
-			return 0;
+		if (error)
+			goto err_notify;
 	}
 
+	return 0;
+err_notify:
 	usb_remove_hcd(hcd);
 err:
 	usb_put_hcd(hcd);
-- 
2.7.1
