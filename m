From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 12 Mar 2013 17:03:19 +0800
Subject: [RFC PATCH 3/3] usb: udc-core: add judgement logic for
 usb_gadget_connect
In-Reply-To: <1363078999-7361-1-git-send-email-peter.chen@freescale.com>
References: <1363078999-7361-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363078999-7361-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- If there is no vbus control to indicate connection
and disconnect, we can pullup dp when we load gadget module.
- If we have vbus control logic, the dp is better pulled up
when there is a vbus session.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/udc-core.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc-core.c b/drivers/usb/gadget/udc-core.c
index 2a9cd36..4b56f7c 100644
--- a/drivers/usb/gadget/udc-core.c
+++ b/drivers/usb/gadget/udc-core.c
@@ -262,6 +262,7 @@ EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
 {
 	int ret;
+	struct usb_gadget *gadget = udc->gadget;
 
 	dev_dbg(&udc->dev, "registering UDC driver [%s]\n",
 			driver->function);
@@ -269,15 +270,18 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 	udc->driver = driver;
 	udc->dev.driver = &driver->driver;
 
-	ret = driver->bind(udc->gadget, driver);
+	ret = driver->bind(gadget, driver);
 	if (ret)
 		goto err1;
-	ret = usb_gadget_udc_start(udc->gadget, driver);
+	ret = usb_gadget_udc_start(gadget, driver);
 	if (ret) {
-		driver->unbind(udc->gadget);
+		driver->unbind(gadget);
 		goto err1;
 	}
-	usb_gadget_connect(udc->gadget);
+	if (!gadget->ops->vbus_session ||
+			(gadget->ops->vbus_session
+				&& gadget->vbus_active))
+		usb_gadget_connect(gadget);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -379,13 +383,17 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t n)
 {
 	struct usb_udc		*udc = container_of(dev, struct usb_udc, dev);
+	struct usb_gadget *gadget = udc->gadget;
 
 	if (sysfs_streq(buf, "connect")) {
-		usb_gadget_udc_start(udc->gadget, udc->driver);
-		usb_gadget_connect(udc->gadget);
+		usb_gadget_udc_start(gadget, udc->driver);
+		if (!gadget->ops->vbus_session ||
+				(gadget->ops->vbus_session
+					&& gadget->vbus_active))
+			usb_gadget_connect(gadget);
 	} else if (sysfs_streq(buf, "disconnect")) {
-		usb_gadget_disconnect(udc->gadget);
-		usb_gadget_udc_stop(udc->gadget, udc->driver);
+		usb_gadget_disconnect(gadget);
+		usb_gadget_udc_stop(gadget, udc->driver);
 	} else {
 		dev_err(dev, "unsupported command '%s'\n", buf);
 		return -EINVAL;
-- 
1.7.0.4
