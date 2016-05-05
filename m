From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 05 May 2016 14:34:21 +0200
Subject: [RFC v2 08/13] usb: hub: Handle deferred probe
In-Reply-To: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462451666-17945-9-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for deferred probing to the usb hub. Currently EPROBE_DEFER
does not exist in usb hub path but future patches will add it on the
port level.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/usb/core/hub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 38cc4bae0a82..1c82fcc448f5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1731,6 +1731,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -1850,11 +1851,12 @@ descriptor_error:
 	if (id->driver_info & HUB_QUIRK_CHECK_PORT_AUTOSUSPEND)
 		hub->quirk_check_port_auto_suspend = 1;
 
-	if (hub_configure(hub, endpoint) >= 0)
+	ret = hub_configure(hub, endpoint);
+	if (ret >= 0)
 		return 0;
 
 	hub_disconnect(intf);
-	return -ENODEV;
+	return ret;
 }
 
 static int
-- 
1.9.1
