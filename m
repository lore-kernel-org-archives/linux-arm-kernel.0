From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 07 May 2014 15:37:17 +0100
Subject: [PATCH v2] of: Keep track of populated platform devices
In-Reply-To: <CACxGe6usWdey1qQT2JF=7LuE62H-_xtd1QkRT9z_Tj2pxdQEjQ@mail.gmail.com>
References: <1398858529.24255.3.camel@hornet>
 <1398866717-20268-1-git-send-email-pawel.moll@arm.com>
 <CAL_JsqL=mxqEKpAsXm7Du0vEDpKk4n+dp5-DyvbuGhTA6bP5Lg@mail.gmail.com>
 <20140501092635.05011C409DA@trevor.secretlab.ca>
 <CACxGe6usWdey1qQT2JF=7LuE62H-_xtd1QkRT9z_Tj2pxdQEjQ@mail.gmail.com>
Message-ID: <1399473437.3706.25.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-05-01 at 10:43 +0100, Grant Likely wrote:
> > That doesn't work in the case where drivers use of_platform_populate().
> > MFD devices in particular make use of it. If the driver does not get
> > cleared on removal of the devices, then all MFD users will be broken on
> > driver unbind/rebind. *
> >
> > We really need to have the inverse of of_platform_populate which will
> > remove all child and child's child devices and clear all flags and such.
> > Right now moany drivers are open-coding the removal.

Agreed, but, unless I'm missing some fundamental issue, I believe we can
solve the flag clearing problem in a generic way:

--8<-----------
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 3cf61a1..0f489fb 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -17,6 +17,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/amba/bus.h>
 #include <linux/sizes.h>
+#include <linux/of_device.h>
 
 #include <asm/irq.h>
 
@@ -268,6 +269,7 @@ static void amba_device_release(struct device *dev)
 {
 	struct amba_device *d = to_amba_device(dev);
 
+	of_device_node_put(dev);
 	if (d->res.parent)
 		release_resource(&d->res);
 	kfree(d);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index ef37021..fd14d46 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -41,6 +41,8 @@ extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env
 
 static inline void of_device_node_put(struct device *dev)
 {
+	if (dev->of_node)
+		of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_put(dev->of_node);
 }
--8<-----------

This will work even if one manually unregisters a DT-originating device,
because of_device_node_put() would be called in both amba and platform
device (kobj) release path.

By the way, the fact that today amba_device_release() doesn't do
of_device_node_put() seems like a bug to me? (node's reference counter
won't be decremented)

> The function shouldn't be too difficult. I would expect it to look
> something like this. You'll need to check the details.

8<-----------
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index dd4328c..b6b5a2b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -493,4 +493,49 @@ int of_platform_populate(struct device_node *root,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(of_platform_populate);
+
+static int of_platform_device_destroy(struct device *dev, void *data)
+{
+	int *parents_children_left = data;
+	int my_children_left = 0;
+
+	/* Do not touch devices not populated from the device tree */
+	if (!dev->of_node || !of_node_check_flag(dev->of_node, OF_POPULATED)) {
+		*parents_children_left++;
+		return 0;
+	}
+
+	device_for_each_child(dev, &my_children_left,
+			of_platform_device_destroy);
+	if (my_children_left) {
+		*parents_children_left++;
+		return 0;
+	}
+
+	if (dev->bus == &platform_bus_type)
+		platform_device_unregister(to_platform_device(dev));
+	else if (dev->bus == &amba_bustype)
+		amba_device_unregister(to_amba_device(dev));
+
+	return 0;
+}
+
+/**
+ * of_platform_depopulate() - Remove devices populated from device tree
+ * @parent: device which childred will be removed
+ *
+ * Complementary to of_platform_populate(), this function removes children
+ * of the given device (and, recurrently, their children) that have been
+ * created from their respective device tree nodes (and only those,
+ * leaving others - eg. manually created - unharmed). */
+ */
+int of_platform_depopulate(struct device *parent)
+{
+	int children_left = 0;
+
+	device_for_each_child(dev, &children_left, of_platform_device_destroy);
+
+	return children_left ? -EBUSY : 0;
+}
+EXPORT_SYMBOL_GPL(of_platform_depopulate);
 #endif /* CONFIG_OF_ADDRESS */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 05cb4a9..ef4f4ad 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -72,6 +72,7 @@ extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
 				struct device *parent);
+static inline int of_platform_depopulate(struct device *parent);
 #else
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
@@ -80,6 +81,10 @@ static inline int of_platform_populate(struct device_node *root,
 {
 	return -ENODEV;
 }
+static inline int of_platform_depopulate(struct device *parent)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif	/* _LINUX_OF_PLATFORM_H */
8<-----------

> static int __of_platform_unpopulate_device(struct device *dev, void *c)
> {
>     if (!dev->of_node || !of_node_get_flag(dev->of_node, OF_POPULATED)
>         return 0;
> 
>     // recursively remove the children too --- I'd like to find a way
> to do this non-recursively
>     device_for_each_child(dev, NULL, __of_platform_unpopulate_device);

As of_platform_populate() is recursive itself, I don't see much problem
with this.

>     // Need to check if the device should be explicitly unbound from
> it's driver before removing it. However, I think the driver core takes
> care of this for us.

Yep, removing either a driver or a device unbinds all existing pairs.

>     // Remove based on the bus type
>     switch (dev->bus) {
>         case &platform_bus_type:

To my surprise gcc said "error: pointers are not permitted as case
values". One learns every day ;-)

>             platform_device_remove(to_platform_device(dev));
>             break;
>         case &amba_bus_type:
>             amba_device_remove(to_platform_device(dev));
>             break;
>     }
> 
>     // Should check here if there are any other children to the
> device. It is probably bad to remove a device that still has children.
> Need to check what the driver core will do.
> }

The reference count will be still be greater than 0, so the parent won't
be harmed. Nevertheless it's better to consciously handle such case. At
least I tried.

Pawel
