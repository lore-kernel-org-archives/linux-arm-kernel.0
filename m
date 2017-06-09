From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Fri, 09 Jun 2017 11:01:01 +0200
Subject: patch "arm: ecard: use dev_groups and not dev_attrs for bus_type"
 added to driver-core-testing
Message-ID: <1496998861151191@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    arm: ecard: use dev_groups and not dev_attrs for bus_type

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


>From 71d1e5d71cec76e927a92354a7eb9d476e7054ad Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:14:16 +0200
Subject: arm: ecard: use dev_groups and not dev_attrs for bus_type

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Cc: Russell King <linux@armlinux.org.uk>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-rpc/ecard.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 6b279d037774..f75b8b562d57 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -761,19 +761,21 @@ static struct expansion_card *__init ecard_alloc_card(int type, int slot)
 	return ec;
 }
 
-static ssize_t ecard_show_irq(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t irq_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->irq);
 }
+static DEVICE_ATTR_RO(irq);
 
-static ssize_t ecard_show_dma(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t dma_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->dma);
 }
+static DEVICE_ATTR_RO(dma);
 
-static ssize_t ecard_show_resources(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t resource_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	char *str = buf;
@@ -787,35 +789,39 @@ static ssize_t ecard_show_resources(struct device *dev, struct device_attribute
 
 	return str - buf;
 }
+static DEVICE_ATTR_RO(resource_show)
 
-static ssize_t ecard_show_vendor(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t vendor_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.manufacturer);
 }
+static DEVICE_ATTR_RO(vendor);
 
-static ssize_t ecard_show_device(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t device_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.product);
 }
+static DEVICE_ATTR_RO(device);
 
-static ssize_t ecard_show_type(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%s\n", ec->easi ? "EASI" : "IOC");
 }
-
-static struct device_attribute ecard_dev_attrs[] = {
-	__ATTR(device,   S_IRUGO, ecard_show_device,    NULL),
-	__ATTR(dma,      S_IRUGO, ecard_show_dma,       NULL),
-	__ATTR(irq,      S_IRUGO, ecard_show_irq,       NULL),
-	__ATTR(resource, S_IRUGO, ecard_show_resources, NULL),
-	__ATTR(type,     S_IRUGO, ecard_show_type,      NULL),
-	__ATTR(vendor,   S_IRUGO, ecard_show_vendor,    NULL),
-	__ATTR_NULL,
+static DEVICE_ATTR_RO(type);
+
+static struct attribute *ecard_dev_attrs[] = {
+	&dev_attr_device.attr,
+	&dev_attr_dma.attr,
+	&dev_attr_irq.attr,
+	&dev_attr_resource.attr,
+	&dev_attr_type.attr,
+	&dev_attr_vendor.attr,
+	NULL,
 };
-
+ATTRIBUTE_GROUPS(ecard_dev);
 
 int ecard_request_resources(struct expansion_card *ec)
 {
@@ -1120,7 +1126,7 @@ static int ecard_match(struct device *_dev, struct device_driver *_drv)
 
 struct bus_type ecard_bus_type = {
 	.name		= "ecard",
-	.dev_attrs	= ecard_dev_attrs,
+	.dev_groups	= ecard_dev_groups,
 	.match		= ecard_match,
 	.probe		= ecard_drv_probe,
 	.remove		= ecard_drv_remove,
-- 
2.13.1
