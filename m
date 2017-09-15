From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 15 Sep 2017 15:31:19 +0200
Subject: [PATCH] N900: Fix USB networking not working when cable is already
 attached during boot
Message-ID: <20170915133119.GA21153@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I noticed that mainline and pmos kernels have problems if USB is
already attached. My kernels don't  seem to have that problem.... so
.. can you test following?

Against v4.13.
								Pavel

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index e6f04ee..f44d731 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1339,14 +1339,37 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 	return ret;
 }
 
-int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
+int usb_udc_attach_driver(const char *name, struct usb_gadget_driver *driver)
+{
+	struct usb_udc *udc = NULL;
+	int ret = -ENODEV;
+
+	mutex_lock(&udc_lock);
+	list_for_each_entry(udc, &udc_list, list) {
+		ret = strcmp(name, dev_name(&udc->dev));
+		if (!ret)
+			break;
+	}
+	if (ret) {
+		ret = -ENODEV;
+		goto out;
+	}
+	if (udc->driver) {
+		ret = -EBUSY;
+		goto out;
+	}
+	ret = udc_bind_to_driver(udc, driver);
+out:
+	mutex_unlock(&udc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_udc_attach_driver);
+
+int __usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
 	struct usb_udc		*udc = NULL;
 	int			ret = -ENODEV;
 
-	if (!driver || !driver->bind || !driver->setup)
-		return -EINVAL;
-
 	mutex_lock(&udc_lock);
 	if (driver->udc_name) {
 		list_for_each_entry(udc, &udc_list, list) {
@@ -1382,6 +1405,36 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 	mutex_unlock(&udc_lock);
 	return ret;
 }
+
+#define USB_GADGET_BIND_RETRIES		5
+#define USB_GADGET_BIND_TIMEOUT		(3 * HZ)
+static void usb_gadget_work(struct work_struct *work)
+{
+	struct usb_gadget_driver *driver = container_of(work,
+						struct usb_gadget_driver,
+						work.work);
+	int res;
+	
+	if (driver->retries++ > USB_GADGET_BIND_RETRIES) {
+		pr_err("couldn't find an available UDC\n");
+		return;
+	}
+
+	res = __usb_gadget_probe_driver(driver);
+	if (res == -ENODEV)
+		schedule_delayed_work(&driver->work, USB_GADGET_BIND_TIMEOUT);
+}
+
+int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
+{
+	if (!driver || !driver->bind || !driver->setup)
+		return -EINVAL;
+
+	INIT_DELAYED_WORK(&driver->work, usb_gadget_work);
+	schedule_delayed_work(&driver->work, 0);
+
+	return 0;
+}
 EXPORT_SYMBOL_GPL(usb_gadget_probe_driver);
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
@@ -1392,6 +1445,8 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	if (!driver || !driver->unbind)
 		return -EINVAL;
 
+	cancel_delayed_work(&driver->work);
+
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list) {
 		if (udc->driver == driver) {
@@ -1573,7 +1628,7 @@ static int __init usb_udc_init(void)
 	udc_class->dev_uevent = usb_udc_uevent;
 	return 0;
 }
-subsys_initcall(usb_udc_init);
+late_initcall_sync(usb_udc_init);
 
 static void __exit usb_udc_exit(void)
 {
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 1a4a4ba..839a47b 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -599,6 +599,8 @@ static inline int usb_gadget_activate(struct usb_gadget *gadget)
  * @resume: Invoked on USB resume.  May be called in_interrupt.
  * @reset: Invoked on USB bus reset. It is mandatory for all gadget drivers
  *	and should be called in_interrupt.
+ * @work: Gadget work used to bind to the USB controller.
+ * @retries: Gadget retries to bind to the USB controller.
  * @driver: Driver model state for this driver.
  * @udc_name: A name of UDC this driver should be bound to. If udc_name is NULL,
  *	this driver will be bound to any available UDC.
@@ -662,6 +664,8 @@ struct usb_gadget_driver {
 	void			(*suspend)(struct usb_gadget *);
 	void			(*resume)(struct usb_gadget *);
 	void			(*reset)(struct usb_gadget *);
+	struct delayed_work	work;
+	int			retries;
 
 	/* FIXME support safe rmmod */
 	struct device_driver	driver;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170915/d889098a/attachment.sig>
