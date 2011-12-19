From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 19 Dec 2011 19:43:35 +0100
Subject: [PATCH 8/8] s3c-hsudc: remove the_controller global
In-Reply-To: <201112191938.22254.heiko@sntech.de>
References: <201112191938.22254.heiko@sntech.de>
Message-ID: <201112191943.35591.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead use container_of to retrieve the s3c_hsudc from the
struct usb_gadget pointer.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/usb/gadget/s3c-hsudc.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index 8e69758..23cac9d 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -161,7 +161,6 @@ struct s3c_hsudc {
 #define ep_index(_ep)		((_ep)->bEndpointAddress & \
 					USB_ENDPOINT_NUMBER_MASK)
 
-static struct s3c_hsudc *the_controller;
 static const char driver_name[] = "s3c-udc";
 static const char ep0name[] = "ep0-control";
 
@@ -1141,7 +1140,8 @@ static irqreturn_t s3c_hsudc_irq(int irq, void *_dev)
 static int s3c_hsudc_start(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver)
 {
-	struct s3c_hsudc *hsudc = the_controller;
+	struct s3c_hsudc *hsudc =
+			container_of(gadget, struct s3c_hsudc, gadget);
 	int ret;
 
 	if (!driver
@@ -1195,7 +1195,8 @@ err_supplies:
 static int s3c_hsudc_stop(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver)
 {
-	struct s3c_hsudc *hsudc = the_controller;
+	struct s3c_hsudc *hsudc =
+			container_of(gadget, struct s3c_hsudc, gadget);
 	unsigned long flags;
 
 	if (!hsudc)
@@ -1238,7 +1239,8 @@ static int s3c_hsudc_gadget_getframe(struct usb_gadget *gadget)
 
 static int s3c_hsudc_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
-	struct s3c_hsudc *hsudc = the_controller;
+	struct s3c_hsudc *hsudc =
+			container_of(gadget, struct s3c_hsudc, gadget);
 
 	if (!hsudc)
 		return -ENODEV;
@@ -1272,7 +1274,6 @@ static int __devinit s3c_hsudc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	the_controller = hsudc;
 	platform_set_drvdata(pdev, dev);
 	hsudc->dev = dev;
 	hsudc->pd = pdev->dev.platform_data;
-- 
1.7.2.3
